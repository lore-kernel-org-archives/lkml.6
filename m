Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B791C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413E22086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413E22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeKSPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:20:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbeKSPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:20:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJ4rVAQ070978
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 23:58:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nujd3h37j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 23:58:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 19 Nov 2018 04:58:10 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Nov 2018 04:58:06 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAJ4w5G751314802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 04:58:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AAB811C04C;
        Mon, 19 Nov 2018 04:58:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38BAA11C04A;
        Mon, 19 Nov 2018 04:58:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.88.94])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Nov 2018 04:58:01 +0000 (GMT)
Subject: Re: [PATCH v5 7/7] tpm: pass an array of tpm_bank_list structures
 to tpm_pcr_extend()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Sun, 18 Nov 2018 23:57:50 -0500
In-Reply-To: <20181118072745.GA5897@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
         <20181114153108.12907-8-roberto.sassu@huawei.com>
         <20181116150352.GA3612@linux.intel.com>
         <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
         <20181118072745.GA5897@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18111904-0016-0000-0000-00000228F3FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111904-0017-0000-0000-000032812487
Message-Id: <1542603470.4914.55.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-18 at 09:27 +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 16, 2018 at 04:55:36PM +0100, Roberto Sassu wrote:
> > On 11/16/2018 4:03 PM, Jarkko Sakkinen wrote:
> > > On Wed, Nov 14, 2018 at 04:31:08PM +0100, Roberto Sassu wrote:
> > > > Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
> > > > 
> > > > This patch modifies the definition of tpm_pcr_extend() to allow other
> > > > kernel subsystems to pass a digest for each algorithm supported by the TPM.
> > > > All digests are processed by the TPM in one operation.
> > > > 
> > > > If a tpm_pcr_extend() caller provides a subset of the supported algorithms,
> > > > the TPM driver extends the remaining PCR banks with the first digest
> > > > passed as an argument to the function.
> > > 
> > > What is the legit use case for this?
> > 
> > A subset could be chosen for better performance, or when a TPM algorithm
> > is not supported by the crypto subsystem.
> 
> Doesn't extending a subset a security concern?

Right, so instead of extending a subset of the allocated banks, all of
the allocated banks need to be extended, even for those banks that a
digest was not included.  This is no different than what is being done
today.  IMA is currently only calculating the SHA1 hash, padding the
digest with 0's, and extending the padded value(s) into all of the
allocated banks.

If there is a vulnerability with the hash algorithm, then any bank
extended with the padded/truncated digest would be susceptible.

IMA will need to become TPM 2.0 aware, calculating and extending
multiple banks and define a new measurement list format containing the
multiple digests.

Mimi

