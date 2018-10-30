Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE51C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F6A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F6A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3QZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:25:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:29832 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeJ3QZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:25:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 00:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,443,1534834800"; 
   d="scan'208";a="104436603"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.66.171]) ([10.252.66.171])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2018 00:25:48 -0700
Subject: Re: [PATCH v2 1/4] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcQ3SDQ4X9+LX+y2vB4PWQURid4R=qy5+5PkWHC5nGqQA@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <a839e9d3-838b-0fb1-55ac-07562ec71313@linux.intel.com>
Date:   Tue, 30 Oct 2018 12:55:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcQ3SDQ4X9+LX+y2vB4PWQURid4R=qy5+5PkWHC5nGqQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Srinivas


On 19-Oct-18 5:42 PM, Andy Shevchenko wrote:
> On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> This adds support to show the Latency Tolerance Reporting for the IPs on
>> the PCH as reported by the PMC. The format shown here is raw LTR data
>> payload that can further be decoded as per the PCI specification.
>>
>> This also fixes some minor alignment issues in the header file by
>> removing spaces and converting to tabs at some places.
>>
> I have pushed slightly modified variant of this patch to my review and
> testing queue.
> Though this series needs a bit more work.

Thanks again for your review Andy. I see that the infradead server is 
down at the moment so i haven't seen your modifications yet.
http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy 
says gateway timeout.

>
> I see inconsistency now with the output with the rest of nodes there.

index printing is not needed for those nodes hence i never added.

> I don't care much, though some can be addressed for no regression.
>
> For example, index printing. Please, remove it. I completely forgot
> about userspace powerful tools. At least two very old and nice can
> enumerate lines for you.
> Obviously the index printing is redundant.

Index printing is required here (for LTR Show and LTR Ignore) because it 
paves an obvious and easy way for the users of this driver to know the 
IP number to be used for LTR ignore. This was specifically requested by 
some customer and Srinivas asked me to implement this so adding him for 
his inputs.

I am also planning to add some documentation for this driver later so 
please consider this in current form.

>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>> Changes in v2:
>>   * Removed IP # from map and displaying IP # while printing.
>>   * Other style fixes as per Andy's suggestion.
>>
>>   drivers/platform/x86/intel_pmc_core.c | 73 +++++++++++++++++++++++++++
>>   drivers/platform/x86/intel_pmc_core.h | 56 +++++++++++++++++---
>>   2 files changed, 122 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
>> index 2d272a3e0176..217a822a8da1 100644
>> --- a/drivers/platform/x86/intel_pmc_core.c
>> +++ b/drivers/platform/x86/intel_pmc_core.c
>> @@ -110,10 +110,37 @@ static const struct pmc_bit_map spt_pfear_map[] = {
>>          {},
>>   };
>>
>> +static const struct pmc_bit_map spt_ltr_show_map[] = {
>> +       {"LTR_SOUTHPORT_A",             SPT_PMC_LTR_SPA},
>> +       {"LTR_SOUTHPORT_B",             SPT_PMC_LTR_SPB},
>> +       {"LTR_SATA",                    SPT_PMC_LTR_SATA},
>> +       {"LTR_GIGABIT_ETHERNET",        SPT_PMC_LTR_GBE},
>> +       {"LTR_XHCI",                    SPT_PMC_LTR_XHCI},
>> +       /* IP 5 is reserved */
>> +       {"LTR_ME",                      SPT_PMC_LTR_ME},
>> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
>> +       {"LTR_EVA",                     SPT_PMC_LTR_EVA},
>> +       {"LTR_SOUTHPORT_C",             SPT_PMC_LTR_SPC},
>> +       {"LTR_HD_AUDIO",                SPT_PMC_LTR_AZ},
>> +       /* IP 10 is reserved */
>> +       {"LTR_LPSS",                    SPT_PMC_LTR_LPSS},
>> +       {"LTR_SOUTHPORT_D",             SPT_PMC_LTR_SPD},
>> +       {"LTR_SOUTHPORT_E",             SPT_PMC_LTR_SPE},
>> +       {"LTR_CAMERA",                  SPT_PMC_LTR_CAM},
>> +       {"LTR_ESPI",                    SPT_PMC_LTR_ESPI},
>> +       {"LTR_SCC",                     SPT_PMC_LTR_SCC},
>> +       {"LTR_ISH",                     SPT_PMC_LTR_ISH},
>> +       /* Below two cannot be used for LTR_IGNORE */
>> +       {"LTR_CURRENT_PLATFORM",        SPT_PMC_LTR_CUR_PLT},
>> +       {"LTR_AGGREGATED_SYSTEM",       SPT_PMC_LTR_CUR_ASLT},
>> +       {}
>> +};
>> +
>>   static const struct pmc_reg_map spt_reg_map = {
>>          .pfear_sts = spt_pfear_map,
>>          .mphy_sts = spt_mphy_map,
>>          .pll_sts = spt_pll_map,
>> +       .ltr_show_sts = spt_ltr_show_map,
>>          .slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
>>          .ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
>>          .regmap_length = SPT_PMC_MMIO_REG_LEN,
>> @@ -252,10 +279,39 @@ static const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
>>          NULL,
>>   };
>>
>> +static const struct pmc_bit_map cnp_ltr_show_map[] = {
>> +       {"LTR_SOUTHPORT_A",             CNP_PMC_LTR_SPA},
>> +       {"LTR_SOUTHPORT_B",             CNP_PMC_LTR_SPB},
>> +       {"LTR_SATA",                    CNP_PMC_LTR_SATA},
>> +       {"LTR_GIGABIT_ETHERNET",        CNP_PMC_LTR_GBE},
>> +       {"LTR_XHCI",                    CNP_PMC_LTR_XHCI},
>> +       /* IP 5 is reserved */
>> +       {"LTR_ME",                      CNP_PMC_LTR_ME},
>> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
>> +       {"LTR_EVA",                     CNP_PMC_LTR_EVA},
>> +       {"LTR_SOUTHPORT_C",             CNP_PMC_LTR_SPC},
>> +       {"LTR_HD_AUDIO",                CNP_PMC_LTR_AZ},
>> +       {"LTR_CNV",                     CNP_PMC_LTR_CNV},
>> +       {"LTR_LPSS",                    CNP_PMC_LTR_LPSS},
>> +       {"LTR_SOUTHPORT_D",             CNP_PMC_LTR_SPD},
>> +       {"LTR_SOUTHPORT_E",             CNP_PMC_LTR_SPE},
>> +       {"LTR_CAMERA",                  CNP_PMC_LTR_CAM},
>> +       {"LTR_ESPI",                    CNP_PMC_LTR_ESPI},
>> +       {"LTR_SCC",                     CNP_PMC_LTR_SCC},
>> +       {"LTR_ISH",                     CNP_PMC_LTR_ISH},
>> +       {"LTR_UFSX2",                   CNP_PMC_LTR_UFSX2},
>> +       {"LTR_EMMC",                    CNP_PMC_LTR_EMMC},
>> +       /* Below two cannot be used for LTR_IGNORE */
>> +       {"LTR_CURRENT_PLATFORM",        CNP_PMC_LTR_CUR_PLT},
>> +       {"LTR_AGGREGATED_SYSTEM",       CNP_PMC_LTR_CUR_ASLT},
>> +       {}
>> +};
>> +
>>   static const struct pmc_reg_map cnp_reg_map = {
>>          .pfear_sts = cnp_pfear_map,
>>          .slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
>>          .slps0_dbg_maps = cnp_slps0_dbg_maps,
>> +       .ltr_show_sts = cnp_ltr_show_map,
>>          .slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
>>          .ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>>          .regmap_length = CNP_PMC_MMIO_REG_LEN,
>> @@ -592,6 +648,21 @@ static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
>>
>> +static int pmc_core_ltr_show(struct seq_file *s, void *unused)
>> +{
>> +       struct pmc_dev *pmcdev = s->private;
>> +       const struct pmc_bit_map *map = pmcdev->map->ltr_show_sts;
>> +       int index;
>> +
>> +       for (index = 0; map[index].name ; index++) {
>> +               seq_printf(s, "IP %-2d :%-32s\tRAW LTR: 0x%x\n", index,
>> +                          map[index].name,
>> +                          pmc_core_reg_read(pmcdev, map[index].bit_mask));
>> +       }
>> +       return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
>> +
>>   static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>>   {
>>          debugfs_remove_recursive(pmcdev->dbgfs_dir);
>> @@ -616,6 +687,8 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>>          debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
>>                              &pmc_core_ltr_ignore_ops);
>>
>> +       debugfs_create_file("ltr_show", 0644, dir, pmcdev, &pmc_core_ltr_fops);
>> +
>>          if (pmcdev->map->pll_sts)
>>                  debugfs_create_file("pll_status", 0444, dir, pmcdev,
>>                                      &pmc_core_pll_ops);
>> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
>> index 93a7e99e1f8b..7a00436e337d 100644
>> --- a/drivers/platform/x86/intel_pmc_core.h
>> +++ b/drivers/platform/x86/intel_pmc_core.h
>> @@ -46,6 +46,25 @@
>>   #define NUM_RETRIES                            100
>>   #define NUM_IP_IGN_ALLOWED                     17
>>
>> +#define SPT_PMC_LTR_CUR_PLT                    0x350
>> +#define SPT_PMC_LTR_CUR_ASLT                   0x354
>> +#define SPT_PMC_LTR_SPA                                0x360
>> +#define SPT_PMC_LTR_SPB                                0x364
>> +#define SPT_PMC_LTR_SATA                       0x368
>> +#define SPT_PMC_LTR_GBE                                0x36C
>> +#define SPT_PMC_LTR_XHCI                       0x370
>> +#define SPT_PMC_LTR_ME                         0x378
>> +#define SPT_PMC_LTR_EVA                                0x37C
>> +#define SPT_PMC_LTR_SPC                                0x380
>> +#define SPT_PMC_LTR_AZ                         0x384
>> +#define SPT_PMC_LTR_LPSS                       0x38C
>> +#define SPT_PMC_LTR_CAM                                0x390
>> +#define SPT_PMC_LTR_SPD                                0x394
>> +#define SPT_PMC_LTR_SPE                                0x398
>> +#define SPT_PMC_LTR_ESPI                       0x39C
>> +#define SPT_PMC_LTR_SCC                                0x3A0
>> +#define SPT_PMC_LTR_ISH                                0x3A4
>> +
>>   /* Sunrise Point: PGD PFET Enable Ack Status Registers */
>>   enum ppfear_regs {
>>          SPT_PMC_XRAM_PPFEAR0A = 0x590,
>> @@ -124,17 +143,38 @@ enum ppfear_regs {
>>   #define SPT_PMC_BIT_MPHY_CMN_LANE3             BIT(3)
>>
>>   /* Cannonlake Power Management Controller register offsets */
>> -#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
>> -#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
>> -#define CNP_PMC_PM_CFG_OFFSET                  0x1818
>> +#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
>> +#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
>> +#define CNP_PMC_PM_CFG_OFFSET                  0x1818
>>   #define CNP_PMC_SLPS0_DBG_OFFSET               0x10B4
>>   /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
>> -#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
>> +#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
>>
>> -#define CNP_PMC_MMIO_REG_LEN                   0x2000
>> -#define CNP_PPFEAR_NUM_ENTRIES                 8
>> -#define CNP_PMC_READ_DISABLE_BIT               22
>> +#define CNP_PMC_MMIO_REG_LEN                   0x2000
>> +#define CNP_PPFEAR_NUM_ENTRIES                 8
>> +#define CNP_PMC_READ_DISABLE_BIT               22
>>   #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)
>> +#define CNP_PMC_LTR_CUR_PLT                    0x1B50
>> +#define CNP_PMC_LTR_CUR_ASLT                   0x1B54
>> +#define CNP_PMC_LTR_SPA                                0x1B60
>> +#define CNP_PMC_LTR_SPB                                0x1B64
>> +#define CNP_PMC_LTR_SATA                       0x1B68
>> +#define CNP_PMC_LTR_GBE                                0x1B6C
>> +#define CNP_PMC_LTR_XHCI                       0x1B70
>> +#define CNP_PMC_LTR_ME                         0x1B78
>> +#define CNP_PMC_LTR_EVA                                0x1B7C
>> +#define CNP_PMC_LTR_SPC                                0x1B80
>> +#define CNP_PMC_LTR_AZ                         0x1B84
>> +#define CNP_PMC_LTR_LPSS                       0x1B8C
>> +#define CNP_PMC_LTR_CAM                                0x1B90
>> +#define CNP_PMC_LTR_SPD                                0x1B94
>> +#define CNP_PMC_LTR_SPE                                0x1B98
>> +#define CNP_PMC_LTR_ESPI                       0x1B9C
>> +#define CNP_PMC_LTR_SCC                                0x1BA0
>> +#define CNP_PMC_LTR_ISH                                0x1BA4
>> +#define CNP_PMC_LTR_CNV                                0x1BF0
>> +#define CNP_PMC_LTR_EMMC                       0x1BF4
>> +#define CNP_PMC_LTR_UFSX2                      0x1BF8
>>
>>   struct pmc_bit_map {
>>          const char *name;
>> @@ -148,6 +188,7 @@ struct pmc_bit_map {
>>    * @mphy_sts:          Maps name of MPHY lane to MPHY status lane status bit
>>    * @pll_sts:           Maps name of PLL to corresponding bit status
>>    * @slps0_dbg_maps:    Array of SLP_S0_DBG* registers containing debug info
>> + * @ltr_show_sts:      Maps PCH IP Names to their MMIO register offsets
>>    * @slp_s0_offset:     PWRMBASE offset to read SLP_S0 residency
>>    * @ltr_ignore_offset: PWRMBASE offset to read/write LTR ignore bit
>>    * @regmap_length:     Length of memory to map from PWRMBASE address to access
>> @@ -166,6 +207,7 @@ struct pmc_reg_map {
>>          const struct pmc_bit_map *mphy_sts;
>>          const struct pmc_bit_map *pll_sts;
>>          const struct pmc_bit_map **slps0_dbg_maps;
>> +       const struct pmc_bit_map *ltr_show_sts;
>>          const u32 slp_s0_offset;
>>          const u32 ltr_ignore_offset;
>>          const int regmap_length;
>> --
>> 2.17.1
>>
>

