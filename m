Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5962086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5962086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIZUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:54:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727404AbeIZUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:54:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QEdbp5144831
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:40:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr9y275h7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:40:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 26 Sep 2018 15:40:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 15:40:52 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QEepeo66846966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 14:40:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 975A8A4055;
        Wed, 26 Sep 2018 17:40:32 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5238A405D;
        Wed, 26 Sep 2018 17:40:31 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.101.34])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 17:40:31 +0100 (BST)
Subject: Re: [PATCH v2, RESEND 0/3] tpm: retrieve digest size of unknown
 algorithms from TPM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 26 Sep 2018 10:40:40 -0400
In-Reply-To: <20180917093820.20500-1-roberto.sassu@huawei.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092614-4275-0000-0000-000002C0D5D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092614-4276-0000-0000-000037CADD9E
Message-Id: <1537972840.3459.6.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 11:38 +0200, Roberto Sassu wrote:
> Resending to maintainer with correct mailing lists in CC.
> 
> The TPM driver currently relies on the crypto subsystem to determine the
> digest size of supported TPM algorithms. In the future, TPM vendors might
> implement new algorithms in their chips, and those algorithms might not
> be supported by the crypto subsystem.
> 
> Usually, vendors provide patches for the new hardware, and likely
> the crypto subsystem will be updated before the new algorithm is
> introduced. However, old kernels might be updated later, after patches
> are included in the mainline kernel. This would leave the opportunity
> for attackers to misuse PCRs, as PCR banks with an unknown algorithm
> are not extended.
> 
> This patch set provides a long term solution for this issue. If a TPM
> algorithm is not known by the crypto subsystem, the TPM driver retrieves
> the digest size from the TPM with a PCR read. All the PCR banks are
> extended, even if the algorithm is not yet supported by the crypto
> subsystem.

Other than checking the digest size before copying the pcrread buffer,
the patches look good.  Please add my Ack on all 3 patches.

(New address) Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks!

Mimi

