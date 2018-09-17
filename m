Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA5BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD40214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD40214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIQNdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:33:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43292 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:33:52 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g1oZC-0007Eo-1r
        for linux-kernel@vger.kernel.org; Mon, 17 Sep 2018 08:07:34 +0000
Received: by mail-pl1-f197.google.com with SMTP id g12-v6so7573798plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mh3Noc8E1gwQPDa/UuRCxD+AUUpZR7sVVJkX5vnZaQs=;
        b=a8jHarXkQYV9m+vTWqVN/RCkMOIvr0R4VqqOXBupplS6O9P4sEi1McVNCADonEFqkO
         kYKDhY6CkHsbw01eSAFQpZp9XMeUxpxbjmOQ1WURFWMItSZVNFB/PS3W9269MH3ReE3J
         hDKq3g0rPJR4sJMjk0sZBdrcNPe2Y/JArnJB1r+hhK6jCTwJWOtzTfvrryfejNWOr90A
         Lt3Nmc8iq6vYapz6E7LsHtAXt/4/H+Zi1oI4yW47oKzUguGtGrptdyAD5Y5ct20hJ0B2
         UNcoOMCasWAmSmLlo48U6jLC0UrC+OZ1k2t7phAaOPi87zHj0TSsSC0eufwefhdJ8IFe
         B2jg==
X-Gm-Message-State: APzg51B7LUO0U7eseyF/FJTirrId0/YFrC6G8PpTExwgR/XHRixuKcmI
        SZUiOKaiKdMKhpjTmAq6f/Zn947XuZ+f+1eIszUSd4tuwSQ9GTEP3DM6cwDwY7Vy+FHFXz8PGkg
        gY9wtWPtHUN0RMkvAnqBU8hQfYf1nuj7q1wbBQbNqtw==
X-Received: by 2002:a62:59d5:: with SMTP id k82-v6mr24454964pfj.143.1537171652667;
        Mon, 17 Sep 2018 01:07:32 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdbuUL8oUeRkkaipH/vI9gXqsxJ80HNuhQ+uaJCMDN1jpKH1Kd4XTffqxFNmLL01HqWBWSITXA==
X-Received: by 2002:a62:59d5:: with SMTP id k82-v6mr24454938pfj.143.1537171652301;
        Mon, 17 Sep 2018 01:07:32 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id v140-v6sm18707136pgb.45.2018.09.17.01.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 01:07:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 1/5] misc: rtsx_usb: Use USB remote wakeup signaling for
 card insertion detection
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1809130936350.1990-100000@iolanthe.rowland.org>
Date:   Mon, 17 Sep 2018 16:07:27 +0800
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <481937DD-FB33-4086-B478-32491A01B51A@canonical.com>
References: <Pine.LNX.4.44L0.1809130936350.1990-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 21:41, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 13 Sep 2018, Kai-Heng Feng wrote:
>
>> I am working on the next version of this series, and the last missing
>> puzzle is to differentiate system-wide resume from runtime resume in
>> usb_driver's resume() and reset_resume() callback.
>>
>> The parent device, rtsx_usb, has two child devices, rtsx_usb_ms and
>> rtsx_usb_sdmmc.
>> pm_request_resume() is used in rtsx_usb's resume() to facilitate USB  
>> remote
>> wakeup signaling, so we don't need to poll the card slot status.
>> But this has a side effect: during system resume the rtsx_usb calls
>> pm_request_resume() in its resume(), so child devices calls their
>> runtime_resume() instead of resume() callback.
>
> Have you actually observed this?  It shouldn't happen.
> pm_request_resume() schedules a runtime resume on the PM work queue,
> but this work queue is frozen during system sleep.  It doesn't unfreeze
> until after all the devices have been restored to full power.  Thus the
> child device's resume() callback should be invoked before
> runtime_resume().

You are right, I read the trace wrong.

It happens right before system-wide suspension, when the PM core resumes it  
to fully functional state.

>
>> So, is it reasonable to pass pm_message_t to resume() and reset_resume()
>> callbacks and use PMSG_IS_AUTO() to differentiate them?
>
> It should not be necessary to do this.

Understood, thanks.

Kai-Heng

>
> Alan Stern


