Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB835C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DED214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfA0HvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 02:51:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbfA0HvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 02:51:12 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0R7mrbT145167
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 02:51:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q95q247sj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 02:51:11 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 27 Jan 2019 07:51:09 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Jan 2019 07:51:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0R7p5bd35979468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 07:51:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E0AFA4062;
        Sun, 27 Jan 2019 07:51:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E373FA405B;
        Sun, 27 Jan 2019 07:51:04 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.103])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Jan 2019 07:51:04 +0000 (GMT)
Date:   Sun, 27 Jan 2019 09:51:03 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai
Subject: Re: [PATCH 10/15] habanalabs: add device reset support
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-11-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123000057.31477-11-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012707-0008-0000-0000-000002B68CB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012707-0009-0000-0000-00002222C839
Message-Id: <20190127075059.GA28461@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901270066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:00:52AM +0200, Oded Gabbay wrote:
> This patch adds support for doing various on-the-fly reset of Goya.
> 
> The driver supports two types of resets:
> 1. soft-reset
> 2. hard-reset
> 
> Soft-reset is done when the device detects a timeout of a command
> submission that was given to the device. The soft-reset process only resets
> the engines that are relevant for the submission of compute jobs, i.e. the
> DMA channels, the TPCs and the MME. The purpose is to bring the device as
> fast as possible to a working state.
> 
> Hard-reset is done in several cases:
> 1. After soft-reset is done but the device is not responding
> 2. When fatal errors occur inside the device, e.g. ECC error
> 3. When the driver is removed
> 
> Hard-reset performs a reset of the entire chip except for the PCI
> controller and the PLLs. It is a much longer process then soft-reset but it
> helps to recover the device without the need to reboot the Host.
> 
> After hard-reset, the driver will restore the max power attribute and in
> case of manual power management, the frequencies that were set.
> 
> This patch also adds two entries to the sysfs, which allows the root user
> to initiate a soft or hard reset.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/command_buffer.c  |  11 +-
>  drivers/misc/habanalabs/device.c          | 308 +++++++++++++++++++++-
>  drivers/misc/habanalabs/goya/goya.c       | 201 ++++++++++++++
>  drivers/misc/habanalabs/goya/goya_hwmgr.c |  18 +-
>  drivers/misc/habanalabs/habanalabs.h      |  35 +++
>  drivers/misc/habanalabs/habanalabs_drv.c  |   9 +-
>  drivers/misc/habanalabs/hwmon.c           |   4 +-
>  drivers/misc/habanalabs/irq.c             |  31 +++
>  drivers/misc/habanalabs/sysfs.c           | 120 ++++++++-
>  9 files changed, 712 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
> index 535ed6cc5bda..700c6da01188 100644
> --- a/drivers/misc/habanalabs/command_buffer.c
> +++ b/drivers/misc/habanalabs/command_buffer.c
> @@ -81,9 +81,10 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
>  	bool alloc_new_cb = true;
>  	int rc;
>  
> -	if (hdev->disabled) {
> +	if ((hdev->disabled) || ((atomic_read(&hdev->in_reset)) &&
> +					(ctx_id != HL_KERNEL_ASID_ID))) {
>  		dev_warn_ratelimited(hdev->dev,
> -			"Device is disabled !!! Can't create new CBs\n");
> +			"Device is disabled or in reset !!! Can't create new CBs\n");
>  		rc = -EBUSY;
>  		goto out_err;
>  	}
> @@ -187,6 +188,12 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
>  	u64 handle;
>  	int rc;
>  
> +	if (hdev->hard_reset_pending) {
> +		dev_crit_ratelimited(hdev->dev,
> +			"Device HARD reset pending !!! Please close FD\n");
> +		return -ENODEV;
> +	}

Probably this check should be done at the top-level ioctl()? 
And, what will happen if the devices performs hard reset, but the used
keeps the file descriptor open?

> +
>  	switch (args->in.op) {
>  	case HL_CB_OP_CREATE:
>  		rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index ff7b610f18c4..00fde57ce823 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -188,6 +188,7 @@ static int device_early_init(struct hl_device *hdev)
>  
>  	mutex_init(&hdev->device_open);
>  	mutex_init(&hdev->send_cpu_message_lock);
> +	atomic_set(&hdev->in_reset, 0);
>  	atomic_set(&hdev->fd_open_cnt, 0);
>  
>  	return 0;
> @@ -238,6 +239,27 @@ static void set_freq_to_low_job(struct work_struct *work)
>  			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
>  }
>  
> +static void hl_device_heartbeat(struct work_struct *work)
> +{
> +	struct hl_device *hdev = container_of(work, struct hl_device,
> +						work_heartbeat.work);
> +
> +	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
> +		goto reschedule;
> +
> +	if (!hdev->asic_funcs->send_heartbeat(hdev))
> +		goto reschedule;

AFAIU, asic_funcs->send_heartbeat() it set once at init time. The work
should not be scheduled it it's NULL, I suppose.

> +
> +	dev_err(hdev->dev, "Device heartbeat failed !!!\n");
> +	hl_device_reset(hdev, true, false);
> +
> +	return;
> +
> +reschedule:
> +	schedule_delayed_work(&hdev->work_heartbeat,
> +			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
> +}
> +
>  /**
>   * device_late_init - do late stuff initialization for the habanalabs device
>   *
> @@ -273,6 +295,12 @@ static int device_late_init(struct hl_device *hdev)
>  	schedule_delayed_work(&hdev->work_freq,
>  			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
>  
> +	if (hdev->heartbeat) {
> +		INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
> +		schedule_delayed_work(&hdev->work_heartbeat,
> +				usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
> +	}
> +
>  	hdev->late_init_done = true;
>  
>  	return 0;
> @@ -290,6 +318,8 @@ static void device_late_fini(struct hl_device *hdev)
>  		return;
>  
>  	cancel_delayed_work_sync(&hdev->work_freq);
> +	if (hdev->heartbeat)
> +		cancel_delayed_work_sync(&hdev->work_heartbeat);
>  
>  	if (hdev->asic_funcs->late_fini)
>  		hdev->asic_funcs->late_fini(hdev);
> @@ -397,6 +427,254 @@ int hl_device_resume(struct hl_device *hdev)
>  	return 0;
>  }
>  
> +static void hl_device_hard_reset_pending(struct work_struct *work)
> +{
> +	struct hl_device_reset_work *device_reset_work =
> +		container_of(work, struct hl_device_reset_work, reset_work);
> +	struct hl_device *hdev = device_reset_work->hdev;
> +	u16 pending_cnt = HL_PENDING_RESET_PER_SEC;
> +	struct task_struct *task = NULL;
> +
> +	/* Flush all processes that are inside hl_open */
> +	mutex_lock(&hdev->device_open);
> +
> +	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
> +
> +		pending_cnt--;
> +
> +		dev_info(hdev->dev,
> +			"Can't HARD reset, waiting for user to close FD\n");
> +		ssleep(1);
> +	}
> +
> +	if (atomic_read(&hdev->fd_open_cnt)) {
> +		task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
> +					PIDTYPE_PID);
> +		if (task) {
> +			dev_info(hdev->dev, "Killing user processes\n");
> +			send_sig(SIGKILL, task, 1);

Shouldn't the user get a chance for cleanup?

> +			msleep(100);
> +
> +			put_task_struct(task);
> +		}
> +	}
> +
> +	mutex_unlock(&hdev->device_open);
> +
> +	hl_device_reset(hdev, true, true);
> +
> +	kfree(device_reset_work);
> +}
> +

[ ... ]

> diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
> index 866d1774b2e4..9482dbb2e03a 100644
> --- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
> +++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
> @@ -38,7 +38,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
>  	struct hl_device *hdev = dev_get_drvdata(dev);
>  	long value;
>  
> -	if (hdev->disabled)
> +	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
>  		return -ENODEV;
>  
>  	value = hl_get_frequency(hdev, MME_PLL, false);
> @@ -57,7 +57,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
>  	int rc;
>  	long value;
>  
> -	if (hdev->disabled) {
> +	if ((hdev->disabled) || (atomic_read(&hdev->in_reset))) {

There are quite a few of those, maybe split this check to a helper
function?

>  		count = -ENODEV;
>  		goto fail;
>  	}
> @@ -87,7 +87,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
>  	struct hl_device *hdev = dev_get_drvdata(dev);
>  	long value;
>  
> -	if (hdev->disabled)
> +	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
>  		return -ENODEV;
>  
>  	value = hl_get_frequency(hdev, TPC_PLL, false);
> @@ -106,7 +106,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
>  	int rc;
>  	long value;
>  
> -	if (hdev->disabled) {
> +	if ((hdev->disabled) || (atomic_read(&hdev->in_reset))) {
>  		count = -ENODEV;
>  		goto fail;
>  	}

-- 
Sincerely yours,
Mike.

