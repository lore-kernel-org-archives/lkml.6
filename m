Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B7C282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BB6213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBJAUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 19:20:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42326 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfBJAUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 19:20:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so8281443qtr.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 16:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OJYSKa853QJfoFCHi5ptf5Uu0+lqO9YmIgFb3XnpUo=;
        b=A22wIeR2vhPqmpV5TxR0I6TadNuEE9oikPYRNj6lJsWFzrWR5zcMZS10wcayqS/+kY
         wZxxX3S341oQdag7iUoxoFF4TY/7amHqah15Y7nEpqes4gk3Sm7PO9KOTA2NPbCD40FY
         3FOzKuja9Qzy+BC+6gVo+wecIQFuZpFTBxjGMs0XoUiEYvCC0x0rrp3EpibCCYAM5Bxz
         ELi2ny05s5P+xIwQSK4XJ+Ugiy7auFu2YQVvpWYES66pKlnME4fmwZcCiatjQWP17mX4
         Im4Bld7HvnrJn5zbquFz8C4koihmeaD326x7xza8qwrilrXH5FHv6g0u/j50940uzJH0
         rJjg==
X-Gm-Message-State: AHQUAuYejrAIyorDgIUvcivMGb2H3DBBCh0RPm6z6Gt1NiO4KFmqaK4n
        /qJBQ4gxtzeaN6DGwkH7fM/rpNCgiAA=
X-Google-Smtp-Source: AHgI3IaRh1/FRQWOcUY+IGZmVZUG1uFQDWXmSepNS3fG6wyHrSXD0EiN2Oca7j1H1h+kYEpI0AfPtA==
X-Received: by 2002:a0c:8665:: with SMTP id p92mr20800155qva.182.1549758052834;
        Sat, 09 Feb 2019 16:20:52 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id e4sm11730278qka.31.2019.02.09.16.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 16:20:51 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:20:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190209191723-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
 <20190208154239.GI674@zn.tnic>
 <20190208164206-mutt-send-email-mst@kernel.org>
 <20190208215232.GN674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208215232.GN674@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:52:32PM +0100, Borislav Petkov wrote:
> On Fri, Feb 08, 2019 at 04:43:37PM -0500, Michael S. Tsirkin wrote:
> > Coding style violation: if a linux/foo.h exists then it must
> > be included in preference to asm/foo.h
> > 
> > And the specific issue is that a follow-up patch moves code from
> > asm/mman.h to linux/mman.h so if any one was indirectly using
> > this header it will now miss the symbols that are being moved.
> 
> Ok, so first of all, this should be your commit message - not what you
> have there now.
> 
> Then, please send full patchsets to recipients - I have only this patch
> in my mbox and have no clue what the whole patchset is addressing.

I can copy you on all patches, sure.

> Further, do you want an ACK only or should I pick this up?


If you can pick it up then great.

> Finally, this whole file is going away:
> 
> https://lkml.kernel.org/r/7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com
> 
> so your patch might become obsolete by then. Depends on what goes first.
> 
> Thx.


> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
