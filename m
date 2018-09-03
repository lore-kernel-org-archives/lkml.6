Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B880FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C66620645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C66620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeICUPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:15:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47936 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeICUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:15:30 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fwrBc-0000xH-Pp
        for linux-kernel@vger.kernel.org; Mon, 03 Sep 2018 15:54:44 +0000
Received: by mail-pg1-f198.google.com with SMTP id s77-v6so400540pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 08:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kb6x/z8cCyIo9SSln7DSrQH8f76UuUGnqCEZtWCpjdA=;
        b=L4auD0H5xCnSLK6wQ+J1j3FJpesEn8tSKGUKv8lb64i2E5fsRFpTeUD2LkB8+4Mzk0
         f+bjdmWgEFzFSESBzJHWiFDxTnN05NlB2g9Jw9ZhDlMm2OAUu8VIzCZmHNVRbEgc//qG
         1eeg+gcMd/gujalG/IJ50xL2fTSQFvO4w21leutkJsrq2uzIWxCjkwO2mfF6QDT8Jw1l
         kCJBXg+Ua04INBpYktalcUjsJcHlv0Q2T67OBNoDN05eD28SGqJXVkFuhs0WlhBIQtV2
         W25I3sQ63SkYcdwGRzEEmOXmtMCkgMfcIuQCm9Ckce1M2C62vyoMcCUaamnph15YnJeY
         M87A==
X-Gm-Message-State: APzg51AE1ttl02GV/kybT+yT6CUlUb3IiXhaSQ2G41k3OwOk/VKSdBtL
        IaZ5s7CzY4dX4fBdhq4xp6zprKXNjiMJROFTIK/9Zx28ZX4EOnST7R3jjZqegCdUYaMqFOpL1mD
        /qTMGMI/j7aVLE63RDONe+Tgx1VgVGgJmlJk3iycOXQ==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr29383916plk.133.1535990083466;
        Mon, 03 Sep 2018 08:54:43 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdZvAxu47GUD1qsoBQk1rmOXGehM7WKJ5CTT3/N57/gE6welvx/TojnMEECfiQNkIQDXiwsO9g==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr29383894plk.133.1535990083136;
        Mon, 03 Sep 2018 08:54:43 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z6-v6sm24467247pgr.41.2018.09.03.08.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 08:54:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] HID: i2c-hid: Don't reset device upon system resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJKAiXfvkBKrTDCSZXMFGp0Ygkhq+G2sgT+Qazm7RGx05Q@mail.gmail.com>
Date:   Mon, 3 Sep 2018 23:54:35 +0800
Cc:     Hans de Goede <hdegoede@redhat.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F02B6A3A-2584-452A-9A3F-BEF9DB0083E7@canonical.com>
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
 <20180903090855.14952-1-kai.heng.feng@canonical.com>
 <CAO-hwJKAiXfvkBKrTDCSZXMFGp0Ygkhq+G2sgT+Qazm7RGx05Q@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I forgot to include mailing list, first time -in-reply-to user :)

at 17:39, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> On Mon, Sep 3, 2018 at 11:09 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Raydium touchscreen triggers interrupt storm after system-wide suspend:
>> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
>> report (58/65535)
>>
>> According to Raydium, Windows driver does not reset the device after
>> system resume.
>>
>> The HID over I2C spec does specify a reset should be used at
>> intialization, but it doesn't specify if reset is required for system
>> suspend.
>
> Hmm, that would explain a lot, thanks for digging into this.
>
> Jiri, I think this patch should partially replace
> https://patchwork.kernel.org/patch/10583481/
>
> Kai-heng, if you do not need to re-request the HID descriptors, I
> think it should be good to squash these together to:
> - remove I2C_HID_QUIRK_RESEND_REPORT_DESCR
> - remove the re-request the HID descriptors on resume
> - merge with this patch

There's still one user uses I2C_HID_QUIRK_RESEND_REPORT_DESCR,  
USB_DEVICE_ID_SIS10FB_TOUCH.
So I'd like to have an Ack from Hans first.

I'll send a new patch with your suggestion afterward.

>
>
>
>> Tested this patch on other i2c-hid touchpanels I have and those
>> touchpanels do work after S3 without doing reset. If any regression
>> happens to other touchpanel vendors, we can use quirk for Raydium
>> devices.
>>
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Cc: Aaron Ma <aaron.ma@canonical.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>
>> Benjamin, Hans,
>>
>> I guess some vendors interpret spec this way, so hardware reset is an
>> unexpected request for their devices.
>> Can you give this patch a try?
>
> The only device I have that you should not is the Surface 3. And I am
> not so sure it goes into S3 fluently (it seems to, but I am not 100%
> sure). If you have tested on a Dell XPS 9360, I think there is not
> much more I could test.

At least for the Raydium touchscreen, the issue can be observed under both  
S2Idle and S3.
So I guess Surface 3 is still suitable for test if it can do S2Idle.

I've test this on XPS 9370 and Precision 5520, the patch doesn't break them.

Kai-Heng

>
> Cheers,
> Benjamin
>
>>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index 57126f6837bb..7567034a009f 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -1237,7 +1237,7 @@ static int i2c_hid_resume(struct device *dev)
>>         pm_runtime_enable(dev);
>>
>>         enable_irq(client->irq);
>> -       ret = i2c_hid_hwreset(client);
>> +       ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>>         if (ret)
>>                 return ret;
>>
>> --
>> 2.17.1


