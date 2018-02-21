Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937332AbeBUOCd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:02:33 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:38321 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933186AbeBUNDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:03:05 -0500
Subject: Re: [PATCH v9 03/11] media: platform: Add Renesas CEU driver
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, magnus.damm@gmail.com,
        geert@glider.be, mchehab@kernel.org, festevam@gmail.com,
        sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com,
        pombredanne@nexb.com, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sh@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519059584-30844-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519059584-30844-4-git-send-email-jacopo+renesas@jmondi.org>
 <024c232f-bd43-42a9-25e7-0fbe71edbcb0@xs4all.nl> <2908261.btsdL5a7UQ@avalon>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <19015eda-c830-f987-92fa-49a407033ada@xs4all.nl>
Date: Wed, 21 Feb 2018 14:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2908261.btsdL5a7UQ@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG0AYon64C6NHIyyrttOOShw81KLWk1WWFRCYx2erJB1Yk2ZMi+GLaCf11UDy7tWm3WI5A4UwKIr9y2vPBA2Br1nQW+KKOrAcXZaHlcFVrzzk2x5E8bw
 COA0HRx8Cs4fWsS0GAz6nUkrKMpDRVYEzAEm8gxFkRDFOiACz0ysPq3HjeW6p010neCbnvsOYGMzjHEVqeDHLvu1ygLboPW0FBxeq3GdqvHteoosPdnX9IFq
 DDtqAFxpAkcdzPwj5sb2BYIHtdYEaC6gqnOjt38siKAI7P+UUi80GxvzYx30jriOe5qMScL3XwbPNMAAWjrlz79jhnzgrxedKdpl5WpNb/o2Yy/PF6I4ZjV3
 iokAekBeCKx8C+AqFUJ9RwfXAi88N+orhXXBrDx3s8u9jlYv1Flzl0nQiIvKebv2+Cg3xTbqV93Ijc3ExIj9ykHroLXiR8L9WC1xL5N+qTN6N1byvhYAqpxl
 J4LQHYM+f/kYFyI/jDPC/1niebLheDyU2tajsV3DOhvcK4Ej7Rx6dFEXsG7hPbcg54VW0hwdEjqsG+bYGL/nuc3Eb83n1H2fbqVmo6SsND2AvxV6tGxTqMq5
 06ef0PM/KLStHLpVnAjYI1p5iRGJRL2RCgS+5/CpTtGDIoI+vm/BhnbPR66OsOBtLOPE6+dr/MmPk0+TPFDlNAZ74M9+aA1pg7wccby5KSAZNeuK6hVlYGBY
 X2H3Q8IG+UW53Ra7uTm/L37VDUzsVGi60cMYO447YlFYJ685WNuvIXgl1A1J2ycvVrn7l8h3moQ5rQovMMWjbbg9Tz0LqE7+QxxmTThlRL9oqZOwpxPKp4QW
 sT7Wxc6Zj/8os+I2iM7xh78745bCS9XctZUqlRriOJetpxciuxFkMydUxMNiG/Wp9ThdLAgInud8X1la9vAzcXMh7dttB6XugCq+NjUrh2Akejseic0qKA79
 I7xlHMoIOFuUBkug9kNIQj6S0q6b27bjs9Vj0sB6wryNoHFa
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/18 13:29, Laurent Pinchart wrote:
> Hi Hans,
> 
> On Wednesday, 21 February 2018 14:03:24 EET Hans Verkuil wrote:
>> On 02/19/18 17:59, Jacopo Mondi wrote:
>>> Add driver for Renesas Capture Engine Unit (CEU).
>>>
>>> The CEU interface supports capturing 'data' (YUV422) and 'images'
>>> (NV[12|21|16|61]).
>>>
>>> This driver aims to replace the soc_camera-based sh_mobile_ceu one.
>>>
>>> Tested with ov7670 camera sensor, providing YUYV_2X8 data on Renesas RZ
>>> platform GR-Peach.
>>>
>>> Tested with ov7725 camera sensor on SH4 platform Migo-R.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> ---
>>>
>>>  drivers/media/platform/Kconfig       |    9 +
>>>  drivers/media/platform/Makefile      |    1 +
>>>  drivers/media/platform/renesas-ceu.c | 1661 +++++++++++++++++++++++++++++
>>>  3 files changed, 1671 insertions(+)
>>>  create mode 100644 drivers/media/platform/renesas-ceu.c
>>
>> <snip>
>>
>>> +static int ceu_s_input(struct file *file, void *priv, unsigned int i)
>>> +{
>>> +	struct ceu_device *ceudev = video_drvdata(file);
>>> +	struct ceu_subdev *ceu_sd_old;
>>> +	int ret;
>>> +
>>> +	if (i >= ceudev->num_sd)
>>> +		return -EINVAL;
>>> +
>>> +	if (vb2_is_streaming(&ceudev->vb2_vq))
>>> +		return -EBUSY;
>>> +
>>> +	if (i == ceudev->sd_index)
>>> +		return 0;
>>> +
>>> +	ceu_sd_old = ceudev->sd;
>>> +	ceudev->sd = &ceudev->subdevs[i];
>>> +
>>> +	/* Make sure we can generate output image formats. */
>>> +	ret = ceu_init_formats(ceudev);
>>
>> Why is this done for every s_input? I would expect that this is done only
>> once for each subdev.
>>
>> I also expect to see a ceu_set_default_fmt() call here. Or that the v4l2_pix
>> is kept in ceu_subdev (i.e. per subdev) instead of a single fmt in cuedev.
>> I think I prefer that over configuring a new default format every time you
>> switch inputs.
> 
> What does userspace expect today ? I don't think we document anywhere that 
> formats are stored per-input in drivers. The VIDIOC_S_INPUT documentation is 
> very vague:
> 
> "To select a video input applications store the number of the desired input in 
> an integer and call the VIDIOC_S_INPUT ioctl with a pointer to this integer. 
> Side effects are possible. For example inputs may support different video 
> standards, so the driver may implicitly switch the current standard. Because 
> of these possible side effects applications must select an input before 
> querying or negotiating any other parameters."
> 
> I understand that as meaning "anything can happen when you switch inputs, so 
> be prepared to reconfigure everything explicitly without assuming any 
> particular parameter to have a sane value".
> 
>> This code will work for two subdevs with exactly the same
>> formats/properties. But switching between e.g. a sensor and a video
>> receiver will leave things in an inconsistent state as far as I can see.
>>
>> E.g. if input 1 is the video receiver then switching to that input and
>> running 'v4l2-ctl -V' will show the sensor format, not the video receiver
>> format.
> 
> I agree that the format should be consistent with the selected input, as 
> calling VIDIOC_S_INPUT immediately followed by a stream start sequence without 
> configuring formats should work (but produce a format that is not known to 
> userspace). My question is whether we should reset to a default format for the 
> newly select input, or switch back to the previously set format. I'd tend to 
> go for the former to keep as little state as possible, but I'm open to 
> counter-proposals.

What to do is up to the driver. My personal preference is to make it persistent
per input, but that's just me. I won't block the other approach (resetting it
to a default). Be aware that for video receivers the format depends on the current
selected standard as well. I think the code does that correctly already, but it
would be good to verify if possible.

BTW, I think it is right that the spec isn't specific about what changes when
you switch inputs. It can be quite complex for drivers to handle this and it
is not unreasonable in my view for userspace to just assume it needs to configure
from scratch after switching inputs.

Regards,

	Hans

> 
>>> +	if (ret) {
>>> +		ceudev->sd = ceu_sd_old;
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/* now that we're sure we can use the sensor, power off the old one. */
>>> +	v4l2_subdev_call(ceu_sd_old->v4l2_sd, core, s_power, 0);
>>> +	v4l2_subdev_call(ceudev->sd->v4l2_sd, core, s_power, 1);
>>> +
>>> +	ceudev->sd_index = i;
>>> +
>>> +	return 0;
>>> +}
>>
>> The remainder of this driver looks good.
> 
