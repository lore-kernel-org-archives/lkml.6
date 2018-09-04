Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90744C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D43F20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D43F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDJZW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:25:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:19820 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbeIDJZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:25:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 22:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="70356747"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2018 22:01:59 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 22:01:59 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 22:01:58 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 13:01:56 +0800
From:   "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: RE: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2
 async notifier complete
Thread-Topic: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2
 async notifier complete
Thread-Index: AQHUQT449K1tfdBFQ0WD2/WKLEKJOaTdpeSAgAAC+QCAABSwAIAAAKAAgAHTqBA=
Date:   Tue, 4 Sep 2018 05:01:56 +0000
Message-ID: <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
References: <20180831152045.9957-1-javierm@redhat.com>
 <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
 <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
 <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
 <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
In-Reply-To: <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmE1YWY3Y2ItODJlOS00YmJlLWJmZmEtZDQ1MzBjMWE3NTAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNUlqdklIWW00WlpmbEs5Qk1nQzRtckw0Q3FCM0M0TWhoZ3VJTVlic2RvWDBROWpwY0RqUjcxbkFiYjlkRk9rZSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Raise my point.
The case here is that we have multiple sensors connected to CIO2. The sensors work independently. So failure on one sensor should not block the function of the other.
That is, we should not rely on that all sensors are ready before allowing user to operate on the ready cameras.
Sometimes due to hardware issues or incompleteness, we did met the case that one sensor is not probing properly. And in this case, the current implementation blocks us using the working one.
What I can think now to solve this are:
1. Register multiple media devices. One for each sensor path. This will increase media device count.
2. Use .bound callback to create the link and register the subdev node for each sensor. Leave .complete empty.
     Not sure if this breaks the rule of media framework. And also have not found an API to register one single subdev node.

Thanks
Tianshu Qiu


> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javierm@redhat.com]
> Sent: Monday, September 3, 2018 4:52 PM
> To: Bing Bu Cao <bingbu.cao@linux.intel.com>; linux-kernel@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; Qiu, Tian Shu <tian.shu.qiu@intel.com>; Zheng, Jian Xu
> <jian.xu.zheng@intel.com>; Sakari Ailus <sakari.ailus@linux.intel.com>; Zhi, Yong <yong.zhi@intel.com>; Cao, Bingbu
> <bingbu.cao@intel.com>; linux-media@vger.kernel.org
> Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async notifier complete
> 
> On 09/03/2018 10:49 AM, Bing Bu Cao wrote:
> >
> >
> > On 09/03/2018 03:35 PM, Javier Martinez Canillas wrote:
> >> Hi,
> >>
> >> Thanks a lot your feedback.
> >>
> >> On 09/03/2018 09:25 AM, Bing Bu Cao wrote:
> >>>
> >>> On 08/31/2018 11:20 PM, Javier Martinez Canillas wrote:
> >>>> Commit 9832e155f1ed ("[media] media-device: split media initialization and
> >>>> registration") split the media_device_register() function in two, to avoid
> >>>> a race condition that can happen when the media device node is accessed by
> >>>> userpace before the pending subdevices have been asynchronously registered.
> >>>>
> >>>> But the ipu3-cio2 driver calls the media_device_register() function right
> >>>> after calling media_device_init() which defeats the purpose of having two
> >>>> separate functions.
> >>>>
> >>>> In that case, userspace could have a partial view of the media device if
> >>>> it opened the media device node before all the pending devices have been
> >>>> bound. So instead, only register the media device once all pending v4l2
> >>>> subdevices have been registered.
> >>> Javier, Thanks for your patch.
> >>> IMHO, there are no big differences for registering the cio2 before and after all the subdevices are ready.
> >>> User may see a partial view of media graph but it presents what it really is then.
> >>> It indicate that device is not available currently not it is not there.
> >> I disagree that there are no differences. The media graph shouldn't be exposed
> >> until its complete. That's the reason why we have a v4l2 async notifier .bound
> >> and .complete callbacks (otherwise the .bound would be enough).
> >>
> >> It's also the reason why media register was split in _init and _register, as I
> >> mentioned in the commit message.
> > I revisit the commit 9832e155f1ed and understand and agree that.
> 
> Great. Does this mean the patch has your Reviewed-by / Acked-by ?
> 
> > Seems like there are some other drivers (such as rcar-vin and omap4iss) still have similar issues.
> 
> Yes it seems so. I don't have access to hardware with these IP blocks though,
> I'm hesitant to attempt to fix them.
> 
> Best regards,
> --
> Javier Martinez Canillas
> Software Engineer - Desktop Hardware Enablement
> Red Hat
