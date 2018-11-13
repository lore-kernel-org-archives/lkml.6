Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5EA21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="iwaL+Cyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5EA21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbeKNB7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:59:09 -0500
Received: from aer-iport-2.cisco.com ([173.38.203.52]:4047 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeKNB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3807; q=dns/txt; s=iport;
  t=1542124827; x=1543334427;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=r4Wytj6twMLgFxLDTGdV2vcE9c7IRhWeSZS/KAokyj0=;
  b=iwaL+Cyb7uyEj85ZDzzq/QHCLaNTkGwQ0K+FwhSmzNzTHNG+vANraia+
   d+OO5KD7jIxycoPpMDus2EFEPBXBrEJw1hXHuwgrdK45mzrPesOSMbpT8
   WDwZ2vvxtLnJf+088V7p3tGIKQdvrgsdwP2yRQoDlchT9PlWNyIiXVtSd
   s=;
X-IronPort-AV: E=Sophos;i="5.54,499,1534809600"; 
   d="scan'208";a="8017978"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 16:00:26 +0000
Received: from [10.47.79.81] ([10.47.79.81])
        (authenticated bits=0)
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id wADG0P1B025786
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 13 Nov 2018 16:00:25 GMT
Subject: Re: [PATCH 0/5] media: Allwinner A10 CSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <df54f2e6-e207-92de-767a-e356345a1a56@xs4all.nl>
 <20181113135259.onutfjtoi25afnfe@flea>
 <f07a0460-cdba-c1a5-acfd-66a39f447a5a@cisco.com>
 <20181113155227.62jjs3mpomwgr7xd@flea>
From:   Hans Verkuil <hansverk@cisco.com>
Message-ID: <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
Date:   Tue, 13 Nov 2018 17:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181113155227.62jjs3mpomwgr7xd@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-User: hansverk
X-Outbound-SMTP-Client: 10.47.79.81, [10.47.79.81]
X-Outbound-Node: aer-core-1.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 16:52, Maxime Ripard wrote:
> On Tue, Nov 13, 2018 at 03:01:45PM +0100, Hans Verkuil wrote:
>> On 11/13/18 14:52, Maxime Ripard wrote:
>>> Hi Hans,
>>>
>>> On Tue, Nov 13, 2018 at 01:30:49PM +0100, Hans Verkuil wrote:
>>>> On 11/13/18 09:24, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> Here is a series introducing the support for the A10 (and SoCs of the same
>>>>> generation) CMOS Sensor Interface (called CSI, not to be confused with
>>>>> MIPI-CSI, which isn't support by that IP).
>>>>>
>>>>> That interface is pretty straightforward, but the driver has a few issues
>>>>> that I wanted to bring up:
>>>>>
>>>>>   * The only board I've been testing this with has an ov5640 sensor
>>>>>     attached, which doesn't work with the upstream driver. Copying the
>>>>>     Allwinner init sequence works though, and this is how it has been
>>>>>     tested. Testing with a second sensor would allow to see if it's an
>>>>>     issue on the CSI side or the sensor side.
>>>>>   * When starting a capture, the last buffer to capture will fail due to
>>>>>     double buffering being used, and we don't have a next buffer for the
>>>>>     last frame. I'm not sure how to deal with that though. It seems like
>>>>>     some drivers use a scratch buffer in such a case, some don't care, so
>>>>>     I'm not sure which solution should be preferred.
>>>>>   * We don't have support for the ISP at the moment, but this can be added
>>>>>     eventually.
>>>>>
>>>>>   * How to model the CSI module clock isn't really clear to me. It looks
>>>>>     like it goes through the CSI controller and then is muxed to one of the
>>>>>     CSI pin so that it can clock the sensor. I'm not quite sure how to
>>>>>     model it, if it should be a clock, the CSI driver being a clock
>>>>>     provider, or if the sensor should just use the module clock directly.
>>>>>
>>>>> Here is the v4l2-compliance output:
>>>>
>>>> Test v4l2-compliance with the -s option so you test streaming as well.
>>>> Even better is -f where it tests streaming with all available formats.
>>>
>>> I will, thanks for the tip!
>>>
>>>>> v4l2-compliance SHA   : 339d550e92ac15de8668f32d66d16f198137006c
>>>>
>>>> Hmm, I can't find this SHA. Was this built from the main v4l-utils repo?
>>>
>>> It was, but using Buildroot. The version packaged in the latest stable
>>> version I was using (2018.08) is 1.14.2.
>>
>> That's seriously out of date. That's why I show the SHA, to see if
>> someone is testing with a recent version of the utility, so it served
>> its purpose here :-)
>>
>> Latest release is 1.16.2.
>>
>> But when submitting new drivers you really need to build it yourself from
>> the master branch, that's the only way to be sure you have all the latest
>> compliance checks.
> 
> Ack, I'll update it and test again then.
> 
>>>
>>> Looking at the Makefile from v4l2-compliance, it looks like it just
>>> invokes git to retrieve the git commit and uses that as the hash. In
>>> Buildroot's case, since buildroot will download the tarball, this will
>>> end up returning the SHA commit of the buildroot repo building the
>>> sources, not the version of the sources themselves.
>>>
>>> I'm not sure how to address that properly though. Thomas, how do you
>>> usually deal with this?
>>
>> Note that cec-compliance and cec-follower do the same, for the same
>> reason.
>>
>> Where does the tarball come from?
> 
> This is the official tarball from linuxtv:
> https://git.buildroot.net/buildroot/tree/package/libv4l/libv4l.mk?h=2018.08.2#n8

Weird, if I build directly from that tarball, then v4l2-compliance should say:

v4l2-compliance SHA: not available, 64 bits

So that's what I expect to see from buildroot as well.

Regards,

	Hans
