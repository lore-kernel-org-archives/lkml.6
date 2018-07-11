Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E75C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFF020857
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6gd1mAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFF020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeGKNzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:55:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34419 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbeGKNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:55:50 -0400
Received: by mail-lf0-f67.google.com with SMTP id n96-v6so21341578lfi.1;
        Wed, 11 Jul 2018 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGmb/SK4/5gaIjzTrMswGNRfj/L4bEKNv64u9bMTbkc=;
        b=G6gd1mAcvwiyORuFP9mKxc3aKMgzJWtRuXJf3uKpWPVPEvfqhDmHdp0Lz/Z2pJi/Mk
         DP2XvJpelgnKTgsJc2sDYUbXYRbjcMfBJq1yOuVXxphdOznkfE2PQ0DEIoxvMbG2IG2X
         bwNddBpgLDrZFWXT9UAYR25bmWKAe0I5nOvu/TCaDiUBTWXm6Lu76h4IKd8iT5JNomTU
         fCVBQqrjWkwftbE2R3YLi/bsElNyZlboe0nJEcxHHoweK6pOfhKFhHdozHU1HSQJz1F+
         zedUGWvB8TxK/lDu1H4SkvVC7isN4OArFV9+orSSmA5bWceja5LnZAA8iPmrgUu1+RbA
         H9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGmb/SK4/5gaIjzTrMswGNRfj/L4bEKNv64u9bMTbkc=;
        b=eyz9yTqYNEJD0RxdzS/O90QMEnfZZUecKJCWG0Huiyn2MfmKEjEqHDh/5bcWiQS/Jp
         z7x7fGhsRw3uwoP62owxDvyPWonb6GVXo4YQCvlXiCMYesqDvZVq+S3TOI7fugZmUoCl
         meqGDKXUoItxzu7LX/Ct98VTvG4sVnJ71hevnANXzdECT3jCRRmKojywzUacHMo8NGhb
         UmMJ43XHZE8gi+GG3czn8cq1wNfy2jDbYeAKWwN9nr1ylwRo/vvQz1+tDKEiTY9QK3XA
         ExAMttpXxuTR4R+hcySGHpzCCmZISBJprsooVFh667fvlNfWhjWM33Q8Ilac0TtM5RCH
         BcRA==
X-Gm-Message-State: APt69E2jp1h9wp8ThixZ1ZKh7cVc29/MetBXS5jain9IAKYdN+pYslNl
        af1OWSE9ytAUMC8lOi2e+xA=
X-Google-Smtp-Source: AAOMgpfCBsr0mKj/PrEaQPjVZesxwh0/I2u76DRVyH97l+939ry3BBJgdyvvYIWJoCKA3o9tKYCWVg==
X-Received: by 2002:a19:1749:: with SMTP id n70-v6mr5851378lfi.54.1531317082298;
        Wed, 11 Jul 2018 06:51:22 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3047202ljt.21.2018.07.11.06.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:51:21 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:52:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180711135210.GA18730@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <20180711065631.GA21948@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711065631.GA21948@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On Tue, Jul 10, 2018 at 11:56:31PM -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> > + * requests a cachable mapping with CWB attribute enabled.
> >   */
> >  #define ioremap_cacheable_cow(offset, size)				\
> >  	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> 
> This isn't actually used anywhere in the kernel tree.  Please remove it
> as well.

I don't really know whether it is necessary at this point. We discarded the 
ioremap_uncached_accelerated() method, since the obvious alternative is now
available: ioremap_wc(). While ioremap_cacheable_cow() hasn't got one.
So if it was up to me, I'd leave it here. Anyway if the subsystem maintainers
think otherwise, I won't refuse to submit a patch with this method removal.

Regards,
-Sergey

