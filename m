Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2EFECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BCB21546
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bdiOQDSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BCB21546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeIUFuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:50:14 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:43311 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388299AbeIUFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537488249; bh=lL4CpPjC9K0O3d5lLk3CNEYmcKIZDt855zbcHoxfDZs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=bdiOQDSsJPMNxmkxGjswv6Bu4W4LkNZVjQ9ZxULNbsjvsBgz52eHBsDUxS+3iXkVYGA9qURdO0FfYOZGxlUvtF51ZWNhx6bZNjO5EY4gxF/aGKLxXrCyHICPNgXGNhQ5HFrjGhk2+nx8jsp54F0phhHcM26rmPBpbcudWRGiPHgezH4lIx9acYLwIp8A+GEacVCm40S2eC4fq/iyzXRvaQ7dxcxeTaWmW1rpgTDj8lKJOAM6ojbWTDB/egqvpqxKlgiU12rdd1OqRrMCrnx5o4Ev9BHkUyLOpN1E5LPZIrmoUQFPJd/SC9CiBPYbXezdFCodKfo6CZoxi7w5bBKlVg==
X-YMail-OSG: oGoTMioVM1nP3S6yNaEPZtbQbz9zQp8eSrtHFHv0Z3iS1jW0uPxUS98zrCyLzpI
 RVndyy54ObL0iTkHyWcEqSsOmpD_yMP1MxAKYttCo1gX76kz0sbkhyt8tNLVtrV2NDdsXmZaoFy6
 v1gd7AcwJsJflmjnW_2enOSa9yNphmLHmVZOdgbxNXYk5gr09.tcL0dtnZOxYwBcX8AOlnjrBZ75
 wtx3MSsM.al8ANpJKuRJH0S4oLHF.3IywqAFZak.Je8AjE3BlfPAl4p4IeRhsLLAplcSKfv0xWna
 pPHkhFVBGOxSYU8cdQ.UvkqmYk1Casbx.EVLeIHPPzRwRWvzfvXzUyAqkmF22hUZX0mW3JtOHdyN
 diY3zBHfzwyHCKixody24ypBY7gl5NGSI2CZnbrnDpgehcscPt_cT48GgCcOhSw_ThSRx7R8FsBY
 SLYeO7R2_u78GG81G3mvQx_OQHLYZWIoj26ulASo51t.pvPOa3IRnBxYXSAYXT25goHsXbHzThHn
 wZlF_jsvgYtuy_IDBQCqwxmcgBrz7JCub9R4o0bDUicCnn8r9nARWUtK9udBKBPaX2p1.tLpL0EZ
 9yYYKEUHvOGl_GSpDa_.oNq10FHRRju7ZGLP3662cXtV2uXxzjfWsgS9ugn0.QKv8r7vjZ1phQs6
 97sUQbeacNaY5SJPz.1_2eZz_7CRxmlfdsDY6zKKh.BkwQXZjVaWo8p1Wx1ulFMnWoYyvzfrgOm1
 xv3fdlPfovTZ8_OVQTDc0uTZ7KWFVXHIfEcNshwen3x62DfYofpVFJ2rfsmDLrtl7vxfKYGuHySd
 sq44iSPzJNuTIKQBQzLuChSr3L8zekFDqtmMganoolBVyq_cnYx5rzdiEMBh1JDip4MUWGarR1xt
 08PsxktQDHXBSUkVf9QjIP7AWa23vB_F6Rlj_IsKtJKg3qKqkw.dIuFOLGeaa_DvdUVj6Kaexgpq
 ORp7yrDR1xSxaPI1_38qKx.r9Kzq.ma_6rpfKp3fqViuzTnKI_Q3KWucowhcYuS.KidURT6OowWb
 2UnQG3XklWVzYYZ3I2bKC958Wat0gfvrUqTnnBA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 00:04:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0edf393cd6d1cfd83fb5ca04c5ded83b;
          Fri, 21 Sep 2018 00:04:07 +0000 (UTC)
Subject: Re: [PATCH security-next v2 18/26] LSM: Build ordered list of ordered
 LSMs for init
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-19-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 17:04:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-19-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 9:23 AM, Kees Cook wrote:
> This constructs a list of ordered LSMs to initialize, using a hard-coded
> list of only "integrity": minor LSMs continue to have direct hook calls,
> and major LSMs continue to initialize separately.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Do you think that this mechanism will be sufficiently
flexible to accommodate dynamically loaded security modules
in the future? While I am not personally an advocate of
dynamically loaded security modules I have been working to
ensure that I haven't done anything that would actively
interfere with someone who did.

> ---
>  security/security.c | 59 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 25a019cc4a2b..2541a512a0f7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -34,6 +34,9 @@
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> +/* How many LSMs were built into the kernel? */
> +#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> +
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  
> @@ -41,6 +44,9 @@ char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_major_lsm;
>  
> +/* Ordered list of LSMs to initialize. */
> +static __initdata struct lsm_info **ordered_lsms;
> +
>  static bool debug __initdata;
>  #define init_debug(...)						\
>  	do {							\
> @@ -74,6 +80,45 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
>  	}
>  }
>  
> +/* Is an LSM already listed in the ordered LSMs list? */
> +static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +{
> +	struct lsm_info **check;
> +
> +	for (check = ordered_lsms; *check; check++)
> +		if (*check == lsm)
> +			return true;
> +
> +	return false;
> +}
> +
> +/* Append an LSM to the list of ordered LSMs to initialize. */
> +static int last_lsm __initdata;
> +static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> +{
> +	/* Ignore duplicate selections. */
> +	if (exists_ordered_lsm(lsm))
> +		return;
> +
> +	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
> +		return;
> +
> +	ordered_lsms[last_lsm++] = lsm;
> +	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
> +		   (!lsm->enabled || *lsm->enabled) ? "en" : "dis");
> +}
> +
> +/* Populate ordered LSMs list from hard-coded list of LSMs. */
> +static void __init prepare_lsm_order(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (strcmp(lsm->name, "integrity") == 0)
> +			append_ordered_lsm(lsm, "builtin");
> +	}
> +}
> +
>  /* Is an LSM allowed to be enabled? */
>  static bool __init lsm_allowed(struct lsm_info *lsm)
>  {
> @@ -104,14 +149,10 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
>  
>  static void __init ordered_lsm_init(void)
>  {
> -	struct lsm_info *lsm;
> -
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
> -			continue;
> +	struct lsm_info **lsm;
>  
> -		maybe_initialize_lsm(lsm);
> -	}
> +	for (lsm = ordered_lsms; *lsm; lsm++)
> +		maybe_initialize_lsm(*lsm);
>  }
>  
>  static void __init major_lsm_init(void)
> @@ -141,6 +182,8 @@ int __init security_init(void)
>  	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
> +	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
> +				GFP_KERNEL);
>  
>  	/* Process "security=", if given. */
>  	if (!chosen_major_lsm)
> @@ -169,6 +212,7 @@ int __init security_init(void)
>  	loadpin_add_hooks();
>  
>  	/* Load LSMs in specified order. */
> +	prepare_lsm_order();
>  	ordered_lsm_init();
>  
>  	/*
> @@ -176,6 +220,7 @@ int __init security_init(void)
>  	 */
>  	major_lsm_init();
>  
> +	kfree(ordered_lsms);
>  	return 0;
>  }
>  

