Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3373E2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfBDNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:00:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729254AbfBDNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:00:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14D0K0X082921
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 08:00:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qem7252vj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:00:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Feb 2019 12:59:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 12:59:22 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14CxLSx27721910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 12:59:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B76A95204E;
        Mon,  4 Feb 2019 12:59:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6FC365204F;
        Mon,  4 Feb 2019 12:59:20 +0000 (GMT)
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 04 Feb 2019 07:59:09 -0500
In-Reply-To: <20190204120746.GG26799@linux.intel.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
         <20190201100641.26936-7-roberto.sassu@huawei.com>
         <1549048506.6993.73.camel@linux.ibm.com>
         <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
         <20190204120746.GG26799@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020412-0028-0000-0000-00000343E5E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020412-0029-0000-0000-00002401EAB1
Message-Id: <1549285149.4146.56.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 14:07 +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 04, 2019 at 10:14:38AM +0100, Roberto Sassu wrote:
> > On 2/1/2019 8:15 PM, Mimi Zohar wrote:
> > > Hi Roberto,
> > > 
> > > Sorry for the delayed review.  A few comments inline below, minor
> > > suggestions.
> > > 
> > > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > > > index cc12f3449a72..e6b2dcb0846a 100644
> > > > --- a/security/integrity/ima/ima.h
> > > > +++ b/security/integrity/ima/ima.h
> > > > @@ -56,6 +56,7 @@ extern int ima_policy_flag;
> > > >   extern int ima_hash_algo;
> > > >   extern int ima_appraise;
> > > >   extern struct tpm_chip *ima_tpm_chip;
> > > > +extern struct tpm_digest *digests;
> > > >   /* IMA event related data */
> > > >   struct ima_event_data {
> > > > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > > > index 6bb42a9c5e47..296a965b11ef 100644
> > > > --- a/security/integrity/ima/ima_init.c
> > > > +++ b/security/integrity/ima/ima_init.c
> > > > @@ -27,6 +27,7 @@
> > > >   /* name for boot aggregate entry */
> > > >   static const char boot_aggregate_name[] = "boot_aggregate";
> > > >   struct tpm_chip *ima_tpm_chip;
> > > > +struct tpm_digest *digests;
> > > 
> > > "digests" is used in the new ima_init_digests() and in
> > > ima_pcr_extend().  It's nice that the initialization routines are
> > > grouped together here in ima_init.c, but wouldn't it better to define
> > > "digests" in ima_queued.c, where it is currently being used?
> > >   "digests" could then be defined as static.
> > 
> > 'digests' and ima_init_digests() can be moved to ima_queue.c, but I have
> > to add the definition of ima_init_digests() to ima.h. Should I do it?

Yes, I think it is preferable, as it's defined as an __init.

> > 
> > 
> > > >   /* Add the boot aggregate to the IMA measurement list and extend
> > > >    * the PCR register.
> > > > @@ -104,6 +105,24 @@ void __init ima_load_x509(void)
> > > >   }
> > > >   #endif
> > > > +int __init ima_init_digests(void)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	if (!ima_tpm_chip)
> > > > +		return 0;
> > > > +
> > > > +	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
> > > > +			  GFP_NOFS);
> > > > +	if (!digests)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> > > > +		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >   int __init ima_init(void)
> > > >   {
> > > >   	int rc;
> > > > @@ -125,6 +144,9 @@ int __init ima_init(void)
> > > >   	ima_load_kexec_buffer();
> > > > +	rc = ima_init_digests();
> > > 
> > > Ok. Getting the tpm chip is at the beginning of this function.
> > >   Deferring allocating "digests" to here, avoids having to free memory
> > > on failure.
> > > 
> > > ima_load_kexec_buffer() restores prior measurements, but doesn't
> > > extend the TPM.  For anyone reading the code, a short comment above
> > > ima_load_kexec_buffer() would make sense.
> > 
> > Ok. Should I resend the last patch again with the fixes you suggested?
> 
> Send the full patch set. For me it is easier then to apply the series
> rather than cherry-picking patches from random versions of the patch
> set.

Jarkko, thanks.  I've been running with previous versions of this
patchset, and now with this latest version.

Mimi

