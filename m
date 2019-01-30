Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12653C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF0A207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfA3QBY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:01:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfA3QBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:01:23 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gosIk-0008K9-4o
        for linux-kernel@vger.kernel.org; Wed, 30 Jan 2019 16:01:22 +0000
Received: by mail-pg1-f198.google.com with SMTP id r16so6747pgr.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZTipoSoB8ykd1NY00WZypDMOTW9gdmBfncfdp+2JvVE=;
        b=rJatSpxB3nW8Fk0w1MD6/ujSFdO7vOWSa0/FXyIsl4EfrXk2GUtllaMiCf+4aYSCRT
         HS2VEBX9mjQLERdgZ4ielZMFkk8zRijjJq7oF3n+3U4tOvslCq4sBwRmzx7cG8csXY/x
         d/sC/UBGwV+WHGHr5ANgqwZE86L4zUJTMV+4Tj76SakPYE4R3OVJNv4BLqbRMlNWvnzS
         3J7Ar8RfAHobqSZ/8ouYxzYZ2q/mOPaeDkwpznHMb7Fbgr3nmv0aEJaqe0Gk/zhCna0U
         TUHz7xH4kvLFzOflby11UEgHDahK6w6fBcFVHoe/tk1bYXoEuA99fQII+f9MwjuNljP0
         iMVQ==
X-Gm-Message-State: AJcUukePcRoBhQvLGNspzWEk2U1KB/sORe73SDANdaCC+mBB5IXolUkm
        evY138MCuoIA6wAYW8RdFgc+n5QWfAsjetTjXpAJ4Okpe9fJgaSGfsAxMklBFtcn6/vFyIYALU+
        fCa1t2D1wmxA+0+MTgK3hvhT6BagNOowgUrRZCggc+g==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr31253937pfv.82.1548864080762;
        Wed, 30 Jan 2019 08:01:20 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5tATOIpt4Lw+7GdFz+qRmT0q2s+V+QlLrLOKQ5I9pHA/W66RO8mmaARxIvl/UI61FrD6QCpg==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr31253894pfv.82.1548864080124;
        Wed, 30 Jan 2019 08:01:20 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 84sm2891490pfk.134.2019.01.30.08.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 08:01:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190130082133.GA32660@kroah.com>
Date:   Thu, 31 Jan 2019 00:01:13 +0800
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D84EEC8F-8B65-4B0C-9EA7-E01A0BB47398@canonical.com>
References: <20190124061643.11663-1-kai.heng.feng@canonical.com>
 <20190130082133.GA32660@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2019, at 16:21, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Thu, Jan 24, 2019 at 02:16:43PM +0800, Kai-Heng Feng wrote:
>> The QCA Rome USB Bluetooth controller has several issues once LPM gets
>> enabled:
>> - Fails to get enumerated in coldboot. [1]
>> - Drains more power (~ 0.2W) when the system is in S5. [2]
>> - Disappears after a warmboot. [2]
>> 
>> The issue happens because the device lingers at LPM L1 in S5, so device
>> can't get enumerated even after a reboot.
>> 
>> Disable LPM at shutdown to solve the issue.
>> 
>> [1] https://bugs.launchpad.net/bugs/1757218
>> [2] https://patchwork.kernel.org/patch/10607097/
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2: Use new LPM helpers.
>> 
>> drivers/usb/core/port.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 1a06a4b5fbb1..bbbb35fa639f 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -285,6 +285,14 @@ static int usb_port_runtime_suspend(struct device *dev)
>> }
>> #endif
>> 
>> +static void usb_port_shutdown(struct device *dev)
>> +{
>> +	struct usb_port *port_dev = to_usb_port(dev);
>> +
>> +	if (port_dev->child)
>> +		usb_disable_usb2_hardware_lpm(port_dev->child);
>> +}
>> +
>> static const struct dev_pm_ops usb_port_pm_ops = {
>> #ifdef CONFIG_PM
>> 	.runtime_suspend =	usb_port_runtime_suspend,
>> @@ -301,6 +309,7 @@ struct device_type usb_port_device_type = {
>> static struct device_driver usb_port_driver = {
>> 	.name = "usb",
>> 	.owner = THIS_MODULE,
>> +	.shutdown = usb_port_shutdown,
>> };
> 
> So you now do this for all ports in the system, no matter what is
> plugged in or not.  Are you _SURE_ you want to do that?  It seems like a
> big hammer to solve just one single device's problems.

Yes I think this should be universally applied.

I don’t think the bug only happens to one device. Users won’t find this
unless they connect their laptop to a power meter.

Platform may not completely cut off USB bus power during shutdown,
so the device transits to L1 after system shutdown. Now xHC is disabled
so nothing can bring it back to L0 or L2.

Kai-Heng

> 
> thanks,
> 
> greg k-h

