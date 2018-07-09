Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8547D2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sz/GxxFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8547D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeGIIwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:52:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39877 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeGIIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:52:45 -0400
Received: by mail-io0-f195.google.com with SMTP id e13-v6so16344901iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7hJIXj84zquagfiuH1c2XYw3nzwK8sMh1oilvJyO37E=;
        b=Sz/GxxFGQ0v6FHvGe/mLhebDFUviKqwF3kwDTIx8IDSvW6m4Zd5ZbYGGRoiElyegk+
         bRIZv9IWQMIQrFQ3Ob3/AVF8UARoW4VOUBxQskiwWG0lSu6xo4EYcwXLp8ixWK9XLguE
         wvnfBBSu1Jq9kCaVhdxTfE+hojRG6jr9G3X8OxFAOOiaoA4l9355VRSxetCyx+cMNq2S
         cWtlg17gyW1fqqUBikvGF1U3cWdm8MSHkIZp/dj8IS/DLl1pT2ilI1q6re1dZtOp4fbQ
         JB5J0v2oOSX6pl6BkjauHNfJqp8eis3NPPFEJqNZDAuypOX8Ls9B06nmBZG6iOm1hyJ7
         EMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7hJIXj84zquagfiuH1c2XYw3nzwK8sMh1oilvJyO37E=;
        b=FXaeOoN4A7q4EIkaiEVzaeFjt4pmvzezLPXhFBG98Ky24nV4MdhVrxXc3mpGx/Q7eM
         HX4ctSUSxmd7Hli/kUQOVuJYLW0KzzAFITLdfrdhkJGVkNF8Bf62ntT6xEmK6VhHuAXs
         vNAqB4e3W12S8O/dDEpv3DVthuHMmCo20XikMutQicZ7EvW6qLWroeOv03BtmJ74aT0q
         q0khQVfzWysLb1yZb6HFG/pZy/Ukz61gmaxsbhHlp0geEs9Wy+p4Og6e0Mcor6Gk8kiq
         AgBguFszBB0OYyu8uSCiKoklRqXUSCiFZoP4ntySzomSJwUnS0jPVgVpgktLLusMQr/A
         pNxw==
X-Gm-Message-State: AOUpUlER/+dCJRHHe0LCGIXPPlkst8rEOVrJd84iI/0UBr2Og/U5GelS
        0vXb6xNOLqqWSeJ/No+1NTcvpm8q8zkdSk8oEpmQtA==
X-Google-Smtp-Source: AAOMgpdTC9/W5sBk4JV8KxeT3L263VXcxlR+R3Zd8e88ECx36oVMQJFMNTtgOZUOH/T4w1jVeqHWeXxUUrQgyIi7OYs=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr15941050ioj.258.1531126364857;
 Mon, 09 Jul 2018 01:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 01:52:44 -0700 (PDT)
In-Reply-To: <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com> <20180705212204.GA10449@rob-hp-laptop>
 <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain> <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Jul 2018 10:52:44 +0200
Message-ID: <CAMRc=Mc4s6tJw6dAHYCPQdsPox9V8sBTqY3LHi5XMWALwOZdyA@mail.gmail.com>
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

2018-07-09 5:12 GMT+02:00 Chiang, AlanX <alanx.chiang@intel.com>:
> Hi Robert,
>
>> -----Original Message-----
>> From: Robert P. J. Day [mailto:rpjday@crashcourse.ca]
>> Sent: Friday, July 6, 2018 4:24 AM
>> To: Rob Herring <robh@kernel.org>
>> Cc: Chiang, AlanX <alanx.chiang@intel.com>; linux-i2c@vger.kernel.org; Yeh,
>> Andy <andy.yeh@intel.com>; sakari.ailus@linux.intel.com;
>> andriy.shevchenko@linux.intel.com; Shevchenko, Andriy
>> <andriy.shevchenko@intel.com>; Mani, Rajmohan
>> <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com;
>> tfiga@chromium.org; jcliang@chromium.org; brgl@bgdev.pl;
>> mark.rutland@arm.com; arnd@arndb.de; gregkh@linuxfoundation.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
>> property
>>
>> On Thu, 5 Jul 2018, Rob Herring wrote:
>>
>> > On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
>> > > From: Alan Chiang <alanx.chiang@intel.com>
>> > >
>> > > The AT24 series chips use 8-bit address by default. If some chips
>> > > would like to support more than 8 bits, the at24 driver should be
>> > > added the compatible field for specfic chips.
>> > >
>> > > Provide a flexible way to determine the addressing bits through
>> > > address-width in this patch.
>> > >
>> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
>> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
>> > > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> > >
>> > > ---
>> > > since v1:
>> > > -- Remove the address-width field in the example.
>> > > since v2:
>> > > -- Remove redundant space.
>> > > since v3:
>> > > -- Add Acked-by.
>> > >
>> > > ---
>> > >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> >
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>>
>>   "... should be added the compatible field ..."??
>>
>> rday
>
> Maybe I should modify the sentence as below that makes it clear.
> "The compatible field should be added in the at24.c for specific chips.".
>
> I quote Andy's words in patch v2:
> "The current at24 driver has no address width support, thus, reusing same
> (allocated) IDs (non-DT case) is hard."
>
> This is the reason that I submitted the patch.
>
> Thanks
>

Make it something like:

Currently the only way to use a variant of a supported model with
a different address width is to define a new compatible string and the
corresponding chip data structure.

Provide a flexible way to specify the size of the address pointer by
defining a new property: address-width.

Best regards,
Bartosz Golaszewski

>>
>> --
>>
>> ==========================================================
>> ==============
>> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>>                   http://crashcourse.ca/dokuwiki
>>
>> Twitter:                                       http://twitter.com/rpjday
>> LinkedIn:                               http://ca.linkedin.com/in/rpjday
>> ==========================================================
>> ==============
