Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBB821904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QR45GSPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392016AbfBMQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:05:58 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:45904
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729649AbfBMQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1550073956; bh=ZmeWGtL2jJAgsHvJTpT8hEHPVvmez+a7kadxy+k1Zso=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QR45GSPP4PFIsLa/DPzaHHIr22eSGKfd5voWItvfC4HYrPKQPukyL1RGj3bypuERGyfxu8q2afUJbnCWc4vVcrmfkDcLI9x7xu7V0pHs8L688+yOjmr+iPwpiDex31WV+sGoS9/PQjC6+1rx9leQ7C0Uqgz0/42JYzqcjbx/54Wqour+lJxrxg5DSxxeONQ0jUKegpVmKSxZZ3RBWfhrivBTvq5XzaPtIotkF3GSLjGzdmey5a/I9K8dWmyTfHR4tTgLlHQyr+dBd0vvDUCeVZ3piOiJU+cWIvza1ynBg/ClD3/e0j3TtnuTBeaTeBl1TahSAi4laeNQUs+w8HqXIA==
X-YMail-OSG: HaWF8QsVM1nwH7B3F3fBitwBOkn4RuGQXa8ru8uwhrgMDPl2.0qnGwg7IJRUCsc
 WFZDXWLuXNArsp4Pnq6ia7peb46Y_yqx7o4O93qlZRuRZWQ5_NxNacWcAe6zbSdD6Vc_N96_qwX8
 tZ.7YZzMnReuOBvqyxp0VzxBzMaXMxbKP0fKc7cBY35Ifr41Oi_Qppdd9nIA3vWi7vDYS2ayuzVZ
 dprxeOYT_3XtqE_3wSF3nZwypSHt3AdqXkkMrPFFsN8j0Gg0MtM.NdqdtwSek.VxRyIf5Kt7yLSG
 xSLONdc8cV3OOMHkTR1n2bP6x4q_M9bV39b6PM2b2AN06fS8BWFEE9QwjNV3jJZdSuRvY8yzx7ti
 JszL8bTcRjCoa2875U4_8crJbOgoFo4t0nxfnUaw2hPFyweY8p3lTPnm7B9URrCnGmuD5VoxlH8j
 JDIqru53ZyN33YVOX8ihsiP0hXQgCOPNvU0V95NgsUzp4r.o7U4aS_zPQC917ezw3kBtJRLMTPje
 uDYYDbJE.5WWpCVlJf7dLCM7qR.NZfJ3GOyQCJ4dxH6iSTg8dCF.9UpNjUsXgHVlqr5.LQ_dl0vz
 .oJJ0yyw6cKNliUXsB366CqRO8PfWkoVpYxlx1w1AqWi4u0s9GcQQbdrP0FKnQGBmLppIIxAmLDw
 OQJuuEVkfj7mf.akqMfMk1qwPpoboHIZtnzB6TgzigybFQqlakeI2KpNKxLAUv8Zlx8kagK9.1oF
 L4BlBPQzLUm_Y54Il23l7_4VyPtr7B5bPPd6KL3AledrONcgMs9g1rcU0mUn92.FAwNMoiv3NI27
 8NJcaMbzfEgGkaNaFHzixEF8pmzY2a3LeUn9z2SP.9KJewCXdxVTji99K88W883WYiSkI212pM8T
 XVS0Qi_HX71psLOicFYW.G2W4.fJQkuirGJmiCADQ0kuMgZjH1lMYA9ntGxRm10J9sYkyzBs2c08
 XK00KqA15_9mH4O3z9lI4f9SCXL.IYmp0eCS_uGKSD7Ke5siAqIlRz_H9aPiXR6SHTgNpe30lcw7
 sJqI3E0lOy4A3LWYK7wg29pHkU.aVBCepk5dE3Jtm6McCDKgDk7FuoG8YAqLiJkYMPC8Goq.f3EX
 dKAjCa_TCPhWoDrlmuBE47yVXA1c7dYQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Feb 2019 16:05:56 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 475e3725adb542197ca4c357eac8f865;
          Wed, 13 Feb 2019 16:05:52 +0000 (UTC)
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190212182318.GA16669@beast>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
Date:   Wed, 13 Feb 2019 08:05:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212182318.GA16669@beast>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/2019 10:23 AM, Kees Cook wrote:
> To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> used on the command line, and report that it is happening.
>
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
>  security/security.c                             |  8 ++++++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 93d2c97f28fe..a0abd5f56e00 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2340,7 +2340,7 @@
>  
>  	lsm=lsm1,...,lsmN
>  			[SECURITY] Choose order of LSM initialization. This
> -			overrides CONFIG_LSM.
> +			overrides CONFIG_LSM, and the "security=" parameter.
>  
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.
> @@ -4129,11 +4129,9 @@
>  			Note: increases power consumption, thus should only be
>  			enabled if running jitter sensitive (HPC/RT) workloads.
>  
> -	security=	[SECURITY] Choose a security module to enable at boot.
> -			If this boot parameter is not specified, only the first
> -			security module asking for security registration will be
> -			loaded. An invalid security module name will be treated
> -			as if no module has been chosen.
> +	security=	[SECURITY] Choose a legacy "major" security module to
> +			enable at boot. This has been deprecated by the
> +			"lsm=" parameter.
>  
>  	selinux=	[SELINUX] Disable or enable SELinux at boot time.
>  			Format: { "0" | "1" }
> diff --git a/security/security.c b/security/security.c
> index 3147785e20d7..23cbb1a295a3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
>  	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
>  				GFP_KERNEL);
>  
> -	if (chosen_lsm_order)
> +	if (chosen_lsm_order) {
> +		if (chosen_major_lsm) {
> +			pr_info("security= is ignored because it is superseded by lsm=\n");
> +			chosen_major_lsm = NULL;
> +		}
>  		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -	else
> +	} else
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
>  
>  	for (lsm = ordered_lsms; *lsm; lsm++)
