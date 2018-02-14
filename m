Return-Path: <kernel-hardening-return-11789-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225WXkGqzWKl8KcxjGXzSn/x1apagSBy9wxEbeCOFtpV/TUhOz0Rvx59Pc4yRXoLHPvBtDWv
ARC-Seal: i=1; a=rsa-sha256; t=1518640260; cv=none;
        d=google.com; s=arc-20160816;
        b=nSgnxwDKWFfG6vRElxTFC6TWWCGD1PnWuB0tu6M5gJMf5h5duYEhMgm5axXgnhz9wD
         vDdIuUIL82Gs0lZJpWwz+ULDOM+BS45gqrzdAl9xsEL536fGts1fNGf+4e0vY86bhZfC
         WFCng6dwP2UxPzWygkWYJiGnhw2tjp45UV/7z4lHhLuQa+G06UloLwzRjB5OFc/jsLnC
         0NJHI0sAQhPyJBC0g+lUx4immfOv1yu88kbA2khiac7B+B3SP/4WV7t09jXWRP1VkhRM
         m7jNf2lztbA76gEH/X1L8hPGdQ0EeSrdEg/fL4yhuXZb2qTocwOsoMBZlf+hVqWEcDlo
         GvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LYLMLeNI8S7YKYS5f5OaKBwUnCo4giGOIN4idZvyeuI=;
        b=SgJRqtW9TCn/T8ZBIr7B8tQUjr6F5uWx+uD7DjsHqf+8sb1hyW3NJI3uezYOl/DeOh
         /HUyQGNrh09TA+W7notFWUxM0XJ+5z0xxo3Qp/DxFvbJg/KZDmAum98rnx1iyUwGeNhh
         t4+LekJEyuJpCVhlt945HRbSyjeVyQD54R50sTGbPJlhTCW+91//0KzarHpQetWCL/zz
         t3gl66dd3jO4z1q7Feb5TZIoxPafhUruj6uCjcVLE+9ojHK6OMMcuRnlPAXcL0nVqOn8
         WSJuwDiDvMXr6fRFjs7WbHyubLdoef+S1JkBPFEBPU3gYuJO8Na8SkusEVDCgb/tFDK2
         Ibtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11789-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11789-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11789-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11789-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:966:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3874:4250:4321:4385:4605:5007:6119:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: feet86_23090c8df7714
X-Filterd-Recvd-Size: 1594
Message-ID: <1518640239.3678.26.camel@perches.com>
Subject: Re: [PATCH v2 3/8] Convert virtio_console to kvzalloc_struct
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
 <mawilcox@microsoft.com>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>,  linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Date: Wed, 14 Feb 2018 12:30:39 -0800
In-Reply-To: <20180214202835.GE20627@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
	 <20180214201154.10186-4-willy@infradead.org>
	 <1518639587.3678.25.camel@perches.com>
	 <20180214202835.GE20627@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408604560950999?=
X-GMAIL-MSGID: =?utf-8?q?1592409730339392935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 12:28 -0800, Matthew Wilcox wrote:
> On Wed, Feb 14, 2018 at 12:19:47PM -0800, Joe Perches wrote:
> > On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> > >  	 */
> > > -	buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
> > > -		      GFP_KERNEL);
> > > +	buf = kvzalloc_struct(buf, sg, pages, GFP_KERNEL);
> > >  	if (!buf)
> > 
> > kvfree?
> 
> Yes, that would also need to be done.  The point of these last six
> patches was to show the API in use, not for applying.

That's what RFC is for...
