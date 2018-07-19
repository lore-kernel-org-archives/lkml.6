Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A06C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF77920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BblhYKVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF77920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeGSVVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:21:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51993 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeGSVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:21:21 -0400
Received: by mail-it0-f65.google.com with SMTP id h2-v6so11752388itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=irEGJTY8Z9zfojF3lHvgJzb1LEGCmA+ZFSBAJBuMpRA=;
        b=BblhYKVl8UTscqM2dVPDiJB81At18DZK1t9GtHU2Ng/FRZC16E56PRQ0jb6+mn3RGH
         INdfhFRUAiVBdtqeqvAoxZAhHrF8YkdIHjxcxvcIQbtNyOdD2Lx9RkBCpluPOAw9WMU+
         pKrmYd5jUtlg0qmY24uIFbwc4Gu9EZ67hFXSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=irEGJTY8Z9zfojF3lHvgJzb1LEGCmA+ZFSBAJBuMpRA=;
        b=TQM8n69cjyBFhuDWVI02Kf972UsqB47VCeI4E9CBqZMOmvZW4qYttx4kghhbB55NLc
         VevWvqAVzCP5lXeQMYMLKQ5W8k4fam+nhwGNP2vkfYBAhjUhbEirE5uQXKlHxRU9W7ca
         2uMoeJw5+xQjZBS239CcHR50aezFzdjBnjrid85+Hf7OyP2TZzfmEQikUmPe6KiLrof6
         /lbaP4pBaxB4LoQT51wfxE+l/Rgn/bjTcR4nJs4/Pj4DPWyAywuy+2H++0CHtprgbnCH
         TpZqKsdpSSQhULEO9Gv+JYOnXMtsZ6qRkLDqg7l0LysH7P8qjdOnrOGZWfHLIEg1On+8
         hacg==
X-Gm-Message-State: AOUpUlGT0uASQV8xP9lxydmr8hzWySLY5uxzjK7Iy7p+6nionbmV7ZUD
        OTEGNJTIjQDSvVOV0bRZdwa+rtGZcKE=
X-Google-Smtp-Source: AAOMgpe1hSlJU0bku9hHAaB1caXR0P4SfySoriMqnaHFtVu2ocq8g7bWhPieQHf6LNR/fKFiZLVi5g==
X-Received: by 2002:a24:818a:: with SMTP id q132-v6mr7117147itd.51.1532032594192;
        Thu, 19 Jul 2018 13:36:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z195-v6sm61273ioe.38.2018.07.19.13.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 13:36:33 -0700 (PDT)
Date:   Thu, 19 Jul 2018 14:36:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 09/10] coresight: perf: Remove set_buffer call back
Message-ID: <20180719203630.GC9421@xps15>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531847501-22226-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:11:40PM +0100, Suzuki K Poulose wrote:
> In coresight perf mode, we need to prepare the sink before
> starting a session, which is done via set_buffer call back.
> We then proceed to enable the tracing. If we fail to start
> the session successfully, we leave the sink configuration
> unchanged. This was fine for the existing backends as they
> don't have any state associated with the buffers. But with
> ETR, we need to keep track of the buffer details and need
> to be cleaned up if we fail. In order to make the operation
> atomic and to avoid yet another call back, we get rid of
> the "set_buffer" call back and pass the buffer details
> via enable() call back to the sink.

Suzuki,

I'm not sure I understand the problem you're trying to fix there.  From the
implementation of tmc_enable_etr_sink_perf() in the next patch, wouldn't the
same result been achievable using a callback?

I'm fine with this patch and supportive of getting rid of callbacks if we can, I
just need to understand the exact problem you're after.  From looking a your
code (and the current implementation), if we succeed in setting the memory for
the sink but fail in any of the subsequent steps i.e, enabling the rest of the
compoment on the path or the source, the sink is left unchanged.


> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c    | 24 ++++++++++++++------
>  drivers/hwtracing/coresight/coresight-etm-perf.c |  9 ++------
>  drivers/hwtracing/coresight/coresight-priv.h     |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc-etf.c  | 28 ++++++++++++++++--------
>  drivers/hwtracing/coresight/coresight-tmc-etr.c  |  7 +++---
>  drivers/hwtracing/coresight/coresight-tpiu.c     |  2 +-
>  drivers/hwtracing/coresight/coresight.c          | 11 +++++-----
>  include/linux/coresight.h                        |  6 +----
>  8 files changed, 51 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index a729a7b..4e829db 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -28,6 +28,7 @@
>  
>  
>  #include "coresight-priv.h"
> +#include "coresight-etm-perf.h"
>  
>  #define ETB_RAM_DEPTH_REG	0x004
>  #define ETB_STATUS_REG		0x00c
> @@ -90,6 +91,9 @@ struct etb_drvdata {
>  	u32			trigger_cntr;
>  };
>  
> +static int etb_set_buffer(struct coresight_device *csdev,
> +			  struct perf_output_handle *handle);
> +
>  static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>  {
>  	u32 depth = 0;
> @@ -131,12 +135,19 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> -static int etb_enable(struct coresight_device *csdev, u32 mode)
> +static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>  {
> +	int ret = 0;
>  	u32 val;
>  	unsigned long flags;
>  	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> +	if (mode == CS_MODE_PERF) {
> +		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	val = local_cmpxchg(&drvdata->mode,
>  			    CS_MODE_DISABLED, mode);
>  	/*
> @@ -156,8 +167,9 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  out:
> -	dev_dbg(drvdata->dev, "ETB enabled\n");
> -	return 0;
> +	if (!ret)
> +		dev_dbg(drvdata->dev, "ETB enabled\n");
> +	return ret;
>  }
>  
>  static void etb_disable_hw(struct etb_drvdata *drvdata)
> @@ -294,12 +306,11 @@ static void etb_free_buffer(void *config)
>  }
>  
>  static int etb_set_buffer(struct coresight_device *csdev,
> -			  struct perf_output_handle *handle,
> -			  void *sink_config)
> +			  struct perf_output_handle *handle)
>  {
>  	int ret = 0;
>  	unsigned long head;
> -	struct cs_buffers *buf = sink_config;
> +	struct cs_buffers *buf = etm_perf_sink_config(handle);
>  
>  	/* wrap head around to the amount of space we have */
>  	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
> @@ -453,7 +464,6 @@ static const struct coresight_ops_sink etb_sink_ops = {
>  	.disable	= etb_disable,
>  	.alloc_buffer	= etb_alloc_buffer,
>  	.free_buffer	= etb_free_buffer,
> -	.set_buffer	= etb_set_buffer,
>  	.update_buffer	= etb_update_buffer,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 3cc4a0b..12a247d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -269,16 +269,11 @@ static void etm_event_start(struct perf_event *event, int flags)
>  	path = etm_event_cpu_path(event_data, cpu);
>  	/* We need a sink, no need to continue without one */
>  	sink = coresight_get_sink(path);
> -	if (WARN_ON_ONCE(!sink || !sink_ops(sink)->set_buffer))
> -		goto fail_end_stop;
> -
> -	/* Configure the sink */
> -	if (sink_ops(sink)->set_buffer(sink, handle,
> -				       event_data->snk_config))
> +	if (WARN_ON_ONCE(!sink))
>  		goto fail_end_stop;
>  
>  	/* Nothing will happen without a path */
> -	if (coresight_enable_path(path, CS_MODE_PERF))
> +	if (coresight_enable_path(path, CS_MODE_PERF, handle))

Here we already have a handle on "event_data".  As such I think this is what we
should feed to coresight_enable_path() rather than the handle.  That way we
don't need to call etm_perf_sink_config(), we just use the data.

Thanks,
Mathieu 

>  		goto fail_end_stop;
>  
>  	/* Tell the perf core the event is alive */
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 1a6cf35..c11da55 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -137,7 +137,7 @@ static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
>  }
>  
>  void coresight_disable_path(struct list_head *path);
> -int coresight_enable_path(struct list_head *path, u32 mode);
> +int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
>  struct coresight_device *coresight_get_sink(struct list_head *path);
>  struct coresight_device *coresight_get_enabled_sink(bool reset);
>  struct list_head *coresight_build_path(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 31a98f9..4156c95 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -10,6 +10,10 @@
>  #include <linux/slab.h>
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
> +#include "coresight-etm-perf.h"
> +
> +static int tmc_set_etf_buffer(struct coresight_device *csdev,
> +			      struct perf_output_handle *handle);
>  
>  static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
> @@ -182,11 +186,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
>  	return ret;
>  }
>  
> -static int tmc_enable_etf_sink_perf(struct coresight_device *csdev)
> +static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
>  {
>  	int ret = 0;
>  	unsigned long flags;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct perf_output_handle *handle = data;
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  	if (drvdata->reading) {
> @@ -204,15 +209,19 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev)
>  		goto out;
>  	}
>  
> -	drvdata->mode = CS_MODE_PERF;
> -	tmc_etb_enable_hw(drvdata);
> +	ret = tmc_set_etf_buffer(csdev, handle);
> +	if (!ret) {
> +		drvdata->mode = CS_MODE_PERF;
> +		tmc_etb_enable_hw(drvdata);
> +	}
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	return ret;
>  }
>  
> -static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
> +static int tmc_enable_etf_sink(struct coresight_device *csdev,
> +			       u32 mode, void *data)
>  {
>  	int ret;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -222,7 +231,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>  		ret = tmc_enable_etf_sink_sysfs(csdev);
>  		break;
>  	case CS_MODE_PERF:
> -		ret = tmc_enable_etf_sink_perf(csdev);
> +		ret = tmc_enable_etf_sink_perf(csdev, data);
>  		break;
>  	/* We shouldn't be here */
>  	default:
> @@ -328,12 +337,14 @@ static void tmc_free_etf_buffer(void *config)
>  }
>  
>  static int tmc_set_etf_buffer(struct coresight_device *csdev,
> -			      struct perf_output_handle *handle,
> -			      void *sink_config)
> +			      struct perf_output_handle *handle)
>  {
>  	int ret = 0;
>  	unsigned long head;
> -	struct cs_buffers *buf = sink_config;
> +	struct cs_buffers *buf = etm_perf_sink_config(handle);
> +
> +	if (!buf)
> +		return -EINVAL;
>  
>  	/* wrap head around to the amount of space we have */
>  	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
> @@ -472,7 +483,6 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
>  	.disable	= tmc_disable_etf_sink,
>  	.alloc_buffer	= tmc_alloc_etf_buffer,
>  	.free_buffer	= tmc_free_etf_buffer,
> -	.set_buffer	= tmc_set_etf_buffer,
>  	.update_buffer	= tmc_update_etf_buffer,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 85a3f59..bc0c932 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1103,19 +1103,20 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	return ret;
>  }
>  
> -static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
> +static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>  {
>  	/* We don't support perf mode yet ! */
>  	return -EINVAL;
>  }
>  
> -static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
> +static int tmc_enable_etr_sink(struct coresight_device *csdev,
> +			       u32 mode, void *data)
>  {
>  	switch (mode) {
>  	case CS_MODE_SYSFS:
>  		return tmc_enable_etr_sink_sysfs(csdev);
>  	case CS_MODE_PERF:
> -		return tmc_enable_etr_sink_perf(csdev);
> +		return tmc_enable_etr_sink_perf(csdev, data);
>  	}
>  
>  	/* We shouldn't be here */
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 7daeb084..d7dd5e4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -67,7 +67,7 @@ static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> -static int tpiu_enable(struct coresight_device *csdev, u32 mode)
> +static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
>  {
>  	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index c0dabbd..fab87c9 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -128,7 +128,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	return -ENODEV;
>  }
>  
> -static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
> +static int coresight_enable_sink(struct coresight_device *csdev,
> +				 u32 mode, void *data)
>  {
>  	int ret;
>  
> @@ -137,7 +138,7 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
>  	 * existing "mode" of operation.
>  	 */
>  	if (sink_ops(csdev)->enable) {
> -		ret = sink_ops(csdev)->enable(csdev, mode);
> +		ret = sink_ops(csdev)->enable(csdev, mode, data);
>  		if (ret)
>  			return ret;
>  		csdev->enable = true;
> @@ -315,7 +316,7 @@ void coresight_disable_path(struct list_head *path)
>  	}
>  }
>  
> -int coresight_enable_path(struct list_head *path, u32 mode)
> +int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
>  {
>  
>  	int ret = 0;
> @@ -340,7 +341,7 @@ int coresight_enable_path(struct list_head *path, u32 mode)
>  
>  		switch (type) {
>  		case CORESIGHT_DEV_TYPE_SINK:
> -			ret = coresight_enable_sink(csdev, mode);
> +			ret = coresight_enable_sink(csdev, mode, sink_data);
>  			/*
>  			 * Sink is the first component turned on. If we
>  			 * failed to enable the sink, there are no components
> @@ -643,7 +644,7 @@ int coresight_enable(struct coresight_device *csdev)
>  		goto out;
>  	}
>  
> -	ret = coresight_enable_path(path, CS_MODE_SYSFS);
> +	ret = coresight_enable_path(path, CS_MODE_SYSFS, NULL);
>  	if (ret)
>  		goto err_path;
>  
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index eafe4d1..3434758 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -190,18 +190,14 @@ struct coresight_device {
>   * @disable:		disables the sink.
>   * @alloc_buffer:	initialises perf's ring buffer for trace collection.
>   * @free_buffer:	release memory allocated in @get_config.
> - * @set_buffer:		initialises buffer mechanic before a trace session.
>   * @update_buffer:	update buffer pointers after a trace session.
>   */
>  struct coresight_ops_sink {
> -	int (*enable)(struct coresight_device *csdev, u32 mode);
> +	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
>  	void (*disable)(struct coresight_device *csdev);
>  	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
>  			      void **pages, int nr_pages, bool overwrite);
>  	void (*free_buffer)(void *config);
> -	int (*set_buffer)(struct coresight_device *csdev,
> -			  struct perf_output_handle *handle,
> -			  void *sink_config);
>  	unsigned long (*update_buffer)(struct coresight_device *csdev,
>  			      struct perf_output_handle *handle,
>  			      void *sink_config);
> -- 
> 2.7.4
> 
