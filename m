Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A6B20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A6B20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeKEWWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:22:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728966AbeKEWWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:22:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5Cxvfg072339
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 08:02:39 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2njkhjyh1k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:02:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Nov 2018 13:02:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 13:02:30 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA5D2TXA10354890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 13:02:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A230CAE051;
        Mon,  5 Nov 2018 13:02:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9254AE057;
        Mon,  5 Nov 2018 13:02:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.137])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Nov 2018 13:02:28 +0000 (GMT)
Subject: Re: [PATCH v3 1/5] tpm: change the end marker of the active_banks
 array to zero
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 05 Nov 2018 08:02:18 -0500
In-Reply-To: <b2622675-041b-c1af-4670-aecab2adf3ac@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
         <20181030154711.2782-2-roberto.sassu@huawei.com>
         <1540996980.11273.67.camel@linux.ibm.com>
         <1541083377.4035.13.camel@linux.ibm.com>
         <b2622675-041b-c1af-4670-aecab2adf3ac@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110513-0008-0000-0000-0000028B8729
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110513-0009-0000-0000-000021F5BB8A
Message-Id: <1541422938.21115.53.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> >>> index 1a803b0cf980..f7fc4b5ee239 100644
> >>> --- a/drivers/char/tpm/tpm-interface.c
> >>> +++ b/drivers/char/tpm/tpm-interface.c
> >>> @@ -1051,7 +1051,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
> >>>   		memset(digest_list, 0, sizeof(digest_list));
> >>>   
> >>>   		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> >>> -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
> >>> +			    chip->active_banks[i]; i++) {
> >>>   			digest_list[i].alg_id = chip->active_banks[i];
> >>>   			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
> >>>   			count++;
> > 
> > The fourth patch further updates this code.  Please move those changes
> > to this first patch.  No need to touch the same code in both places.
> 
> alg_id is introduced in patch 4/5. It cannot be moved here.

Thanks, I missed that.

Mimi 

