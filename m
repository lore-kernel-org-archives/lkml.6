Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC82A20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mDp5iCFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC82A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeGQIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:32:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45970 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbeGQIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:32:39 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so153735ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EbKbS9MsnOFZS0QcZojJdV1wGWqENjJLsIMfwPBHDqo=;
        b=mDp5iCFGItPuIMuSHAPIbCG15A3E1SwaDR/0bDT5/2sFs6Gj1KH+iYsYSpKengEK+M
         7VnbD1Ypa3btlUgICHSZ7yPaBA7sSsn/qsPSND3JaY24cm4Vjx9fKg9CQlDx0aCDccyV
         GQ00aEhniGvzVCnNZ+1I0kJhHbzSRyoQSXi0GWYmxO0Z1e8f37ELbWl1H1nN2cYO4KJa
         nneSehtt/4/jpaQ1JGamB498r6osgVYTlN35s2GdiWPVxFC8BnKsV+Erw4xL2csOz30e
         8sc3uJ8VwUee0Q46wLOORrfGc7fA7i2Vvs1etdsWHqGAsappTYd0Ch0PLoSlIy3mSJsI
         Qbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EbKbS9MsnOFZS0QcZojJdV1wGWqENjJLsIMfwPBHDqo=;
        b=Uj7767hdra/DqpmphQJ6JoRiOpghGqlCx4a/tMpsSGMcCspA0+yZgqqTRjav+7hg49
         QXm1S/mHSyXaFbGuhKwhlyGKE4tY8K9VFcGSc4HKWhQgqpw3joXFOyeCx9wpEj9LRi7A
         mCphzHxvQIc8WFEW4/qxvrVbj38HHx6X2Xx8VGpt+fJdAKhKoplxEVwzV5RohQYff5LK
         oAkLoBQVSPsevfwT7vdnwByRcgRh9HzL4TZmAc7D6hXwGPTGOqxrAqyrst59wydnbuPO
         PkC1QfNE8R1gCmtsJLCouzxis3D+EatBupS7eGA7IQWSaKJevtgdnGM5h30wry2+5acm
         d/CQ==
X-Gm-Message-State: AOUpUlH/pURHfp2xCe3m0ijx2fjx7FabdNKdeOxnGs6RTDK4eM/4PJn7
        q15KNhr/jN8lFs1yIcw70jZ02BSKWSiML9ltuHyI3g==
X-Google-Smtp-Source: AAOMgpeTFz/GPZNV8kjmwjVykNgvCKD4PyucBBe6TXHLO8VyMFhNhlVOkcnrbEQ/ZMgj5+AFoRSNSQsgr3KHeDCsibk=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr459088ioj.258.1531814477945;
 Tue, 17 Jul 2018 01:01:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 01:01:17
 -0700 (PDT)
In-Reply-To: <CAMRc=Mc4s6tJw6dAHYCPQdsPox9V8sBTqY3LHi5XMWALwOZdyA@mail.gmail.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com> <20180705212204.GA10449@rob-hp-laptop>
 <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
 <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com> <CAMRc=Mc4s6tJw6dAHYCPQdsPox9V8sBTqY3LHi5XMWALwOZdyA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Jul 2018 10:01:17 +0200
Message-ID: <CAMRc=MfNa0OwMbJ6ibbCJJD0pV9tKtyTZ3cQi34ra5oc_-5jYw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width property
To:     "Chiang, AlanX" <alanx.chiang@intel.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Rob Herring <robh@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "jcliang@chromium.org" <jcliang@chromium.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-09 10:52 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2018-07-09 5:12 GMT+02:00 Chiang, AlanX <alanx.chiang@intel.com>:
>> Hi Robert,
>>
>>> -----Original Message-----
>>> From: Robert P. J. Day [mailto:rpjday@crashcourse.ca]
>>> Sent: Friday, July 6, 2018 4:24 AM
>>> To: Rob Herring <robh@kernel.org>
>>> Cc: Chiang, AlanX <alanx.chiang@intel.com>; linux-i2c@vger.kernel.org; Yeh,
>>> Andy <andy.yeh@intel.com>; sakari.ailus@linux.intel.com;
>>> andriy.shevchenko@linux.intel.com; Shevchenko, Andriy
>>> <andriy.shevchenko@intel.com>; Mani, Rajmohan
>>> <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com;
>>> tfiga@chromium.org; jcliang@chromium.org; brgl@bgdev.pl;
>>> mark.rutland@arm.com; arnd@arndb.de; gregkh@linuxfoundation.org;
>>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>>> Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
>>> property
>>>
>>> On Thu, 5 Jul 2018, Rob Herring wrote:
>>>
>>> > On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
>>> > > From: Alan Chiang <alanx.chiang@intel.com>
>>> > >
>>> > > The AT24 series chips use 8-bit address by default. If some chips
>>> > > would like to support more than 8 bits, the at24 driver should be
>>> > > added the compatible field for specfic chips.
>>> > >
>>> > > Provide a flexible way to determine the addressing bits through
>>> > > address-width in this patch.
>>> > >
>>> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
>>> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
>>> > > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> > >
>>> > > ---
>>> > > since v1:
>>> > > -- Remove the address-width field in the example.
>>> > > since v2:
>>> > > -- Remove redundant space.
>>> > > since v3:
>>> > > -- Add Acked-by.
>>> > >
>>> > > ---
>>> > >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>>> > >  1 file changed, 2 insertions(+)
>>> >
>>> > Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>>   "... should be added the compatible field ..."??
>>>
>>> rday
>>
>> Maybe I should modify the sentence as below that makes it clear.
>> "The compatible field should be added in the at24.c for specific chips.".
>>
>> I quote Andy's words in patch v2:
>> "The current at24 driver has no address width support, thus, reusing same
>> (allocated) IDs (non-DT case) is hard."
>>
>> This is the reason that I submitted the patch.
>>
>> Thanks
>>
>
> Make it something like:
>
> Currently the only way to use a variant of a supported model with
> a different address width is to define a new compatible string and the
> corresponding chip data structure.
>
> Provide a flexible way to specify the size of the address pointer by
> defining a new property: address-width.
>
> Best regards,
> Bartosz Golaszewski
>
>>>
>>> --
>>>
>>> ==========================================================
>>> ==============
>>> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>>>                   http://crashcourse.ca/dokuwiki
>>>
>>> Twitter:                                       http://twitter.com/rpjday
>>> LinkedIn:                               http://ca.linkedin.com/in/rpjday
>>> ==========================================================
>>> ==============

Hi,

I will soon be sending my pull request to Wolfram, so if you still
want that applied for 4.19 - please resend with the commit message
fixed.

Thanks,
Bart
