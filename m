Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8A20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A8A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJBE0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:26:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51610 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBE0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:26:52 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g761p-0000lq-RX; Mon, 01 Oct 2018 21:46:58 +0000
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and
 lsm.disable=
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-19-keescook@chromium.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com>
Date:   Mon, 1 Oct 2018 14:46:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-19-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> This introduces the "lsm.enable=..." and "lsm.disable=..." boot parameters
> which each can contain a comma-separated list of LSMs to enable or
> disable, respectively. The string "all" matches all LSMs.
> 
> This has very similar functionality to the existing per-LSM enable
> handling ("apparmor.enabled=...", etc), but provides a centralized
> place to perform the changes. These parameters take precedent over any
> LSM-specific boot parameters.
> 
> Disabling an LSM means it will not be considered when performing
> initializations. Enabling an LSM means either undoing a previous
> LSM-specific boot parameter disabling or a undoing a default-disabled
> CONFIG setting.
> 
> For example: "lsm.disable=apparmor apparmor.enabled=1" will result in
> AppArmor being disabled. "selinux.enabled=0 lsm.enable=selinux" will
> result in SELinux being enabled.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I don't like this. It brings about conflicting kernel params that are
bound to confuse users. Its pretty easy for a user to understand that
when they specify a parameter manually at boot, that  it overrides the
build time default. But conflicting kernel parameters are a lot harder
to deal with.

I prefer a plain enabled= list being an override of the default build
time value. Where conflicts with LSM-specific configs always result in
the LSM being disabled with a complaint about the conflict.

Though I have yet to be convinced its worth the cost, I do recognize
it is sometimes convenient to disable a single LSM, instead of typing
in a whole list of what to enable. If we have to have conflicting
kernel parameters I would prefer that the conflict throw up a warning
and leaving the LSM with the conflicting config disabled.



> ---
>  .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
>  security/Kconfig                              |  4 +++-
>  security/security.c                           | 22 +++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 32d323ee9218..67c90985d2b8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2276,6 +2276,18 @@
>  
>  	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
>  
> +	lsm.disable=lsm1,...,lsmN
> +			[SECURITY] Comma-separated list of LSMs to disable
> +			at boot time. This overrides "lsm.enable=",
> +			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
> +			parameters.
> +
> +	lsm.enable=lsm1,...,lsmN
> +			[SECURITY] Comma-separated list of LSMs to enable
> +			at boot time. This overrides any omissions from
> +			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
> +			boot parameters.
> +
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.
>  			Example: machvec=hpzx1_swiotlb
> diff --git a/security/Kconfig b/security/Kconfig
> index 71306b046270..1a82a006cc62 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -282,7 +282,9 @@ config LSM_ENABLE
>  	help
>  	  A comma-separate list of LSMs to enable by default at boot. The
>  	  default is "all", to enable all LSM modules at boot. Any LSMs
> -	  not listed here will be disabled by default.
> +	  not listed here will be disabled by default. This can be
> +	  changed with the "lsm.enable=" and "lsm.disable=" boot
> +	  parameters.
>  
>  endmenu
>  
> diff --git a/security/security.c b/security/security.c
> index 7ecb9879a863..456a3f73bc36 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -44,6 +44,8 @@ char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
>  	CONFIG_DEFAULT_SECURITY;
> +static __initdata const char *chosen_lsm_enable;
> +static __initdata const char *chosen_lsm_disable;
>  
>  static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
>  
> @@ -185,6 +187,10 @@ static void __init prepare_lsm_enable(void)
>  {
>  	/* Prepare defaults. */
>  	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
> +
> +	/* Process "lsm.enable=" and "lsm.disable=", if given. */
> +	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
> +	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
>  }
>  
>  /**
> @@ -240,6 +246,22 @@ static int __init enable_debug(char *str)
>  }
>  __setup("lsm.debug", enable_debug);
>  
> +/* Explicitly enable a list of LSMs. */
> +static int __init enable_lsm(char *str)
> +{
> +	chosen_lsm_enable = str;
> +	return 1;
> +}
> +__setup("lsm.enable=", enable_lsm);
> +
> +/* Explicitly disable a list of LSMs. */
> +static int __init disable_lsm(char *str)
> +{
> +	chosen_lsm_disable = str;
> +	return 1;
> +}
> +__setup("lsm.disable=", disable_lsm);
> +
>  static bool match_last_lsm(const char *list, const char *lsm)
>  {
>  	const char *last;
> 

