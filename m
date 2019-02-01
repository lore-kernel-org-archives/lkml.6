Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9143AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622B9218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfBAOda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:33:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726972AbfBAOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:33:30 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11ESkJD074164
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 09:33:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qcpp8vm7g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:33:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 1 Feb 2019 14:33:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 14:33:22 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11EXL605833080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 14:33:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28146AE058;
        Fri,  1 Feb 2019 14:33:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2990AE045;
        Fri,  1 Feb 2019 14:33:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.130])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 14:33:19 +0000 (GMT)
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Fri, 01 Feb 2019 09:33:09 -0500
In-Reply-To: <20190201134151.GF17861@linux.intel.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
         <20190201100641.26936-7-roberto.sassu@huawei.com>
         <20190201133949.GE17861@linux.intel.com>
         <20190201134151.GF17861@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020114-0020-0000-0000-000003105383
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020114-0021-0000-0000-000021615725
Message-Id: <1549031589.6993.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-01 at 15:41 +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 01, 2019 at 03:39:49PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 01, 2019 at 11:06:41AM +0100, Roberto Sassu wrote:
> > > Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
> > > 
> > > This patch replaces the hash parameter of tpm_pcr_extend() with an array of
> > > tpm_digest structures, so that the caller can provide a digest for each PCR
> > > bank currently allocated in the TPM.
> > > 
> > > tpm_pcr_extend() will not extend banks for which no digest was provided,
> > > as it happened before this patch, but instead it requires that callers
> > > provide the full set of digests. Since the number of digests will always be
> > > chip->nr_allocated_banks, the count parameter has been removed.
> > > 
> > > Due to the API change, ima_pcr_extend() and pcrlock() have been modified.
> > > Since the number of allocated banks is not known in advance, the memory for
> > > the digests must be dynamically allocated. To avoid performance degradation
> > > and to avoid that a PCR extend is not done due to lack of memory, the array
> > > of tpm_digest structures is allocated by the users of the TPM driver at
> > > initialization time.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I tested that this does not break TPM. I'd need someone to check that
> this does not break IMA. After that, I'm ready to apply this series.

Thanks!  I just finished compiling, rebooting, and verifying the IMA
boot-aggregate matches.

While compiling, I saw some messages that "TPM_BUFSIZE is redefined"
for tpm_i2c_infineon, tpm_i2c_nuvoton, and st33zp24.  Didn't look to
see if this is a result of this patch set or not.

The IMA boot-aggregate matches the PCRs.

Tested-by: Mimi Zohar <zohar@linux.ibm.com> (on x86 for TPM 1.2 & PTT
TPM 2.0)

