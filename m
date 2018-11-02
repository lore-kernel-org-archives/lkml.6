Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837AFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A312081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGDnaqce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A312081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKCDk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:40:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46021 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKCDk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:40:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id d135so4513061qkc.12;
        Fri, 02 Nov 2018 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vspMdCH1oMkJ33sgJQRujPN+jYdkxtwarIuAd1mp6A=;
        b=TGDnaqceiGjlQ0IzWToUNHV/sIaNSri/exT6eOSVsQgLn05yH5WUUhp9hOlmHf/rJO
         9mOjZa1BzIX0Xf7M2V6P3z4EU5zMTKUznbP1XEg1pmbybThYZCPX52kUhZf9plLxTcdl
         CZtDaLSZrKcLF9une23uXI8/W+UdKLTYLZJ6Lhmo7ai7FVT4PtjIYXWc3fE3H7q6Ilco
         QNxNO7jgV6qNlCPTVETeDyQdFcyMSzfMkVaY2XkCkNBKEgiWZGHTt4xP/p/vdq0X8Kf3
         0HGs5swctiuY+Cyf9O/dL0UdKtbhRh5G8sbr9a+kE9wZw73sQi3F3KluZo2+l3rn9w2S
         +W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vspMdCH1oMkJ33sgJQRujPN+jYdkxtwarIuAd1mp6A=;
        b=pWrf6LfKjE0tAP8gc56TwLwg9rOi/Wblwraf1MCi04WnEHpNNseqbACuKa1bulFEfg
         0GgvUgBmV2LXuH/K8v+njBRW5rqTJtiCutjsVrdbp+v1hUI+1XtB6gcfyifXhnhQsFDB
         dmLSyux8dZ1ssus8uwCgwrXh8f1b7Syl0CBNpGVN+valc40fAyegxETsbFuFwqXTsN31
         hucX9ASjRT8r5Ip0wg1mDJlz2vt5zoqdNS6rgpwWd7WTFXAo33EnWsizrrY1OssAEys+
         wiTu5SFssF3l8Y2goS/qweQ8JgjZ01Bz5nerpvGlgfhRdyKzgufMuZIeHPQ742Kb+vFp
         rq1g==
X-Gm-Message-State: AGRZ1gJzCG+oIhvcrclvNbID6T/y6nzRWXmeZ19BRZ4htJJYzE/jsdQK
        bGfHLkD2z+ZMLiLLGyYERYEplJL96pK5G8IF3DY=
X-Google-Smtp-Source: AJdET5fE4aBKu4356TyFVftsNgRGAyR9uT5ASfIX0z6c1ioXQTEE0cO+lNwW4BeGHT+c96JJTByz7u752SLgFs9MTFs=
X-Received: by 2002:aed:3b76:: with SMTP id q51mr8792998qte.229.1541183567821;
 Fri, 02 Nov 2018 11:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181102103441.21943-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181102103441.21943-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:32:36 +0200
Message-ID: <CAHp75VfCcLPc_y4ZxvkahpMxjkj_5sntamYze90p7Ki94yU5Lg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 12:37 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> The LTR values follow PCIE LTR encoding format and can be decoded as per
> https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf
>
> This adds support to translate the raw LTR values as read from the PMC
> to meaningful values in nanosecond units of time.

> +#include <linux/bits.h>

I told you something different, i.e. put this header where you _use_
it, i.o.w into the header file.

> +#define LTR_REQ_NONSNOOP                       BIT(31)
> +#define LTR_REQ_SNOOP                          BIT(15)
> +#define LTR_DECODED_VAL                                GENMASK(9, 0)
> +#define LTR_DECODED_SCALE                      GENMASK(12, 10)

If these are in one register, please keep ordered by start bit.

The rest is fine.

-- 
With Best Regards,
Andy Shevchenko
