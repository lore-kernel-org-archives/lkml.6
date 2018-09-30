Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63B6C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F21C20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TtvodZFm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U+7js5BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F21C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeI3WCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:02:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeI3WCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:02:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48A6F6078C; Sun, 30 Sep 2018 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538321330;
        bh=xewe+/XVw2jGROGFu2rdaJ2L3ZPLon4LPkLnCfTQfyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TtvodZFmgAejwPzkYayNl023Isa7HmyeSz5kwjXcV15slhiJVgB3fDa3XuPmR3kYC
         sP6rUJBTUcSyTI4XmwwQkhrgrGuUSpaMqfu7yVhexVpNxnNWV8BItnh9B1OTUthapA
         aJUToU+irMBGYjTNW4Hl1aA9QK12F+IeQplT1e+4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 294A56044B;
        Sun, 30 Sep 2018 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538321329;
        bh=xewe+/XVw2jGROGFu2rdaJ2L3ZPLon4LPkLnCfTQfyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U+7js5BQeDkOEvygaUqjgBLxSA7bRzav7feU7+8VP4cGE6XUDW+JjkNi4dvkNy2cM
         bSOnylldS2My6bvEQgnNK9K1TdZ5PO6NcOveKDssTtUkSk6F2N5IiUHyi7GAxr4885
         pHA62y44uy2qQt93abjoyj2fwCvZ+n7zbdZGIabY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 30 Sep 2018 20:58:49 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC PATCH] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
In-Reply-To: <20180925172943.GA118699@ban.mtv.corp.google.com>
References: <20180925080607.30565-1-bjorn.andersson@linaro.org>
 <20180925172943.GA118699@ban.mtv.corp.google.com>
Message-ID: <37621d4fadff8e3a0bbe034119351d16@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-25 22:59, Brian Norris wrote:
> Hi Bjorn,
> 
> On Tue, Sep 25, 2018 at 01:06:07AM -0700, Bjorn Andersson wrote:
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
>> The suggestion is therefor to link the rmtfs_mem to its associated
>> remote processor instance and control it based on the availability of
>> the rmtfs_mem implementation.
> 
> But what does "availability" mean? If I'm reading your rmtfs daemon
> properly, "availability" should mean that the daemon is up and has
> registered a RMTFS_QMI_SERVICE. But in this patch, you're keying off of
> the open() call, which sounds like you're introducing a race condition
> -- we might have open()ed the RMTFS memory but we're not actually
> completely ready to service requests.
> 
> So rather than looking for open(), I think somebody needs to be looking
> for the appearance and disappearance of the RMTFS_QMI_SERVICE. (Looking
> for disappearance would resolve the daemon restart issue, no?) That
> "somebody" could be the remoteproc driver I suppose 
> (qmi_add_lookup()?),
> or...couldn't it just be the modem itself? Do you actually need to
> restart the entire modem when the RMTFS service goes away, or do you
> just need to pause storage activity?
> 

Hi Brian,

It might be more logical to make that "somebody" the rmtfs_mem driver 
itself, since
the modem as such does not have any direct functional dependency on 
rmtfs_mem i.e
the firmware can be configured to run on rmtfs_mem or internal fs. So in 
such cases
where the modem is running on internal fs, it would be undesirable to 
have a hard
coded dependency for rmtfs_mem in remoteproc modem itself.

Wouldn't it be simpler/quicker to fix this in kernel than churning out 
new firmware
releases. A fix in firmware will also mean that this becomes one-off fix 
for dragon
boards diverging the firmware branch from whats used in android for 
8916/8974/8996.

>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
>>  .../reserved-memory/qcom,rmtfs-mem.txt        |  7 ++++++
>>  drivers/remoteproc/qcom_q6v5_pil.c            |  1 +
>>  drivers/soc/qcom/Kconfig                      |  1 +
>>  drivers/soc/qcom/rmtfs_mem.c                  | 23 
>> ++++++++++++++++++-
>>  4 files changed, 31 insertions(+), 1 deletion(-)
>> 
> ...
>> diff --git a/drivers/soc/qcom/rmtfs_mem.c 
>> b/drivers/soc/qcom/rmtfs_mem.c
>> index 8a3678c2e83c..8b08be310397 100644
>> --- a/drivers/soc/qcom/rmtfs_mem.c
>> +++ b/drivers/soc/qcom/rmtfs_mem.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/of.h>
>>  #include <linux/of_reserved_mem.h>
>> +#include <linux/remoteproc.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/slab.h>
>>  #include <linux/uaccess.h>
>> @@ -39,6 +40,8 @@ struct qcom_rmtfs_mem {
>>  	unsigned int client_id;
>> 
>>  	unsigned int perms;
>> +
>> +	struct rproc *rproc;
>>  };
>> 
>>  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
>> @@ -80,11 +83,18 @@ static int qcom_rmtfs_mem_open(struct inode 
>> *inode, struct file *filp)
>>  	struct qcom_rmtfs_mem *rmtfs_mem = container_of(inode->i_cdev,
>>  							struct qcom_rmtfs_mem,
>>  							cdev);
>> +	int ret = 0;
>> 
>>  	get_device(&rmtfs_mem->dev);
>>  	filp->private_data = rmtfs_mem;
>> 
>> -	return 0;
>> +	if (rmtfs_mem->rproc) {
>> +		ret = rproc_boot(rmtfs_mem->rproc);
>> +		if (ret)
>> +			put_device(&rmtfs_mem->dev);
>> +	}
>> +
>> +	return ret;
>>  }
>>  static ssize_t qcom_rmtfs_mem_read(struct file *filp,
>>  			      char __user *buf, size_t count, loff_t *f_pos)
>> @@ -127,6 +137,9 @@ static int qcom_rmtfs_mem_release(struct inode 
>> *inode, struct file *filp)
>>  {
>>  	struct qcom_rmtfs_mem *rmtfs_mem = filp->private_data;
>> 
>> +	if (rmtfs_mem->rproc)
>> +		rproc_shutdown(rmtfs_mem->rproc);
>> +
>>  	put_device(&rmtfs_mem->dev);
>> 
>>  	return 0;
>> @@ -156,6 +169,7 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	struct qcom_scm_vmperm perms[2];
>>  	struct reserved_mem *rmem;
>>  	struct qcom_rmtfs_mem *rmtfs_mem;
>> +	phandle rproc_phandle;
>>  	u32 client_id;
>>  	u32 vmid;
>>  	int ret;
>> @@ -181,6 +195,13 @@ static int qcom_rmtfs_mem_probe(struct 
>> platform_device *pdev)
>>  	rmtfs_mem->client_id = client_id;
>>  	rmtfs_mem->size = rmem->size;
>> 
>> +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
>> +	if (!ret) {
>> +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
> 
> You're doing an rproc_get(), so you need to do a rproc_put() in
> remove().
> 
> Brian
> 
>> +		if (!rmtfs_mem->rproc)
>> +			return -EPROBE_DEFER;
>> +	}
>> +
>>  	device_initialize(&rmtfs_mem->dev);
>>  	rmtfs_mem->dev.parent = &pdev->dev;
>>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
