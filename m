Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1562BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9336208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9336208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeH1NNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:13:17 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:38516 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbeH1NNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:13:17 -0400
Received: from [IPv6:2001:983:e9a7:1:c424:af2:2099:1a08] ([IPv6:2001:983:e9a7:1:c424:af2:2099:1a08])
        by smtp-cloud7.xs4all.net with ESMTPA
        id uaCifSm3txhiguaCkfDyFW; Tue, 28 Aug 2018 11:22:30 +0200
Subject: Re: [PATCH 3/7] media: imx274: don't hard-code the subdev name to
 DRIVER_NAME
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com
References: <20180824163525.12694-1-luca@lucaceresoli.net>
 <20180824163525.12694-4-luca@lucaceresoli.net>
 <20180825144915.tq7m5jlikwndndzq@valkosipuli.retiisi.org.uk>
 <799f4d1a-b91d-0404-7ef0-965d123319da@lucaceresoli.net>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <113d3e05-9331-bd54-0e49-46c5e132339f@xs4all.nl>
Date:   Tue, 28 Aug 2018 11:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <799f4d1a-b91d-0404-7ef0-965d123319da@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAXAvuYgbxurKza3U3lKGqHNiHyrU9VTMP+LFTHQc9JN1ukpJsLSszDkTSpWHfjOxU/icrEZ2GmCSgZPWT+wWurAIpRRiv00DHzjItgWOyYyCeJ9eAp+
 7P9yUPxxzZs5qu6vlxdVCvFHkeeMgat8G8ec/yrgGg4DVe2g9dfiyHg2JfgG7haaVHGtg1Alhnkd3cHB+Py45CV29jgktLKEHrvclaIe5OOF54rPOmzZ+Y+c
 LKmMgJhoHWHbXTJQbILQCH27Has++Wc6asyzUwJnMF39AnJAObYFHm4oXaJlv6wZW9FY1b+7U+Xw6FB5N8HTK+jCpRS9VRcBZlERI8BJrk7g2vRj84lYZG6m
 HRhbKWp4EwH/JRDGvlBwxA7lWUxkttyGQj4g/NHQcgyAAmyJAb7NGoddA0AqZmVlVKbQeuCjK4YK6+LupZIMHE/nY1fFcOSzyav/flOZTsI0gUakmjDp/tmX
 AQA8XExPCV5rnyHH7dR0hrQtG+z2zPAXexh029A3dQV/uqg6mPfudk6NXR7KNTU7zHHN2kl9IIEQSpjf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/18 22:41, Luca Ceresoli wrote:
> Hi Sakari,
> 
> On 25/08/2018 16:49, Sakari Ailus wrote:
>> Hi Luca,
>>
>> On Fri, Aug 24, 2018 at 06:35:21PM +0200, Luca Ceresoli wrote:
>>> Forcibly setting the subdev name to DRIVER_NAME (i.e. "IMX274") makes
>>> it non-unique and less informative.
>>>
>>> Let the driver use the default name from i2c, e.g. "IMX274 2-001a".
>>>
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>> ---
>>>  drivers/media/i2c/imx274.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
>>> index 9b524de08470..570706695ca7 100644
>>> --- a/drivers/media/i2c/imx274.c
>>> +++ b/drivers/media/i2c/imx274.c
>>> @@ -1885,7 +1885,6 @@ static int imx274_probe(struct i2c_client *client,
>>>  	imx274->client = client;
>>>  	sd = &imx274->sd;
>>>  	v4l2_i2c_subdev_init(sd, client, &imx274_subdev_ops);
>>> -	strlcpy(sd->name, DRIVER_NAME, sizeof(sd->name));
>>>  	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
>>>  
>>>  	/* initialize subdev media pad */
>>
>> This ends up changing the entity as well as the sub-device name which may
>> well break applications.
> 
> Right, unfortunately.
> 
>> On the other hand, you currently can't have more
>> than one of these devices on a media device complex due to the name being
>> specific to a driver, not the device.
>>
>> An option avoiding that would be to let the user choose by e.g. through a
>> Kconfig option would avoid having to address that, but I really hate adding
>> such options.
> 
> I agree adding a Kconfig option just for this would be very annoying.
> However I think the issue affects a few other drivers (sr030pc30.c and
> s5c73m3-core.c apparently), thus maybe one option could serve them all.
> 
>> I wonder what others think. If anyone ever needs to add another on a board
>> so that it ends up being the part of the same media device complex
>> (likely), then changing the name now rather than later would be the least
>> pain. In this case I'd be leaning (slightly) towards accepting the patch
>> and hoping there wouldn't be any fallout... I don't see any board (DT)
>> containing imx274, at least not in the upstream kernel.
> 
> I'll be OK with either decision. Should we keep it as is, then I think a
> comment before that line would be appropriate to clarify it's not
> correct but it is kept for backward userspace compatibility. This would
> help avoid new driver writers doing the same mistake, and prevent other
> people to send another patch like mine.

In this end, this is a driver bug. I would just fix this, but add a comment
that states the old name and why it was changed. No need for a dev_info
IMHO.

It would be nice if you can check if the same mistake is made in other drivers,
and update those as well. It's easier if this is all done at the same time.

Regards,

	Hans
