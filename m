Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521C82081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521C82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeKAXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:46:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728843AbeKAXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:46:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1ETMpx081656
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 10:43:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ng2ejk7tm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:43:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 1 Nov 2018 14:43:14 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 14:43:10 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1Eh9rj65273986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 14:43:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 031C011C050;
        Thu,  1 Nov 2018 14:43:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 236A611C054;
        Thu,  1 Nov 2018 14:43:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.26])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 14:43:07 +0000 (GMT)
Subject: Re: [PATCH v3 1/5] tpm: change the end marker of the active_banks
 array to zero
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 01 Nov 2018 10:42:57 -0400
In-Reply-To: <1540996980.11273.67.camel@linux.ibm.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
         <20181030154711.2782-2-roberto.sassu@huawei.com>
         <1540996980.11273.67.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110114-0008-0000-0000-00000289A9A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110114-0009-0000-0000-000021F3D0DA
Message-Id: <1541083377.4035.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 10:43 -0400, Mimi Zohar wrote:
> On Tue, 2018-10-30 at 16:47 +0100, Roberto Sassu wrote:
> > This patch changes the end marker of the active_banks array from
> > TPM2_ALG_ERROR to zero.
> 
> The patch description is a bit off.
> 
> TPM2_ALG_ERROR is defined as zero.  Since tpm_chip_alloc() calls
> kzalloc to allocate the structure, there is no need to explicitly set
> the active_banks end marker to TPM2_ALG_ERROR, nor is there a need to
> explicitly test for the end marker.
> 
> This patch removes explicitly setting the end marker and changes the
> coding style.
> 
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 2 +-
> >  drivers/char/tpm/tpm2-cmd.c      | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 1a803b0cf980..f7fc4b5ee239 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -1051,7 +1051,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
> >  		memset(digest_list, 0, sizeof(digest_list));
> >  
> >  		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> > -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
> > +			    chip->active_banks[i]; i++) {
> >  			digest_list[i].alg_id = chip->active_banks[i];
> >  			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
> >  			count++;

The fourth patch further updates this code.  Please move those changes
to this first patch.  No need to touch the same code in both places.

                for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-                           chip->active_banks[i]; i++) {
-                       digest_list[i].alg_id = chip->active_banks[i];
+                           chip->active_banks[i].alg_id; i++) {
+                       digest_list[i].alg_id = chip->active_banks[i].alg_id;
                        memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
                        count++;
                }
Mimi

> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index c31b490bd41d..046c9d8f3c1e 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -908,9 +908,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >  	}
> >  
> >  out:
> > -	if (i < ARRAY_SIZE(chip->active_banks))
> > -		chip->active_banks[i] = TPM2_ALG_ERROR;
> > -
> >  	tpm_buf_destroy(&buf);
> >  
> >  	return rc;
> 

