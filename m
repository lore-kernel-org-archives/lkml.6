Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652BBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C482081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="isN8oPEs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MyA1hF02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C482081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeJaXan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:30:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbeJaXan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:30:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6796F6037B; Wed, 31 Oct 2018 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540996345;
        bh=8ik9KhElyueFsV2l7WFF61FTfepn/2fgklDn88PYdi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isN8oPEsy03d1GEAZO4tDJq3gmQXkl8iUK2Lfazc71HILkNi70SW1lKimEfRPRG4P
         oUNKxqGpb1GLSCR1N0Alsp8qTvlryKGKl/qwjN8EroQ65QPK0+4/GtRAowrDf2DtS4
         GDJYvrsLl86+ljSsczLEgjZFSvV5a6DC1zgE1pKU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 785E360112;
        Wed, 31 Oct 2018 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540996344;
        bh=8ik9KhElyueFsV2l7WFF61FTfepn/2fgklDn88PYdi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MyA1hF02odmZMNg/ghj4qUokTyYh9+YRc4pfRmrAdau8Gn+xPtxXR36adIgY9tW9y
         zf+qPs+d3oYR5jpZQOtwzWZY1/tVG5wmqrO6kPtNyixRjP8vvedG7jEbEFfyOeqqYs
         v3m4t5lnywSP38zgB6uGMrMtjMjFffTRpvYwKhoo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Oct 2018 20:02:24 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC PATCH v2] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
In-Reply-To: <20181018005426.GC179852@rodete-desktop-imager.corp.google.com>
References: <20180930155646.20590-1-sibis@codeaurora.org>
 <20181018005426.GC179852@rodete-desktop-imager.corp.google.com>
Message-ID: <c5cde3e5a6b129197e723e88b5df9ede@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,
Thanks for the review!

On 2018-10-18 06:24, Brian Norris wrote:
> Hi Sibi,
> 
> On Sun, Sep 30, 2018 at 09:26:46PM +0530, Sibi Sankar wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>> 
>> rmtfs_mem provides access to physical storage and is crucial for the
>> operation of the Qualcomm modem subsystem.
>> 
>> The rmtfs_mem implementation must be available before the modem
>> subsystem is booted and a solution where the modem remoteproc will
>> verify that the rmtfs_mem is available has been discussed in the past.
>> But this would not handle the case where the rmtfs_mem provider is
>> restarted, which would cause fatal loss of access to the storage 
>> device
>> for the modem.
>> 
>> The suggestion is therefore to link the rmtfs_mem to its associated
>> remote processor instance and control it based on the availability of
>> the rmtfs_mem implementation.
>> 
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> [sibis: Added qmi lookup for Remote file system service]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> The currently implemented workaround in the Linaro QCOMLT releases is 
>> to
>> blacklist the qcom_q6v5_pil kernel module and load this explicitly 
>> after rmtfs
>> has been started.
>> 
>> With this patch the modem module can be loaded automatically by the
>> platform_bus and will only be booted as the rmtfs becomes available. 
>> Performing
>> actions such as upgrading (and restarting) the rmtfs service will 
>> cause the
>> modem to automatically restart and hence continue to function after 
>> the
>> upgrade.
>> 
>> v2:
>>   Remove rproc_boot/shutdown from rmtfs_mem open/release and add
>>   qmi lookup for Remote file system service to address Brian's
>>   race concerns.
>> 
>>  .../reserved-memory/qcom,rmtfs-mem.txt        |  7 ++
>>  drivers/remoteproc/qcom_q6v5_pil.c            |  1 +
>>  drivers/soc/qcom/Kconfig                      |  2 +
>>  drivers/soc/qcom/rmtfs_mem.c                  | 65 
>> ++++++++++++++++++-
>>  4 files changed, 72 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt 
>> b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
>> index 8562ba1dce69..95b209e7f5d1 100644
>> --- 
>> a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
>> +++ 
>> b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
>> @@ -32,6 +32,13 @@ access block device data using the Remote 
>> Filesystem protocol.
>>  	Value type: <u32>
>>  	Definition: vmid of the remote processor, to set up memory 
>> protection.
>> 
>> +- rproc:
>> +	Usage: optional
>> +	Value type: <phandle>
>> +	Definition: reference to a remoteproc node, that should be powered 
>> up
>> +		    while the remote file system memory instance is ready to
>> +		    handle requests from the remote subsystem.
>> +
> 
> I'll repeat my comment here: this is straying far into the territory of
> putting software configuration in the device tree. Per your own
> comments, the modem firmware can be configured to run with or without a
> remote FS, and now you're assuming that the device tree will include
> this property or not, based on how you configured said firmware. That's
> not how device tree is supposed to work.
> 

Yes makes sense, will remove all dt dependencies in the next re-spin

>>  = EXAMPLE
>>  The following example shows the remote filesystem memory setup for 
>> APQ8016,
>>  with the rmtfs region for the Hexagon DSP (id #1) located at 
>> 0x86700000.
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c 
>> b/drivers/remoteproc/qcom_q6v5_pil.c
>> index d7a4b9eca5d2..1445a38e8b34 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -1142,6 +1142,7 @@ static int q6v5_probe(struct platform_device 
>> *pdev)
>>  	qproc = (struct q6v5 *)rproc->priv;
>>  	qproc->dev = &pdev->dev;
>>  	qproc->rproc = rproc;
>> +	rproc->auto_boot = false;
> 
> So how is it supposed to work when you have an internal filesystem for
> the modem? User space just knows about this, and manually starts the
> remoteproc?
> 

I somehow missed this

Since the default firmware configuration for 8916/8996/845 has
rmtfs dependency I plan on adding the qmi lookup by default till
we get a platform that needs rmtfs disabled by default for which
I could easily add a flag for rmtfs dependency in
rproc_hexagon_res in qcom_q6v5_mss driver and do qmi lookup only
if rmtfs is supported.

>>  	platform_set_drvdata(pdev, qproc);
>> 
>>  	ret = q6v5_init_mem(qproc, pdev);
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 8a7b8dea6990..4e3345944325 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -86,7 +86,9 @@ config QCOM_QMI_HELPERS
>>  config QCOM_RMTFS_MEM
>>  	tristate "Qualcomm Remote Filesystem memory driver"
>>  	depends on ARCH_QCOM
>> +	depends on REMOTEPROC
>>  	select QCOM_SCM
>> +	select QCOM_QMI_HELPERS
>>  	help
>>  	  The Qualcomm remote filesystem memory driver is used for 
>> allocating
>>  	  and exposing regions of shared memory with remote processors for 
>> the
>> diff --git a/drivers/soc/qcom/rmtfs_mem.c 
>> b/drivers/soc/qcom/rmtfs_mem.c
>> index 97bb5989aa21..757e30083f67 100644
>> --- a/drivers/soc/qcom/rmtfs_mem.c
>> +++ b/drivers/soc/qcom/rmtfs_mem.c
>> @@ -18,11 +18,13 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/of.h>
>>  #include <linux/of_reserved_mem.h>
>> +#include <linux/remoteproc.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/slab.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/io.h>
>>  #include <linux/qcom_scm.h>
>> +#include <linux/soc/qcom/qmi.h>
>> 
>>  #define QCOM_RMTFS_MEM_DEV_MAX	(MINORMASK + 1)
>> 
>> @@ -31,6 +33,7 @@ static dev_t qcom_rmtfs_mem_major;
>>  struct qcom_rmtfs_mem {
>>  	struct device dev;
>>  	struct cdev cdev;
>> +	struct qmi_handle rmtfs_hdl;
>> 
>>  	void *base;
>>  	phys_addr_t addr;
>> @@ -39,6 +42,8 @@ struct qcom_rmtfs_mem {
>>  	unsigned int client_id;
>> 
>>  	unsigned int perms;
>> +
>> +	struct rproc *rproc;
>>  };
>> 
>>  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
>> @@ -141,6 +146,36 @@ static const struct file_operations 
>> qcom_rmtfs_mem_fops = {
>>  	.llseek = default_llseek,
>>  };
>> 
>> +static int rmtfs_new_server(struct qmi_handle *qmi,
>> +				 struct qmi_service *service)
>> +{
>> +	int ret = 0;
>> +	struct qcom_rmtfs_mem *rmtfs_mem = container_of(qmi,
>> +							struct qcom_rmtfs_mem,
>> +							rmtfs_hdl);
>> +
>> +	if (rmtfs_mem->rproc)
> 
> Couldn't you avoid registering these callbacks entirely, if there's no
> rproc device/phandle?
> 

will remove all dt dependencies in the next re-spin

>> +		ret = rproc_boot(rmtfs_mem->rproc);
>> +
>> +	return ret;
>> +};
>> +
>> +static void rmtfs_del_server(struct qmi_handle *qmi,
>> +				  struct qmi_service *service)
>> +{
>> +	struct qcom_rmtfs_mem *rmtfs_mem = container_of(qmi,
>> +							struct qcom_rmtfs_mem,
>> +							rmtfs_hdl);
>> +
>> +	if (rmtfs_mem->rproc)
>> +		rproc_shutdown(rmtfs_mem->rproc);
>> +};
>> +
>> +static struct qmi_ops rmtfs_lookup_ops = {
>> +	.new_server = rmtfs_new_server,
>> +	.del_server = rmtfs_del_server,
>> +};
>> +
>>  static void qcom_rmtfs_mem_release_device(struct device *dev)
>>  {
>>  	struct qcom_rmtfs_mem *rmtfs_mem = container_of(dev,
>> @@ -156,6 +191,7 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	struct qcom_scm_vmperm perms[2];
>>  	struct reserved_mem *rmem;
>>  	struct qcom_rmtfs_mem *rmtfs_mem;
>> +	phandle rproc_phandle;
>>  	u32 client_id;
>>  	u32 vmid;
>>  	int ret;
>> @@ -181,6 +217,22 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	rmtfs_mem->client_id = client_id;
>>  	rmtfs_mem->size = rmem->size;
>> 
>> +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
>> +	if (!ret) {
>> +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
>> +		if (!rmtfs_mem->rproc)
>> +			return -EPROBE_DEFER;
>> +	}
>> +
>> +	ret = qmi_handle_init(&rmtfs_mem->rmtfs_hdl, 0,
>> +			      &rmtfs_lookup_ops, NULL);
> 
> Similar to the above comment: this should just be under the "if rproc"
> condition -- also because in remove(), you only unregister these
> callbacks if you have an rproc device.
> 

I'll be moving qmi_lookup logic to qcom_q6v5_mss driver will fix
it there

>> +	if (ret < 0)
>> +		goto put_rproc;
> 
> You've got the error handling wrong here. You're doing the
> rmtfs_mem->dev cleanup under the 'put_rproc' label, but you haven't 
> even
> started to initialize that device by now.
> 
>> +
>> +	ret = qmi_add_lookup(&rmtfs_mem->rmtfs_hdl, 14, 0, 0);
> 
> I can see there are some bad examples out there already to cheat off
> of...but please don't just use magic nubmers like '14' here. There
> should be a defined constant for this.
> 

Yes, I'll make sure I add comments and the corresponding define

> And while we're at it: why isn't there a common header for QMI service
> IDs? Would be nice to list all the IDs that the kernel might be using,
> in one place.

I can probably take this up as a separate task if its something
Bjorn wants cleaned up?

> 
>> +	if (ret < 0)
>> +		goto err_release_qmi_handle;
>> +
>>  	device_initialize(&rmtfs_mem->dev);
>>  	rmtfs_mem->dev.parent = &pdev->dev;
>>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
>> @@ -191,7 +243,7 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	if (IS_ERR(rmtfs_mem->base)) {
>>  		dev_err(&pdev->dev, "failed to remap rmtfs_mem region\n");
>>  		ret = PTR_ERR(rmtfs_mem->base);
>> -		goto put_device;
>> +		goto err_release_qmi_handle;
>>  	}
>> 
>>  	cdev_init(&rmtfs_mem->cdev, &qcom_rmtfs_mem_fops);
>> @@ -204,7 +256,7 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to add cdev: %d\n", ret);
>> -		goto put_device;
>> +		goto err_release_qmi_handle;
>>  	}
>> 
>>  	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
>> @@ -237,7 +289,10 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>> 
>>  remove_cdev:
>>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>> -put_device:
>> +err_release_qmi_handle:
>> +	qmi_handle_release(&rmtfs_mem->rmtfs_hdl);
>> +put_rproc:
>> +	rproc_put(rmtfs_mem->rproc);
>>  	put_device(&rmtfs_mem->dev);
> 
> As mentioned above, this is in the wrong order. You probably will need
> an additional exit label too.
> 

yes missed that but will move the qmi lookup logic to qcom_q6v5_mss
driver. will fix it there

>> 
>>  	return ret;
>> @@ -257,6 +312,10 @@ static int qcom_rmtfs_mem_remove(struct 
>> platform_device *pdev)
>>  	}
>> 
>>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>> +	if (rmtfs_mem->rproc) {
>> +		qmi_handle_release(&rmtfs_mem->rmtfs_hdl);
> 
> As noted above, this doesn't match with probe().
> 
> Brian
> 
>> +		rproc_put(rmtfs_mem->rproc);
>> +	}
>>  	put_device(&rmtfs_mem->dev);
>> 
>>  	return 0;

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
