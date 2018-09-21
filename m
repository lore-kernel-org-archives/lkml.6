Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429FECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3479921533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ln+qk8qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3479921533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbeIUF4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:56:45 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:45327 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbeIUF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537488639; bh=82peLjBhSiHNgFYaidybAqoaUyeQ0Ys2x10pG6UkUss=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ln+qk8qcmUkjJsrY9MoT7xeuibAVP0Pcefxwew7rhhq2i3W9MQVMJKNVYcbc4r2ftHRNJ5K+bUUSTay/4Nc/8dTJ5VYK9LwDDhovvxOmyZk71xImT18vqTRzvD+pOxsseq55kXFRYaWWWEis9rP3YfZ6X1nYl1Yt1LBCEV6fK/Jh+5BTz55swqBLgNGIiYrlYCFshbsdA9QTDWXefq2MIJq4HdrhdYZhzzuM28Nu1qWuADKMrR5IiFm32WaFho54qyAX6+9G8vuaETbOkL8ST949Rfmh/vgnK4IYyLoPZGiRjskuYWficP2Ey9Blu9T9BImrJ5UZwTIVTqXVsQig6w==
X-YMail-OSG: .zjKAo4VM1ny7iWzV3wDJIqwjZlBP9Xc_P5Zr.rRhHHsHJX4fGZzcGliQVD_COA
 j4EpxqINIaVMCAlFf1EjrAxhEGhoAZZzgRh2VCdgcFJbXbXU4YRJPsjkx2Bwoo5yhAr6KmOPfBNX
 zerzJDS3ONSMkZv3S.Zy5NsTju4dELzXs1be3ICKjgKiiUpboRZOkS_FSw.nhyxhBOxcOrkd27PM
 .pS99ipEadntvMwu4uoe7UtWOOfLYzvbbqnWFSZ6nrZAevupLwc6j8a9n8aNoWpumT5FlFu1szNo
 bQ8K27GGYZnDm.VHQN3rFiqy.tKxH1qx_Hd0ScshmTMgDEXYlTMKGcMC92L0zl4yPIxvTXSdZ6Kj
 ljMqtGWS6ioz3MN.IdcFe71Iz8gNzA_D2nwCCyha0ohB4YBb98BjRozFIxc0blryGQ6wbXAyF3P_
 DJgbH15SfQ2kPHTClmil1pqmDQGkmbBsjL7qjfGkFrIuFS_kLXRf9iXe.DH5zrbe2XJYdH5NUdqR
 RCXsU_OI90jjv7MuS9sinP3dvcrK2HEXoaRA3uiJuGp8sEmvV7mfDfg7x87k3dVd4gpBTm0sii96
 Krk8XbwHhGPD77sPBmOUaWMW0odSecrOElpiHsZ_mOmxcAZ9ir6BYjZ71nTGiqwRESd6iNEWML.h
 5yOOsWG_F0.R97d0n1iFe_z7w2KDI0zQrUaJfo1XgeTynTY5YqKavAQfddIa5_gNfFYQKkYYwxlN
 7ykgfrkqzl.gsUbcqwfFdXTECzrUfgThl0Emyq8bdfzNGtX8eF.dVJXCf_r1obmZJ2MHUCtHxA7p
 zwjGl1EgQbUfdpcAqMLXc93cDjog46eseZclXDbzb9SJvArfYVNPMEGhn7qpQCfoV5pyBfh0yTwY
 pujnbVgVBFA4AMrexB6ODK2Y.uwr05Gk9Pekife57YY9cD_28p_vohhvALVCYT5Ce50sfmcI357Z
 5VV6Jd7JxHi_nWFMgfjSeTpamp7ic8ipIyU3q8_QjrNEcjNWqiRSjhzTmBCdDWEb8tqIvvvfvHvE
 xZ6zuIelZ5msFyC93A8.t8uapNJE2wmZUdPBlAw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 00:10:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4df4822910f7438fc6d2591add0b14ad;
          Fri, 21 Sep 2018 00:10:37 +0000 (UTC)
Subject: Re: [PATCH security-next v2 19/26] LSM: Introduce CONFIG_LSM_ORDER
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
 <20180920162338.21060-20-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <25825681-a465-684d-d48e-79473bca7606@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 17:10:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-20-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 9:23 AM, Kees Cook wrote:
> This provides a way to declare LSM initialization order via Kconfig.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/Kconfig    | 11 +++++++++++
>  security/security.c | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 27d8b2688f75..de8202886c1d 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -276,5 +276,16 @@ config DEFAULT_SECURITY
>  	default "apparmor" if DEFAULT_SECURITY_APPARMOR
>  	default "" if DEFAULT_SECURITY_DAC
>  
> +config LSM_ORDER
> +	string "Default initialization order of builtin LSMs"
> +	default "integrity"

I would like to see the default spelled out rather than
provided implicitly.

  +	  default "integrity,yama,loadpin,selinux,smack,apparmor,tomoyo"

> +	help
> +	  A comma-separated list of LSMs, in initialization order.
> +	  Any LSMs left off this list will be link-order initialized
> +	  after any listed LSMs. Any LSMs listed here but not built in
> +	  the kernel will be ignored.

This should also describe what will happen if you include multiple
major modules in the list.

> +
> +	  If unsure, leave this as the default.
> +
>  endmenu
>  
> diff --git a/security/security.c b/security/security.c
> index 2541a512a0f7..063ee2466e58 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -44,6 +44,8 @@ char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_major_lsm;
>  
> +static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
> +
>  /* Ordered list of LSMs to initialize. */
>  static __initdata struct lsm_info **ordered_lsms;
>  
> @@ -108,14 +110,44 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  		   (!lsm->enabled || *lsm->enabled) ? "en" : "dis");
>  }
>  
> -/* Populate ordered LSMs list from hard-coded list of LSMs. */
> +/* Populate ordered LSMs list from given string. */
> +static void __init parse_lsm_order(const char *order, const char *origin)
> +{
> +	struct lsm_info *lsm;
> +	char *sep, *name, *next;
> +
> +	sep = kstrdup(order, GFP_KERNEL);
> +	next = sep;
> +	/* Walk the list, looking for matching LSMs. */
> +	while ((name = strsep(&next, ",")) != NULL) {
> +		bool found = false;
> +
> +		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
> +			    strcmp(lsm->name, name) == 0) {
> +				append_ordered_lsm(lsm, origin);
> +				found = true;
> +			}
> +		}
> +
> +		if (!found)
> +			init_debug("%s ignored: %s\n", origin, name);
> +	}
> +	kfree(sep);
> +}
> +
> +/* Populate ordered LSMs list from builtin list of LSMs. */
>  static void __init prepare_lsm_order(void)
>  {
>  	struct lsm_info *lsm;
>  
> +	/* Parse order from builtin list. */
> +	parse_lsm_order(builtin_lsm_order, "builtin");
> +
> +	/* Add any missing LSMs, in link order. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (strcmp(lsm->name, "integrity") == 0)
> -			append_ordered_lsm(lsm, "builtin");
> +		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> +			append_ordered_lsm(lsm, "link-time");
>  	}
>  }
>  

