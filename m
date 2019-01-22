Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A79217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfAVPhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:37:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbfAVPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:37:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MFXCVb104781
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:37:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6421xb5s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:37:40 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 22 Jan 2019 15:37:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 15:37:32 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MFbV4t10682400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 15:37:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D9A1AE051;
        Tue, 22 Jan 2019 15:37:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26CE9AE04D;
        Tue, 22 Jan 2019 15:37:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.23])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 15:37:29 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] integrity, KEYS: add a reference to platform
 keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Tue, 22 Jan 2019 10:37:18 -0500
In-Reply-To: <20190121095929.26915-2-kasong@redhat.com>
References: <20190121095929.26915-1-kasong@redhat.com>
         <20190121095929.26915-2-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012215-0008-0000-0000-000002B473CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012215-0009-0000-0000-00002220A060
Message-Id: <1548171438.4038.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 17:59 +0800, Kairui Song wrote:
> commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
> introduced a .platform keyring for storing preboot keys, used for
> verifying kernel images' signature. Currently only IMA-appraisal is able
> to use the keyring to verify kernel images that have their signature
> stored in xattr.
> 
> This patch exposes the .platform keyring, making it
> accessible for verifying PE signed kernel images as well.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed/Tested-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  certs/system_keyring.c        | 9 +++++++++
>  include/keys/system_keyring.h | 9 +++++++++
>  security/integrity/digsig.c   | 3 +++
>  3 files changed, 21 insertions(+)
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
> index 359c2f936004..df766ef8f03c 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -61,5 +61,14 @@ static inline struct key *get_ima_blacklist_keyring(void)
>  }
>  #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
>  
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +
> +extern void __init set_platform_trusted_keys(struct key* keyring);
> +
> +#else
> +
> +static inline void set_platform_trusted_keys(struct key* keyring) { };
> +
> +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
>  
>  #endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f45d6edecf99..e19c2eb72c51 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -87,6 +87,9 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
>  		pr_info("Can't allocate %s keyring (%d)\n",
>  			keyring_name[id], err);
>  		keyring[id] = NULL;
> +	} else {
> +		if (id == INTEGRITY_KEYRING_PLATFORM)
> +			set_platform_trusted_keys(keyring[id]);
>  	}
>  
>  	return err;

