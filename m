Return-Path: <kernel-hardening-return-11766-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227D4Vr8beTvYAtL7AMzzJHdMaW6nCY5dBPiSpuZxxWvP1RIf0uSJ31MTiujZlAt74MX1fA1
ARC-Seal: i=1; a=rsa-sha256; t=1518636995; cv=none;
        d=google.com; s=arc-20160816;
        b=yCpZu9Njz/MW9rFx8sF+ziDul22DEbyrG/OhdsnOzsgZTdxfGuA+pe/PtC3VaGc30P
         0B9tZ1PN2Bvxh56jBZY7+2Etrk1aFnp8o411ZSYwcEp8X6A0xXIXe4SqjnwYD9WYz6Wz
         3Eq3NVpBdnVfdMxFdN3CAKLlappxuuIeXPcvtNi9l5X8PwZNcZgXYqD3OpSolH2pp0tl
         1DKnkSAuGOm4/GBRC0wFLdvAYPYbQBjCTHP/PADpw3DJPSO1ZFbITzK7BsRFA7xijUcX
         YdOMGdbAzW+MmCBiT5Dg/9fayibR51vSC8fln0h1jVcKD5WcuIPQ02cy7Vsyhmd7sUps
         mh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=tluaSAInQ0RtnC/13oB4uLOUTaTM46m+ILHUQjElGTk=;
        b=PrL6l4ED0vSv3C/zp9vDIqcVJTLzWOYqJJ519tcUr/8+ppuBASq+tnaxm0ZiC8uW/w
         OjmZnbFco5ORZi+pduBCleOOG/HX2dNxUEUeVh8IYnGnU+jVJ6XxNsVttYGZ8mXPHEu/
         yhLdip3FkalQMomHd5KL2Ic4ajdR8CD8O6MfR2BlrEcFHaibDrPtN0UyLMJzAleOVhnX
         +IOSGIvmm844iyQYZyuHOw/323k2DELMg7V9lYYJlPIQTz+WaeOCPmckmXsLEAIpl3Se
         rMJNkaxUdafb4a72cFH0W80+c0Pv5hT3kqEu1UjahkbbhOFDiWwXORmXrUoGQ2OkkRf3
         ZeHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=SOkTAynz;
       spf=pass (google.com: domain of kernel-hardening-return-11766-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11766-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=SOkTAynz;
       spf=pass (google.com: domain of kernel-hardening-return-11766-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11766-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 11:36:13 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
Message-ID: <20180214193613.GB20627@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <1518634058.3678.15.camel@perches.com>
 <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
 <1518636765.3678.19.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518636765.3678.19.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592406306775449404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:32:45AM -0800, Joe Perches wrote:
> On Wed, 2018-02-14 at 11:23 -0800, Kees Cook wrote:
> > On Wed, Feb 14, 2018 at 10:47 AM, Joe Perches <joe@perches.com> wrote:
> > > I think expanding the number of allocation functions
> > > is not necessary.
> > 
> > I think removing common mispatterns in favor of overflow-protected
> > allocation functions makes sense.
> 
> Function symmetry matters too.
> 
> These allocation functions are specific to kvz<foo>
> and are not symmetric for k<foo>, v<foo>, devm_<foo>
> <foo>_node, and the like.

If somebody wants them, then we can add them.
