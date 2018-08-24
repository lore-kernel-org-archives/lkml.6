Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6722156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xk1fmsHW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j6K9LVpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6722156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHXQBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:01:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeHXQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:01:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5D6B6053B; Fri, 24 Aug 2018 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535113608;
        bh=Ix8OtI0E9tcBpxZUwKDtEUcygtVciziIRaJ+LbZkq8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xk1fmsHW50Bi9SJqRdKiQBDhzT5IxPndhOv7kf62GaxEu5AEwZejkRxNapXXVP0e7
         +8pE57GxJ0sdufayttNPOoHXUkZF0SaYCOmVTedemwqUYgfdzdxJqgKu1XCjXzEdLz
         KIPhzOFdbjDLwUQRV802qY1tHdRWC4ESk7NbnC1E=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1B59460227;
        Fri, 24 Aug 2018 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535113607;
        bh=Ix8OtI0E9tcBpxZUwKDtEUcygtVciziIRaJ+LbZkq8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j6K9LVpjLtADoXNPUmMzrMnQYr54A8kSqxa6ptn2+yqFTeocDqIEtACXEBlbYtYnn
         nVdq8iDnwS4/sCruKpbERTIWiKqBM3l9Y/cgF9LnfbllP6h/Bgwg3zVRxHqHmWnC9W
         Skod7gO2ENoq9UdQvWddZMR0mEUh2Qo4R1tTt8Ys=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 17:56:47 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/4] venus: firmware: add no TZ boot and shutdown
 routine
In-Reply-To: <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com>
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-4-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com>
Message-ID: <9e9417cf2fccfed4015f6893045e4f7f@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2018-08-24 13:09, Alexandre Courbot wrote:
> On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia 
> <vgarodia@codeaurora.org> wrote:

[snip]

>> +struct video_firmware {
>> +       struct device *dev;
>> +       struct iommu_domain *iommu_domain;
>> +};
>> +
>>  /**
>>   * struct venus_core - holds core parameters valid for all instances
>>   *
>> @@ -98,6 +103,7 @@ struct venus_caps {
>>   * @dev:               convenience struct device pointer
>>   * @dev_dec:   convenience struct device pointer for decoder device
>>   * @dev_enc:   convenience struct device pointer for encoder device
>> + * @fw:                a struct for venus firmware info
>>   * @no_tz:     a flag that suggests presence of trustzone
>>   * @lock:      a lock for this strucure
>>   * @instances: a list_head of all instances
>> @@ -130,6 +136,7 @@ struct venus_core {
>>         struct device *dev;
>>         struct device *dev_dec;
>>         struct device *dev_enc;
>> +       struct video_firmware fw;
> 
> Since struct video_firmware is only used here I think you can declare
> it inline, i.e.
> 
>     struct {
>         struct device *dev;
>         struct iommu_domain *iommu_domain;
>     } fw;
> 
> This structure is actually a good candidate to hold the firmware
> memory area start address and size.

I can make it inline.
Memory area and size are common parameters populated
locally while loading the firmware with or without tz. Firmware struct 
has
info more specific to firmware device.

[snip]

> 
>> +{
>> +       struct iommu_domain *iommu_dom;
>> +       struct device *dev;
>> +       int ret;
>> +
>> +       dev = core->fw.dev;
>> +       if (!dev)
>> +               return -EPROBE_DEFER;
>> +
>> +       iommu_dom = iommu_domain_alloc(&platform_bus_type);
>> +       if (!iommu_dom) {
>> +               dev_err(dev, "Failed to allocate iommu domain\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       ret = iommu_attach_device(iommu_dom, dev);
>> +       if (ret) {
>> +               dev_err(dev, "could not attach device\n");
>> +               goto err_attach;
>> +       }
> 
> I think like the above belongs more in venus_firmware_init()
> (introduced in patch 4/4) than here. There is no reason to
> detach/reattach the iommu if we stop the firmware.

Consider the case when we want to reload the firmware during error 
recovery.
Boot and shutdown will be needed in such case without the need to 
populate
the firmware device again.

[snip]

>> +static int venus_shutdown_no_tz(struct venus_core *core)
>> +{
>> +       struct iommu_domain *iommu;
>> +       size_t unmapped;
>> +       u32 reg;
>> +       struct device *dev = core->fw.dev;
>> +       void __iomem *base = core->base;
>> +
>> +       /* Assert the reset to ARM9 */
>> +       reg = readl_relaxed(base + WRAPPER_A9SS_SW_RESET);
>> +       reg |= WRAPPER_A9SS_SW_RESET_BIT;
>> +       writel_relaxed(reg, base + WRAPPER_A9SS_SW_RESET);
>> +
>> +       /* Make sure reset is asserted before the mapping is removed 
>> */
>> +       mb();
>> +
>> +       iommu = core->fw.iommu_domain;
>> +
>> +       unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, 
>> VENUS_FW_MEM_SIZE);
>> +       if (unmapped != VENUS_FW_MEM_SIZE)
>> +               dev_err(dev, "failed to unmap firmware\n");
>> +
>> +       iommu_detach_device(iommu, dev);
>> +       iommu_domain_free(iommu);
> 
> Accordingly, this would also be moved into venus_firmware_deinit().

Same explanation here as well.

Thanks,
Vikash
