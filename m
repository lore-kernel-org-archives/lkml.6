Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B262C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D823221536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fOZKjSch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D823221536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbeIUF6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:58:46 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:35556 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbeIUF6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537488757; bh=ddFYN2AxpEaOilHUU7cEDEP26gxa6oxv3prcGOIDDE4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fOZKjSchBRTRm5DcfZLoZh1rDXlgklSqRt2E2PErz2PQURgRrCj4SyWTtD0+a9Yw/c9L9NLFNDrrnhVNstpVDmSsB0xzgShexMVPZL/EpBJbl2hbtQy/IvvY0XNJJvJ0ESk2q+N59YCBXzeaIbQm4DLWAQ7op7lNZdvC3NUDbkjrWz3ylslevyG//1aWpowAX+z60RDBYgLWthtO10rCuC/9YSZVrNq9Kn4bktZyplDY6BwiU1zVNyK3RbI+7azy6mFwgdkGJaGrL9j+yeMAIGpIDW0Z9/HIHvrTVb/VeMFVbxFTb3ry0d6EP1ZetJ5nwM3QLihlDQy9PKPJ1OY5KA==
X-YMail-OSG: n.zNBgcVM1mYLgpIeANomFbVXLbR7OHsk4mGIK5S_NBFa50E0cj.76ifoj9Yf1j
 ChnSlIvW53_eSy89nGA2mC0U.PmGY53Ibw2Up_JnTZDwjq30MB_KnzEzng_MU.Keqaqh2mFUbOwX
 u9bg_C_PRx7KzMs_ML.UMRGTafpYF8_Q3KjPn52gaDpLh2eGR6azOQ6nV9pndmXTWg0l2.LW4paC
 hOrlR556uLlPmdjVBE.qSSWCf1BQ.Ortq7NaLWVe.MFAM.GvZsvWIBGR7ZB3xe_tU7AzWBzRLb9e
 o8Nm08PnqpLSB4WA3XYB0UG_rpt8sRFhJL9IWPHPMNq3m47LCyUuFl68_S4RyTAGxU5l2aqGEi1n
 krUtGMA0fHF4ya8p4uo8XsMcqcK8.JlxH9gCPN5dNPaKwz1jTszX2EP5YzK82EWcp_xXiOS8kO5n
 w1gPKMNTcovvzKjv.bd08K_nmBPLxT5BDoJFzGZTbp6BW_ADDsqu11TzFX9FXJyvCH6wIx9acUJQ
 f9bG39r_9RyQgZQw0oqqNEC4BE7tXOx0.dZTK75W3pUkT5Olc9WHAw8vU_mVvCSPXzg6NFIPwqKp
 Aau_639bTW1yhG1awkeUESeciEeESiNZvtrwpdDa3j2.rclsrN0I6L1OX4J1R1bIX59QVXkBMOLT
 t1.bPlt8wFfgkq4TPkoC1ZdgKB5ShxFb.582RVclHcgyOkZpshN.qI3lQrlYsjhSlVSAR9lcykLu
 kpe66m9brbvQWFg1L7AHhYxoRytN2ehQgHGW9c7eACIDVh6YSFg.1FG0DUitVeB6GUiW6DPnJsnc
 2L1z48rBNpVHwAs0aDocdQyF0nxSVvBSxZer4AHj19Mi9dFnQfh6eJJNXuVoTLsbmkEDUUJdGkMe
 jNGnJkHtUE9dVbQUXlJKo4evWegFo.p0BJDfuF9VElZkK0kUWtTq6hfxyjQVHf7J21XsCwBRRE4v
 hD7gXr8_BKOWruD3zZ3XE6ACOoMqPLr0jTuv2zzNfk28BGPcQAcLlSyTr9KzECWmfosYF2fwssjW
 4qa9OV8Nv7Bs5LmvZxXvV.jCOuvYAsRuhVSKClQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 00:12:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 075318250b282495fa2ab4dcaba9543a;
          Fri, 21 Sep 2018 00:12:34 +0000 (UTC)
Subject: Re: [PATCH security-next v2 20/26] LSM: Introduce "lsm.order=" for
 boottime ordering
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
 <20180920162338.21060-21-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <71f833b8-40cb-83f8-6803-7df26e8fa460@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 17:12:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-21-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 9:23 AM, Kees Cook wrote:
> Provide a way to reorder LSM initialization using the new "lsm.order="
> comma-separated list of LSMs. Any LSMs not listed will be added in builtin
> order.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  security/security.c                             | 15 ++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 32d323ee9218..5ac4c1056ffa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2276,6 +2276,11 @@
>  
>  	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
>  
> +	lsm.order=lsm1,...,lsmN
> +			[SECURITY] Choose order of LSM initialization. Any
> +			builtin LSMs not listed here will be implicitly
> +			added to the list in builtin order.

Added at the end of the list, or beginning of the list?

> +
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.
>  			Example: machvec=hpzx1_swiotlb
> diff --git a/security/security.c b/security/security.c
> index 063ee2466e58..4db194f81419 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -43,6 +43,7 @@ static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_major_lsm;
> +static __initdata const char *chosen_lsm_order;
>  
>  static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
>  
> @@ -136,11 +137,15 @@ static void __init parse_lsm_order(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> -/* Populate ordered LSMs list from builtin list of LSMs. */
> +/* Populate ordered LSMs list from commandline and builtin list of LSMs. */
>  static void __init prepare_lsm_order(void)
>  {
>  	struct lsm_info *lsm;
>  
> +	/* Parse order from commandline, if present. */
> +	if (chosen_lsm_order)
> +		parse_lsm_order(chosen_lsm_order, "cmdline");
> +
>  	/* Parse order from builtin list. */
>  	parse_lsm_order(builtin_lsm_order, "builtin");
>  
> @@ -264,6 +269,14 @@ static int __init choose_major_lsm(char *str)
>  }
>  __setup("security=", choose_major_lsm);
>  
> +/* Explicitly choose LSM initialization order. */
> +static int __init choose_lsm_order(char *str)
> +{
> +	chosen_lsm_order = str;
> +	return 1;
> +}
> +__setup("lsm.order=", choose_lsm_order);
> +
>  /* Enable LSM order debugging. */
>  static int __init enable_debug(char *str)
>  {

