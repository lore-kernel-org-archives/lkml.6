Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D8DC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E588A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeK2DsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:48:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729118AbeK2DsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:48:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASGbXS9078934
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:45:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1vrg6xyv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:45:46 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Nov 2018 16:45:44 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 16:45:40 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASGjd0J9568566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 16:45:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9657A42042;
        Wed, 28 Nov 2018 16:45:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 039964203F;
        Wed, 28 Nov 2018 16:45:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.103.235])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 16:45:37 +0000 (GMT)
Subject: Re: [PATCH 0/7] add platform/firmware keys support for kernel
 verification by IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, seth.forshee@canonical.com,
        kexec@lists.infradead.org, keyrings@vger.kernel.org,
        vgoyal@redhat.com, ebiederm@xmission.com, mpe@ellerman.id.au
Date:   Wed, 28 Nov 2018 11:45:27 -0500
In-Reply-To: <20181125151500.8298-1-nayna@linux.ibm.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112816-4275-0000-0000-000002E81C26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112816-4276-0000-0000-000037F55D5A
Message-Id: <1543423527.3902.239.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,

On Sun, 2018-11-25 at 20:44 +0530, Nayna Jain wrote:
> On secure boot enabled systems, a verified kernel may need to kexec
> additional kernels. For example, it may be used as a bootloader needing
> to kexec a target kernel or it may need to kexec a crashdump kernel.
> In such cases, it may want to verify the signature of the next kernel
> image.
> 
> It is possible that the new kernel image is signed with third party keys
> which are stored as platform or firmware keys in the 'db' variable. The
> kernel, however, can not directly verify these platform keys, and an
> administrator may therefore not want to trust them for arbitrary usage.
> In order to differentiate platform keys from other keys and provide the
> necessary separation of trust the kernel needs an additional keyring to
> store platform/firmware keys.
> 
> The secure boot key database is expected to store the keys as EFI
> Signature List(ESL). The patch set uses David Howells and Josh Boyer's
> patch to access and parse the ESL to extract the certificates and load
> them onto the platform keyring.
> 
> The last patch in this patch set adds support for IMA-appraisal to
> verify the kexec'ed kernel image based on keys stored in the platform
> keyring.
> 
> Changelog:
> 
> v0:
> - The original patches loaded the certificates onto the secondary
>   trusted keyring. This patch set defines a new keyring named
>   ".platform" and adds the certificates to this new keyring  
> - removed CONFIG EFI_SIGNATURE_LIST_PARSER and LOAD_UEFI_KEYS
> - moved files from certs/ to security/integrity/platform_certs/

This patch set is looking really good!  There are a couple of
checkpatch.pl warnings that need to be addressed before these patches
can be upstreamed.  I'd also like to see some Reviews/Acks for them as
well.

For the time being these patches are queued in the #next-integrity-
queued branch.

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.
git/

thanks!

Mimi

> 
> Dave Howells (2):
>   efi: Add EFI signature data types
>   efi: Add an EFI signature blob parser
> 
> Josh Boyer (2):
>   efi: Import certificates from UEFI Secure Boot
>   efi: Allow the "db" UEFI variable to be suppressed
> 
> Nayna Jain (3):
>   integrity: define a trusted platform keyring
>   integrity: load certs to the platform keyring
>   ima: support platform keyring for kernel appraisal
> 
>  include/linux/efi.h                                |  34 ++++
>  security/integrity/Kconfig                         |  11 ++
>  security/integrity/Makefile                        |   5 +
>  security/integrity/digsig.c                        | 115 ++++++++----
>  security/integrity/ima/ima_appraise.c              |  11 +-
>  security/integrity/integrity.h                     |  23 ++-
>  security/integrity/platform_certs/efi_parser.c     | 112 ++++++++++++
>  security/integrity/platform_certs/load_uefi.c      | 192 +++++++++++++++++++++
>  .../integrity/platform_certs/platform_keyring.c    |  62 +++++++
>  9 files changed, 527 insertions(+), 38 deletions(-)
>  create mode 100644 security/integrity/platform_certs/efi_parser.c
>  create mode 100644 security/integrity/platform_certs/load_uefi.c
>  create mode 100644 security/integrity/platform_certs/platform_keyring.c
> 

