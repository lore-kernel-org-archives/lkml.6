Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF442084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF442084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJDUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:05:55 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:35001 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbeJDUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:05:55 -0400
Received: from [IPv6:2001:420:44c1:2579:51eb:3c7a:5e3a:802b] ([IPv6:2001:420:44c1:2579:51eb:3c7a:5e3a:802b])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 83QggDyed0ZZE83QkgkkAE; Thu, 04 Oct 2018 15:12:39 +0200
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
 <ca4757b9-0825-bbbf-b388-0295fd13bad7@linux.vnet.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <373d2ca3-a6cd-8d87-2bbc-613d65305170@xs4all.nl>
Date:   Thu, 4 Oct 2018 15:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ca4757b9-0825-bbbf-b388-0295fd13bad7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMLEEuRT81+I8ZGDgqnFFsBMKxVPcWnaV8tzS/VTp+swIwemdCPiC0WjNrBog9kg3eEdDBrLUxv1pt3MoyJIrhBRyjSiMBseVccTCcNu31S9xzDGFBXL
 FQYitKeS7zKBoCV22R8SUJZjPs5gFYDbgXD8z6J1eM/2HfpmxrXQonJIC0BT9FxP5QahGllnJ+NAt9qxovqgQ+A1N7g5wtCP+RQaDsikrTO7Ak+6sDNQkYmo
 2zW3170WrrUOCF5iBaFYLErBMpdZ6xDvvZ5ndLWtR4VXkERrZTynXJFe5L1Gr9XFD3b/jB03GRxZqv8xQy0GRo3Rh7iC6EP5+yuiA6P7Izfm3eTQPAtXDe7K
 q845ri2gzpk2bJTM26a3cUjKXfVNeoSMMUeeSBZ13BE89a8SwSS2h1o2O2PhCcLgA7/kUHhGyjziSCtvwy2UlclCljYzIwUv4BrxIvhPm8H2nugCZfNk4v/n
 YQytivzqJJZxByauSrlIfPcSpNM+pZLZIunWoKchXWgw5eKQt86rO6/DFZQt7dCvEjsKJZSvegmeCPWSXXolHxAkDx/8hg5fH1H/qg5vj9VkMZW5u3+nPCRK
 q2BRFY9johOoIiPBKhheTMCT5oEk7Xz25smGsb2BHauy0rOnb2hlJIB42VcghzZXd70=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/18 22:43, Eddie James wrote:
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
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
>>> +	}
>>> +
>>> +	video->height = (bottom - top) + 1;
>>> +	video->width = (right - left) + 1;
>>> +	size = video->height * video->width;
>> It looks like you can actually determine the blanking width/height and
>> possibly even more detailed information that would be very useful to
>> show with the DV_TIMINGS ioctls.
> 
> Hmm. This information is related to the video signal captured from the 
> host. That information has nothing to do with the buffer that is 
> compressed and grabbed by the driver and ultimately provided to 
> userspace. Isn't the timing information meaningless for JPEG frames?

It helps in debugging. Basically you are implementing a receiver for a
video signal. So if for some reason you cannot support the video timings
that the host sends, then it is very useful to have QUERY_DV_TIMINGS report
as much information about the signal as possible.

BTW, out of curiosity, how are the host video signals connected to the
aspeed? Is it still a VGA video signal?

Looking at product briefs it appears that it is VGA. So I guess the aspeed
'sniffs' the VGA signals from the host and can capture the video that way.
Is that correct?

If so, then this driver is a VGA receiver and should act like that.
The host can configure its VGA transmitter to invalid timings, or weird
values, and you need to be able to handle that in your driver.

> Forgot to include this question in my previous reply, sorry for the 
> additional mail.

No problem! Happy to help.

Regards,

	Hans
