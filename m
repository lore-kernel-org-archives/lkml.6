Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB38C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F8B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mKSNGvEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F8B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJWBdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:33:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41017 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:33:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id l197-v6so32830815oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0V1t8kfAngLPXWra9ffpiy4gOvH9IwmN1ZHYwA8AK0=;
        b=mKSNGvEhfVdi8c5qYoevG7RGZBL3Qid6RnkDSGCyHOUp1D1WeUe4KA0DSniHDKNtrN
         yqFbIs0EppCppAHdYmobUHd4/DRK3hYvn7jO47gX8ZZzHyYjfflqvWDd0hZPP8y5iJrh
         J1TgKiIVXJ16qL2mhTKiij/IoPDvhFHLPzOV5DJEfAaAW9CUQEKmBg5tQo3Bl9m2uGNi
         89OWtf2VTr4gXvyQeu67hI3ijJtEyNI8YrERmHLyosvmTEJ0XHlASUIuGqQiJZ6HWVjv
         X5FBhqeS/qoJmSWEfCsk8ebid5C28hK9zoo8e2Fn1t5GI+ZdjuHch74IH4B+lGlmbLXT
         vkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0V1t8kfAngLPXWra9ffpiy4gOvH9IwmN1ZHYwA8AK0=;
        b=gB8OEcJAUzdtNLLwbMXzqGe1iacMfZ4/u20zPjgr+/vMg6JLb0SFBKBC/82nD5lKjv
         POaGGevPxnZ848LINPws5CcK+4vUybr2haoIC3Od3D/xKk+N6Ruh7ydrFNegHAELxW3s
         pf0S+ejoPvvh+Hp2uu60DdvdoJ1MRS2/U3e5Y61ffpJE0gPxcObbCBl/TCWWdYftO+O4
         NKLZbqa8KNqvaVFf6I4PSo/uQM//oP6lkPFb81zqUUCktggGCQhO6iiCYqduIXaqtcgs
         eBwRduXqGe1YN5EuNv0kL0JUgHS5nadW47HmLo22VH+A4Po4vvWYlvD7RWR5z1REoVCT
         YuMQ==
X-Gm-Message-State: ABuFfoit+9CVwCMPDdQqOfn43obfgCZbYi+RWl6EG4BzwkIWTQaRt4KO
        AL29+eUdjGTCLUwUdqSPeBembg57/tGi8CkG4xes1w==
X-Google-Smtp-Source: ACcGV63P6XyFjU5LhZoSMuH4vsIBZ0TJjaeWw32bne78EBuLqtifHgMQp7JSnsEFyfKb3ZOOSNp9TuCTr0ZM5OggonM=
X-Received: by 2002:aca:590b:: with SMTP id n11-v6mr23163858oib.232.1540228439626;
 Mon, 22 Oct 2018 10:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
In-Reply-To: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Oct 2018 10:13:48 -0700
Message-ID: <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
Subject: Re: [PATCH] pfn_t: force '~' to be parsed as an unary operator
To:     sebhtml@videotron.qc.ca
Cc:     Steven Rostedt <rostedt@goodmis.org>, acme@redhat.com,
        tz.stoyanov@gmail.com, Namhyung Kim <namhyung@kernel.org>,
        zwisler@kernel.org, arangradient@gmail.com,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ added Andrew ]

Patch here: https://lore.kernel.org/patchwork/patch/1002234/

On Sun, Oct 21, 2018 at 8:00 AM Sebastien Boisvert
<sebhtml@videotron.qc.ca> wrote:
>
> Tracing the event "fs_dax:dax_pmd_insert_mapping" with perf produces this
> warning:
>       [fs_dax:dax_pmd_insert_mapping] unknown op '~'
>
> It is printed in process_op (tools/lib/traceevent/event-parse.c) because '~'
> is parsed as a binary operator.
>
> perf reads the format of fs_dax:dax_pmd_insert_mapping ("print fmt") from
> /sys/kernel/debug/tracing/events/fs_dax/dax_pmd_insert_mapping/format .
>
> The format contains:
>
> ~(((u64) ~(~(((1UL) << 12)-1)))
>          ^
>          \ interpreted as a binary operator by process_op().
>
> This part is generated in the declaration of the event class
> dax_pmd_insert_mapping_class in include/trace/events/fs_dax.h :
>
>                 __print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
>                         PFN_FLAGS_TRACE),
>
> This patch adds a pair of parentheses in the declaration of PFN_FLAGS_MASK to
> make sure that '~' is parsed as a unary operator by perf.
>
> The part of the format that was problematic is now:
>
> ~(((u64) (~(~(((1UL) << 12)-1))))
>
> Now, all the '~' are parsed as unary operators.
>
> Cc: Dan Williams <dan.j.williams@intel.com>


Acked-by: Dan Williams <dan.j.williams@intel.com>


> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Elenie Godzaridis <arangradient@gmail.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sebastien Boisvert <sebhtml@videotron.qc.ca>
> ---
>  include/linux/pfn_t.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> index 21713dc14ce2..673546ba7342 100644
> --- a/include/linux/pfn_t.h
> +++ b/include/linux/pfn_t.h
> @@ -10,7 +10,7 @@
>   * PFN_DEV - pfn is not covered by system memmap by default
>   * PFN_MAP - pfn has a dynamic page mapping established by a device driver
>   */
> -#define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
> +#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
>  #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
>  #define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
>  #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
> --
> 2.17.1
>
