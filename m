Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D7C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39E120862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39E120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeKGPgJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:36:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:3828 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbeKGPgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:36:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 22:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="scan'208";a="106562587"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2018 22:07:16 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 6 Nov 2018 22:07:15 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 6 Nov 2018 22:07:15 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.84]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 14:07:08 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Index: AQHUdMlDcnwPlQkmSk2wysYaWtdoaqVDpZEQ
Date:   Wed, 7 Nov 2018 06:07:07 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
In-Reply-To: <20181105053151.7173-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjFkZjUyNjYtMTc4OC00MWJlLWJmZWYtY2ZkMWUzNzhjMjI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNFVoT3RHWExUMmxrdHRzOUQwUWxmZVJYOVE5RHhydEd0TzFRWGZoYno0TWF6dm11MDRWVEJpWXBKOU5VbmZcL2oifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Monday, November 5, 2018 1:32 PM

[...]

> ---
>  drivers/iommu/dmar.c                | 83 +++++++++++++++++++----------
>  drivers/iommu/intel-svm.c           | 76 ++++++++++++++++----------
>  drivers/iommu/intel_irq_remapping.c |  6 ++-
>  include/linux/intel-iommu.h         |  9 +++-
>  4 files changed, 115 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index d9c748b6f9e4..ec10427b98ac 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1160,6 +1160,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int
> index)
>  	int head, tail;
>  	struct q_inval *qi = iommu->qi;
>  	int wait_index = (index + 1) % QI_LENGTH;
> +	int shift = qi_shift(iommu);
> 
>  	if (qi->desc_status[wait_index] == QI_ABORT)
>  		return -EAGAIN;
> @@ -1173,13 +1174,15 @@ static int qi_check_fault(struct intel_iommu *iommu,
> int index)
>  	 */
>  	if (fault & DMA_FSTS_IQE) {
>  		head = readl(iommu->reg + DMAR_IQH_REG);
> -		if ((head >> DMAR_IQ_SHIFT) == index) {
> +		if ((head >> shift) == index) {
> +			struct qi_desc *desc = qi->desc + head;
> +
>  			pr_err("VT-d detected invalid descriptor: "
>  				"low=%llx, high=%llx\n",
> -				(unsigned long long)qi->desc[index].low,
> -				(unsigned long long)qi->desc[index].high);
> -			memcpy(&qi->desc[index], &qi->desc[wait_index],
> -					sizeof(struct qi_desc));
> +				(unsigned long long)desc->qw0,
> +				(unsigned long long)desc->qw1);

Still missing qw2 and qw3. May make the print differ based on if smts is configed.

> +			memcpy(desc, qi->desc + (wait_index << shift),

Would "memcpy(desc, (unsigned long long) (qi->desc +  (wait_index << shift)," be
more safe?

> +			       1 << shift);
>  			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
>  			return -EINVAL;
>  		}
> @@ -1191,10 +1194,10 @@ static int qi_check_fault(struct intel_iommu *iommu,
> int index)
>  	 */
>  	if (fault & DMA_FSTS_ITE) {
>  		head = readl(iommu->reg + DMAR_IQH_REG);
> -		head = ((head >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
> +		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>  		head |= 1;
>  		tail = readl(iommu->reg + DMAR_IQT_REG);
> -		tail = ((tail >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
> +		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
> 
>  		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
> 
> @@ -1222,15 +1225,14 @@ int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu)
>  {
>  	int rc;
>  	struct q_inval *qi = iommu->qi;
> -	struct qi_desc *hw, wait_desc;
> +	int offset, shift, length;
> +	struct qi_desc wait_desc;
>  	int wait_index, index;
>  	unsigned long flags;
> 
>  	if (!qi)
>  		return 0;
> 
> -	hw = qi->desc;
> -
>  restart:
>  	rc = 0;
> 
> @@ -1243,16 +1245,21 @@ int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu)
> 
>  	index = qi->free_head;
>  	wait_index = (index + 1) % QI_LENGTH;
> +	shift = qi_shift(iommu);
> +	length = 1 << shift;
> 
>  	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
> 
> -	hw[index] = *desc;
> -
> -	wait_desc.low = QI_IWD_STATUS_DATA(QI_DONE) |
> +	offset = index << shift;
> +	memcpy(qi->desc + offset, desc, length);
> +	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>  			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
> -	wait_desc.high = virt_to_phys(&qi->desc_status[wait_index]);
> +	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
> +	wait_desc.qw2 = 0;
> +	wait_desc.qw3 = 0;
> 
> -	hw[wait_index] = wait_desc;
> +	offset = wait_index << shift;
> +	memcpy(qi->desc + offset, &wait_desc, length);

same question with above one.

Thanks,
Yi Liu

