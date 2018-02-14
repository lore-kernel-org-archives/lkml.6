Return-Path: <kernel-hardening-return-11767-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227+V4O98OHbQeJPlAwfrMNi+FnjZk2VHuzZ1ZB1u0mXrLBQw5CYAeHdh/Xn+A7NFxp9qzxe
ARC-Seal: i=1; a=rsa-sha256; t=1518637446; cv=none;
        d=google.com; s=arc-20160816;
        b=Dh0xY7x6nA2UbAhnDdUwyGQd3N1v2O4LzT6DPc9MpgdBlML1HEuvyUylOqZ+kOqzRK
         Mqmd6Pj9ue57Rcsu+E39rEQW5vE7Cg/loU1fW1FSDf7eSN4aTTCOyTh3bJ9r1Q0t1gcZ
         9h7rEt7rqYiUF2hOwk9+Wqo3tEuyHk7SZZpiE+KYeGW2odcKh38Grcehy2WIRBHayxjv
         c1gXHo7xhEPmWZMlaiVuC3CvRgUytQxaqSws0081D0jLjtZriQ4BEcYHdEwDkIFYEC4H
         h25TgTfsuamcsvVX0H4ngiUWKUjZF0wN30+9I53TnX4dx60QtY9aZqLrx3ynsW71H/ba
         JQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LnseVRwSRM8upgc5tHutYOvYpHJU9rpq4iLXxBhvA5A=;
        b=j2tazYaNdGRwk6Qk9Xk5ADfFgvin/Rh63llxNtnzgp79d42YHpKVmZv0oHOsmILRQq
         7vnvb0Sgvf1Prwms6PtGQpwFfzfsMyVEHuyi3DSkkpVG9doFqiqEUK2W2DKM3/p23VqZ
         U2WVynJCWzJPU/SPybKdNvslRSgHrYOc6lZb8tH1YgOiiFh3pxLPrJs9F0q3LfG6nOrl
         vKzFIjMUD+BLZcfxCa3V91PiNfwZ21u9WKILkrzekEFz60BYPV5xRWTwRRp0pdsSyvVm
         YqwMHFRnsuQYBO1sq335d0dQHI05fVC5wZva62D+CZEdmhyJiA6f0C4Kdl3R2WI5GT+a
         NHiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11767-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11767-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11767-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11767-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:30034:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: geese21_3e39ec9e0790c
X-Filterd-Recvd-Size: 1982
Message-ID: <1518637426.3678.21.camel@perches.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <mawilcox@microsoft.com>,
 Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,  Kernel
 Hardening <kernel-hardening@lists.openwall.com>
Date: Wed, 14 Feb 2018 11:43:46 -0800
In-Reply-To: <20180214193613.GB20627@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
	 <1518634058.3678.15.camel@perches.com>
	 <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
	 <1518636765.3678.19.camel@perches.com>
	 <20180214193613.GB20627@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592406779664130634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 11:36 -0800, Matthew Wilcox wrote:
> On Wed, Feb 14, 2018 at 11:32:45AM -0800, Joe Perches wrote:
> > On Wed, 2018-02-14 at 11:23 -0800, Kees Cook wrote:
> > > On Wed, Feb 14, 2018 at 10:47 AM, Joe Perches <joe@perches.com> wrote:
> > > > I think expanding the number of allocation functions
> > > > is not necessary.
> > > 
> > > I think removing common mispatterns in favor of overflow-protected
> > > allocation functions makes sense.
> > 
> > Function symmetry matters too.
> > 
> > These allocation functions are specific to kvz<foo>
> > and are not symmetric for k<foo>, v<foo>, devm_<foo>
> > <foo>_node, and the like.
> 
> If somebody wants them, then we can add them.

Yeah, but I don't think any of it is necessary.

How many of these struct+bufsize * count entries
actually exist?
