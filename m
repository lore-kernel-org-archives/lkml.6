Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D94C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADE9218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptw0zsLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfBLKST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:18:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33161 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:18:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so1100737plp.0;
        Tue, 12 Feb 2019 02:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnvL7O10vtzKSR6S71KX+QJh6IMCcrMrOYEQFjMAKnM=;
        b=Ptw0zsLMlCJolK6CpGn31rFbiH0eHa+rZ6a5VdSAx8KkOhVkQYLuM8CUDZaRl87KcR
         haHw21vCx1IxjQHzbmDTFRekF2IWgAqnRssWjx/rNGNSgHJKO81KcCFPHPAIDS0G1bgw
         bD8GlTqWVFJXr+jZUr1BkE+A+GTdVa7eyD4SkTNnGPI2ZnySd9zutfu8w9lXRu7CDdax
         1v6GMx11LH8NTkn1AoD9AnxRWoWKA9ib25/Kjo2jWYbMmWtRLdFzSX90m6EGiEpV/aye
         uaBSnsWSIycozCDrbd8gSrJbvA2m/432MLPu40/OBKG+OvSEJtm+XB86RsfV/BxfQQfz
         MvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnvL7O10vtzKSR6S71KX+QJh6IMCcrMrOYEQFjMAKnM=;
        b=mHWIHiY2OTsCfoi/MczPU6epXe1LBDlQEe7UgayzT1pgsjBwnrxqtxL8iIYAMvo8NJ
         Ho02OZGivw+IuFgTRS95VNfx6Awz181OQdeZNtaMalZeVsU16MMeJuDa0y1gH2LjpsdM
         T1z+qfFU0uAp2WYEvyDovfReOHq3/jpom+Stt2TMzF9ZmpBMBnYh4XRu/gzEL1WqQvQI
         VOYr0Ol5hMq1F3ouIiJqVlaxcrjZUpeUK4HcwCx+uItTHHaUR9ToUZsqfAUa7hJEt8gW
         /CDYuPYX9vJO3CTbvQouqcty/rgK94zbENVAiG4fc7+JZJuTFJuYaXK0Jxp1LdG5MtV+
         UzSA==
X-Gm-Message-State: AHQUAubG9xOTvQ8HXvOC2zpeJRLeN+0OOFqkFSJTTclU/lWgxbIDmGUz
        TkOBemzlUNbZHbDmA0TGTyO7x3J9ZoAFmKsDmn8nK3+l
X-Google-Smtp-Source: AHgI3IaCP+XXWmFHsfVk82hKLq8qwuo4+YnW3uF7rvhkP3oVgcrCem5mrXb6GT/EhKn6pfxyieEa8fJXsQ2wnUwHlLk=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr3168182pla.144.1549966697617;
 Tue, 12 Feb 2019 02:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <20190201073234.13280-9-rajneesh.bhardwaj@linux.intel.com> <20190212094318.GA8062@genxfsim-desktop>
In-Reply-To: <20190212094318.GA8062@genxfsim-desktop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:18:06 +0200
Message-ID: <CAHp75Ve+Sxes8Zb0AtZ81nJTjPsrKokDzOZnZxSe=C-k_Oo5MQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] platform/x86: intel_pmc_core: Add ICL platform support
To:     Anshuman Gupta <anshuman.gupta@intel.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:46 AM Anshuman Gupta
<anshuman.gupta@intel.com> wrote:
> On Fri, Feb 01, 2019 at 01:02:32PM +0530, Rajneesh Bhardwaj wrote:
> > Icelake can resue most of the CNL PCH IPs as they are mostly similar.
> > This patch enables the PMC Core driver for ICL family.
> >
> > It also addresses few other minor issues like upper case conversions and
> > some tab alignments.
> >
> > Cc: "David E. Box" <david.e.box@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

>   Acked-and-tested-by: <anshuman.gupta@intel.com>

Thanks.

Can you clarify what patches had been tested?
As far as I can understand you can't test this one before applying
previous seven patches.

Rajneesh, when you will be about to send the rest, don't forget to
append the received tags.

> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 59 +++++++++++++++++++++------
> >  drivers/platform/x86/intel_pmc_core.h |  4 ++
> >  2 files changed, 50 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> > index d3752d75075b..400946b7a3b5 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -166,25 +166,26 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
> >       {"SDX",                 BIT(4)},
> >       {"SPE",                 BIT(5)},
> >       {"Fuse",                BIT(6)},
> > -     {"Res_23",              BIT(7)},
> > +     /* Reserved for Cannonlake but valid for Icelake */
> > +     {"SBR8",                BIT(7)},
> >
> >       {"CSME_FSC",            BIT(0)},
> >       {"USB3_OTG",            BIT(1)},
> >       {"EXI",                 BIT(2)},
> >       {"CSE",                 BIT(3)},
> > -     {"csme_kvm",            BIT(4)},
> > -     {"csme_pmt",            BIT(5)},
> > -     {"csme_clink",          BIT(6)},
> > -     {"csme_ptio",           BIT(7)},
> > -
> > -     {"csme_usbr",           BIT(0)},
> > -     {"csme_susram",         BIT(1)},
> > -     {"csme_smt1",           BIT(2)},
> > +     {"CSME_KVM",            BIT(4)},
> > +     {"CSME_PMT",            BIT(5)},
> > +     {"CSME_CLINK",          BIT(6)},
> > +     {"CSME_PTIO",           BIT(7)},
> > +
> > +     {"CSME_USBR",           BIT(0)},
> > +     {"CSME_SUSRAM",         BIT(1)},
> > +     {"CSME_SMT1",           BIT(2)},
> >       {"CSME_SMT4",           BIT(3)},
> > -     {"csme_sms2",           BIT(4)},
> > -     {"csme_sms1",           BIT(5)},
> > -     {"csme_rtc",            BIT(6)},
> > -     {"csme_psf",            BIT(7)},
> > +     {"CSME_SMS2",           BIT(4)},
> > +     {"CSME_SMS1",           BIT(5)},
> > +     {"CSME_RTC",            BIT(6)},
> > +     {"CSME_PSF",            BIT(7)},
> >
> >       {"SBR0",                BIT(0)},
> >       {"SBR1",                BIT(1)},
> > @@ -209,6 +210,20 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
> >       {"HDA_PGD4",            BIT(2)},
> >       {"HDA_PGD5",            BIT(3)},
> >       {"HDA_PGD6",            BIT(4)},
> > +     /* Reserved for Cannonlake but valid for Icelake */
> > +     {"PSF6",                BIT(5)},
> > +     {"PSF7",                BIT(6)},
> > +     {"PSF8",                BIT(7)},
> > +
> > +     /* Icelake generation onwards only */
> > +     {"RES_65",              BIT(0)},
> > +     {"RES_66",              BIT(1)},
> > +     {"RES_67",              BIT(2)},
> > +     {"TAM",                 BIT(3)},
> > +     {"GBETSN",              BIT(4)},
> > +     {"TBTLSX",              BIT(5)},
> > +     {"RES_71",              BIT(6)},
> > +     {"RES_72",              BIT(7)},
> >       {}
> >  };
> >
> > @@ -290,6 +305,8 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
> >       {"ISH",                 CNP_PMC_LTR_ISH},
> >       {"UFSX2",               CNP_PMC_LTR_UFSX2},
> >       {"EMMC",                CNP_PMC_LTR_EMMC},
> > +     /* Reserved for Cannonlake but valid for Icelake */
> > +     {"WIGIG",               ICL_PMC_LTR_WIGIG},
> >       /* Below two cannot be used for LTR_IGNORE */
> >       {"CURRENT_PLATFORM",    CNP_PMC_LTR_CUR_PLT},
> >       {"AGGREGATED_SYSTEM",   CNP_PMC_LTR_CUR_ASLT},
> > @@ -311,6 +328,21 @@ static const struct pmc_reg_map cnp_reg_map = {
> >       .ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
> >  };
> >
> > +static const struct pmc_reg_map icl_reg_map = {
> > +     .pfear_sts = cnp_pfear_map,
> > +     .slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
> > +     .slps0_dbg_maps = cnp_slps0_dbg_maps,
> > +     .ltr_show_sts = cnp_ltr_show_map,
> > +     .slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
> > +     .ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
> > +     .regmap_length = CNP_PMC_MMIO_REG_LEN,
> > +     .ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
> > +     .ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
> > +     .pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
> > +     .pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> > +     .ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
> > +};
> > +
> >  static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
> >  {
> >       return readb(pmcdev->regbase + offset);
> > @@ -740,6 +772,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
> >       INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
> >       INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
> >       INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
> > +     INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
> >       {}
> >  };
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> > index 0680ca397b57..78dd4229489d 100644
> > --- a/drivers/platform/x86/intel_pmc_core.h
> > +++ b/drivers/platform/x86/intel_pmc_core.h
> > @@ -178,6 +178,10 @@ enum ppfear_regs {
> >  #define LTR_REQ_SNOOP                                BIT(15)
> >  #define LTR_REQ_NONSNOOP                     BIT(31)
> >
> > +#define ICL_PPFEAR_NUM_ENTRIES                       9
> > +#define ICL_NUM_IP_IGN_ALLOWED                       20
> > +#define ICL_PMC_LTR_WIGIG                    0x1BFC
> > +
> >  struct pmc_bit_map {
> >       const char *name;
> >       u32 bit_mask;
> > --
> > 2.17.1
> >
>
> --



-- 
With Best Regards,
Andy Shevchenko
