Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E05C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F822081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8/pYXHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F822081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeKCDgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:36:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46620 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:36:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id q1so4486143qkf.13;
        Fri, 02 Nov 2018 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XStlG1IVOPz03XrBY4kJcyeuULnJcYmDsn2P5pl1Mto=;
        b=G8/pYXHl+QdLKV5ZhPZKLsio8+PCRl+gGDhftMGAlpxcF7Hwderd044mSvvM9ZpYPH
         Jd7ijRZueDNH8+VQ9zKAdxa8bVzCEvTL2RFuewPwIXLcNly9nOzrFBCb4Lz0fEXOgKw5
         1r6Wbd6X60jOKSL78LcgLqjLCS0OFR/MgD6rc8iOev/k3e/JqZ964BNUzjVkZzX0b6sY
         NNZOwwn1fY+bZBOBxPDueJ/+xnCI5mux7vL865IePbsRYAW8MGrtvMgZRHynCRDsPcym
         CHTC7tw2YpiLQLHLvaH6FWsK0EgGSGOve/x1Kkd/shUTF4ljQDRPU/GqmUfTq4cah2oN
         PqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XStlG1IVOPz03XrBY4kJcyeuULnJcYmDsn2P5pl1Mto=;
        b=rbjmsXuKNSAG5dGF9PlFd2z4F14Us2r58ANdFTJH+7/NL/jIZ3gi8hzudl7c4ZT2Q6
         YeS/u4wJIYVhTQXX29m4DsZeJF4qjCBTBGtS55bA9X2i+XUwJbHhA6qnqYS82ii3yuGu
         zE0EipBB4ibQadRftylY08UUJ8E46Wf6nVljyytmeFbFHHxFd89iO1nSnB3NVGJFAU7Q
         DZPxzWApIxwTwpZgxjgxOI42etXaGG6kjwaxwzzJk5Xjcfqm3koTMAeSqyX0Xp6MS0zv
         kEuYBUMh7j7z7jcW2GNaeeDfXynX5e5B6CtgvCWDzcwnrvCuR3gCcXb7iw7YeJxiOx6u
         acxw==
X-Gm-Message-State: AGRZ1gIe0B2XWOwinJYejCn4h0m4O8q6cvcWRqNmzeU3eVB3AVACf5+J
        nd7Rl0jryNT688P4/eEotrYp8m/CP2xbePOUhjf5ko74auQ=
X-Google-Smtp-Source: AJdET5crX3ODdsC3s1REnEW9q8oVu30cd0n2FWNilP2EaEIg/krVujWgYtCuBwHj96PGC4gWnrSzn3Uvgkf0uc+gVyQ=
X-Received: by 2002:a0c:b60a:: with SMTP id f10-v6mr12347411qve.7.1541183278826;
 Fri, 02 Nov 2018 11:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181102102703.21846-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181102102703.21846-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:27:47 +0200
Message-ID: <CAHp75VcJDSM31JMzHnFcb=Rh9wOn+LJ-qKe7x-S8h3P9AQwcdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 12:29 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> This adds support to show the Latency Tolerance Reporting for the IPs on
> the PCH as reported by the PMC. The format shown here is raw LTR data
> payload that can further be decoded as per the PCI specification.
>
> This also fixes some minor alignment issues in the header file by
> removing spaces and converting to tabs at some places.

Thanks for the update, my comments below.

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

> [andy: fixed output to avoid LTR duplication and put space after colon]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You incorporated changes I proposed =E2=80=94 good!
But please, don't do my job with signing stuff, etc. Just mention what
you did in the changelog.


> +static const struct pmc_bit_map spt_ltr_show_map[] =3D {
> +       {"SOUTHPORT_A",         SPT_PMC_LTR_SPA},
> +       {"SOUTHPORT_B",         SPT_PMC_LTR_SPB},
> +       {"SATA",                SPT_PMC_LTR_SATA},
> +       {"GIGABIT_ETHERNET",    SPT_PMC_LTR_GBE},
> +       {"XHCI",                SPT_PMC_LTR_XHCI},

> +       /* IP 5 is reserved */
Since we dropped explicit numbering, this line and similar sounds redundant=
.

> +       {"ME",                  SPT_PMC_LTR_ME},
> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
> +       {"EVA",                 SPT_PMC_LTR_EVA},
> +       {"SOUTHPORT_C",         SPT_PMC_LTR_SPC},
> +       {"HD_AUDIO",            SPT_PMC_LTR_AZ},
> +       /* IP 10 is reserved */
> +       {"LPSS",                SPT_PMC_LTR_LPSS},
> +       {"SOUTHPORT_D",         SPT_PMC_LTR_SPD},
> +       {"SOUTHPORT_E",         SPT_PMC_LTR_SPE},
> +       {"CAMERA",              SPT_PMC_LTR_CAM},
> +       {"ESPI",                SPT_PMC_LTR_ESPI},
> +       {"SCC",                 SPT_PMC_LTR_SCC},
> +       {"ISH",                 SPT_PMC_LTR_ISH},
> +       /* Below two cannot be used for LTR_IGNORE */
> +       {"CURRENT_PLATFORM",    SPT_PMC_LTR_CUR_PLT},
> +       {"AGGREGATED_SYSTEM",   SPT_PMC_LTR_CUR_ASLT},
> +       {}
> +};

>  /* Cannonlake Power Management Controller register offsets */
> -#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
> -#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
> -#define CNP_PMC_PM_CFG_OFFSET                  0x1818
> +#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
> +#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
> +#define CNP_PMC_PM_CFG_OFFSET                  0x1818
>  #define CNP_PMC_SLPS0_DBG_OFFSET               0x10B4

Can we preserve ordering?

>  /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
> -#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
> +#define CNP_PMC_HOST_PPFEAR0A                  0x1D90

What's wrong with this line? Why is it changed?

>
> -#define CNP_PMC_MMIO_REG_LEN                   0x2000
> -#define CNP_PPFEAR_NUM_ENTRIES                 8
> -#define CNP_PMC_READ_DISABLE_BIT               22
> +#define CNP_PMC_MMIO_REG_LEN                   0x2000
> +#define CNP_PPFEAR_NUM_ENTRIES                 8
> +#define CNP_PMC_READ_DISABLE_BIT               22

What happened to these lines?

>  #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)

Perhaps
 + blank line
here

> +#define CNP_PMC_LTR_CUR_PLT                    0x1B50
> +#define CNP_PMC_LTR_CUR_ASLT                   0x1B54
> +#define CNP_PMC_LTR_SPA                                0x1B60
> +#define CNP_PMC_LTR_SPB                                0x1B64
> +#define CNP_PMC_LTR_SATA                       0x1B68
> +#define CNP_PMC_LTR_GBE                                0x1B6C
> +#define CNP_PMC_LTR_XHCI                       0x1B70
> +#define CNP_PMC_LTR_ME                         0x1B78
> +#define CNP_PMC_LTR_EVA                                0x1B7C
> +#define CNP_PMC_LTR_SPC                                0x1B80
> +#define CNP_PMC_LTR_AZ                         0x1B84
> +#define CNP_PMC_LTR_LPSS                       0x1B8C
> +#define CNP_PMC_LTR_CAM                                0x1B90
> +#define CNP_PMC_LTR_SPD                                0x1B94
> +#define CNP_PMC_LTR_SPE                                0x1B98
> +#define CNP_PMC_LTR_ESPI                       0x1B9C
> +#define CNP_PMC_LTR_SCC                                0x1BA0
> +#define CNP_PMC_LTR_ISH                                0x1BA4
> +#define CNP_PMC_LTR_CNV                                0x1BF0
> +#define CNP_PMC_LTR_EMMC                       0x1BF4
> +#define CNP_PMC_LTR_UFSX2                      0x1BF8

--=20
With Best Regards,
Andy Shevchenko
