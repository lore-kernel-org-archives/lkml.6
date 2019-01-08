Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B37FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B44A20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfAHPS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:18:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727906AbfAHPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:18:26 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08FEgX4051849
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 10:18:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvurc8xqh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:18:24 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 8 Jan 2019 15:18:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 15:18:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08FID5F7471528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 15:18:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A90C742041;
        Tue,  8 Jan 2019 15:18:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FCB24204C;
        Tue,  8 Jan 2019 15:18:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.90.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 15:18:11 +0000 (GMT)
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to
 .secondary_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Tue, 08 Jan 2019 10:18:00 -0500
In-Reply-To: <20190108081247.2266-2-kasong@redhat.com>
References: <20190108081247.2266-1-kasong@redhat.com>
         <20190108081247.2266-2-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010815-0012-0000-0000-000002E3FC54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010815-0013-0000-0000-0000211B09D9
Message-Id: <1546960680.19931.114.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'ing the LSM and integrity mailing lists]

Repeating my comment on PATCH 0/1 here with the expanded set of
mailing lists.

The builtin and secondary keyrings have a signature change of trust
rooted in the signed kernel image.  Adding the pre-boot keys to the
secondary keyring breaks that signature chain of trust.

Please do NOT add the pre-boot "platform" keys to the secondary
keyring.

Mimi


On Tue, 2019-01-08 at 16:12 +0800, Kairui Song wrote:
> Currently kexec may need to verify the kerne image, and the kernel image
> could be signed with third part keys which are provided by paltform or
> firmware (eg. stored in MokListRT EFI variable). And the same time,
> kexec_file_load will only verify the image agains .builtin_trusted_keys
> or .secondary_trusted_keys according to configuration, but there is no
> way for kexec_file_load to verify the image against any third part keys
> mentioned above.
> 
> In ea93102f3224 ('integrity: Define a trusted platform keyring') a
> .platform keyring is introduced to store the keys provided by platform
> or firmware. And with a few following commits including 15ea0e1e3e185
> ('efi: Import certificates from UEFI Secure Boot'), now keys required to
> verify the image is being imported to .paltform keyring, and later
> IMA-appraisal could access the keyring and verify the image.
> 
> This patch links the .platform keyring to .secondary_trusted_keys so
> kexec_file_load could also leverage the .platform keyring to verify the
> kernel image.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
>  include/keys/platform_keyring.h | 12 ++++++++++++
>  security/integrity/digsig.c     |  7 +++++++
>  3 files changed, 49 insertions(+)
>  create mode 100644 include/keys/platform_keyring.h
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 81728717523d..dcef0259e149 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -18,12 +18,14 @@
>  #include <linux/verification.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
> +#include <keys/platform_keyring.h>
>  #include <crypto/pkcs7.h>
>  
>  static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +static struct key *platform_keys = NULL;
>  
>  extern __initconst const u8 system_certificate_list[];
>  extern __initconst const unsigned long system_certificate_list_size;
> @@ -67,6 +69,12 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  		/* Allow the builtin keyring to be added to the secondary */
>  		return 0;
>  
> +	if (type == &key_type_keyring &&
> +	    dest_keyring == secondary_trusted_keys &&
> +	    payload == &platform_keys->payload)
> +		/* Allow the platform keyring to be added to the secondary */
> +		return 0;
> +
>  	return restrict_link_by_signature(dest_keyring, type, payload,
>  					  secondary_trusted_keys);
>  }
> @@ -188,6 +196,28 @@ static __init int load_system_certificate_list(void)
>  }
>  late_initcall(load_system_certificate_list);
>  
> +#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && defined(CONFIG_SECONDARY_TRUSTED_KEYRING)
> +
> +/*
> + * Link .platform keyring to .secondary_trusted_key keyring
> + */
> +static __init int load_platform_certificate_list(void)
> +{
> +	int ret = 0;
> +	platform_keys = integrity_get_platform_keyring();
> +	if (!platform_keys) {
> +		return 0;
> +	}
> +	ret = key_link(secondary_trusted_keys, platform_keys);
> +	if (ret < 0) {
> +		pr_err("Failed to link platform keyring: %d", ret);
> +	}
> +	return 0;
> +}
> +late_initcall(load_platform_certificate_list);
> +
> +#endif
> +
>  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
>  
>  /**
> diff --git a/include/keys/platform_keyring.h b/include/keys/platform_keyring.h
> new file mode 100644
> index 000000000000..4f92ed6c0b42
> --- /dev/null
> +++ b/include/keys/platform_keyring.h
> @@ -0,0 +1,12 @@
> +#ifndef _KEYS_PLATFORM_KEYRING_H
> +#define _KEYS_PLATFORM_KEYRING_H
> +
> +#include <linux/key.h>
> +
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +
> +extern const struct key* __init integrity_get_platform_keyring(void);
> +
> +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
> +
> +#endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f45d6edecf99..397758d4f12d 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -176,3 +176,10 @@ int __init integrity_load_cert(const unsigned int id, const char *source,
>  	pr_info("Loading X.509 certificate: %s\n", source);
>  	return integrity_add_key(id, data, len, perm);
>  }
> +
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +struct key* __init integrity_get_platform_keyring(void)
> +{
> +	return keyring[INTEGRITY_KEYRING_PLATFORM];
> +}
> +#endif

