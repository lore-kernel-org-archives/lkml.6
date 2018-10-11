Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8EFC6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E17A20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf0OD1Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E17A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJLDYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:24:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42180 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeJLDYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:24:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so4660902pgq.9;
        Thu, 11 Oct 2018 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R+JpQBEsN1n1PrBH/iXS+DoMYo8KgrT+7C24wo4ZKeA=;
        b=Cf0OD1LdtEwnZPEvK9cOLnaIdQfraatC+VA/YbpdIOsrsRvmYXsF5q9sSuCKeGrhQF
         W5X0W7DHIy1b2r5UiwuUm88aowmW0GAngK+y+oSaUt6GUTiCbfyteSKxJsTgMYUN1Bpt
         7cGk0Zs42QoAAQqjzCzhCXaPoSW3f5k+kg3WzUtmbxx/J5hXcMNYE9fvbTdcPOsdtUtq
         /A2KUH+guzAKcEokP3vgJX8ZZnWkVzrL0CZjQHC5Y0M/8DKypKupjnGT9ihGYC8KAdLZ
         ShV6gSTHT75iUuTOI7abyw773ciKgGY9nWI71spBvO18W8yCanZgnLpufTG5004CiozN
         J8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+JpQBEsN1n1PrBH/iXS+DoMYo8KgrT+7C24wo4ZKeA=;
        b=re3thfiRO4BsrAnNoN1qb7QpzWx14DwpmqIuah6AtINGTDY8bwTou1SktJnIqwpq1y
         NmvmSPiuzaXSA7JvGSgzK5DYhkHJWMtdNnOyvK2vYXe3mwtz//s3ThOJ++Xxg4JfLK6h
         o/TSWnwEGVBibXayoAKvE+0fMaZihXwE3LhI4kHFxyOY5RRKFIrTfhxmEM5zVWJz5X/Z
         NCXI74Ipb9kBoG9DdAnd+tg2XBkYWkTxAdFhhLnvW6vkR8VnEoJedU0CFoHU17MeR+kd
         ToZbIjJOth99EZGASiLgOdlTVDxbAuo/uyxK6dT5WobYX7BWn3V64c7pWGfwHVw1giQS
         Ud8g==
X-Gm-Message-State: ABuFfogK2a/ahSAh31rZgK0ttfhug2zQW1yLAsi3hSarAjhoKEGqYQEc
        vwSd/bDzZ7PQ7uF8H6DODQ34Af/u
X-Google-Smtp-Source: ACcGV626jV5kHFxT4Qlj2l9VQbmVeM/msz4CCCOf7oNLdJcJKfQSpJrIKQ8eGx2XbniND2G3GK3ByA==
X-Received: by 2002:a62:ccd4:: with SMTP id j81-v6mr3017356pfk.76.1539287756749;
        Thu, 11 Oct 2018 12:55:56 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l83-v6sm67245938pfi.172.2018.10.11.12.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:55:56 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] cpuidle/powernv: Add support for states with
 ibm,cpuidle-state-v1
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     huntbag@linux.vnet.ibm.com, npiggin@gmail.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com
References: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
 <20181011132237.14604-2-akshay.adiga@linux.vnet.ibm.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e1e585e3-5605-0f03-f145-95ced05ca682@gmail.com>
Date:   Thu, 11 Oct 2018 12:55:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011132237.14604-2-akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ devicetree mail list

On 10/11/18 06:22, Akshay Adiga wrote:
> This patch adds support for new device-tree format for idle state
> description.
> 
> Previously if a older kernel runs on a newer firmware, it may enable
> all available states irrespective of its capability of handling it.
> New device tree format adds a compatible flag, so that only kernel
> which has the capability to handle the version of stop state will enable
> it.
> 
> Older kernel will still see stop0 and stop0_lite in older format and we
> will depricate it after some time.
> 
> 1) Idea is to bump up the version in firmware if we find a bug or
> regression in stop states. A fix will be provided in linux which would
> now know about the bumped up version of stop states, where as kernel
> without fixes would ignore the states.
> 
> 2) Slowly deprecate cpuidle /cpuhotplug threshold which is hard-coded
> into cpuidle-powernv driver. Instead use compatible strings to indicate
> if idle state is suitable for cpuidle and hotplug.
> 
> New idle state device tree format :
>        power-mgt {
>             ...
>          ibm,enabled-stop-levels = <0xec000000>;
>          ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>          ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>          ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>          ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>          ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>          ibm,idle-states {
>                      stop4 {
>                          flags = <0x207000>;
>                          compatible = "ibm,state-v1",
>                                       "opal-supported";
>                          type = "cpuidle";
>                          psscr-mask = <0x0 0x3003ff>;
>                          handle = <0x102>;
>                          latency-ns = <0x186a0>;
>                          residency-ns = <0x989680>;
>                          psscr = <0x0 0x300374>;
>                   };
>                     ...
>                     stop11 {
>                      ...
>                          compatible = "ibm,state-v1",
>                                       "opal-supported";
>                          type = "cpuoffline";
>                          ...
>                   };
>              };
> type strings :
> "cpuidle" : indicates it should be used by cpuidle-driver
> "cpuoffline" : indicates it should be used by hotplug driver
> 
> compatible strings :
> "ibm,state-v1" : kernel checks if it knows about this version
> "opal-supported" : indicates kernel can fall back to use opal
> 		   for stop-transitions
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
> 
> Changes from v1 :
>  - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
>    idle code in C"
>  - Moved "cpuidle" and "cpuoffline" as seperate property called
>    "type"
>  
> 
>  arch/powerpc/include/asm/cpuidle.h    |   9 ++
>  arch/powerpc/platforms/powernv/idle.c | 132 +++++++++++++++++++++++++-
>  drivers/cpuidle/cpuidle-powernv.c     |  31 ++++--
>  3 files changed, 160 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 9844b3ded187..e920a15e797f 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -70,14 +70,23 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +enum idle_state_type_t {
> +	CPUIDLE_TYPE,
> +	CPUOFFLINE_TYPE
> +};
> +
> +#define POWERNV_THRESHOLD_LATENCY_NS 200000
> +#define PNV_VER_NAME_LEN    32
>  #define PNV_IDLE_NAME_LEN    16
>  struct pnv_idle_states_t {
>  	char name[PNV_IDLE_NAME_LEN];
> +	char version[PNV_VER_NAME_LEN];
>  	u32 latency_ns;
>  	u32 residency_ns;
>  	u64 psscr_val;
>  	u64 psscr_mask;
>  	u32 flags;
> +	enum idle_state_type_t type;
>  	bool valid;
>  };
>  
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 96186af9e953..755918402591 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -54,6 +54,20 @@ static bool default_stop_found;
>  static u64 pnv_first_tb_loss_level = MAX_STOP_STATE + 1;
>  static u64 pnv_first_hv_loss_level = MAX_STOP_STATE + 1;
>  
> +
> +static int parse_dt_v1(struct device_node *np);
> +struct stop_version_t {
> +	const char name[PNV_VER_NAME_LEN];
> +	int (*parser_fn)(struct device_node *np);
> +};
> +struct stop_version_t known_versions[] = {
> +		{
> +			.name =  "ibm,state-v1",
> +			.parser_fn = parse_dt_v1,
> +		}
> +	};
> +const int nr_known_versions = 1;
> +
>  /*
>   * psscr value and mask of the deepest stop idle state.
>   * Used when a cpu is offlined.
> @@ -1195,6 +1209,77 @@ static void __init pnv_probe_idle_states(void)
>  		supported_cpuidle_states |= pnv_idle_states[i].flags;
>  }
>  
> +static int parse_dt_v1(struct device_node *dt_node)
> +{
> +	const char *temp_str;
> +	int rc;
> +	int i = nr_pnv_idle_states;
> +
> +	if (!dt_node) {
> +		pr_err("Invalid device_node\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = of_property_read_string(dt_node, "name", &temp_str);
> +	if (rc) {
> +		pr_err("error reading names rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +	strncpy(pnv_idle_states[i].name, temp_str, PNV_IDLE_NAME_LEN);
> +	rc = of_property_read_u32(dt_node, "residency-ns",
> +				  &pnv_idle_states[i].residency_ns);
> +	if (rc) {
> +		pr_err("error reading residency rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +	rc = of_property_read_u32(dt_node, "latency-ns",
> +				  &pnv_idle_states[i].latency_ns);
> +	if (rc) {
> +		pr_err("error reading latency rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +	rc = of_property_read_u32(dt_node, "flags",
> +				  &pnv_idle_states[i].flags);
> +	if (rc) {
> +		pr_err("error reading flags rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +
> +	/* We are not expecting power8 device-tree in this format */
> +	rc = of_property_read_u64(dt_node, "psscr-mask",
> +				  &pnv_idle_states[i].psscr_mask);
> +	if (rc) {
> +		pr_err("error reading psscr-mask rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +	rc = of_property_read_u64(dt_node, "psscr",
> +				  &pnv_idle_states[i].psscr_val);
> +	if (rc) {
> +		pr_err("error reading psscr rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * TODO : save the version strings in data structure
> +	 */
> +	rc = of_property_read_string(dt_node, "type", &temp_str);
> +	pr_info("type = %s\n", temp_str);
> +	if (rc) {
> +		pr_err("error reading type rc= %d\n", rc);
> +		return -EINVAL;
> +	}
> +	if (strcmp(temp_str, "cpuidle") == 0)
> +		pnv_idle_states[i].type = CPUIDLE_TYPE;
> +	else if (strcmp(temp_str, "cpuoffline") == 0)
> +		pnv_idle_states[i].type = CPUOFFLINE_TYPE;
> +	else {
> +		pr_err("Invalid type skipping %s\n",
> +					pnv_idle_states[i].name);
> +		return -EINVAL;
> +	}
> +	return 0;
> +
> +}
>  /*
>   * This function parses device-tree and populates all the information
>   * into pnv_idle_states structure. It also sets up nr_pnv_idle_states
> @@ -1203,8 +1288,9 @@ static void __init pnv_probe_idle_states(void)
>  
>  static int pnv_parse_cpuidle_dt(void)
>  {
> -	struct device_node *np;
> +	struct device_node *np, *np1, *dt_node;
>  	int nr_idle_states, i;
> +	int additional_states = 0;
>  	int rc = 0;
>  	u32 *temp_u32;
>  	u64 *temp_u64;
> @@ -1218,8 +1304,14 @@ static int pnv_parse_cpuidle_dt(void)
>  	nr_idle_states = of_property_count_u32_elems(np,
>  						"ibm,cpu-idle-state-flags");
>  
> -	pnv_idle_states = kcalloc(nr_idle_states, sizeof(*pnv_idle_states),
> -				  GFP_KERNEL);
> +	np1 = of_find_node_by_path("/ibm,opal/power-mgt/ibm,idle-states");
> +	if (np1) {
> +		for_each_child_of_node(np1, dt_node)
> +			additional_states++;
> +	}
> +	pr_info("states in new format : %d\n", additional_states);
> +	pnv_idle_states = kcalloc(nr_idle_states + additional_states,
> +				  sizeof(*pnv_idle_states), GFP_KERNEL);
>  	temp_u32 = kcalloc(nr_idle_states, sizeof(u32),  GFP_KERNEL);
>  	temp_u64 = kcalloc(nr_idle_states, sizeof(u64),  GFP_KERNEL);
>  	temp_string = kcalloc(nr_idle_states, sizeof(char *),  GFP_KERNEL);
> @@ -1298,8 +1390,40 @@ static int pnv_parse_cpuidle_dt(void)
>  	for (i = 0; i < nr_idle_states; i++)
>  		strlcpy(pnv_idle_states[i].name, temp_string[i],
>  			PNV_IDLE_NAME_LEN);
> +
> +	/* Mark states as CPUIDLE_TYPE /CPUOFFLINE for older version*/
> +	for (i = 0; i < nr_idle_states; i++) {
> +		if (pnv_idle_states[i].latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
> +			pnv_idle_states[i].type  = CPUOFFLINE_TYPE;
> +		else
> +			pnv_idle_states[i].type  = CPUIDLE_TYPE;
> +	}
>  	nr_pnv_idle_states = nr_idle_states;
> -	rc = 0;
> +	/* Parsing node-based idle states device-tree format */
> +	if (!np1) {
> +		pr_info("dt does not contain ibm,idle_states");
> +		goto out;
> +	}
> +	/* Parse each child node with appropriate parser_fn */
> +	for_each_child_of_node(np1, dt_node) {
> +		bool found_known_version = false;
> +		/* we don't have state falling back to opal*/
> +		for (i = 0; i < nr_known_versions ; i++) {
> +			if (of_device_is_compatible(dt_node, known_versions[i].name)) {
> +				rc = known_versions[i].parser_fn(dt_node);
> +				if (rc) {
> +					pr_err("%s could not parse\n", known_versions[i].name);
> +					continue;
> +				}
> +				found_known_version = true;
> +			}
> +		}
> +		if (!found_known_version) {
> +			pr_info("Unsupported state, skipping all further state\n");
> +			goto out;
> +		}
> +		nr_pnv_idle_states++;
> +	}
>  out:
>  	kfree(temp_u32);
>  	kfree(temp_u64);
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 84b1ebe212b3..a15514ebd1c3 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -26,7 +26,6 @@
>   * Expose only those Hardware idle states via the cpuidle framework
>   * that have latency value below POWERNV_THRESHOLD_LATENCY_NS.
>   */
> -#define POWERNV_THRESHOLD_LATENCY_NS 200000
>  
>  static struct cpuidle_driver powernv_idle_driver = {
>  	.name             = "powernv_idle",
> @@ -265,7 +264,7 @@ extern u32 pnv_get_supported_cpuidle_states(void);
>  static int powernv_add_idle_states(void)
>  {
>  	int nr_idle_states = 1; /* Snooze */
> -	int dt_idle_states;
> +	int dt_idle_states = 0;
>  	u32 has_stop_states = 0;
>  	int i;
>  	u32 supported_flags = pnv_get_supported_cpuidle_states();
> @@ -277,14 +276,19 @@ static int powernv_add_idle_states(void)
>  		goto out;
>  	}
>  
> -	/* TODO: Count only states which are eligible for cpuidle */
> -	dt_idle_states = nr_pnv_idle_states;
> +	/* Count only cpuidle states*/
> +	for (i = 0; i < nr_pnv_idle_states; i++) {
> +		if (pnv_idle_states[i].type == CPUIDLE_TYPE)
> +			dt_idle_states++;
> +	}
> +	pr_info("idle states in dt = %d , states with idle flag = %d",
> +					nr_pnv_idle_states, dt_idle_states);
>  
>  	/*
>  	 * Since snooze is used as first idle state, max idle states allowed is
>  	 * CPUIDLE_STATE_MAX -1
>  	 */
> -	if (nr_pnv_idle_states > CPUIDLE_STATE_MAX - 1) {
> +	if (dt_idle_states > CPUIDLE_STATE_MAX - 1) {
>  		pr_warn("cpuidle-powernv: discovered idle states more than allowed");
>  		dt_idle_states = CPUIDLE_STATE_MAX - 1;
>  	}
> @@ -305,8 +309,15 @@ static int powernv_add_idle_states(void)
>  		 * Skip the platform idle state whose flag isn't in
>  		 * the supported_cpuidle_states flag mask.
>  		 */
> -		if ((state->flags & supported_flags) != state->flags)
> +		if ((state->flags & supported_flags) != state->flags) {
> +			pr_warn("State %d does not have supported flag\n", i);
> +			continue;
> +		}
> +		if (state->type != CPUIDLE_TYPE) {
> +			pr_info("State %d is not idletype, it of %d type\n", i,
> +								state->type);
>  			continue;
> +		}
>  		/*
>  		 * If an idle state has exit latency beyond
>  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> @@ -321,8 +332,10 @@ static int powernv_add_idle_states(void)
>  		exit_latency = DIV_ROUND_UP(state->latency_ns, 1000);
>  		target_residency = DIV_ROUND_UP(state->residency_ns, 1000);
>  
> -		if (has_stop_states && !(state->valid))
> +		if (has_stop_states && !(state->valid)) {
> +			pr_warn("State %d is invalid\n", i);
>  				continue;
> +		}
>  
>  		if (state->flags & OPAL_PM_TIMEBASE_STOP)
>  			stops_timebase = true;
> @@ -360,8 +373,10 @@ static int powernv_add_idle_states(void)
>  					  state->psscr_mask);
>  		}
>  #endif
> -		else
> +		else {
> +			pr_warn("cpuidle-powernv : could not add state\n");
>  			continue;
> +		}
>  		nr_idle_states++;
>  	}
>  out:
> 

