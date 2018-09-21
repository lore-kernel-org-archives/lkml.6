Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2BBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ECD2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kdHyVchM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ECD2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbeIUGMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:12:01 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:42273 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbeIUGMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537489552; bh=NP66JWgDCiwOIWbQRYkw/4e57OLaxZaK6S7EJfawXfI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kdHyVchMXCsms2+pJE6S3SYFsqlkykEGHrjezP+M9r5t9JvIEbdqaRJ6rVKRZ1YZnccEHCl0TDIVN8ix5PUI7137OPi0Li9izjhzZS4qlTcIV0MaTCMW349LtsTlqry0rQQn9Iwt+jNpl+NZs5dGAYLPyKAqoraJNZH6JeNenK+Lav+WZicMq2vV8nH22u8AbRoHoD0/mmjToay82V7p0aWA9E4ekGhYJAV5B8tpc0YjlN2EHCTxOCKY4cSci1oARJoRMxJo+c+cQypAsUJ8pl9GoqZIDPKQ4aiFkiDfAJ0h0xCEkbTeDlUbzJ/vPpDJidO9sbzTXCkUgy2c2LV3pg==
X-YMail-OSG: q9TDyjIVM1lIzMKxN2KsrN4oObJXs.zOs6x22PyEP4uBW5GJNYrgA6YifDG6e27
 dOUvCHkHTOM85NJOikGoMqp3F8KMURgC1rCdn2Xf7eLH0lMUYE4se9p6JKARR9w0oZJOMJj6fnmo
 VH_3Gb_2mHbjceLsyjp5V_PTlhkMHBWfWqFFfyJuCfX5OXpv7GJZBhM6Qbt91FBNKUUo5z2ROkrz
 h1FYu8A6ehZXCrbZTlYunE7Us3hm8v5ss6_TU6r9EcCvQaoYSmUSh_fXqOUbLTjWg.zrRTTJVDX.
 cDFY3H4eMKW2SQTUC1qXb9QoQnyaFWtmgAgLkk9l9mi4fwciwNrGrK7hfTU2X8TEngxpTm4FCMkT
 QjWwQf_yi4ShtcDp2Sy2jf.tpU.rac6w6_9xk2Rw5j_6GrHDqPIoFcKcUZh5UM4CmLRLTwE5cxmL
 oeoRsq03WA7QAbcQJ17td3GHEOLhvgNifCsTlw45j_M24O85Th4Ad5Hn_wpcOF73j6coO7AJl0V4
 HalNHw23vl3hokMAe5hj.lO2LXPUh6CF.Yz39NRP0lrO8CiBpucByFt.GgJqiTo7JGUIcs_6oJwd
 4y4szQcrlgHJXFprfbame3.Qi6kfGJMt.45nbr2mCS.gmsziATXnHYZkPZj9xfOxw8rzvHDmzucl
 4Kka3Dq7V3CQX9e2mIzkW1BVBt09etkn1riMXnB6GEtXHAPf8ozHwpNqAwi_DP.l2xufTfreRfA8
 CSbzPx2jN7fsk0ozfeGlOONboMrndlxF7l8LbrlvEAX.QYV6N3m1klUKMBP5wY.zjq8FSPHUQVt5
 4V0x6x211zjAAWTPV2xOHZBjZSamH8alz_BcSdr0qA9H9iPyuOADIXlqCasnmka7bKfwAutJL955
 4rH6d3bBEhPBL6ynKwebklCgRLfUu9PzvK.lGRj2RwhFiu2yGoqGYMr_22U_3azVYGNb1MeKcttl
 sSbwB_Z__McW_u2o_QblP...HEEtLlOsASKsqTu5pbhD60cf1UIuF.sAL5EzENokk9PJWn0nKJY9
 ziSHZOCO.4Bgw_MLXM7NZnqUrUctpWKWA2aFasDs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 00:25:52 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 15678ac77bb764a5b7612219a78407b0;
          Fri, 21 Sep 2018 00:25:49 +0000 (UTC)
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
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
 <20180920162338.21060-27-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 17:25:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-27-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 9:23 AM, Kees Cook wrote:
> This removes CONFIG_DEFAULT_SECURITY in favor of the explicit build-time
> ordering offered by CONFIG_LSM_ORDER, and adds all the exclusive LSMs
> to the ordered LSM initialization.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/Kconfig    | 39 +--------------------------------------
>  security/security.c | 23 +----------------------
>  2 files changed, 2 insertions(+), 60 deletions(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 33c9ac3cb759..a2e365420919 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -239,46 +239,9 @@ source security/yama/Kconfig
>  
>  source security/integrity/Kconfig
>  
> -choice
> -	prompt "Default security module"
> -	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> -	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
> -	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> -	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> -	default DEFAULT_SECURITY_DAC
> -
> -	help
> -	  Select the security module that will be used by default if the
> -	  kernel parameter security= is not specified.
> -
> -	config DEFAULT_SECURITY_SELINUX
> -		bool "SELinux" if SECURITY_SELINUX=y
> -
> -	config DEFAULT_SECURITY_SMACK
> -		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> -
> -	config DEFAULT_SECURITY_TOMOYO
> -		bool "TOMOYO" if SECURITY_TOMOYO=y
> -
> -	config DEFAULT_SECURITY_APPARMOR
> -		bool "AppArmor" if SECURITY_APPARMOR=y
> -
> -	config DEFAULT_SECURITY_DAC
> -		bool "Unix Discretionary Access Controls"
> -
> -endchoice
> -
> -config DEFAULT_SECURITY
> -	string
> -	default "selinux" if DEFAULT_SECURITY_SELINUX
> -	default "smack" if DEFAULT_SECURITY_SMACK
> -	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
> -	default "apparmor" if DEFAULT_SECURITY_APPARMOR
> -	default "" if DEFAULT_SECURITY_DAC
> -
>  config LSM_ORDER
>  	string "Default initialization order of builtin LSMs"
> -	default "yama,loadpin,integrity"
> +	default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"

If I want to compile all the major modules into my kernel and use
AppArmor by default would I use

	default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"

or

	default "yama,loadpin,integrity,apparmor"

When we have "blob-sharing" how could I compile in tomoyo,
but exclude it without a boot line option?

When we have full stacking, how could I compile in selinux
but exclude it?

>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be link-order initialized
> diff --git a/security/security.c b/security/security.c
> index f076fdc6b451..628e62fda5fe 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -130,7 +130,6 @@ static void __init parse_lsm_order(const char *order, const char *origin)
>  
>  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  			if (lsm->order == LSM_ORDER_MUTABLE &&
> -			    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
>  			    strcmp(lsm->name, name) == 0) {
>  				append_ordered_lsm(lsm, origin);
>  				found = true;
> @@ -163,8 +162,7 @@ static void __init prepare_lsm_order(void)
>  
>  	/* Add any missing LSMs, in link order. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (lsm->order == LSM_ORDER_MUTABLE &&
> -		    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> +		if (lsm->order == LSM_ORDER_MUTABLE)
>  			append_ordered_lsm(lsm, "link-time");
>  	}
>  
> @@ -222,18 +220,6 @@ static void __init ordered_lsm_init(void)
>  		maybe_initialize_lsm(*lsm);
>  }
>  
> -static void __init major_lsm_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> -			continue;
> -
> -		maybe_initialize_lsm(lsm);
> -	}
> -}
> -
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -253,8 +239,6 @@ int __init security_init(void)
>  				GFP_KERNEL);
>  
>  	/* Process "security=", if given. */
> -	if (!chosen_major_lsm)
> -		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
>  	if (chosen_major_lsm) {
>  		struct lsm_info *lsm;
>  
> @@ -275,11 +259,6 @@ int __init security_init(void)
>  	prepare_lsm_order();
>  	ordered_lsm_init();
>  
> -	/*
> -	 * Load all the remaining security modules.
> -	 */
> -	major_lsm_init();
> -
>  	kfree(ordered_lsms);
>  	return 0;
>  }

