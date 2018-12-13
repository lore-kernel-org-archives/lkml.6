Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF59C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5069A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XK2u3MEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5069A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeLMCWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:22:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeLMCWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:22:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBD2KHUv131784;
        Thu, 13 Dec 2018 02:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=nbDVI4xzLByxjPU1z6OYi5y6qEFEfqhwxwiuOPL+908=;
 b=XK2u3MEzX9ZIoaWgIsv4RGNfaTdxHPhvj6SV6eUTwKFHccndb7f3x1ZeoVMSQfI7M0pV
 qA0cJRQww/TV+VFmjVW2zYEwA0IS4Vwa9WqOh44HANsQqe5OurdiQ5cp5tgqBYlMgB/8
 QCCVT6YSvB4KR9JXz8hgjzfpFWAUn+pZGprgx993DmqJagcVgojSMr5PJckVBCCMeqDD
 7zycJkV58V0ljPYUIEiSgQjzlVNtI8y5yjBYpWnHrhVCb5sUELYut51aqJn33QMkwsqR
 xn21nB8touV0ss1yDNfkkW1ssd+v4IOzeg7TxiYGvTaB/X1CKCap/nO+IuJSSG3G/zWb rg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pb3n735d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 02:22:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBD2MI5Y029546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 02:22:19 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBD2MIvt021673;
        Thu, 13 Dec 2018 02:22:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 18:20:19 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v4 4/5] scsi: hisi_sas: Add support for DIF feature for v3 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
        <1544103284-100497-5-git-send-email-john.garry@huawei.com>
Date:   Wed, 12 Dec 2018 21:20:17 -0500
In-Reply-To: <1544103284-100497-5-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 6 Dec 2018 21:34:43 +0800")
Message-ID: <yq1o99qgobi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=577
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812130019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> +static void fill_prot_v3_hw(struct scsi_cmnd *scsi_cmnd,
> +			    struct hisi_sas_protect_iu_v3_hw *prot)
> +{
> +	u8 prot_type = scsi_get_prot_type(scsi_cmnd);
> +	u8 prot_op = scsi_get_prot_op(scsi_cmnd);
> +	unsigned int interval = scsi_prot_interval(scsi_cmnd);
> +	u32 lbrt_chk_val;
> +
> +	if (interval == 4096)
> +		lbrt_chk_val = (u32)(scsi_get_lba(scsi_cmnd) >> 3);
> +	else
> +		lbrt_chk_val = (u32)scsi_get_lba(scsi_cmnd);

lbrt_chk_val = t10_pi_ref_tag(scmd->request);

> +
> +	switch (prot_op) {
> +	case SCSI_PROT_READ_STRIP:
> +		prot->dw0 |= (T10_RMV_EN_MSK | T10_CHK_EN_MSK);
> +		prot->lbrtcv = lbrt_chk_val;
> +		if (prot_type == SCSI_PROT_DIF_TYPE1)
> +			prot->dw4 |= (0xc << 16);
> +		else if (prot_type == SCSI_PROT_DIF_TYPE3)
> +			prot->dw4 |= (0xfc << 16);

We're moving away from prot_type. You should use:

enum scsi_prot_flags {
        SCSI_PROT_TRANSFER_PI           = 1 << 0,
        SCSI_PROT_GUARD_CHECK           = 1 << 1,
        SCSI_PROT_REF_CHECK             = 1 << 2,
        SCSI_PROT_REF_INCREMENT         = 1 << 3,
        SCSI_PROT_IP_CHECKSUM           = 1 << 4,
};

to set your controller flags.

+		if (prot_op == SCSI_PROT_WRITE_INSERT) {
+			unsigned int interval = scsi_prot_interval(scsi_cmnd);
+			unsigned int ilog2_interval = ilog2(interval);
+
+			len = (task->total_xfer_len >> ilog2_interval) * 8;

scsi_transfer_length(struct scsi_cmnd *scmd)

> +	if (hisi_hba->enable_dif) {
> +		dev_info(dev, "Registering for DIF type 1/2/3 protection.\n");
> +		prot |=	SHOST_DIF_TYPE1_PROTECTION |
> +			SHOST_DIF_TYPE2_PROTECTION |
> +			SHOST_DIF_TYPE3_PROTECTION;
> +	}
> +
> +	scsi_host_set_prot(hisi_hba->shost, prot);

I'm not so keen on this enable_dif/enable_dix business in module
parameters. I suggest you just allow the user to specify the host
protection mask instead of having a layer of indirection.

-- 
Martin K. Petersen	Oracle Linux Engineering
