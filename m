Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C620873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60C620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeG0IUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:20:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:29355 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeG0IUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:20:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 00:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="59908472"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2018 00:00:07 -0700
Subject: Re: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock
 frequency to 200MHz
To:     "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chuanjin Pang (WH)" <chuanjin.pang@bayhubtech.com>,
        "Mike Li (WH)" <mike.li@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Bobby Wu (WH)" <bobby.wu@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
 <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
 <06a9dcec-846e-495c-4519-4af13549fe0e@intel.com>
 <BYAPR04MB4760BF8783C0E58A75D00F25E52A0@BYAPR04MB4760.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a56c0e30-cf71-5294-bc3a-1179808bd85b@intel.com>
Date:   Fri, 27 Jul 2018 09:58:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4760BF8783C0E58A75D00F25E52A0@BYAPR04MB4760.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/18 09:49, Ernest Zhang(WH) wrote:
> Hi Adrian,
> 	Do I need re-submit all 5 patches after fix that and change the version to v8?

You can reply to this email with PATCH V8 2/5 that has my Ack and the
comment fixed.

> BR
> 
> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com] 
> Sent: 2018年7月25日 15:45
> To: Ernest Zhang(WH); Ulf Hansson; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Chuanjin Pang (WH); Mike Li (WH); Chevron Li (WH); Shirley Her (SC); Xiaoguang Yu (WH); Bobby Wu (WH)
> Subject: Re: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock frequency to 200MHz
> 
> On 16/07/18 09:26, ernest.zhang wrote:
>> O2 SD Host HS200 mode clock frequency current is 208MHz, should be 
>> changed to 200MHz to meet specification.
>>
>> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> 
> You left in the misleading comment.  Fix that and add:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> ---
>> Change in V7:
>> 	Change HS200 mode clock frequency from 208MHz to 200MHz to meet
>> 	Specification.
>>
>> Change in V1~V6:
>> 	N/A
>> ---
>>  drivers/mmc/host/sdhci-pci-o2micro.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c 
>> b/drivers/mmc/host/sdhci-pci-o2micro.c
>> index ba59db6a126c..94cf3cd75dd3 100644
>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> @@ -311,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip 
>> *chip)
>>  
>>  			/* Check Whether subId is 0x11 or 0x12 */
>>  			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
>> -				scratch_32 = 0x2c280000;
>> +				scratch_32 = 0x25100000;
>>  
>>  				/* Set Base Clock to 208MZ */
> 
> That comment is misleading now.
> 
>>  				o2_pci_set_baseclk(chip, scratch_32); @@ -406,7 +406,7 @@ int 
>> sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>>  					       O2_SD_PLL_SETTING, scratch_32);
>>  		} else {
>>  			scratch_32 &= 0x0000FFFF;
>> -			scratch_32 |= 0x2c280000;
>> +			scratch_32 |= 0x25100000;
>>  
>>  			pci_write_config_dword(chip->pdev,
>>  					       O2_SD_PLL_SETTING, scratch_32);
>>
> 

