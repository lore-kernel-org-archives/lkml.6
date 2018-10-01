Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E9CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D946208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D946208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJBD50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:57:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51238 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJBD50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:57:26 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g75ZT-0007pR-4b; Mon, 01 Oct 2018 21:17:39 +0000
Subject: Re: [PATCH security-next v3 13/29] LoadPin: Rename "enable" to
 "enforce"
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
 <20180925001832.18322-14-keescook@chromium.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <30e52d2d-844f-675f-8b12-b91ca5a8d96e@canonical.com>
Date:   Mon, 1 Oct 2018 14:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-14-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> LoadPin's "enable" setting is really about enforcement, not whether
> or not the LSM is using LSM hooks. Instead, split this out so that LSM
> enabling can be logically distinct from whether enforcement is happening
> (for example, the pinning happens when the LSM is enabled, but the pin
> is only checked when "enforce" is set). This allows LoadPin to continue
> to operate sanely in test environments once LSM enable/disable is
> centrally handled (i.e. we want LoadPin to be enabled separately from
> its enforcement).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/loadpin/Kconfig   |  4 ++--
>  security/loadpin/loadpin.c | 21 +++++++++++----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index dd01aa91e521..8653608a3693 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -10,10 +10,10 @@ config SECURITY_LOADPIN
>  	  have a root filesystem backed by a read-only device such as
>  	  dm-verity or a CDROM.
>  
> -config SECURITY_LOADPIN_ENABLED
> +config SECURITY_LOADPIN_ENFORCING
>  	bool "Enforce LoadPin at boot"
>  	depends on SECURITY_LOADPIN
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter
> -	  "loadpin.enabled=1".
> +	  "loadpin.enforcing=1".
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 0716af28808a..d8a68a6f6fef 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -44,7 +44,7 @@ static void report_load(const char *origin, struct file *file, char *operation)
>  	kfree(pathname);
>  }
>  
> -static int enabled = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENABLED);
> +static int enforcing = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCING);
>  static struct super_block *pinned_root;
>  static DEFINE_SPINLOCK(pinned_root_spinlock);
>  
> @@ -60,8 +60,8 @@ static struct ctl_path loadpin_sysctl_path[] = {
>  
>  static struct ctl_table loadpin_sysctl_table[] = {
>  	{
> -		.procname       = "enabled",
> -		.data           = &enabled,
> +		.procname       = "enforcing",
> +		.data           = &enforcing,
>  		.maxlen         = sizeof(int),
>  		.mode           = 0644,
>  		.proc_handler   = proc_dointvec_minmax,
> @@ -97,7 +97,7 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
>  					   loadpin_sysctl_table))
>  			pr_notice("sysctl registration failed!\n");
>  		else
> -			pr_info("load pinning can be disabled.\n");
> +			pr_info("enforcement can be disabled.\n");
>  	} else
>  		pr_info("load pinning engaged.\n");
>  }
> @@ -128,7 +128,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  
>  	/* This handles the older init_module API that has a NULL file. */
>  	if (!file) {
> -		if (!enabled) {
> +		if (!enforcing) {
>  			report_load(origin, NULL, "old-api-pinning-ignored");
>  			return 0;
>  		}
> @@ -151,7 +151,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  		 * Unlock now since it's only pinned_root we care about.
>  		 * In the worst case, we will (correctly) report pinning
>  		 * failures before we have announced that pinning is
> -		 * enabled. This would be purely cosmetic.
> +		 * enforcing. This would be purely cosmetic.
>  		 */
>  		spin_unlock(&pinned_root_spinlock);
>  		check_pinning_enforcement(pinned_root);
> @@ -161,7 +161,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  	}
>  
>  	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
> -		if (unlikely(!enabled)) {
> +		if (unlikely(!enforcing)) {
>  			report_load(origin, file, "pinning-ignored");
>  			return 0;
>  		}
> @@ -186,10 +186,11 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>  
>  void __init loadpin_add_hooks(void)
>  {
> -	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
> +	pr_info("ready to pin (currently %senforcing)\n",
> +		enforcing ? "" : "not ");
>  	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
>  }
>  
>  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
> -module_param(enabled, int, 0);
> -MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
> +module_param(enforcing, int, 0);
> +MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
> 

