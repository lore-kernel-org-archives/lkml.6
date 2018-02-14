Return-Path: <kernel-hardening-return-11771-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226FcIYFGOECI7zQbF8W3BfIkS8uGOxRbVJJd62aVB3+vQ9U5XHoGLG00nXCbHuH0zWVrKiJ
ARC-Seal: i=1; a=rsa-sha256; t=1518638784; cv=none;
        d=google.com; s=arc-20160816;
        b=fT7SzNjfI0wdv5AHPQzXYubIZqe1HppO0UXQCilndR6TtuNI1PDPrQutbdz/XUGvDV
         FCmJfN2tDscnRDDYOQy+VSPNlunWqi0soolRVig++VC1wauiTSDcRYmawZ7WnatSR92i
         c9vB+Lx8/+aC8b2vjqHdzS0JzvEv1qyPdr22QvuQsuU8OAi9UlFxXblTzpgaf7hBRH1a
         uJ/jX4rkq4KeR7GSktD+ORd1Gg/os2iFwCvzZk8aeVfinDMU+6KB6EYhMEZa10Ybn/de
         Hb8GTo4/y/nsbauPWSeWo1vhkrCuLIYldbdHBUUUBAgqyJoGKJHVs82YU7LendxzKf/K
         zSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=vEz9YB0UrkrAbjiTyN8HuQJdoogns0Itw1B6X9ZvMgc=;
        b=fDMKgK6BIusM/1wxCJSpvlqVwdV/F0fpHKUkEmIbO/DlouuNK5Bu+i32j+oaRphH7P
         kXjGloxxW/PDe34Fx0to6nCyTwmCulKkdEmd34nyClvLZ1VmO6mHqpyHmgQTu1vrjWeb
         2aDurNqtlkm7myJmN+6mlwR53Iu3dwxAXtaOyXP1ci/1EijYbxWv1YvKX4jdv4sJfVJr
         yWD2UO7mO/sV8rKVAmrDCbyT8BQlR2hGogWwVmlnOXh0eufHgizc4TmCfSBp/LISINgi
         BQ1uJmPWX5sMjbdebYxq0uVbmjkU+DrEiOpIIHQAsNueKx1YByULe19OPAAhcCiN3F4s
         YOWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11771-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11771-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11771-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11771-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:3874:4250:4321:5007:8526:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13149:13230:13311:13357:13439:14096:14097:14659:21080:21433:21611:21627:30041:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: woman25_6f63d04d92e16
X-Filterd-Recvd-Size: 2044
Message-ID: <1518638764.3678.23.camel@perches.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <mawilcox@microsoft.com>,
 Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,  Kernel
 Hardening <kernel-hardening@lists.openwall.com>
Date: Wed, 14 Feb 2018 12:06:04 -0800
In-Reply-To: <20180214195631.GC20627@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
	 <1518634058.3678.15.camel@perches.com>
	 <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
	 <1518636765.3678.19.camel@perches.com>
	 <20180214193613.GB20627@bombadil.infradead.org>
	 <1518637426.3678.21.camel@perches.com>
	 <20180214195631.GC20627@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592408182125259845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 11:56 -0800, Matthew Wilcox wrote:
> On Wed, Feb 14, 2018 at 11:43:46AM -0800, Joe Perches wrote:
> > On Wed, 2018-02-14 at 11:36 -0800, Matthew Wilcox wrote:
> > > If somebody wants them, then we can add them.
> > 
> > Yeah, but I don't think any of it is necessary.
> > 
> > How many of these struct+bufsize * count entries
> > actually exist?
> 
> Wrong question.  How many of them currently exist that don't check for
> integer overflow?  How many of them will be added in the future that
> will fail to check for integer overflow?
> 
> I chose five at random to fix as demonstration that the API is good.
> There are more; I imagine that Julia will be able to tell us how many.

No such conversions exist in the patch series
you submitted.

What are those?
