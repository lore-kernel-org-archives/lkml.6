Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79692C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFCB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXU+9C42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFCB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeGSUod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:44:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55135 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeGSUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:44:32 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so11557245itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tvwZHyBPBBdQUGaPaFsdk7qBpy5eh1Zhr9AOBok1RzY=;
        b=AXU+9C4211eo+XkQnwzk5iVFzMUgTuZeB7nU0zTnDDhsCJKkmqGnu4T0berx7xub5Y
         PUxOC2v31cxYPB5PT6c3oDOx2EJvg0z02jT1zTsns9OCrGxlh5Nh3ZddbHxmni6dr85Y
         9URbpo3otK2IIt2T2dC5JhuSv/sI+fpy+VIRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvwZHyBPBBdQUGaPaFsdk7qBpy5eh1Zhr9AOBok1RzY=;
        b=EQflfd9LS0FxYn2MhUDmEBFC7d2vVHpMetObfEvXcW3OHKJNesI4MepEJptzot5VZo
         6iM0q9jYy1lBUTzCr27MgGNHrL2GINLxa1EhdvGwrzVkyVP/vTgADPc0CQt1K7T29Sry
         Jn+y1IZYBDHHVnatUKTfUGOmCJA5YsWvp2Cw9f8/fHf47VN9TZfwYKv4smycZtKXtl4w
         518FBKuWBP1EaMmXRSOU1exZVeVA6+s03572YBbQ64T2qPq7TDN4ISYStoe2K26s//z9
         Kih2OwGGQlhqrA/3xnhIEE8HCb3p/kF+1lJUa4I8bMmqzQ7Jvzg8V4WnztcqRtqFMidZ
         e6bA==
X-Gm-Message-State: AOUpUlGCnRrCdOOKvbYNe8IRJ1nkks9P/xMJE92NSnX4dTJTo1ydWw65
        +ya8g5WlgQmJ8EXoNILHEoIbnQ==
X-Google-Smtp-Source: AAOMgpcNS+yPUDUooorE07MJXk8V7bQZbiQEptXpIMmabbo7Baf1j/KmDm9GE2LsB5r5V9tMr/vEOg==
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr6574865itf.121.1532030392836;
        Thu, 19 Jul 2018 12:59:52 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e142-v6sm242074itc.7.2018.07.19.12.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 12:59:51 -0700 (PDT)
Date:   Thu, 19 Jul 2018 13:59:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 10/10] coresight: etm-perf: Add support for ETR backend
Message-ID: <20180719195949.GA9421@xps15>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-11-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531847501-22226-11-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:11:41PM +0100, Suzuki K Poulose wrote:
> Add support for using TMC-ETR as backend for ETM perf tracing.
> We use software double buffering at the moment. i.e, the TMC-ETR
> uses a separate buffer than the perf ring buffer. The data is
> copied to the perf ring buffer once a session completes.
> 
> The TMC-ETR would try to match the larger of perf ring buffer
> or the ETR buffer size configured via sysfs, scaling down to
> a minimum limit of 1MB.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 248 +++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
>  2 files changed, 248 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index bc0c932..6280790 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include "coresight-catu.h"
> +#include "coresight-etm-perf.h"
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>  
> @@ -21,6 +22,28 @@ struct etr_flat_buf {
>  };
>  
>  /*
> + * etr_perf_buffer - Perf buffer used for ETR
> + * @etr_buf		- Actual buffer used by the ETR
> + * @snaphost		- Perf session mode
> + * @head		- handle->head at the beginning of the session.
> + * @nr_pages		- Number of pages in the ring buffer.
> + * @pages		- Array of Pages in the ring buffer.
> + */
> +struct etr_perf_buffer {
> +	struct etr_buf		*etr_buf;
> +	bool			snapshot;
> +	unsigned long		head;
> +	int			nr_pages;
> +	void			**pages;
> +};
> +
> +/* Convert the perf index to an offset within the ETR buffer */
> +#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
> +
> +/* Lower limit for ETR hardware buffer */
> +#define TMC_ETR_PERF_MIN_BUF_SIZE	SZ_1M
> +
> +/*
>   * The TMC ETR SG has a page size of 4K. The SG table contains pointers
>   * to 4KB buffers. However, the OS may use a PAGE_SIZE different from
>   * 4K (i.e, 16KB or 64KB). This implies that a single OS page could
> @@ -1103,10 +1126,228 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	return ret;
>  }
>  
> +/*
> + * tmc_etr_setup_perf_buf: Allocate ETR buffer for use by perf.
> + * The size of the hardware buffer is dependent on the size configured
> + * via sysfs and the perf ring buffer size. We prefer to allocate the
> + * largest possible size, scaling down the size by half until it
> + * reaches a minimum limit (1M), beyond which we give up.
> + */
> +static struct etr_perf_buffer *
> +tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
> +		       void **pages, bool snapshot)
> +{
> +	struct etr_buf *etr_buf;
> +	struct etr_perf_buffer *etr_perf;
> +	unsigned long size;
> +
> +	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
> +	if (!etr_perf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Try to match the perf ring buffer size if it is larger
> +	 * than the size requested via sysfs.
> +	 */
> +	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
> +		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
> +					    0, node, NULL);
> +		if (!IS_ERR(etr_buf))
> +			goto done;
> +	}
> +
> +	/*
> +	 * Else switch to configured size for this ETR
> +	 * and scale down until we hit the minimum limit.
> +	 */
> +	size = drvdata->size;
> +	do {
> +		etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);
> +		if (!IS_ERR(etr_buf))
> +			goto done;
> +		size /= 2;
> +	} while (size >= TMC_ETR_PERF_MIN_BUF_SIZE);
> +
> +	kfree(etr_perf);
> +	return ERR_PTR(-ENOMEM);
> +
> +done:
> +	etr_perf->etr_buf = etr_buf;
> +	return etr_perf;
> +}
> +
> +
> +static void *tmc_etr_alloc_perf_buffer(struct coresight_device *csdev,
> +				       int cpu, void **pages, int nr_pages,
> +				       bool snapshot)
> +{
> +	struct etr_perf_buffer *etr_perf;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +
> +	etr_perf = tmc_etr_setup_perf_buf(drvdata, cpu_to_node(cpu),
> +					  nr_pages, pages, snapshot);
> +	if (IS_ERR(etr_perf)) {
> +		dev_dbg(drvdata->dev, "Unable to allocate ETR buffer\n");
> +		return NULL;
> +	}
> +
> +	etr_perf->snapshot = snapshot;
> +	etr_perf->nr_pages = nr_pages;
> +	etr_perf->pages = pages;
> +
> +	return etr_perf;
> +}
> +
> +static void tmc_etr_free_perf_buffer(void *config)
> +{
> +	struct etr_perf_buffer *etr_perf = config;
> +
> +	if (etr_perf->etr_buf)
> +		tmc_free_etr_buf(etr_perf->etr_buf);
> +	kfree(etr_perf);
> +}
> +
> +/*
> + * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
> + * buffer to the perf ring buffer.
> + */
> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> +{
> +	long bytes, to_copy;
> +	long pg_idx, pg_offset, src_offset;
> +	unsigned long head = etr_perf->head;
> +	char **dst_pages, *src_buf;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +
> +	head = etr_perf->head;
> +	pg_idx = head >> PAGE_SHIFT;
> +	pg_offset = head & (PAGE_SIZE - 1);
> +	dst_pages = (char **)etr_perf->pages;
> +	src_offset = etr_buf->offset;
> +	to_copy = etr_buf->len;
> +
> +	while (to_copy > 0) {
> +		/*
> +		 * In one iteration, we can copy minimum of :
> +		 *  1) what is available in the source buffer,
> +		 *  2) what is available in the source buffer, before it
> +		 *     wraps around.
> +		 *  3) what is available in the destination page.
> +		 * in one iteration.
> +		 */
> +		bytes = tmc_etr_buf_get_data(etr_buf, src_offset, to_copy,
> +					     &src_buf);
> +		if (WARN_ON_ONCE(bytes <= 0))
> +			break;
> +		bytes = min(bytes, (long)(PAGE_SIZE - pg_offset));
> +
> +		memcpy(dst_pages[pg_idx] + pg_offset, src_buf, bytes);
> +
> +		to_copy -= bytes;
> +
> +		/* Move destination pointers */
> +		pg_offset += bytes;
> +		if (pg_offset == PAGE_SIZE) {
> +			pg_offset = 0;
> +			if (++pg_idx == etr_perf->nr_pages)
> +				pg_idx = 0;
> +		}
> +
> +		/* Move source pointers */
> +		src_offset += bytes;
> +		if (src_offset >= etr_buf->size)
> +			src_offset -= etr_buf->size;
> +	}
> +}
> +
> +/*
> + * tmc_etr_update_perf_buffer : Update the perf ring buffer with the
> + * available trace data. We use software double buffering at the moment.
> + *
> + * TODO: Add support for reusing the perf ring buffer.
> + */
> +static unsigned long
> +tmc_etr_update_perf_buffer(struct coresight_device *csdev,
> +			   struct perf_output_handle *handle,
> +			   void *config)
> +{
> +	bool lost = false;
> +	unsigned long flags, size = 0;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etr_perf_buffer *etr_perf = config;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (WARN_ON(drvdata->perf_data != etr_perf)) {
> +		lost = true;
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		goto out;
> +	}
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	tmc_flush_and_stop(drvdata);
> +	tmc_sync_etr_buf(drvdata);
> +
> +	CS_UNLOCK(drvdata->base);

This is a copy/paste oversight, here you want to lock again.

> +	/* Reset perf specific data */
> +	drvdata->perf_data = NULL;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +	size = etr_buf->len;
> +	tmc_etr_sync_perf_buffer(etr_perf);
> +
> +	/*
> +	 * Update handle->head in snapshot mode. Also update the size to the
> +	 * hardware buffer size if there was an overflow.
> +	 */
> +	if (etr_perf->snapshot) {
> +		handle->head += size;
> +		if (etr_buf->full)
> +			size = etr_buf->size;
> +	}
> +
> +	lost |= etr_buf->full;
> +out:
> +	if (lost)
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +	return size;
> +}
> +
>  static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>  {
> -	/* We don't support perf mode yet ! */
> -	return -EINVAL;
> +	int rc = 0;
> +	unsigned long flags;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct perf_output_handle *handle = data;
> +	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	/*
> +	 * There can be only one writer per sink in perf mode. If the sink
> +	 * is already open in SYSFS mode, we can't use it.
> +	 */
> +	if (drvdata->mode != CS_MODE_DISABLED || drvdata->perf_data) {
> +		rc = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
> +		rc = -EINVAL;
> +		goto unlock_out;
> +	}
> +
> +	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
> +	drvdata->perf_data = etr_perf;
> +	drvdata->mode = CS_MODE_PERF;
> +	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
> +
> +unlock_out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return rc;
>  }
>  
>  static int tmc_enable_etr_sink(struct coresight_device *csdev,
> @@ -1148,6 +1389,9 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>  static const struct coresight_ops_sink tmc_etr_sink_ops = {
>  	.enable		= tmc_enable_etr_sink,
>  	.disable	= tmc_disable_etr_sink,
> +	.alloc_buffer	= tmc_etr_alloc_perf_buffer,
> +	.update_buffer	= tmc_etr_update_perf_buffer,
> +	.free_buffer	= tmc_etr_free_perf_buffer,


	.alloc_buffer	= tmc_alloc_etr_buffer,
	.update_buffer	= tmc_update_etr_buffer,
	.free_buffer	= tmc_free_etr_buffer,

To be consistant with .enable and .disable along with the naming convention on
the ETF side.

>  };
>  
>  const struct coresight_ops tmc_etr_cs_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 872f63e..487c537 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -170,6 +170,7 @@ struct etr_buf {
>   * @trigger_cntr: amount of words to store after a trigger.
>   * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
>   *		device configuration register (DEVID)
> + * @perf_data:	PERF buffer for ETR.
>   * @sysfs_data:	SYSFS buffer for ETR.
>   */
>  struct tmc_drvdata {
> @@ -191,6 +192,7 @@ struct tmc_drvdata {
>  	u32			trigger_cntr;
>  	u32			etr_caps;
>  	struct etr_buf		*sysfs_buf;
> +	void			*perf_data;
>  };
>  
>  struct etr_buf_operations {
> -- 
> 2.7.4
> 
