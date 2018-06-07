Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LS1TFmbWGFvrRgAAmS7hNA
	; Thu, 07 Jun 2018 07:01:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7236A608B8; Thu,  7 Jun 2018 07:01:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A03ZVVtm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 70C256063F;
	Thu,  7 Jun 2018 07:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70C256063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeFGHA6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:00:58 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:42518 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeFGHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:00:56 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0581C1E05C3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 09:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528354855; bh=VmXL8rerO9yulc/hCNp2qfqjs7jMolupSkjIbg/7r7k=;
        h=From:To:CC:Subject:Date:References:From;
        b=A03ZVVtmg3sCduxv5nDBx9vwWl6I0/g1SZ+4Q7ZUqOXT0I3p8QQ16V/+yGNXGaIvf
         FvueIiJB8eiqXjAYrzs5vZiZS1AUPxHxBajHpBjqSUiDleoXgOXtH+YRiix5BQwn1T
         ituDw2KGzLHMbbafTQn0qTJ8ji+3JR4sAQ1JNGpv6+kjWox0yD7d+kwZ8+iuqLTWUR
         LwhT+QsX2IR0+U3b1TjDnNQdQXYYOZWKa1lsielnCTGhCHNwMCWPQYYWvFdxg40kq+
         yYncKrF77lVXwpegnNL8o/hzovtGYK6zSmNVod5VB5DkWM9/SxBOijnvUXLzG5Vzxl
         tyNkxgiec9Edw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4DEF7366E;
        Thu,  7 Jun 2018 00:00:54 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 7 Jun 2018 00:00:53 -0700
Received: from IN01WEMBXA.internal.synopsys.com ([fe80::ed6f:22d3:d35:4833])
 by IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 7 Jun 2018 12:30:51 +0530
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
CC: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 5/5] scsi: ufs: Add hooks in UFS HC driver for crypto
 support
Thread-Topic: [PATCH 5/5] scsi: ufs: Add hooks in UFS HC driver for crypto
 support
Thread-Index: AQHT/EojyUGtqDsm4ESj/jdJu85XFA==
Date: Thu, 7 Jun 2018 07:00:50 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020C816@IN01WEMBXA.internal.synopsys.com>
References: <51bd1b68-1ab2-af04-99f4-07e08852c401@synopsys.com>
 <20180604212218.GB72668@jaegeuk-macbookpro.roam.corp.google.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 June 2018 10:22 PM, Jaegeuk Kim wrote:=0A=
> Hi Ladvine,=0A=
>=0A=
> On 05/28, Ladvine D Almeida wrote:=0A=
>> This patch adds the crypto support in the UFS Host Controller=0A=
>> driver like allocation of the crypto resources, registration of=0A=
>> crypto algorithm, preparing UTRD requests for inline encryption job,=0A=
>> freeing the resources during exit stage.=0A=
>> The crypto support is enabled in the UFS Host Controller driver only if =
the=0A=
>> crypto capability is detected in the hardware during the init stage.=0A=
>> The changes done for the UFS HC crypto support are guarded with=0A=
>> CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION.=0A=
>>=0A=
>> Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>=0A=
>> ---=0A=
>>  drivers/scsi/ufs/ufshcd.c | 63 ++++++++++++++++++++++++++++++++++++++++=
++-----=0A=
>>  drivers/scsi/ufs/ufshcd.h | 29 ++++++++++++++++++++++=0A=
>>  2 files changed, 86 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c=0A=
>> index 00e7905..7bac5a3 100644=0A=
>> --- a/drivers/scsi/ufs/ufshcd.c=0A=
>> +++ b/drivers/scsi/ufs/ufshcd.c=0A=
>> @@ -1839,6 +1839,10 @@ static inline void ufshcd_hba_capabilities(struct=
 ufs_hba *hba)=0A=
>>  	hba->nutrs =3D (hba->capabilities & MASK_TRANSFER_REQUESTS_SLOTS) + 1;=
=0A=
>>  	hba->nutmrs =3D=0A=
>>  	((hba->capabilities & MASK_TASK_MANAGEMENT_REQUEST_SLOTS) >> 16) + 1;=
=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	/* read crypto capabilities of host controller */=0A=
>> +	ufshcd_read_crypto_capabilities(hba);=0A=
>> +#endif=0A=
>>  }=0A=
>>  =0A=
>>  /**=0A=
>> @@ -2076,7 +2080,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs=
hcd_lrb *lrbp,=0A=
>>  {=0A=
>>  	struct utp_transfer_req_desc *req_desc =3D lrbp->utr_descriptor_ptr;=
=0A=
>>  	u32 data_direction;=0A=
>> -	u32 dword_0;=0A=
>> +	u32 dword_0 =3D 0;=0A=
>>  =0A=
>>  	if (cmd_dir =3D=3D DMA_FROM_DEVICE) {=0A=
>>  		data_direction =3D UTP_DEVICE_TO_HOST;=0A=
>> @@ -2094,10 +2098,22 @@ static void ufshcd_prepare_req_desc_hdr(struct u=
fshcd_lrb *lrbp,=0A=
>>  	if (lrbp->intr_cmd)=0A=
>>  		dword_0 |=3D UTP_REQ_DESC_INT_CMD;=0A=
>>  =0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>>  	/* Transfer request descriptor header fields */=0A=
>> -	req_desc->header.dword_0 =3D cpu_to_le32(dword_0);=0A=
>> -	/* dword_1 is reserved, hence it is set to 0 */=0A=
>> +	if (lrbp->ccfg_idx >=3D 0) {=0A=
>> +		dword_0 |=3D (UTP_REQ_CRYPT_EN_CMD | (lrbp->ccfg_idx & 0xff));=0A=
>> +		req_desc->header.dword_1 =3D lrbp->lba & 0xffffffff;=0A=
>> +		req_desc->header.dword_3 =3D (lrbp->lba >> 32) & 0xffffffff;=0A=
> Please assign a logical value to DUN. (e.g., inode_number << 32 | page->o=
ffset)=0A=
> Otherwise upper layers like F2FS won't be able to move any block from one=
 LBA to=0A=
> another LBA without the key. We couldn't do upstream tho, it'd be doable =
to add=0A=
> one DUN value in bio structure and manage its sequentiality by disallowin=
g bio=0A=
> merges, which looks like requiring to modify ufshcd_prepare_for_crypto().=
=0A=
=0A=
Kim,=0A=
=0A=
I will consider the change in the new patch.=0A=
=0A=
Regards,=0A=
Ladvine=0A=
=0A=
>=0A=
> Thanks,=0A=
>=0A=
>> +	} else {=0A=
>> +		req_desc->header.dword_1 =3D 0;=0A=
>> +		req_desc->header.dword_3 =3D 0;=0A=
>> +	}=0A=
>> +#else=0A=
>>  	req_desc->header.dword_1 =3D 0;=0A=
>> +	req_desc->header.dword_3 =3D 0;=0A=
>> +#endif=0A=
>> +	req_desc->header.dword_0 =3D cpu_to_le32(dword_0);=0A=
>> +=0A=
>>  	/*=0A=
>>  	 * assigning invalid value for command status. Controller=0A=
>>  	 * updates OCS on command completion, with the command=0A=
>> @@ -2105,8 +2121,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs=
hcd_lrb *lrbp,=0A=
>>  	 */=0A=
>>  	req_desc->header.dword_2 =3D=0A=
>>  		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);=0A=
>> -	/* dword_3 is reserved, hence it is set to 0 */=0A=
>> -	req_desc->header.dword_3 =3D 0;=0A=
>>  =0A=
>>  	req_desc->prd_table_length =3D 0;=0A=
>>  }=0A=
>> @@ -2355,6 +2369,12 @@ static int ufshcd_queuecommand(struct Scsi_Host *=
host, struct scsi_cmnd *cmd)=0A=
>>  	lrbp->lun =3D ufshcd_scsi_to_upiu_lun(cmd->device->lun);=0A=
>>  	lrbp->intr_cmd =3D !ufshcd_is_intr_aggr_allowed(hba) ? true : false;=
=0A=
>>  	lrbp->req_abort_skip =3D false;=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	lrbp->lba =3D 0;=0A=
>> +	lrbp->ccfg_idx =3D -1;=0A=
>> +	/* prepare block for crypto */=0A=
>> +	ufshcd_prepare_for_crypto(hba, lrbp);=0A=
>> +#endif=0A=
>>  =0A=
>>  	ufshcd_comp_scsi_upiu(hba, lrbp);=0A=
>>  =0A=
>> @@ -3215,6 +3235,7 @@ static inline int ufshcd_read_unit_desc_param(stru=
ct ufs_hba *hba,=0A=
>>  static int ufshcd_memory_alloc(struct ufs_hba *hba)=0A=
>>  {=0A=
>>  	size_t utmrdl_size, utrdl_size, ucdl_size;=0A=
>> +	int ret =3D 0;=0A=
>>  =0A=
>>  	/* Allocate memory for UTP command descriptors */=0A=
>>  	ucdl_size =3D (sizeof(struct utp_transfer_cmd_desc) * hba->nutrs);=0A=
>> @@ -3233,6 +3254,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba=
)=0A=
>>  	    WARN_ON(hba->ucdl_dma_addr & (PAGE_SIZE - 1))) {=0A=
>>  		dev_err(hba->dev,=0A=
>>  			"Command Descriptor Memory allocation failed\n");=0A=
>> +		ret =3D -ENOMEM;=0A=
>>  		goto out;=0A=
>>  	}=0A=
>>  =0A=
>> @@ -3249,6 +3271,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba=
)=0A=
>>  	    WARN_ON(hba->utrdl_dma_addr & (PAGE_SIZE - 1))) {=0A=
>>  		dev_err(hba->dev,=0A=
>>  			"Transfer Descriptor Memory allocation failed\n");=0A=
>> +		ret =3D -ENOMEM;=0A=
>>  		goto out;=0A=
>>  	}=0A=
>>  =0A=
>> @@ -3265,6 +3288,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba=
)=0A=
>>  	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {=0A=
>>  		dev_err(hba->dev,=0A=
>>  		"Task Management Descriptor Memory allocation failed\n");=0A=
>> +		ret =3D -ENOMEM;=0A=
>>  		goto out;=0A=
>>  	}=0A=
>>  =0A=
>> @@ -3274,11 +3298,21 @@ static int ufshcd_memory_alloc(struct ufs_hba *h=
ba)=0A=
>>  				GFP_KERNEL);=0A=
>>  	if (!hba->lrb) {=0A=
>>  		dev_err(hba->dev, "LRB Memory allocation failed\n");=0A=
>> +		ret =3D -ENOMEM;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	/* Allocate memory for crypto operations */=0A=
>> +	if (ufshcd_is_encryption_supported(hba))=0A=
>> +		ret =3D ufshcd_crypto_memory_alloc(hba);=0A=
>> +	if (ret !=3D 0) {=0A=
>> +		dev_err(hba->dev, "Crypto Memory allocation failed\n");=0A=
>>  		goto out;=0A=
>>  	}=0A=
>> +#endif=0A=
>>  	return 0;=0A=
>>  out:=0A=
>> -	return -ENOMEM;=0A=
>> +	return ret;=0A=
>>  }=0A=
>>  =0A=
>>  /**=0A=
>> @@ -4208,6 +4242,19 @@ static int ufshcd_link_startup(struct ufs_hba *hb=
a)=0A=
>>  		goto out;=0A=
>>  =0A=
>>  	ret =3D ufshcd_make_hba_operational(hba);=0A=
>> +	if (ret)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	/* Enable algorithm if crypto capability is present */=0A=
>> +	if (ufshcd_is_encryption_supported(hba))=0A=
>> +		ret =3D ufshcd_enable_crypt_alg(hba);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(hba->dev, "Crypto setup failed (%d)\n",=0A=
>> +			ret);=0A=
>> +		ret =3D 0;=0A=
>> +	}=0A=
>> +#endif=0A=
>>  out:=0A=
>>  	if (ret) {=0A=
>>  		dev_err(hba->dev, "link startup failed %d\n", ret);=0A=
>> @@ -7661,6 +7708,10 @@ EXPORT_SYMBOL(ufshcd_shutdown);=0A=
>>   */=0A=
>>  void ufshcd_remove(struct ufs_hba *hba)=0A=
>>  {=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	ufshcd_disable_crypt_alg(hba);=0A=
>> +	ufshcd_remove_crypto_memory(hba);=0A=
>> +#endif=0A=
>>  	ufs_sysfs_remove_nodes(hba->dev);=0A=
>>  	scsi_remove_host(hba->host);=0A=
>>  	/* disable interrupts */=0A=
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h=0A=
>> index 8110dcd..b1356ca 100644=0A=
>> --- a/drivers/scsi/ufs/ufshcd.h=0A=
>> +++ b/drivers/scsi/ufs/ufshcd.h=0A=
>> @@ -68,6 +68,9 @@=0A=
>>  =0A=
>>  #include "ufs.h"=0A=
>>  #include "ufshci.h"=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	#include "ufshcd-crypto.h"=0A=
>> +#endif=0A=
>>  =0A=
>>  #define UFSHCD "ufshcd"=0A=
>>  #define UFSHCD_DRIVER_VERSION "0.2"=0A=
>> @@ -168,6 +171,8 @@ struct ufs_pm_lvl_states {=0A=
>>   * @issue_time_stamp: time stamp for debug purposes=0A=
>>   * @compl_time_stamp: time stamp for statistics=0A=
>>   * @req_abort_skip: skip request abort task flag=0A=
>> + * @lba: LBA value for crypto engine=0A=
>> + * @ccfg_idx: key configuration index for crypto engine=0A=
>>   */=0A=
>>  struct ufshcd_lrb {=0A=
>>  	struct utp_transfer_req_desc *utr_descriptor_ptr;=0A=
>> @@ -193,6 +198,10 @@ struct ufshcd_lrb {=0A=
>>  	ktime_t compl_time_stamp;=0A=
>>  =0A=
>>  	bool req_abort_skip;=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	u64 lba;=0A=
>> +	int ccfg_idx;=0A=
>> +#endif=0A=
>>  };=0A=
>>  =0A=
>>  /**=0A=
>> @@ -499,6 +508,8 @@ struct ufs_stats {=0A=
>>   * @urgent_bkops_lvl: keeps track of urgent bkops level for device=0A=
>>   * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level =
for=0A=
>>   *  device is known or not.=0A=
>> + * @cc: stores the crypto capability information.=0A=
>> + * @ccxp: stores the crypto configuration information.=0A=
>>   */=0A=
>>  struct ufs_hba {=0A=
>>  	void __iomem *mmio_base;=0A=
>> @@ -683,6 +694,17 @@ struct ufs_hba {=0A=
>>  =0A=
>>  	struct rw_semaphore clk_scaling_lock;=0A=
>>  	struct ufs_desc_size desc_size;=0A=
>> +=0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +	/*=0A=
>> +	 * Thus capability allows the host controller to perform=0A=
>> +	 * inline encryption once it is configured.=0A=
>> +	 */=0A=
>> +#define UFSHCD_CAP_INLINE_ENCRYPTION (1 << 6)=0A=
>> +=0A=
>> +	struct ufshcd_ccap cc;=0A=
>> +	struct ufshcd_x_crypto_cap *ccxp;=0A=
>> +#endif=0A=
>>  };=0A=
>>  =0A=
>>  /* Returns true if clocks can be gated. Otherwise false */=0A=
>> @@ -717,6 +739,13 @@ return true;=0A=
>>  #endif=0A=
>>  }=0A=
>>  =0A=
>> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION=0A=
>> +static inline int ufshcd_is_encryption_supported(struct ufs_hba *hba)=
=0A=
>> +{=0A=
>> +	return hba->caps & UFSHCD_CAP_INLINE_ENCRYPTION;=0A=
>> +}=0A=
>> +#endif=0A=
>> +=0A=
>>  #define ufshcd_writel(hba, val, reg)	\=0A=
>>  	writel((val), (hba)->mmio_base + (reg))=0A=
>>  #define ufshcd_readl(hba, reg)	\=0A=
>> -- =0A=
>> 2.7.4=0A=
=0A=
=0A=
