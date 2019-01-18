Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099AA20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAROfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:35:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727342AbfAROfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:35:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IEZfxP063983
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:35:43 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q3gjyrb0e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:35:43 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 18 Jan 2019 14:35:36 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 14:35:30 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0IEZTYZ22937790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 14:35:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A485AE05F;
        Fri, 18 Jan 2019 14:35:29 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6428AE063;
        Fri, 18 Jan 2019 14:35:27 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.136.27])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 14:35:27 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] integrity, KEYS: add a reference to platform
 keyring
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, jwboyer@fedoraproject.org,
        keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com,
        nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
References: <20190118091733.29940-1-kasong@redhat.com>
 <20190118091733.29940-2-kasong@redhat.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Fri, 18 Jan 2019 09:35:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190118091733.29940-2-kasong@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19011814-0060-0000-0000-000002FBD6E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010430; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01148278; UDB=6.00598214; IPR=6.00928581;
 MB=3.00025187; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-18 14:35:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011814-0061-0000-0000-000047F882F3
Message-Id: <3c7fa625-e77c-d6b4-35a4-8f8e9af60864@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/18/2019 04:17 AM, Kairui Song wrote:
> commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
> introduced a .platform keyring for storing preboot keys, used for
> verifying kernel images' signature. Currently only IMA-appraisal is able
> to use the keyring to verify kernel images that have their signature
> stored in xattr.
>
> This patch exposes the .platform keyring, making it accessible for
> verifying PE signed kernel images as well.
>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   certs/system_keyring.c        | 9 +++++++++
>   include/keys/system_keyring.h | 5 +++++
>   security/integrity/digsig.c   | 6 ++++++
>   3 files changed, 20 insertions(+)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 81728717523d..4690ef9cda8a 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>   static struct key *secondary_trusted_keys;
>   #endif
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +static struct key *platform_trusted_keys;
> +#endif
>   
>   extern __initconst const u8 system_certificate_list[];
>   extern __initconst const unsigned long system_certificate_list_size;
> @@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
>   }
>   EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
>   
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +void __init set_platform_trusted_keys(struct key *keyring) {
> +	platform_trusted_keys = keyring;
> +}
> +#endif
> +
>   #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 359c2f936004..9e1b7849b6aa 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
>   }
>   #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
>   
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +
> +extern void __init set_platform_trusted_keys(struct key* keyring);
> +
> +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
>   
>   #endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f45d6edecf99..bfabc2a8111d 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
>   		keyring[id] = NULL;
>   	}
>   
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	if (id == INTEGRITY_KEYRING_PLATFORM) {

Shouldn't it also check that keyring[id] is not NULL ?

Thanks & Regards,
     - Nayna

> +		set_platform_trusted_keys(keyring[id]);
> +	}
> +#endif
> +
>   	return err;
>   }
>   

