Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01148C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C479B2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C479B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeJDTzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:55:23 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:35058 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbeJDTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:55:22 -0400
Received: from [IPv6:2001:420:44c1:2579:51eb:3c7a:5e3a:802b] ([IPv6:2001:420:44c1:2579:51eb:3c7a:5e3a:802b])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 83GUgDtLi0ZZE83GYgkhIF; Thu, 04 Oct 2018 15:02:09 +0200
Subject: Re: [PATCH v3 2/2] media: platform: Add Aspeed Video Engine driver
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
 <1537903629-14003-3-git-send-email-eajames@linux.ibm.com>
 <a78d4c7a-ac58-c23d-a683-23dce54be993@xs4all.nl>
 <8ca47483-5347-c40d-0d01-4f13e88f8cde@linux.vnet.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d7c82025-5c9a-6a64-75e0-f0d84d149dde@xs4all.nl>
Date:   Thu, 4 Oct 2018 15:02:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8ca47483-5347-c40d-0d01-4f13e88f8cde@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNof8y89VQ636bB96ItiCiLaL+Nl1OyLkYfONLp9YR3DAGnYwZedb6pkzczeKB8Sg2o5NKI24tNNcfgW5DnC+Ms7uvYj5W9CZOjPRDIDfjNlz+1FSF4d
 F8G3fy5607kUjkT9g40ouC3xX+1uQPk5oyhw8eURaDpZoU3kEdbyIbGdCksb5CsaAe7iLg99KhbxxtI6aWCZEGI1qPtu6ApSdvmKu46+w0TS+XHXi5YkRlXB
 gfBd0QMl68cJwCYGMbvP7nmmeB4VCAFD3pwDRTfzBlqo0ZNiVSqnrU5VQrMHLjffh9+BcfNfIDllq/a4cQFrzWe+G9aTUKcnfclIAVM1v3Yo/ONxHYFqPciS
 pE1d4ikWziA5nvd4dhnFMi2l5Na1BZUJhxP4UvnvOrcd0Di7dBEGy/WhS4uCy2m0MtsWfx1RaZZb1ME6rY1rI1Im9lI52Zk4G5E35PM2/cisG9VkEm6OTIAN
 qKlesHp/PYzr8KwEWulIz9AHT9HcfBs/Yis48bFBSIX3l6yETZe+25U5z4C1zkG1qXrh0rUs0TdwwVI0LF0xQloqnLnUAQ50xoRhveAP4Kt6lykYmBxbFOlZ
 ezh3r31baZIy60Mi9UaVg+6ysx67cfyQFRjvglfx37lpcjLAaD34itSG0foSPJ1qn4s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/18 22:26, Eddie James wrote:
> 
> 
> On 09/28/2018 06:30 AM, Hans Verkuil wrote:
>> On 09/25/2018 09:27 PM, Eddie James wrote:
>>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>>> can capture and compress video data from digital or analog sources. With
>>> the Aspeed chip acting a service processor, the Video Engine can capture
>>> the host processor graphics output.
>>>
>>> Add a V4L2 driver to capture video data and compress it to JPEG images.
>>> Make the video frames available through the V4L2 streaming interface.
>>>
>>> +		memcpy(&table[base], aspeed_video_jpeg_dct[i],
>>> +		       sizeof(aspeed_video_jpeg_dct[i]));
>>> +
>>> +		base += ASPEED_VIDEO_JPEG_DCT_SIZE;
>>> +		memcpy(&table[base], aspeed_video_jpeg_quant,
>>> +		       sizeof(aspeed_video_jpeg_quant));
>>> +
>>> +		if (yuv420)
>>> +			table[base + 2] = 0x00220103;
>>> +	}
>>> +}
>>> +
>>> +static void aspeed_video_update(struct aspeed_video *video, u32 reg,
>>> +				unsigned long mask, u32 bits)
>> You probably want to use u32 for the mask.
> 
> Using a u32 there results in:
> 
> warning: large integer implicitly truncated to unsigned type [-Woverflow]
> 
> everywhere I call aspeed_video_update. Not sure what the deal is. Any 
> suggestions?

The BIT and GENMASK macros produce unsigned long values.

I think it is easier if instead of passing a mask (i.e. the bits you want
to keep) you pass the bits you want to clear and replace with new ones.

So 'u32 clear' instead of 'unsigned long mask'.

The problem occurs because e.g. ~BIT(10) expands to an unsigned long with
all bits except for bit 10 set to 1. And passing that to an u32 will obviously
fail.

But just passing BIT(10) is fine since that fits in an u32.

Regards,

	Hans

> 
> Thanks,
> Eddie
> 
>>
>>> +{
>>> +	u32 t = readl(video->base + reg);
>>> +	u32 before = t;
>>> +
>>> +	t &= mask;
>>> +	t |= bits;
>>> +	writel(t, video->base + reg);
>>> +	dev_dbg(video->dev, "update %03x[%08x -> %08x]\n", reg, before,
>>>
>>> +
>>> +module_platform_driver(aspeed_video_driver);
>>> +
>>> +MODULE_DESCRIPTION("ASPEED Video Engine Driver");
>>> +MODULE_AUTHOR("Eddie James");
>>> +MODULE_LICENSE("GPL v2");
>>>
>> Regards,
>>
>> 	Hans
>>
> 

