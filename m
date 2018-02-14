Return-Path: <kernel-hardening-return-11763-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224AEM/RsB1U3Uv2IwWkvnT2y2EC1vvMiKrIJO7G5qUwNnfaLQWV5wdZaqLeccjrNShtNLyS
ARC-Seal: i=1; a=rsa-sha256; t=1518636788; cv=none;
        d=google.com; s=arc-20160816;
        b=Ri30ftUVJ5zxKmVLwgeUmf5F7yCjP+dcQlLsXFJuT/0dppc4Gxm0utiwuForzwEqQj
         wh8nHzHAiK3Iz7l1WNHPvagmiUfvZcCFEW6LnF9ECZnhNKZwqego3MWfLdpHxyGY1kP6
         4wCRXszbJlBK5GQIP55ZDzaPfj3AY0KZ7PS0AEeBW9irONhHPx1mtwHb9m7Ztr+J0ozj
         LNcTVmlZeQx2PhXz67REVDGaS+DyU3It9qCaL2wQQHCSnXb/CVCnlKKg21/tluALzZ9L
         KZd832n2PndStW0OVHkPAeUX/Yfq30fIzkZw8BGJ6+F+d63fL6CUMLxFxA57ruYw7vjx
         l9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=xGzbHzdfoxUKfArhC82al+ELMuX1PeQ5PuUZlhJc+FQ=;
        b=Oo6BWxfFmVAXn/74AAE3zEeMJdhrjjQZ16wCEb2Z6yfY4EXpg1o3jEY+Oj/uYxy5iF
         EAfrP23WO5NGFY6b3Byq15fk5hV9SNwvYy3whsVSpoEXV6Mzobuk4ySXJFhHsTF7fb4l
         txfOxAk7AdaWjfWQCTy9kT1pn5NnerWGNETOkMs0wh+5VK+6+hYMS2q/0nVE9mzOyvmm
         +ji//zUt96VZguQ/+KCL2Dhs4xxYKJPWqneiVUWCI5JSiuOABtFxsVBJ4mMP4651Ax0p
         7B7B2l75In29vAQgmZ7P7vShotQQ5w1veR5n34rOuixGKniRF6yQnbicvaFrOKc9Wloz
         6KrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11763-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11763-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11763-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11763-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7576:7688:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:30034:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: shoes08_6f8de17626d53
X-Filterd-Recvd-Size: 2110
Message-ID: <1518636765.3678.19.camel@perches.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>,
 Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Kernel
 Hardening <kernel-hardening@lists.openwall.com>
Date: Wed, 14 Feb 2018 11:32:45 -0800
In-Reply-To: <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
References: <20180214182618.14627-1-willy@infradead.org>
	 <1518634058.3678.15.camel@perches.com>
	 <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592406088529673301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 11:23 -0800, Kees Cook wrote:
> On Wed, Feb 14, 2018 at 10:47 AM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-02-14 at 10:26 -0800, Matthew Wilcox wrote:
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > We all know the perils of multiplying a value provided from userspace
> > > by a constant and then allocating the resulting number of bytes.  That's
> > > why we have kvmalloc_array(), so we don't have to think about it.
> > > This solves the same problem when we embed one of these arrays in a
> > > struct like this:
> > > 
> > > struct {
> > >       int n;
> > >       unsigned long array[];
> > > };
> > 
> > I think expanding the number of allocation functions
> > is not necessary.
> 
> I think removing common mispatterns in favor of overflow-protected
> allocation functions makes sense.

Function symmetry matters too.

These allocation functions are specific to kvz<foo>
and are not symmetric for k<foo>, v<foo>, devm_<foo>
<foo>_node, and the like.
