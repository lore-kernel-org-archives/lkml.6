Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7AFC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EFB2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfBDWUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:20:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbfBDWUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:20:18 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14MJG8K039694
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 17:20:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qew27ackg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 17:20:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Feb 2019 22:20:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 22:20:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14MKAFm5308774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 22:20:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D99A405B;
        Mon,  4 Feb 2019 22:20:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6082A4054;
        Mon,  4 Feb 2019 22:20:08 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Feb 2019 22:20:08 +0000 (GMT)
Subject: Re: [PATCH] integrity, KEYS: Fix build break with
 set_platform_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Mon, 04 Feb 2019 17:20:08 -0500
In-Reply-To: <20190203155927.24390-1-kasong@redhat.com>
References: <20190203155927.24390-1-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020422-0016-0000-0000-000002511E2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020422-0017-0000-0000-000032AB2703
Message-Id: <1549318808.4146.127.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-02-03 at 23:59 +0800, Kairui Song wrote:
> Commit 15ebb2eb0705 ("integrity, KEYS: add a reference to platform
> keyring") introduced a function set_platform_trusted_keys
> and calls the function in __integrity_init_keyring.
> 
> It only checks if CONFIG_INTEGRITY_PLATFORM_KEYRING is enabled when
> enabling this function, but actually this function also depends on
> CONFIG_SYSTEM_TRUSTED_KEYRING.
> 
> So when built with CONFIG_INTEGRITY_PLATFORM_KEYRING &&
> !CONFIG_SYSTEM_TRUSTED_KEYRING. we will get following error:
> 
> digsig.c:92: undefined reference to `set_platform_trusted_keys'
> 
> And it also mistakenly wrapped the function code in the ifdef block of
> CONFIG_SYSTEM_DATA_VERIFICATION.
> 
> This commit fixes the issue by adding the missing check of
> CONFIG_SYSTEM_TRUSTED_KEYRING and move the function code out of
> CONFIG_SYSTEM_DATA_VERIFICATION's ifdef block.
> 
> Fixes: 15ebb2eb0705 ("integrity, KEYS: add a reference to platform keyring")
> Signed-off-by: Kairui Song <kasong@redhat.com>

Thank you.  As the original patch hasn't yet been upstreamed , I plan
on squashing them.

Mimi


> ---
>  certs/system_keyring.c        | 4 ++--
>  include/keys/system_keyring.h | 9 +++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 19bd0504bbcb..c05c29ae4d5d 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -279,11 +279,11 @@ int verify_pkcs7_signature(const void *data, size_t len,
>  }
>  EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
>  
> +#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> +
>  #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>  void __init set_platform_trusted_keys(struct key *keyring)
>  {
>  	platform_trusted_keys = keyring;
>  }
>  #endif
> -
> -#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index c7f899ee974e..42a93eda331c 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -61,16 +61,13 @@ static inline struct key *get_ima_blacklist_keyring(void)
>  }
>  #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
>  
> -#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> -
> +#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && \
> +	defined(CONFIG_SYSTEM_TRUSTED_KEYRING)
>  extern void __init set_platform_trusted_keys(struct key *keyring);
> -
>  #else
> -
>  static inline void set_platform_trusted_keys(struct key *keyring)
>  {
>  }
> -
> -#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
> +#endif
>  
>  #endif /* _KEYS_SYSTEM_KEYRING_H */

