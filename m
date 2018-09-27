Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0183B216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0183B216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeI0TuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:50:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727199AbeI0TuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:50:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RDOlrW068175
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:32:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrxt7mjgf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:32:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Sep 2018 14:31:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 14:31:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8RDVsnJ1311158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 13:31:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E5D942041;
        Thu, 27 Sep 2018 16:31:38 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAC5942045;
        Thu, 27 Sep 2018 16:31:36 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.85.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 16:31:36 +0100 (BST)
Subject: Re: [PATCH v4 6/6] x86/ima: define arch_get_ima_policy() for x86
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, Eric Richter <erichte@linux.vnet.ibm.com>
Date:   Thu, 27 Sep 2018 09:31:42 -0400
In-Reply-To: <20180926122210.14642-7-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
         <20180926122210.14642-7-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092713-0016-0000-0000-0000020B5857
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092713-0017-0000-0000-000032627EA7
Message-Id: <1538055102.3459.112.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, Nayna,

On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:
> From: Eric Richter <erichte@linux.vnet.ibm.com>

> This patch implements an example arch-specific IMA policy for x86 to
> enable measurement and appraisal of any kernel image loaded for kexec,
> when CONFIG_KEXEC_VERIFY_SIG is not enabled.
> 
> For systems with CONFIG_KEXEC_VERIFY_SIG enabled, only the measurement
> rule is enabled, not the IMA-appraisal rule.

The patch itself looks good, but this patch description explains
"what" the patch is doing, not "why".  Missing is the motivation for
the patch.

Mimi

> 
> Signed-off-by: Eric Richter <erichte@linux.vnet.ibm.com>
> - Removed the policy KEXEC_ORIG_KERNEL_CHECK which was defined to
>   disable the kexec_load syscall.
> - arch_get_ima_policy() uses arch_ima_get_secureboot() to get secureboot
>   state
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> ---
>  arch/x86/kernel/ima_arch.c     | 18 ++++++++++++++++++
>  include/linux/ima.h            |  4 ++++
>  security/integrity/ima/Kconfig |  8 ++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> index bb5a88d2b271..245976e49a55 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/arch/x86/kernel/ima_arch.c
> @@ -15,3 +15,21 @@ bool arch_ima_get_secureboot(void)
>  	else
>  		return false;
>  }
> +
> +/* arch rules for audit and user mode */
> +static const char * const sb_arch_rules[] = {
> +#ifndef CONFIG_KEXEC_VERIFY_SIG
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> +#endif /* CONFIG_KEXEC_VERIFY_SIG */
> +	"measure func=KEXEC_KERNEL_CHECK",
> +	NULL
> +};
> +
> +#ifdef CONFIG_IMA_ARCH_POLICY
> +const char * const *arch_get_ima_policy(void)
> +{
> +	if (arch_ima_get_secureboot())
> +		return sb_arch_rules;
> +	return NULL;
> +}
> +#endif
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 350fa957f8a6..dabd3abdf671 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -39,10 +39,14 @@ static inline bool arch_ima_get_secureboot(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_X86) && defined(CONFIG_IMA_ARCH_POLICY)
> +extern const char * const *arch_get_ima_policy(void);
> +#else
>  static inline const char * const *arch_get_ima_policy(void)
>  {
>  	return NULL;
>  }
> +#endif
>  
>  #else
>  static inline int ima_bprm_check(struct linux_binprm *bprm)
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 13b446328dda..97609a76aa14 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -157,6 +157,14 @@ config IMA_APPRAISE
>  	  <http://linux-ima.sourceforge.net>
>  	  If unsure, say N.
>  
> +config IMA_ARCH_POLICY
> +        bool "Enable loading an IMA architecture specific policy"
> +        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
> +        default n
> +        help
> +          This option enables loading an IMA architecture specific policy
> +          based on run time secure boot flags.
> +
>  config IMA_APPRAISE_BUILD_POLICY
>  	bool "IMA build time configured policy rules"
>  	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS

