Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA9AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969932084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bW9ua3XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969932084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGSUwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:52:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52056 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGSUwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:52:23 -0400
Received: by mail-it0-f68.google.com with SMTP id h2-v6so11635473itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C193EPtpw8vyfxHJYOBjCTiKpFeHbiNQw5Fc1ZwJLys=;
        b=bW9ua3XVurwkXw9E2RREDnmcQESZsg7IIW7B5R383b1eDFsOoSebt3SxfIoJvxu/QE
         jp8i/t3fSO6SYs26SzFavZS+vuhV5LJjF/oAq0rI46th0fZOC542QlI0xihP923FGmq5
         vxreXvKQ9/rxj+6cf/ew3ccTChO2K45KlLlO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C193EPtpw8vyfxHJYOBjCTiKpFeHbiNQw5Fc1ZwJLys=;
        b=MBxZTxxa45JpX3q1eRovoLPMWuAy04jmMFAAyL1ghQgJjpfEMBsu0MTn5sX48iR1Xp
         +xx435MramldEqFsAvilIDvHVXNmYSYo6EoO2zGZFr3eLBnRcJkdG5KeMaSUSMvHFmZ0
         0yIfqsbTd4eRaqzMb8KwRKT6sngwxqrNiOxZTJFt8x8ceDEvgugvRhD96MJzd/HeiFFf
         y/3HS9wfzYnBQaZtWN8DAJp6AgaWFta9ZR9OiJpzvJora9OHf3sU9Y5A0ZWVNNaXzhrB
         BPxjNRD7yV+69Fg1b2j10gbhNbHUTQ/ZPL9oBhgve6T3IJ+ifz2gnHiKyQyneEaN8iQ1
         NVgA==
X-Gm-Message-State: AOUpUlFYS2NLPf1G7c14EutiqlFuOxaGQcteaVqLOqClM3OliZrNtuAj
        yQThdPELBMkXus9f4O48aJjpTA==
X-Google-Smtp-Source: AAOMgpcyoDJnief7wbTCI38yi/lUOhL7iUK/XGBDvMy3E4Ni7XYvXNTfF/ZAU3kR1tlJbC6VbQKmwQ==
X-Received: by 2002:a02:18d0:: with SMTP id 77-v6mr11099699jar.25.1532030862520;
        Thu, 19 Jul 2018 13:07:42 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v3-v6sm4363iop.78.2018.07.19.13.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 13:07:41 -0700 (PDT)
Date:   Thu, 19 Jul 2018 14:07:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 08/10] coresight: perf: Add helper to retrieve sink
 configuration
Message-ID: <20180719200739.GB9421@xps15>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-9-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531847501-22226-9-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:11:39PM +0100, Suzuki K Poulose wrote:
> We can always find the sink configuration for a given perf_output_handle.
> Add a helper to retrieve the sink configuration for a given
> perf_output_handle. This will be used to get rid of the set_buffer()
> call back.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
>  drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 6a4252b..3cc4a0b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -23,20 +23,6 @@
>  static struct pmu etm_pmu;
>  static bool etm_perf_up;
>  
> -/**
> - * struct etm_event_data - Coresight specifics associated to an event
> - * @work:		Handle to free allocated memory outside IRQ context.
> - * @mask:		Hold the CPU(s) this event was set for.
> - * @snk_config:		The sink configuration.
> - * @path:		An array of path, each slot for one CPU.
> - */
> -struct etm_event_data {
> -	struct work_struct work;
> -	cpumask_t mask;
> -	void *snk_config;
> -	struct list_head * __percpu *path;
> -};
> -

If this is moved to coresight-etm-perf.h, the #include <linux/percpu-defs.h> can
be removed.

>  static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 4197df4..da7d933 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -7,6 +7,7 @@
>  #ifndef _CORESIGHT_ETM_PERF_H
>  #define _CORESIGHT_ETM_PERF_H
>  
> +#include <linux/percpu-defs.h>
>  #include "coresight-priv.h"
>  
>  struct coresight_device;
> @@ -42,14 +43,39 @@ struct etm_filters {
>  	bool			ssstatus;
>  };
>  
> +/**
> + * struct etm_event_data - Coresight specifics associated to an event
> + * @work:		Handle to free allocated memory outside IRQ context.
> + * @mask:		Hold the CPU(s) this event was set for.
> + * @snk_config:		The sink configuration.
> + * @path:		An array of path, each slot for one CPU.
> + */
> +struct etm_event_data {
> +	struct work_struct work;
> +	cpumask_t mask;
> +	void *snk_config;
> +	struct list_head * __percpu *path;
> +};
>  
>  #ifdef CONFIG_CORESIGHT
>  int etm_perf_symlink(struct coresight_device *csdev, bool link);
> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> +{
> +	struct etm_event_data *data = perf_get_aux(handle);
>  
> +	if (data)
> +		return data->snk_config;
> +	return NULL;
> +}
>  #else
>  static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
>  { return -EINVAL; }
>  
> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> +{
> +	return NULL;
> +}
> +

I think we can do without those... See my comment in the next patch.

Thanks,
Mathieu

>  #endif /* CONFIG_CORESIGHT */
>  
>  #endif
> -- 
> 2.7.4
> 
