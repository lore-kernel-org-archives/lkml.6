Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812CDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC20216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FtpeoHcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC20216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeI1E6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:58:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44228 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1E6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:58:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so3637363oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzp6chPE4U/om/RqIyXbbVoLFTq6OEjXopugcPjwqo4=;
        b=FtpeoHcZMCUJcWDH4U4AyhPFwfVklJj9BEn/LjzWCWY4gUKHHX2YVYsENYzK9YRW5t
         1+o7vTRl+nSFdh7Fr6+C5dBXPXls0wYFbl6FMtuCIGRc4KSOXCqzTjBl+60PT/PeXIes
         zuNZqnJg/JNi6JKiNcLWdixLKMzQyPmCJwdB3VBvBOjy7POJ0YrdJTQFM6f+av3kP1l+
         IW9wNOSZ3G2JclspOVeaRb5tg7/9Te6vMK5lhcjoAfYA/BRtSmoIduBhkT3W54DzChrd
         d0+AKJJkQmw0XwED/yk5/yTjkuW/nZfoVRrGnldcRTXIbn3ZqGSvQRZEhMgt7z8zDQ0N
         b1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzp6chPE4U/om/RqIyXbbVoLFTq6OEjXopugcPjwqo4=;
        b=NPS/QBj/eD4V88ImYuj9Sw2M9j6YPhfbpoMFr6QQQ9aayicU3grgSMNGz94eJ9cIyM
         in5t5RdwZORcFONUaqS5ZCSBNu4bDE/l/2y2ebHXCRhVf5zL+RZYqrrBIAnyn087+HTU
         AI7XhVG2eWCPITb2Z89W0FHXNNDkOKLrejCUn26/pRoM7x1l2/qhwCGCJN9n7Mn4A3Jg
         Pbsu9OysjPa33P/WXK9t2v+kXbsB+pQQnVUoew66RwMewMe4TV86U9GREFBoXsSsprAT
         aDnevfgnv1loq3mOBSn+g9x41gsIQAoLsKk/UQ35pnDYL3Cbrz4HKDxlcddrLFuFbKGn
         /t9w==
X-Gm-Message-State: ABuFfoitsOP+fx8cJsus0J6OSJGSaUO7NnASlzN5yeAQKBYPULWYFTlP
        zC16ceC15NmMDGq8KG4Rn9ymmzWrOJSa7p5JT4+8XIlu
X-Google-Smtp-Source: ACcGV61FErPhtHUlM6Yo7w/jjnP5J2Uy/mO5NZ2b8N98K0ud8a85tlrTrSvafpqlaKc/8hW6Lwh5j998g4ROa5yKO0M=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr3970652oig.159.1538087888280;
 Thu, 27 Sep 2018 15:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <1538086549-100536-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1538086549-100536-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Sep 2018 15:37:56 -0700
Message-ID: <CAPcyv4jgNsqxKjaQNuY8t1FXcoNNThAoYuAvd=7Gg=JqvZHx3g@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: dax: add comment for PFN_SPECIAL
To:     yang.shi@linux.alibaba.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:17 PM <yang.shi@linux.alibaba.com> wrote:
>
> The comment for PFN_SPECIAL is missed in pfn_t.h. Add comment to get
> consistent with other pfn flags.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: rephrase the comment per Dan

Looks good for the -mm tree.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
>  include/linux/pfn_t.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> index 21713dc..d6cc4b5 100644
> --- a/include/linux/pfn_t.h
> +++ b/include/linux/pfn_t.h
> @@ -9,6 +9,8 @@
>   * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
>   * PFN_DEV - pfn is not covered by system memmap by default
>   * PFN_MAP - pfn has a dynamic page mapping established by a device driver
> + * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
> + *              get_user_pages
>   */
>  #define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
>  #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
> --
> 1.8.3.1
>
