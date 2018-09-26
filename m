Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957ACC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B81F214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLFqTdqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B81F214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeIZUBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:01:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42470 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:01:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id w73-v6so9918604qkb.9;
        Wed, 26 Sep 2018 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTUT9zklqoW9nrK8SE8Gpn55j3DZMaEfU2fi/GJxgNw=;
        b=dLFqTdqnTAkVdJpLu3VrSh5ukAbFiGiMsTOUvJgEGGJRHBx3/tGK673MD/FnfjLRDk
         mFGW6Kbp2hpBlmE0Ic9O4f+uvtFPqRvKD4UTtynzk9K++KVBwA4mPYJ0xCisAcWbjo/8
         i76FLG3qCANmADCmBKiDnGJKj48NcvKayY3wbQPkDmZTAEdYmXChKkvFE0n0dIhfTraj
         r2d3BFbsKilac7kAj4vsZerNxbhdk4Kh13/4GkFZZYtdkoTyOyf6DV/kAjceg0o7MzyN
         OaKVHd/Wu/9AlpSDl85T82DEmw9q3jDVxj2HuCOsNVb/A2nnRb0BG5Bi//WDjDbaYACN
         fF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTUT9zklqoW9nrK8SE8Gpn55j3DZMaEfU2fi/GJxgNw=;
        b=tkd9/wHd82yKeN23SVBSU8IindzoT5afi8TdrnBtD3brA2Zaos6pkf3k7+A6qyeqH7
         n2osZBLc96WUv2+Ahjd9T4673zb9s1QBlgymeK6VoRszmxWCLvN3AIZqWnYvrd4cKhPm
         xQNolu2SUUI9CuXoCP+kRg4e/XqTT8CxPYEL7MWZ+c5iTuib9UrB5/X5irZCp/7bCq0J
         pycDIaB5SqNX4c9s1csxd1WAql8l8mesIcPivsDrBgmhVfxdDNoH0XpbxHfZI649eoQX
         M9to2qBoHSnu5jSr2xLFknlwX1SS0vdalh4q5+U+TTNrMpWfnBg/awtN4ZVTwvCu58Hb
         c/YA==
X-Gm-Message-State: ABuFfoiv3MiFQKUkWuqThGAhhrrApCi1ovwRWpj7o0zZE9EGCP3r+nKe
        SpKLO06K74WfNEeQkDiBF7sU2mQyb8Km8fk4GhQ=
X-Google-Smtp-Source: ACcGV60HBairq8+jYIdyXD43bJB3DovrcRF5dpzK1wpJjJDYh6LrtcacwKUCw5fAYhJXlBtTS84A/CaxJDY/w4/xMBg=
X-Received: by 2002:a37:4712:: with SMTP id u18-v6mr4281242qka.301.1537969716235;
 Wed, 26 Sep 2018 06:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 16:48:18 +0300
Message-ID: <CAHp75Vesn4TrdF8tWLkU7nCRGp_o8fEK6gxpTkwM7E7zQo0qKg@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/x86: intel_pmc_core: Show Latency Tolerance info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 9:06 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> This adds support to show the Latency Tolerance Reporting for the IPs on
> the PCH as reported by the PMC. The format shown here is raw LTR data
> payload that can further be decoded as per the PCI specification.
>
> This also fixes some minor alignment issues in the header file by
> removing spaces and converting to tabs at some places.

Thanks for the patch, my comments below.

> +static const struct pmc_bit_map spt_ltr_show_map[] = {
> +       {"IP 0  : LTR_SOUTHPORT_A",             SPT_PMC_LTR_SPA},
> +       {"IP 1  : LTR_SOUTHPORT_B",             SPT_PMC_LTR_SPB},
> +       {"IP 2  : LTR_SATA",                    SPT_PMC_LTR_SATA},
> +       {"IP 3  : LTR_GIGABIT_ETHERNET",        SPT_PMC_LTR_GBE},
> +       {"IP 4  : LTR_XHCI",                    SPT_PMC_LTR_XHCI},
> +       /* IP 5 is reserved */
> +       {"IP 6  : LTR_ME",                      SPT_PMC_LTR_ME},
> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
> +       {"IP 7  : LTR_EVA",                     SPT_PMC_LTR_EVA},
> +       {"IP 8  : LTR_SOUTHPORT_C",             SPT_PMC_LTR_SPC},
> +       {"IP 9  : LTR_HD_AUDIO",                SPT_PMC_LTR_AZ},
> +       /* IP 10 is reserved */
> +       {"IP 11 : LTR_LPSS",                    SPT_PMC_LTR_LPSS},
> +       {"IP 12 : LTR_SOUTHPORT_D",             SPT_PMC_LTR_SPD},
> +       {"IP 13 : LTR_SOUTHPORT_E",             SPT_PMC_LTR_SPE},
> +       {"IP 14 : LTR_CAMERA",                  SPT_PMC_LTR_CAM},
> +       {"IP 15 : LTR_ESPI",                    SPT_PMC_LTR_ESPI},
> +       {"IP 16 : LTR_SCC",                     SPT_PMC_LTR_SCC},
> +       {"IP 17 : LTR_ISH",                     SPT_PMC_LTR_ISH},
> +       /* Below two cannot be for LTR_IGNORE */
> +       {"LTR_CURRENT_PLATFORM",                SPT_PMC_LTR_CUR_PLT},
> +       {"LTR_AGGREGATED_SYSTEM",               SPT_PMC_LTR_CUR_ASLT},

Before no map has this fancy "IP xx :" prefixes. Please, remove.

> +       {},

No need for comma

> +

Redundant.

> +};

> +static const struct pmc_bit_map cnp_ltr_show_map[] = {

Same comments as above.

> +};

> +       debugfs_create_file("ltr_show", 0644, dir, pmcdev,
> +                           &pmc_core_ltr_fops);

One line?

>  #define NUM_RETRIES                            100
>  #define NUM_IP_IGN_ALLOWED                     17

+ blank line here.

> +#define SPT_PMC_LTR_CUR_PLT                    0x350

-- 
With Best Regards,
Andy Shevchenko
