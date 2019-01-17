Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C9C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E01D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfAQXVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:21:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbfAQXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:21:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HNJkFP110490
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:21:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2xuw9ec0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:21:05 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 17 Jan 2019 23:21:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 23:20:59 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HNKwRW10355110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 23:20:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4871552052;
        Thu, 17 Jan 2019 23:20:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.54])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 90D9352050;
        Thu, 17 Jan 2019 23:20:56 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] integrity, KEYS: add a reference to platform
 keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Thu, 17 Jan 2019 18:20:45 -0500
In-Reply-To: <20190116101654.7288-2-kasong@redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
         <20190116101654.7288-2-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011723-4275-0000-0000-00000300ADD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011723-4276-0000-0000-0000380ED44B
Message-Id: <1547767245.3931.56.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> Currently when loading new kernel via kexec_file_load syscall, it is able
> to verify the signed PE bzimage against .builtin_trusted_keys or
> .secondary_trusted_keys. But the image could be signed with third part
> keys which will be provided by platform or firmware as EFI variable (eg.
> stored in MokListRT EFI variable), and the keys won't be available in
> keyrings mentioned above.
> 
> After commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
> a .platform keyring is introduced to store the keys provided by platform
> or firmware, this keyring is intended to be used for verifying kernel
> images being loaded by kexec_file_load syscall. And with a few following
> up commits, keys provided by firmware is being loaded into this keyring,
> and IMA-appraisal is able to use the keyring to verify kernel images.
> IMA is the currently the only user of that keyring.

How about simply saying, Commit "...." introduced a platform keyring
for storing preboot keys, used for verifying the kexec kernel image's
signature.

> This patch exposes the .platform, and makes it useable for other
> components. For example, kexec_file_load could use this .platform
> keyring to verify the kernel image's image.

The above statement is too generic.  Please replace "and makes it 
useable for other components" with " keyring, making it accessible for
verifying a PE signed kernel image".

> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed/Tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  certs/system_keyring.c        | 9 +++++++++
>  include/keys/system_keyring.h | 5 +++++
>  security/integrity/digsig.c   | 6 ++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 81728717523d..4690ef9cda8a 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +static struct key *platform_trusted_keys;
> +#endif
>  
>  extern __initconst const u8 system_certificate_list[];
>  extern __initconst const unsigned long system_certificate_list_size;
> @@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
>  }
>  EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
>  
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +void __init set_platform_trusted_keys(struct key *keyring) {
> +	platform_trusted_keys = keyring;
> +}
> +#endif
> +
>  #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 359c2f936004..9e1b7849b6aa 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
>  }
>  #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
>  
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +
> +extern void __init set_platform_trusted_keys(struct key* keyring);
> +
> +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
>  
>  #endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f45d6edecf99..bfabc2a8111d 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
>  		keyring[id] = NULL;
>  	}
>  
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	if (id == INTEGRITY_KEYRING_PLATFORM) {
> +		set_platform_trusted_keys(keyring[id]);
> +	}
> +#endif
> +
>  	return err;
>  }
>  

