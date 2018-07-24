Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03608C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B776D20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B776D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeGXKJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:09:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56941 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388185AbeGXKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:09:22 -0400
Received: from mail-pl0-f69.google.com ([209.85.160.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fhtEX-0000NM-9t
        for linux-kernel@vger.kernel.org; Tue, 24 Jul 2018 09:03:53 +0000
Received: by mail-pl0-f69.google.com with SMTP id f91-v6so2474318plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=76bKq/Rt4J64OL7sdPRiXAnnXI41XRy++gC9P4TX+HE=;
        b=qIEpGeSwv7fq0tmZiJncZ2ONc9RgehR7B0zS2A+ZP38LeRzFrybUOAU46Tu+lL64FH
         ZY22fhwRgS9+ViV5W2YmBJu70xZfz+Z3mIEflJuIEiF1fktXJOGt7rcUEq6/cLVqQ507
         eQHuBv546Cpoc3vxrHFa0O4yofQJiI8h88/9EQuhEfkmMIaFt7GaliMB18yESOhrMhY4
         ZA+BQG2XhHeiV0ccsvcIZD1Yosz/Wlgj7WqYLxVwzViAhLNtyiyXIZMk0sRgVPM1/QVQ
         jAIJenT/P5E7K1nV/Hzdset0GlgyGH+NlqMOxKHwJo4AxmAoOHp+VB/jsfFvLCGEJ4Np
         hfcg==
X-Gm-Message-State: AOUpUlENNoHFT5PXkY1mdzYusp9+ANZwaQdS6XyO6faElQJiDpW4//wG
        xRB8YRVO37uL54y1w4sEDhlHTDNK0wO4njvywKON2ZsiYqgW0vXO7EQRhQUfZGctODJ7H9NA30M
        /aPNUSY7qFSD01egWlkx22cybfcsXl1h4hHNCfeWqnA==
X-Received: by 2002:a63:f309:: with SMTP id l9-v6mr15191380pgh.369.1532423032019;
        Tue, 24 Jul 2018 02:03:52 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpfglrbXCUL16GtdYM20ahWcdNXsLBeUnxsdLdiZgbQ7OLCV+eAE00T1ry51ZgHQG7/+2Xrghg==
X-Received: by 2002:a63:f309:: with SMTP id l9-v6mr15191367pgh.369.1532423031813;
        Tue, 24 Jul 2018 02:03:51 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15944789pfe.163.2018.07.24.02.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 02:03:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH 1/5] misc: rtsx_usb: Use USB remote wakeup signaling for
 card insertion detection
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1807231018290.1644-100000@iolanthe.rowland.org>
Date:   Tue, 24 Jul 2018 17:03:47 +0800
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DCDB68D2-142C-4A1F-ABE3-6A9741E997E8@canonical.com>
References: <Pine.LNX.4.44L0.1807231018290.1644-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 23, 2018, at 10:19 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 23 Jul 2018, Kai-Heng Feng wrote:
>
>> Although rtsx_usb doesn't support card removal detection, card insertion
>> will resume rtsx_usb by USB remote wakeup signaling.
>>
>> When rtsx_usb gets resumed, also resumes its child devices,
>> rtsx_usb_sdmmc and rtsx_usb_ms, to notify them there's a card in its
>> slot.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/misc/cardreader/rtsx_usb.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/misc/cardreader/rtsx_usb.c  
>> b/drivers/misc/cardreader/rtsx_usb.c
>> index b97903ff1a72..fed83453e5c5 100644
>> --- a/drivers/misc/cardreader/rtsx_usb.c
>> +++ b/drivers/misc/cardreader/rtsx_usb.c
>> @@ -723,8 +723,20 @@ static int rtsx_usb_suspend(struct usb_interface  
>> *intf, pm_message_t message)
>>  	return 0;
>>  }
>>
>> +static int rtsx_usb_resume_child(struct device *dev, void *data)
>> +{
>> +	/* No need to wake up self again */
>> +	if (dev == data)
>> +		return 0;
>
> Is this test actually needed?  device_for_each_child() won't enumerate
> the device it is called for, only that device's children.

Ok, I'll update this part.

>
>> +
>> +	dev_dbg(dev, "%s called\n", __func__);
>
> Not necessary.  People can use ftrace if they want this information.

Sure I'll remove it.
This is to make the change more aligned with the original code. It uses  
similar function on other places too.

Kai-Heng

>
> Alan Stern
>
>> +	pm_request_resume(dev);
>> +	return 0;
>> +}
>> +
>>  static int rtsx_usb_resume(struct usb_interface *intf)
>>  {
>> +	device_for_each_child(&intf->dev, &intf->dev, rtsx_usb_resume_child);
>>  	return 0;
>>  }
>>
>> @@ -734,6 +746,7 @@ static int rtsx_usb_reset_resume(struct  
>> usb_interface *intf)
>>  		(struct rtsx_ucr *)usb_get_intfdata(intf);
>>
>>  	rtsx_usb_reset_chip(ucr);
>> +	device_for_each_child(&intf->dev, &intf->dev, rtsx_usb_resume_child);
>>  	return 0;
>>  }
