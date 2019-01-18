Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2EA2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHh/X8SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfARBDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:03:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35720 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfARBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:03:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so5552669plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1C5Qp7K+x+/8HzlcfBZ9t/LHtyE2lrKBbGICrYJ9U0=;
        b=SHh/X8SFW4qCBk14HH+7QJt0/jy43nQK7EMUpt0d+mwFaeoyalMAJbaO1re3hKIHTM
         pnegdvyilv/+7plDuVlHKfDRx8Q94INkbyp2D9HnW9IBfEcWqJWv7VJtavlnS+1GkMnp
         ow7skvi38G7NS5rh4gYSM6yeeIIHZrp6YiSlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1C5Qp7K+x+/8HzlcfBZ9t/LHtyE2lrKBbGICrYJ9U0=;
        b=VSVjviFY79P0g7JkmGxYwGejY2UFTlxK2gRpl/Zv3dpGTkwOkyJ3OdJwkFeHUVi+Dy
         wc9FxCYkZlLv/Yv1VPhgKq8alAPPeH9Jff+CEVsGPbrpijRSp082GH21+FYVSDnITmwk
         IqjH/ofT5OKQpR7w3QMNqNBFa9YN7J7fr3xxpJs5gIClEd9eup6twt4g49YkV6+/94FV
         spb7fu7YwBI0JcvxhiLV38x5vDGyd82tJx4qlvDcrvVgEZbkLYZ5eCjEWqD2Jt839vK7
         w8zuw2yYBCsRfUlL/IZ9TjGA+qYHHef6Lgf/k/legrtVaIAxOyWzdDpCfP9OwmBNaLlA
         IFSQ==
X-Gm-Message-State: AJcUukcIQX2gcY6ZsG4Gdnz9DU9tc3cNXJ9/lRnT2nNf5ZTov1tWZ89K
        TavzAAMIx1g/nIhHPbfU4ZRlfw==
X-Google-Smtp-Source: ALg8bN7nyjzxff28yqcTgjTQAZFi5zwl+uXihw9ro+7kfKOPvDdr6HQJj7xDyBHsBg5PEck1i3NHHw==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr16981345plm.234.1547773387791;
        Thu, 17 Jan 2019 17:03:07 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d6sm3350905pgc.89.2019.01.17.17.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 17:03:06 -0800 (PST)
Date:   Thu, 17 Jan 2019 17:03:05 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: base: Add frequency constraint
 infrastructure
Message-ID: <20190118010305.GX261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Thanks for your work on this!

Not a complete review, more a first pass.

On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> This commit introduces the frequency constraint infrastructure, which
> provides a generic interface for parts of the kernel to constraint the
> working frequency range of a device.
> 
> The primary users of this are the cpufreq and devfreq frameworks. The
> cpufreq framework already implements such constraints with help of
> notifier chains (for thermal and other constraints) and some local code
> (for user-space constraints). The devfreq framework developers have also
> shown interest in such a framework, which may use it at a later point of
> time.
> 
> The idea here is to provide a generic interface and get rid of the
> notifier based mechanism.
> 
> Frameworks like cpufreq and devfreq need to provide a callback, which
> the freq-constraint core will call on updates to the constraints, with
> the help of freq_constraint_{set|remove}_dev_callback() OR
> freq_constraint_{set|remove}_cpumask_callback() helpers.
> 
> Individual constraints can be managed by any part of the kernel with the
> help of freq_constraint_{add|remove|update}() helpers.
> 
> Whenever a device constraint is added, removed or updated, the
> freq-constraint core re-calculates the aggregated constraints on the
> device and calls the callback if the min-max range has changed.
> 
> The current constraints on a device can be read using
> freq_constraints_get().
> 
> Co-developed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS                     |   8 +
>  drivers/base/Kconfig            |   5 +
>  drivers/base/Makefile           |   1 +
>  drivers/base/freq_constraint.c  | 633 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/freq_constraint.h |  45 +++
>  5 files changed, 692 insertions(+)
>  create mode 100644 drivers/base/freq_constraint.c
>  create mode 100644 include/linux/freq_constraint.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6fc1b9dc00b..5b0ad4956d31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6176,6 +6176,14 @@ F:	Documentation/power/freezing-of-tasks.txt
>  F:	include/linux/freezer.h
>  F:	kernel/freezer.c
>  
> +FREQUENCY CONSTRAINTS
> +M:	Viresh Kumar <vireshk@kernel.org>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
> +F:	drivers/base/freq_constraint.c
> +F:	include/linux/freq_constraint.h
> +
>  FRONTSWAP API
>  M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 3e63a900b330..d53eb18ab732 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -26,6 +26,11 @@ config UEVENT_HELPER_PATH
>  	  via /proc/sys/kernel/hotplug or via /sys/kernel/uevent_helper
>  	  later at runtime.
>  
> +config DEVICE_FREQ_CONSTRAINT
> +	bool
> +	help
> +	  Enable support for device frequency constraints.
> +
>  config DEVTMPFS
>  	bool "Maintain a devtmpfs filesystem to mount at /dev"
>  	help
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 157452080f3d..7530cbfd3cf8 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
>  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> +obj-$(CONFIG_DEVICE_FREQ_CONSTRAINT) += freq_constraint.o
>  
>  obj-y			+= test/
>  
> diff --git a/drivers/base/freq_constraint.c b/drivers/base/freq_constraint.c
> new file mode 100644
> index 000000000000..91356bae1af8
> --- /dev/null
> +++ b/drivers/base/freq_constraint.c
>
> ...
>
> +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> +		       enum fc_event event)
> +{
> +	mutex_lock(&fcs->lock);
> +
> +	if (_fcs_update(fcs, freq, event)) {
> +		if (fcs->callback)
> +			schedule_work(&fcs->work);

IIUC the constraints aren't applied until the callback is executed. I
wonder if a dedicated workqueue should be used instead of the system
one, to avoid longer delays from other kernel entities that might
'misbehave'. Especially for thermal constraints we want a quick
response.

> +void freq_constraint_remove(struct device *dev,
> +			    struct freq_constraint *constraint)
> +{
> +	struct freq_constraints *fcs;
> +	struct freq_pair freq = constraint->freq;
> +
> +	fcs = find_fcs(dev);
> +	if (IS_ERR(fcs)) {
> +		dev_err(dev, "Failed to find freq-constraint\n");

"freq-constraint: device not registered\n" as in other functions?

> +		return;
> +	}
> +
> +	free_constraint(fcs, constraint);
> +	fcs_update(fcs, &freq, REMOVE);
> +
> +	/*
> +	 * Put the reference twice, once for the freed constraint and one for

s/one/once/

> +int freq_constraint_update(struct device *dev,
> +			   struct freq_constraint *constraint,
> +			   unsigned long min_freq,
> +			   unsigned long max_freq)
> +{
> +	struct freq_constraints *fcs;
> +
> +	if (!max_freq || min_freq > max_freq) {
> +		dev_err(dev, "freq-constraints: Invalid min/max frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	fcs = find_fcs(dev);
> +	if (IS_ERR(fcs)) {
> +		dev_err(dev, "Failed to find freq-constraint\n");

same as above

> +int freq_constraint_set_dev_callback(struct device *dev,
> +				     void (*callback)(void *param),
> +				     void *callback_param)
> +{
> +	struct freq_constraints *fcs;
> +	int ret;
> +
> +	if (WARN_ON(!callback))
> +		return -ENODEV;

Wouldn't that be rather -EINVAL?

> +/* Caller must call put_fcs() after using it */
> +static struct freq_constraints *remove_callback(struct device *dev)
> +{
> +	struct freq_constraints *fcs;
> +
> +	fcs = find_fcs(dev);
> +	if (IS_ERR(fcs)) {
> +		dev_err(dev, "freq-constraint: device not registered\n");
> +		return fcs;
> +	}
> +
> +	mutex_lock(&fcs->lock);
> +
> +	cancel_work_sync(&fcs->work);
> +
> +	if (fcs->callback) {
> +		fcs->callback = NULL;
> +		fcs->callback_param = NULL;
> +	} else {
> +		dev_err(dev, "freq-constraint: Call back not registered for device\n");

s/Call back/callback/ (for consistency with other messages)

or "no callback registered ..."

> +void freq_constraint_remove_dev_callback(struct device *dev)
> +{
> +	struct freq_constraints *fcs;
> +
> +	fcs = remove_callback(dev);
> +	if (IS_ERR(fcs))
> +		return;
> +
> +	/*
> +	 * Put the reference twice, once for the callback removal and one for

s/one/once/

> +int freq_constraint_set_cpumask_callback(const struct cpumask *cpumask,
> +					 void (*callback)(void *param),
> +					 void *callback_param)
> +{
> +	struct freq_constraints *fcs = ERR_PTR(-ENODEV);
> +	struct device *cpu_dev, *first_cpu_dev = NULL;
> +	struct freq_constraint_dev *fcdev;
> +	int cpu, ret;
> +
> +	if (WARN_ON(cpumask_empty(cpumask) || !callback))
> +		return -ENODEV;

-EINVAL?

> +
> +	/* Find a CPU for which fcs already exists */
> +	for_each_cpu(cpu, cpumask) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (unlikely(!cpu_dev))
> +			continue;
> +
> +		if (unlikely(!first_cpu_dev))
> +			first_cpu_dev = cpu_dev;

I'd expect setting the callback to be a one time/rare operation. Is
there really any gain from cluttering this code with 'unlikely's?

There are other functions where it could be removed if the outcome is
that it isn't needed/desirable in code that only runs sporadically.

> +
> +		fcs = find_fcs(cpu_dev);
> +		if (!IS_ERR(fcs))
> +			break;
> +	}
> +
> +	/* Allocate fcs if it wasn't already present */
> +	if (IS_ERR(fcs)) {
> +		if (unlikely(!first_cpu_dev)) {
> +			pr_err("device structure not available for any CPU\n");
> +			return -ENODEV;
> +		}
> +
> +		fcs = alloc_fcs(first_cpu_dev);
> +		if (IS_ERR(fcs))
> +			return PTR_ERR(fcs);
> +	}
> +
> +	for_each_cpu(cpu, cpumask) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (unlikely(!cpu_dev))
> +			continue;
> +
> +		if (!find_fcdev(cpu_dev, fcs)) {
> +			fcdev = alloc_fcdev(cpu_dev, fcs);
> +			if (IS_ERR(fcdev)) {
> +				remove_cpumask_fcs(fcs, cpumask, cpu);
> +				put_fcs(fcs);
> +				return PTR_ERR(fcdev);
> +			}
> +		}
> +
> +		kref_get(&fcs->kref);
> +	}
> +
> +	mutex_lock(&fcs->lock);
> +	ret = set_fcs_callback(first_cpu_dev, fcs, callback, callback_param);
> +	mutex_unlock(&fcs->lock);
> +
> +	if (ret)
> +		remove_cpumask_fcs(fcs, cpumask, cpu);

I think it would be clearer to pass -1 instead of 'cpu', as in
freq_constraint_remove_cpumask_callback(), no need to backtrack and
'confirm' that the above for loop always stops at the last CPU in the
cpumask (unless the function returns due to an error).

Cheers

Matthia
