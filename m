Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED0EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D64208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXYlEh9Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BjrsufzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D64208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeH0QgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:36:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0QgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:36:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01DDB60600; Mon, 27 Aug 2018 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535374171;
        bh=P34mUxrd2An7JXH3tkcxLwW4XhPDwa23B1WDJRoF+HY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXYlEh9YNQASughBTczVDMYFTw4j+pLnKoU5tl64jMuhcU6hycJ/t7XBm5/BZBDbq
         2nGNvv5YGFkIFE3wWbTK/7gUSGP/Mlqud/n3QvWqEBi1lxBAPo0EwQ4l9dPo+fqpmY
         2c6aJvClVl32i+gIzDlAqUTKFWQWimg7sMizFcGs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 03D35601DA;
        Mon, 27 Aug 2018 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535374170;
        bh=P34mUxrd2An7JXH3tkcxLwW4XhPDwa23B1WDJRoF+HY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BjrsufzWWdrME8GyFQfEeA1mbVNqCrs2Q38WbQEMs5SKztCxaDlhq659V3f+oTnVC
         5rcpx+mDM9RDbsS7IYfMVRWTbM/h8rEtMNRKFb8BoRfZNSZ1LyQGTBUYPZOw3jpFj2
         y+b3/MR6CFWUEitLW1cwxo6V4HNGwMHpi9LUFHeY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Aug 2018 18:19:29 +0530
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
        devicetree@vger.kernel.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v6 3/4] venus: firmware: add no TZ boot and shutdown
 routine
In-Reply-To: <CAPBb6MX7EQvXfq_F+8b2FcqROpGY7ud4M6UyttGzoELsw=NJ=Q@mail.gmail.com>
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-4-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com>
 <9e9417cf2fccfed4015f6893045e4f7f@codeaurora.org>
 <CAPBb6MX7EQvXfq_F+8b2FcqROpGY7ud4M6UyttGzoELsw=NJ=Q@mail.gmail.com>
Message-ID: <002138192bcb3f7e6bf55e090d1b5328@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 08:36, Alexandre Courbot wrote:
> On Fri, Aug 24, 2018 at 9:26 PM Vikash Garodia 
> <vgarodia@codeaurora.org> wrote:
>> 
>> Hi Alex,
>> 
>> On 2018-08-24 13:09, Alexandre Courbot wrote:
>> > On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia
>> > <vgarodia@codeaurora.org> wrote:
>> 
>> [snip]
>> 
>> >> +struct video_firmware {
>> >> +       struct device *dev;
>> >> +       struct iommu_domain *iommu_domain;
>> >> +};
>> >> +
>> >>  /**
>> >>   * struct venus_core - holds core parameters valid for all instances
>> >>   *
>> >> @@ -98,6 +103,7 @@ struct venus_caps {
>> >>   * @dev:               convenience struct device pointer
>> >>   * @dev_dec:   convenience struct device pointer for decoder device
>> >>   * @dev_enc:   convenience struct device pointer for encoder device
>> >> + * @fw:                a struct for venus firmware info
>> >>   * @no_tz:     a flag that suggests presence of trustzone
>> >>   * @lock:      a lock for this strucure
>> >>   * @instances: a list_head of all instances
>> >> @@ -130,6 +136,7 @@ struct venus_core {
>> >>         struct device *dev;
>> >>         struct device *dev_dec;
>> >>         struct device *dev_enc;
>> >> +       struct video_firmware fw;
>> >
>> > Since struct video_firmware is only used here I think you can declare
>> > it inline, i.e.
>> >
>> >     struct {
>> >         struct device *dev;
>> >         struct iommu_domain *iommu_domain;
>> >     } fw;
>> >
>> > This structure is actually a good candidate to hold the firmware
>> > memory area start address and size.
>> 
>> I can make it inline.
>> Memory area and size are common parameters populated
>> locally while loading the firmware with or without tz. Firmware struct
>> has
>> info more specific to firmware device.
>> 
>> [snip]
>> 
>> >
>> >> +{
>> >> +       struct iommu_domain *iommu_dom;
>> >> +       struct device *dev;
>> >> +       int ret;
>> >> +
>> >> +       dev = core->fw.dev;
>> >> +       if (!dev)
>> >> +               return -EPROBE_DEFER;
>> >> +
>> >> +       iommu_dom = iommu_domain_alloc(&platform_bus_type);
>> >> +       if (!iommu_dom) {
>> >> +               dev_err(dev, "Failed to allocate iommu domain\n");
>> >> +               return -ENOMEM;
>> >> +       }
>> >> +
>> >> +       ret = iommu_attach_device(iommu_dom, dev);
>> >> +       if (ret) {
>> >> +               dev_err(dev, "could not attach device\n");
>> >> +               goto err_attach;
>> >> +       }
>> >
>> > I think like the above belongs more in venus_firmware_init()
>> > (introduced in patch 4/4) than here. There is no reason to
>> > detach/reattach the iommu if we stop the firmware.
>> 
>> Consider the case when we want to reload the firmware during error
>> recovery.
>> Boot and shutdown will be needed in such case without the need to
>> populate
>> the firmware device again.
> 
> Is there a need to reattach the iommu domain in case of an error?

re-attach is not needed. We can have alloc/attach in init and 
detach/free in deinit.
map/reset and unmap/reset can continue to remain in boot and shutdown 
calls. Let me
know if this is good, i can repatch the series.
