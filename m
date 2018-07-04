Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB22C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D782244E8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="myVcP9v4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D782244E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933322AbeGDGly (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:41:54 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:20798 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeGDGlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:41:52 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180704064150epoutp01e62b618628ba5529b3a35a72f8fac580~_F0Vz_Kh30923309233epoutp01f;
        Wed,  4 Jul 2018 06:41:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180704064150epoutp01e62b618628ba5529b3a35a72f8fac580~_F0Vz_Kh30923309233epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530686510;
        bh=rrzvgDTOn50RHISi9inNwgy9iGKzSXwqYQon7dTXa28=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=myVcP9v4FNz1ZahxETXPZd9GZfWvMSm4bxW7zC1U4BRq6w2uxRJz2RxDARtmRUj5+
         7jVIR6g0OnUFKAWkISjg9P3vKnPQpakh1eKtmaEtLM6pcuxlvYnLdPifTYS+Ayuq5D
         DUL3ifYI7wojb5A8OD1oou+r3hs0sFBpT8FML46g=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180704064147epcas1p394713ec03cac8b00236b62cd7cadb315~_F0TPamoR2196821968epcas1p3U;
        Wed,  4 Jul 2018 06:41:47 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.10.04187.B2C6C3B5; Wed,  4 Jul 2018 15:41:47 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180704064147epcas2p2e4cfd8ba7788a7efd8e17a1d117a38b8~_F0SwQ1dM1296512965epcas2p24;
        Wed,  4 Jul 2018 06:41:47 +0000 (GMT)
X-AuditID: b6c32a46-c4fff7000000105b-5f-5b3c6c2b7434
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.B8.04192.A2C6C3B5; Wed,  4 Jul 2018 15:41:47 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBB00CRLX9MPV30@mmp1.samsung.com>; Wed, 04 Jul 2018 15:41:46 +0900 (KST)
Message-id: <5B3C6C2A.1070205@samsung.com>
Date:   Wed, 04 Jul 2018 15:41:46 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
In-reply-to: <20180703234705.227473-6-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmqa52jk20wbtXKhZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM67+ucRUcDe24vjPYywNjCe9uxg5OSQE
        TCROr5zD2sXIxSEksINR4uKPRnYI5zujxLO3X5lhqm5vPMMIkdjNKHH8zgawBK+AoMSPyfdY
        uhg5OJgF5CWOXMoGCTMLaEps3b0eatBdRoklTVOg6rUk/k47zAxSzyKgKjG3wwMkzAYU3v/i
        BhuIzS+gKHH1x2NGEFtUIEJi5/xv7CC2iECwxIKf51lAZjILvGaRWNjymxUkISzgI3Gv4zOY
        zSlgLrH1VgczSJGEwDl2if4P/1ggPnCR2Pe7jRXCFpZ4dXwLO4QtLfFs1UZGiIZ2RokvL5pZ
        IZwJjBIfTm1mgqgylni2sIsJ4jc+iY7Df9lBXpAQ4JXoaBOCMD0kpk2shfh4O6NE56Sr7BMY
        ZWchBdIsRCDNQgqkBYzMqxjFUguKc9NTi40KjPSKE3OLS/PS9ZLzczcxglOwltsOxiXnfA4x
        CnAwKvHwrii1jhZiTSwrrsw9xCjBwawkwtupbxMtxJuSWFmVWpQfX1Sak1p8iNEUGMYTmaVE
        k/OB+SGvJN7Q1MjY2NjC1NzS2MBSSZyX8aZAtJBAemJJanZqakFqEUwfEwenVAOjD3fsB6Nj
        xxMtLz0vm3z+qc7VnY9mr2JWDT9fm7uy81232xv/2K3Se764TrM7sqel7lpraWDLtUkm/80l
        1UvyAx+8XJThdtR6j3ZKZYrnrsOtYqm+i/2VSjQj13+RalRUWa3GMOXTnJjwiRFfQmrn2XA0
        nFjg42TxbObWUnH16RxK1sxHbWqUWIozEg21mIuKEwFWU1Kq1wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t9jAV3tHJtog5kzmCz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlXH1
        zyWmgruxFcd/HmNpYDzp3cXIySEhYCJxe+MZxi5GLg4hgZ2MEjvuNbCCJHgFBCV+TL7H0sXI
        wcEsIC9x5FI2SJhZQF1i0rxFzBD19xkl1j5YxwhRryXxd9phZpB6FgFVibkdHiBhNqDw/hc3
        2EBsfgFFias/HjOClIgKREh0n6gECYsIBEt8aO5hAxnJLPCWRWLpt/9gI4UFfCTudXxmhdi1
        nVHixb05YLdxCphLbL3VwTyBUWAWklNnIZw6C8mpCxiZVzFKphYU56bnFhsVGOWllusVJ+YW
        l+al6yXn525iBMbktsNa/TsYHy+JP8QowMGoxMO7otQ6Wog1say4MvcQowQHs5IIb6e+TbQQ
        b0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGRkf5Ut7LfKmx
        7mcvd4rwcc7ZffegoIce15pDX/s3W28Nzjjnn7l6DkvFLKFDfWcaM4t4d9zdN+NNToW4ao3z
        icZPTE6l8x++nPNuz42yqDD7sl/iF5/y2HZadzvc2MWS9fdrvcbdKPkm+RvPgiq+p236Xnv6
        xTu7vXF+Pd+09FYua5eO0+C9osRSnJFoqMVcVJwIAIgt5W/FAgAA
X-CMS-MailID: 20180704064147epcas2p2e4cfd8ba7788a7efd8e17a1d117a38b8
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
        <20180703234705.227473-6-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Firstly,
I'm not sure why devfreq needs the devfreq_verify_within_limits() function.

devfreq already used the OPP interface as default. It means that
the outside of 'drivers/devfreq' can disable/enable the frequency
such as drivers/thermal/devfreq_cooling.c. Also, when some device
drivers disable/enable the specific frequency, the devfreq core
consider them.

So, devfreq doesn't need to devfreq_verify_within_limits() because
already support some interface to change the minimum/maximum frequency
of devfreq device. 

In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
to change the minimum/maximum frequency of cpu. some device driver cannot
change the minimum/maximum frequency through OPP interface.

But, in case of devfreq subsystem, as I explained already, devfreq support
the OPP interface as default way. devfreq subsystem doesn't need to add
other way to change the minimum/maximum frequency.


Secondly,
This patch send the 'struct devfreq_policy' instance as the data
when sending the notification as following:

	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
			DEVFREQ_ADJUST, policy);

But, I think that if devfreq core sends the 'struct devfreq_freq_limits'
instance instead of 'struct devfreq_policy', it is enough.
Because receiver of DEVFREQ_ADJUST just will use the min_freq/max_freq variables.

So, I tried to find the cpufreq's case. The some device drivers using
CPUFREQ_POLICY_NOTIFIER uses following variables of 'struct cpufreq_policy'.
It means that receiver of CPUFREQ_POLICY_NOTIFIER don't need to other
information/variables except for min/max frequency.

- policy->min
- policy->max
- policy->cpuinfo.max_freq
- policy->cpuinfo.min_freq
- policy->cpu : not related to devfreq)
- policy->related_cpus : not related to devfreq)

- list of device drivers using CPUFREQ_POLICY_NOTIFIER (linux kernel is v4.18-rc1)
$ grep -rn "CPUFREQ_POLICY_NOTIFIER" .
./drivers/macintosh/windfarm_cpufreq_clamp.c
./drivers/thermal/cpu_cooling.c
./drivers/thermal/cpu_cooling.c
./drivers/acpi/processor_thermal.c
./drivers/acpi/processor_thermal.c
./drivers/acpi/processor_perflib.c
./drivers/acpi/processor_perflib.c
./drivers/base/arch_topology.c
./drivers/base/arch_topology.c
./drivers/video/fbdev/sa1100fb.c
./drivers/video/fbdev/pxafb.c
./drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
./drivers/cpufreq/cpufreq.c
./drivers/cpufreq/cpufreq.c
./drivers/cpufreq/cpufreq.c
./drivers/cpufreq/cpufreq.c


On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> Policy notifiers are called before a frequency change and may narrow
> the min/max frequency range in devfreq_policy, which is used to adjust
> the target frequency if it is beyond this range.
> 
> Also add a few helpers:
>  - devfreq_verify_within_[dev_]limits()
>     - should be used by the notifiers for policy adjustments.
>  - dev_to_devfreq()
>     - lookup a devfreq strict from a device pointer
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - Fixed typo in commit message: devfreg => devfreq
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - devfreq.h: fixed misspelling of struct devfreq_policy
> 
> Changes in v2:
> - performance, powersave and simpleondemand governors don't need changes
>   with "PM / devfreq: Don't adjust to user limits in governors"
> - formatting fixes
> ---
>  drivers/devfreq/devfreq.c | 48 ++++++++++++++++++++++-------
>  include/linux/devfreq.h   | 65 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 21604d6ae2b8..4cbaa7ad1972 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -72,6 +72,21 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +/**
> + * dev_to_devfreq() - find devfreq struct using device pointer
> + * @dev:	device pointer used to lookup device devfreq.
> + */
> +struct devfreq *dev_to_devfreq(struct device *dev)
> +{
> +	struct devfreq *devfreq;
> +
> +	mutex_lock(&devfreq_list_lock);
> +	devfreq = find_device_devfreq(dev);
> +	mutex_unlock(&devfreq_list_lock);
> +
> +	return devfreq;
> +}
> +
>  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>  {
>  	struct dev_pm_opp *opp;
> @@ -269,20 +284,21 @@ int update_devfreq(struct devfreq *devfreq)
>  	if (!policy->governor)
>  		return -EINVAL;
>  
> +	policy->min = policy->devinfo.min_freq;
> +	policy->max = policy->devinfo.max_freq;

Why don't you consider 'policy->user.max/min_freq' as following?
As I already commented, I think that 'struct devfreq_freq_limits' is enough
instead of 'struct devfreq_policy'.

	->max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
	->min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);


> +
> +	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
> +				DEVFREQ_ADJUST, policy);
> +
>  	/* Reevaluate the proper frequency */
>  	err = policy->governor->get_target_freq(devfreq, &freq);
>  	if (err)
>  		return err;
>  
> -	/*
> -	 * Adjust the frequency with user freq, QoS and available freq.
> -	 *
> -	 * List from the highest priority
> -	 * max_freq
> -	 * min_freq
> -	 */
> -	max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
> -	min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);
> +	/* Adjust the frequency */
> +
> +	max_freq = MIN(policy->max, policy->user.max_freq);
> +	min_freq = MAX(policy->min, policy->user.min_freq);
>  
>  	if (freq < min_freq) {
>  		freq = min_freq;
> @@ -645,6 +661,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> +	srcu_init_notifier_head(&devfreq->policy_notifier_list);
>  
>  	mutex_unlock(&devfreq->lock);
>  
> @@ -1445,7 +1462,7 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
>   * devfreq_register_notifier() - Register a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to register.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devfreq_register_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
> @@ -1461,6 +1478,10 @@ int devfreq_register_notifier(struct devfreq *devfreq,
>  		ret = srcu_notifier_chain_register(
>  				&devfreq->transition_notifier_list, nb);
>  		break;
> +	case DEVFREQ_POLICY_NOTIFIER:
> +		ret = srcu_notifier_chain_register(
> +				&devfreq->policy_notifier_list, nb);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1473,7 +1494,7 @@ EXPORT_SYMBOL(devfreq_register_notifier);
>   * devfreq_unregister_notifier() - Unregister a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devfreq_unregister_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
> @@ -1489,6 +1510,11 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
>  		ret = srcu_notifier_chain_unregister(
>  				&devfreq->transition_notifier_list, nb);
>  		break;
> +	case DEVFREQ_POLICY_NOTIFIER:
> +		ret = srcu_notifier_chain_unregister(
> +				&devfreq->policy_notifier_list, nb);
> +		break;
> +
>  	default:
>  		ret = -EINVAL;
>  	}
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 9bf23b976f4d..7c8dce96db73 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -33,6 +33,10 @@
>  #define	DEVFREQ_PRECHANGE		(0)
>  #define DEVFREQ_POSTCHANGE		(1)
>  
> +#define DEVFREQ_POLICY_NOTIFIER		1
> +
> +#define	DEVFREQ_ADJUST			0
> +
>  struct devfreq;
>  struct devfreq_governor;
>  
> @@ -121,12 +125,16 @@ struct devfreq_freq_limits {
>  
>  /**
>   * struct devfreq_policy - Devfreq policy
> + * @min:	minimum frequency (adjustable by policy notifiers)
> + * @min:	maximum frequency (adjustable by policy notifiers)
>   * @user:	frequency limits requested by the user
>   * @devinfo:	frequency limits of the device (available OPPs)
>   * @governor:	method how to choose frequency based on the usage.
>   * @governor_name:	devfreq governor name for use with this devfreq
>   */
>  struct devfreq_policy {
> +	unsigned long min;
> +	unsigned long max;
>  	struct devfreq_freq_limits user;
>  	struct devfreq_freq_limits devinfo;
>  	const struct devfreq_governor *governor;
> @@ -155,6 +163,7 @@ struct devfreq_policy {
>   * @time_in_state:	Statistics of devfreq states
>   * @last_stat_updated:	The last time stat updated
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @policy_notifier_list: list head of DEVFREQ_POLICY_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
>   *
> @@ -188,6 +197,7 @@ struct devfreq {
>  	unsigned long last_stat_updated;
>  
>  	struct srcu_notifier_head transition_notifier_list;
> +	struct srcu_notifier_head policy_notifier_list;
>  };
>  
>  struct devfreq_freqs {
> @@ -240,6 +250,45 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
>  extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>  						int index);
>  
> +/**
> + * devfreq_verify_within_limits() - Adjust a devfreq policy if needed to make
> + *                                  sure its min/max values are within a
> + *                                  specified range.
> + * @policy:	the policy
> + * @min:	the minimum frequency
> + * @max:	the maximum frequency
> + */
> +static inline void devfreq_verify_within_limits(struct devfreq_policy *policy,
> +		unsigned int min, unsigned int max)
> +{
> +	if (policy->min < min)
> +		policy->min = min;
> +	if (policy->max < min)
> +		policy->max = min;
> +	if (policy->min > max)
> +		policy->min = max;
> +	if (policy->max > max)
> +		policy->max = max;
> +	if (policy->min > policy->max)
> +		policy->min = policy->max;
> +}
> +
> +/**
> + * devfreq_verify_within_dev_limits() - Adjust a devfreq policy if needed to
> + *                                      make sure its min/max values are within
> + *                                      the frequency range supported by the
> + *                                      device.
> + * @policy:	the policy
> + */
> +static inline void
> +devfreq_verify_within_dev_limits(struct devfreq_policy *policy)
> +{
> +	devfreq_verify_within_limits(policy, policy->devinfo.min_freq,
> +			policy->devinfo.max_freq);
> +}
> +
> +struct devfreq *dev_to_devfreq(struct device *dev);
> +
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>  /**
>   * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
> @@ -394,10 +443,26 @@ static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +static inline void devfreq_verify_within_limits(struct devfreq_policy *policy,
> +		unsigned int min, unsigned int max)
> +{
> +}
> +
> +static inline void
> +devfreq_verify_within_dev_limits(struct devfreq_policy *policy)
> +{
> +}
> +
>  static inline int devfreq_update_stats(struct devfreq *df)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline struct devfreq *dev_to_devfreq(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_PM_DEVFREQ */
>  
>  #endif /* __LINUX_DEVFREQ_H__ */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
