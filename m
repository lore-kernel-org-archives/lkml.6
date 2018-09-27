Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57782C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C3D21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C3D21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI0Q1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:27:18 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:59932 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726929AbeI0Q1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:27:17 -0400
Received: from [192.168.1.10] ([80.101.105.217])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 5TEtgvMIvgyCD5TEugUsAc; Thu, 27 Sep 2018 12:09:45 +0200
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
References: <20180831152045.9957-1-javierm@redhat.com>
 <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
 <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
 <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
 <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
 <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
 <20180904064605.6prcawieb4ooxtyl@paasikivi.fi.intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5c6944ec-ee1f-8be6-3eff-2c65fd888222@xs4all.nl>
Date:   Thu, 27 Sep 2018 12:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904064605.6prcawieb4ooxtyl@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMYizZfNC/3+JnBXuRWzPpX5ORTqAigwhsuTMkQHjuW0qlShaW/0RfAI6i5LIvturcqJVfD7woUdOXUZ0rHfgAYD/SBXPLmA4SFqo5njsPJCyf4MSJuI
 Km65uu8nqph9Vf/TR84GTcMq4bbl5TmSZpjdcNsD3HWWM7zSF29JpsUHizYwC97G6+uaCiu22Ov6UZrh8FEWe0zpBONTRCxnLkn7bWjQEfUEMxInznLrwwiA
 vitK2XpcDPOpnay2GGuiASKE2H1UXu5lc7UNB3+dfpeFMyqzuFD1AqN0f9TymdSea9JZW4nTxOWuMpchZo8eXXcbGpMKHnkZiMCUgeMqOu/hiYDpeJZ99pPJ
 hh43JhYSO+uQUDbjW9hVuynCCRjzQmCOKYhdsJEuAfExUpKbAEtrLtrlQklViijzTAC9cYIurU4jB4pU2hUhi6tbLm6WvHiIAL4owBid7/yXoXsb30kTwjF8
 ZaX63w6bH445rOmJBpthxOWSoWe4X5XHDhb2Ww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 08:46 AM, Sakari Ailus wrote:
> Hi Javier, Tian Shu,
> 
> On Tue, Sep 04, 2018 at 05:01:56AM +0000, Qiu, Tian Shu wrote:
>> Hi,
>>
>> Raise my point.
>> The case here is that we have multiple sensors connected to CIO2. The sensors work independently. So failure on one sensor should not block the function of the other.
>> That is, we should not rely on that all sensors are ready before allowing user to operate on the ready cameras.
>> Sometimes due to hardware issues or incompleteness, we did met the case that one sensor is not probing properly. And in this case, the current implementation blocks us using the working one.
>> What I can think now to solve this are:
>> 1. Register multiple media devices. One for each sensor path. This will increase media device count.
>> 2. Use .bound callback to create the link and register the subdev node for each sensor. Leave .complete empty.
>>      Not sure if this breaks the rule of media framework. And also have not found an API to register one single subdev node.
> 
> I'd prefer to keep the driver as-is.
> 
> Even if the media device is only created once all the sub-devices are
> around, the devices are still created one by one so there's no way to
> prevent the user space seeing a partially registered media device complex.
> 
> In general that doesn't happen as the sensors are typically registered
> early during system boot.
> 
> Javier is right in asking a way for the user to know whether everything is
> fully initialised. That should be added but I don't think it is in any way
> specific to the cio2 driver.
> 

Today we have no userspace mechanism to deal with partially initialized topologies.
Instead if parts fails to come up we shouldn't register any media device and
instead (once we discover that something is broken) tear everything down.

In fact, video/subdev/media devices shouldn't be registered until everything is
complete.

I know we want to allow for partial bring up as well, and I fully agree with that,
but in that case someone needs to write an RFC with a proposal how userspace should
handle this.

We've discussed this in the past, but I have not seen such an RFC.

So until we add support for partial bringup I think this patch does the right
thing since otherwise this is out-of-spec.

Regards,

	Hans
