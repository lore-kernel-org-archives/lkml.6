Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25283ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD4B2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT92qkdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD4B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeKIFl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:41:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38226 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeKIFl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:41:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id d19so28768692qkg.5;
        Thu, 08 Nov 2018 12:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGF2lpgC7Dgp/+bXyvLhWSCCLA9lFrB2X+dDiPnm5fM=;
        b=cT92qkdU0UY+L19oMETKNaUhytTKekzpptLaVrwk/lecb9wwv++aE43nOJGMMxGFvX
         m0AQK3XFKgxE7iVyqz/6IkRFP7BUcbbWcBkRZQ7BS2jnBwt8z38bD0z7WqQMFhjuk0w9
         AvSpB3PP0qe8CxJloqiXdI61hQwvdlFgyGXdERA5nIDTfuGBh6yah4y3Q9sBgMNh6bLa
         eoZXzQgUMW35+Gz+IecZt+QpQyRI0Ipy5pcpFAImwHzQ7hKT8mfWz9zJ8QzsvF/CvRgQ
         bWC6G2CPQpRGMKls+SVuUp11Njst1Mpt6OND7b18u6874kzI19+dRaNojL9OVmlAHvF7
         0YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGF2lpgC7Dgp/+bXyvLhWSCCLA9lFrB2X+dDiPnm5fM=;
        b=pF4pWmofrbZX46DL7iwpLkgwcfTsk6UdYjGuo0WGyGN1H5PjHzB39SdUstPvr0rVqV
         +NfxPaKvpr3LHtW2gy/OL/nWiZPYV0d/wQlEtz7yotcEkHVtlFKEAOTx0OzZO0s6XOde
         oVGviU60uo0y7eaAKwDfihYX0OA9Eg0FHV8V8i9gl+hl5ymvBZoBAPfpDXSxsuWxrmqP
         k1F9bf+nEUTMF/3ll/7Vql29ZkL6TArOw5H+/O8Egh/T/tjIg7Fzzxh+3tQlx5vQiDV9
         BORsEl9F1vpmPO9YrxwCp369bZt/ioRPHAocsrDSgsC/vxaNOswRmojvQVHMlaBGqnyw
         1Wfw==
X-Gm-Message-State: AGRZ1gIev4VwNi6ssrWJv4AOOcD198DIchG5/7iQV6IY2CzrlN6eCwUd
        f4dJt7sCnoVzHrOIHxd0CufMmTe888nVC3o4dzo=
X-Google-Smtp-Source: AJdET5d1Mek+zgArcWaI10Fz2Pt44cKz4vF1CxKQ1ML1unSc279J18/Ehds4mQoZuSzGs2yr49nOAWj2tpkn5+WRZR0=
X-Received: by 2002:aed:2d42:: with SMTP id h60mr6044069qtd.373.1541707494952;
 Thu, 08 Nov 2018 12:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20181108190244.19204-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181108190244.19204-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Nov 2018 22:04:43 +0200
Message-ID: <CAHp75VezOYCO1KCR8Fkain-gWffnHVCzBgmwDMrVs37-S76ttQ@mail.gmail.com>
Subject: Re: [Patch v4 1/3] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:05 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> This adds support to show the Latency Tolerance Reporting for the IPs on
> the PCH as reported by the PMC. The format shown here is raw LTR data
> payload that can further be decoded as per the PCI specification.
>
> This also fixes some minor alignment issues in the header file by
> removing spaces and converting to tabs at some places.
>

All three pushed to my review and testing queue, thanks!

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
> Changes in v4:
>  * Removed unnecessary comments related to reserved IPs
>  * Reordered #defines in the header in chronological order
>  * Worked on patch taken from review-andy branch that removed LTR
>    duplication strings and other style fixes.
>
>  drivers/platform/x86/intel_pmc_core.c | 69 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h | 57 +++++++++++++++++++---
>  2 files changed, 119 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 6b31d410cb09..54080c0e52fb 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -101,10 +101,35 @@ static const struct pmc_bit_map spt_pfear_map[] = {
>         {},
>  };
>
> +static const struct pmc_bit_map spt_ltr_show_map[] = {
> +       {"SOUTHPORT_A",         SPT_PMC_LTR_SPA},
> +       {"SOUTHPORT_B",         SPT_PMC_LTR_SPB},
> +       {"SATA",                SPT_PMC_LTR_SATA},
> +       {"GIGABIT_ETHERNET",    SPT_PMC_LTR_GBE},
> +       {"XHCI",                SPT_PMC_LTR_XHCI},
> +       {"ME",                  SPT_PMC_LTR_ME},
> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
> +       {"EVA",                 SPT_PMC_LTR_EVA},
> +       {"SOUTHPORT_C",         SPT_PMC_LTR_SPC},
> +       {"HD_AUDIO",            SPT_PMC_LTR_AZ},
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
> +
>  static const struct pmc_reg_map spt_reg_map = {
>         .pfear_sts = spt_pfear_map,
>         .mphy_sts = spt_mphy_map,
>         .pll_sts = spt_pll_map,
> +       .ltr_show_sts = spt_ltr_show_map,
>         .slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
>         .ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
>         .regmap_length = SPT_PMC_MMIO_REG_LEN,
> @@ -243,10 +268,38 @@ static const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
>         NULL,
>  };
>
> +static const struct pmc_bit_map cnp_ltr_show_map[] = {
> +       {"SOUTHPORT_A",         CNP_PMC_LTR_SPA},
> +       {"SOUTHPORT_B",         CNP_PMC_LTR_SPB},
> +       {"SATA",                CNP_PMC_LTR_SATA},
> +       {"GIGABIT_ETHERNET",    CNP_PMC_LTR_GBE},
> +       {"XHCI",                CNP_PMC_LTR_XHCI},
> +       {"ME",                  CNP_PMC_LTR_ME},
> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
> +       {"EVA",                 CNP_PMC_LTR_EVA},
> +       {"SOUTHPORT_C",         CNP_PMC_LTR_SPC},
> +       {"HD_AUDIO",            CNP_PMC_LTR_AZ},
> +       {"CNV",                 CNP_PMC_LTR_CNV},
> +       {"LPSS",                CNP_PMC_LTR_LPSS},
> +       {"SOUTHPORT_D",         CNP_PMC_LTR_SPD},
> +       {"SOUTHPORT_E",         CNP_PMC_LTR_SPE},
> +       {"CAMERA",              CNP_PMC_LTR_CAM},
> +       {"ESPI",                CNP_PMC_LTR_ESPI},
> +       {"SCC",                 CNP_PMC_LTR_SCC},
> +       {"ISH",                 CNP_PMC_LTR_ISH},
> +       {"UFSX2",               CNP_PMC_LTR_UFSX2},
> +       {"EMMC",                CNP_PMC_LTR_EMMC},
> +       /* Below two cannot be used for LTR_IGNORE */
> +       {"CURRENT_PLATFORM",    CNP_PMC_LTR_CUR_PLT},
> +       {"AGGREGATED_SYSTEM",   CNP_PMC_LTR_CUR_ASLT},
> +       {}
> +};
> +
>  static const struct pmc_reg_map cnp_reg_map = {
>         .pfear_sts = cnp_pfear_map,
>         .slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
>         .slps0_dbg_maps = cnp_slps0_dbg_maps,
> +       .ltr_show_sts = cnp_ltr_show_map,
>         .slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
>         .ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>         .regmap_length = CNP_PMC_MMIO_REG_LEN,
> @@ -583,6 +636,20 @@ static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
>
> +static int pmc_core_ltr_show(struct seq_file *s, void *unused)
> +{
> +       struct pmc_dev *pmcdev = s->private;
> +       const struct pmc_bit_map *map = pmcdev->map->ltr_show_sts;
> +       int index;
> +
> +       for (index = 0; map[index].name ; index++) {
> +               seq_printf(s, "%-32s\tRAW LTR: 0x%x\n", map[index].name,
> +                          pmc_core_reg_read(pmcdev, map[index].bit_mask));
> +       }
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
> +
>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>  {
>         debugfs_remove_recursive(pmcdev->dbgfs_dir);
> @@ -607,6 +674,8 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>         debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
>                             &pmc_core_ltr_ignore_ops);
>
> +       debugfs_create_file("ltr_show", 0644, dir, pmcdev, &pmc_core_ltr_fops);
> +
>         if (pmcdev->map->pll_sts)
>                 debugfs_create_file("pll_status", 0444, dir, pmcdev,
>                                     &pmc_core_pll_ops);
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index be045348ad86..fcb13ca1f2bd 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -37,6 +37,25 @@
>  #define NUM_RETRIES                            100
>  #define NUM_IP_IGN_ALLOWED                     17
>
> +#define SPT_PMC_LTR_CUR_PLT                    0x350
> +#define SPT_PMC_LTR_CUR_ASLT                   0x354
> +#define SPT_PMC_LTR_SPA                                0x360
> +#define SPT_PMC_LTR_SPB                                0x364
> +#define SPT_PMC_LTR_SATA                       0x368
> +#define SPT_PMC_LTR_GBE                                0x36C
> +#define SPT_PMC_LTR_XHCI                       0x370
> +#define SPT_PMC_LTR_ME                         0x378
> +#define SPT_PMC_LTR_EVA                                0x37C
> +#define SPT_PMC_LTR_SPC                                0x380
> +#define SPT_PMC_LTR_AZ                         0x384
> +#define SPT_PMC_LTR_LPSS                       0x38C
> +#define SPT_PMC_LTR_CAM                                0x390
> +#define SPT_PMC_LTR_SPD                                0x394
> +#define SPT_PMC_LTR_SPE                                0x398
> +#define SPT_PMC_LTR_ESPI                       0x39C
> +#define SPT_PMC_LTR_SCC                                0x3A0
> +#define SPT_PMC_LTR_ISH                                0x3A4
> +
>  /* Sunrise Point: PGD PFET Enable Ack Status Registers */
>  enum ppfear_regs {
>         SPT_PMC_XRAM_PPFEAR0A = 0x590,
> @@ -115,18 +134,40 @@ enum ppfear_regs {
>  #define SPT_PMC_BIT_MPHY_CMN_LANE3             BIT(3)
>
>  /* Cannonlake Power Management Controller register offsets */
> -#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
> -#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
> -#define CNP_PMC_PM_CFG_OFFSET                  0x1818
>  #define CNP_PMC_SLPS0_DBG_OFFSET               0x10B4
> +#define CNP_PMC_PM_CFG_OFFSET                  0x1818
> +#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
> +#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
>  /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
> -#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
> +#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
>
> -#define CNP_PMC_MMIO_REG_LEN                   0x2000
> -#define CNP_PPFEAR_NUM_ENTRIES                 8
> -#define CNP_PMC_READ_DISABLE_BIT               22
>  #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)
>
> +#define CNP_PMC_MMIO_REG_LEN                   0x2000
> +#define CNP_PPFEAR_NUM_ENTRIES                 8
> +#define CNP_PMC_READ_DISABLE_BIT               22
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
> +
>  struct pmc_bit_map {
>         const char *name;
>         u32 bit_mask;
> @@ -139,6 +180,7 @@ struct pmc_bit_map {
>   * @mphy_sts:          Maps name of MPHY lane to MPHY status lane status bit
>   * @pll_sts:           Maps name of PLL to corresponding bit status
>   * @slps0_dbg_maps:    Array of SLP_S0_DBG* registers containing debug info
> + * @ltr_show_sts:      Maps PCH IP Names to their MMIO register offsets
>   * @slp_s0_offset:     PWRMBASE offset to read SLP_S0 residency
>   * @ltr_ignore_offset: PWRMBASE offset to read/write LTR ignore bit
>   * @regmap_length:     Length of memory to map from PWRMBASE address to access
> @@ -157,6 +199,7 @@ struct pmc_reg_map {
>         const struct pmc_bit_map *mphy_sts;
>         const struct pmc_bit_map *pll_sts;
>         const struct pmc_bit_map **slps0_dbg_maps;
> +       const struct pmc_bit_map *ltr_show_sts;
>         const u32 slp_s0_offset;
>         const u32 ltr_ignore_offset;
>         const int regmap_length;
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
