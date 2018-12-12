Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FEC6786C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A022084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A022084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeLLSPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:15:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727748AbeLLSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:15:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCIDbk6051195
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:15:06 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb793ggea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:15:05 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Wed, 12 Dec 2018 18:15:05 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 18:15:01 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCIF0rP29032522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 18:15:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 338D0BE051;
        Wed, 12 Dec 2018 18:15:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEBEBBE04F;
        Wed, 12 Dec 2018 18:14:52 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.201.40])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Dec 2018 18:14:52 +0000 (GMT)
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-8-nayna@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 7/7] ima: Support platform keyring for kernel appraisal
In-reply-to: <20181208202705.18673-8-nayna@linux.ibm.com>
Date:   Wed, 12 Dec 2018 16:14:47 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18121218-0016-0000-0000-000009637388
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010215; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130792; UDB=6.00587619; IPR=6.00910926;
 MB=3.00024670; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 18:15:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121218-0017-0000-0000-000041619E9B
Message-Id: <8736r2fw88.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Nayna Jain <nayna@linux.ibm.com> writes:

> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
>
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> ---
> Changelog:
>
> v2:
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
>
>  security/integrity/ima/ima_appraise.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index deec1804a00a..e8f520450895 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -289,12 +289,21 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	case EVM_IMA_XATTR_DIGSIG:
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>  		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
> -					     (const char *)xattr_value, rc,
> +					     (const char *)xattr_value,
> +					     xattr_len,
>  					     iint->ima_hash->digest,
>  					     iint->ima_hash->length);
>  		if (rc == -EOPNOTSUPP) {
>  			status = INTEGRITY_UNKNOWN;
> -		} else if (rc) {
> +			break;
> +		}
> +		if (rc && func == KEXEC_KERNEL_CHECK)
> +			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
> +						     (const char *)xattr_value,
> +						     xattr_len,
> +						     iint->ima_hash->digest,
> +						     iint->ima_hash->length);

If CONFIG_INTEGRITY_PLATFORM_KEYRING=n the second call to
integrity_digsig_verify() above will always fail, and the audit message
of failed signature verifications for KEXEC_KERNEL will always log the
same rc value, which is whatever request_key() returns when asked to
look for an inexistent keyring.

Here is a patch which only performs the second try if the platform
keyring is enabled.


From d5fb94ab9eb13f6294f8dc44d1344cb85dfa41b8 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Wed, 12 Dec 2018 16:02:09 -0200
Subject: [PATCH] ima: Only use the platform keyring if it's enabled

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index e8f520450895..f6ac405daabb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -297,7 +297,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 			status = INTEGRITY_UNKNOWN;
 			break;
 		}
-		if (rc && func == KEXEC_KERNEL_CHECK)
+		if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) && rc &&
+		    func == KEXEC_KERNEL_CHECK)
 			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
 						     (const char *)xattr_value,
 						     xattr_len,

