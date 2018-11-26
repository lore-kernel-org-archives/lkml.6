Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B96CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1773213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="xnzafMHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1773213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeK0Ih3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:37:29 -0500
Received: from vern.gendns.com ([98.142.107.122]:47304 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeK0Ih3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rUvdSNCoP3lXARK+Y+kuF/xq/Oo6RwcwSkI+0v9FcA8=; b=xnzafMHAb1hslKnbUbQYuxcvKF
        bzpvciGPlnAUjCDJR1Li/57OITavWI5xV+WM3IcxAl2Di3PyHjRAGn+vscrPweDZys/iIU+PA98U4
        PoB+8r9Jtlhq8uD8fmEtzX8ldnj+ZZLOVkCEA2I0L+edmZLZi+a8sh17aUaM96nXWV/WW741/HHrG
        UDntmu2hEezEmtKc4kNLkVPbqtjxjg8blO8q+sqClG2GZsg1xLDis3lgO3cufPqCNmuq8pROL1Qx4
        wY0F6lUlShSLJyu0ADmUxGql4t8wtVDYF39VqVs6bP/JUY83nJrAmhHSLADbi3xS6WiK7Zlx/+Qkk
        N3PDJN0A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45146 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROcs-0005T9-0J; Mon, 26 Nov 2018 16:41:06 -0500
Subject: Re: [PATCH 02/16] remoteproc: Add a rproc_set_firmware() API
To:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-3-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <ee68d58b-24ff-f7b2-aa62-f1e73e078516@lechnology.com>
Date:   Mon, 26 Nov 2018 15:41:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543218769-5507-3-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 1:52 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> A new API, rproc_set_firmware() is added to allow the remoteproc platform
> drivers and remoteproc client drivers to be able to configure a custom
> firmware name that is different from the default name used during
> remoteproc registration. This function is being introduced to provide
> a kernel-level equivalent of the current sysfs interface to remoteproc
> client drivers. This allows some remoteproc drivers to choose different
> firmwares at runtime when the remote processor is not running based on
> the functional feature it is providing using that remote processor.
> The TI PRU Ethernet driver will be an example of such usage as it
> requires to use different firmwares for different supported protocols.
> 
> Also, update the firmware_store() function used by the sysfs interface
> to reuse this function to avoid code duplication.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   drivers/remoteproc/remoteproc_core.c  | 61 +++++++++++++++++++++++++++++++++++
>   drivers/remoteproc/remoteproc_sysfs.c | 33 ++-----------------
>   include/linux/remoteproc.h            |  1 +
>   3 files changed, 64 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 39458a7..581e6e8 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2151,6 +2151,67 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)

...

> +int rproc_set_firmware(struct rproc *rproc, const char *fw_name)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	int ret, len;
> +	char *p;
> +
> +	if (!rproc || !fw_name)
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&rproc->lock);
> +	if (ret) {
> +		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> +		return -EINVAL;
> +	}
> +
> +	if (rproc->state != RPROC_OFFLINE) {
> +		dev_err(dev, "can't change firmware while running\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	len = strcspn(fw_name, "\n");
> +	if (!len) {
> +		dev_err(dev, "can't provide a NULL firmware\n");

I realize this was just copied, but technically, this would be an
empty string rather than NULL.

