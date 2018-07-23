Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E65ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DFE20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="CIKbN0t3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjwvVvTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DFE20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbeGWRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:47:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33428 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbeGWRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:47:47 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so1287816qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CGHuju4mhoLAoedxFIDqQaJGgA9DjkBMXizSOSS84Pc=;
        b=CIKbN0t3NZZuy9RtlyyFU1UKr+iGc6NJS3VNDU9pnKCzKlOUtX0mLeT3U/GEf3K3QW
         vsy9xJVVPyF7hYb3SkoEVwKL7tCDQr4+nF4XYhmn7AmyNUIb0SvcGmQRuVZFF6fhWyh7
         lyL0hP9s3N5kTO6NvC0ET/Sdy51LDmwhwLWgo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CGHuju4mhoLAoedxFIDqQaJGgA9DjkBMXizSOSS84Pc=;
        b=TjwvVvTrorzkepUwzTjPHFegkWGd/9fl1jQ43gy/JEBmsS4uMFxe/zwnQwmt1GAMCL
         b6/NbV/u68968/T3vtEfh1GzhCWecqmivau4ysttCrkvRQVK+aH99+bs6Qq6l/0bQGx2
         VDRdorWiQuvqDD0CS1UGAEEGpraVeQC+SUTXBYF9vVv5VG10DrSdXlxiPl2yDbQ2CVTg
         7rWUC/hnj8d8M4Cc2vmT5MQM3tKvsuI3Asn6MiE56I7DTiYaGt9FO56IDgHQtqsibp6x
         44F2FORuHjy6xGheJLIcVY2f2XPeOMkGaU9R4CFoOCQB4+Y2IvtPpL19UOv0qgblr4k4
         a50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CGHuju4mhoLAoedxFIDqQaJGgA9DjkBMXizSOSS84Pc=;
        b=Dm2GIkIv/Z5fwLbCRpMYyx4EteyOHRPNnnQoF7WeSUea5EkJoypFV/iEgBOSAG7tpI
         cX2zj5/d6vyCneOryCgViiksDD9DmBhLz8ZOHZQAG2gRhVbNgYRIAis4//SZT9LOJt5m
         Qd72r8L/a4a8UxlyAhR2Qv3k1miO4208DIE0JvisUDkGw4MIvDmBHFCAP738lO+rQOyW
         DFJRTsi4ZkmnMnjCmqH2hWhwXWRiRnDov72ICmmnHX41i6cMdvgT4a7i81tRrKNJsIBn
         JiY9AGAUV7TvfjKoRaOkpGjM2AzRccnOTy8CmyCCt//Pwv9w0TDbDiTEDF3E84YN3M5U
         5DbQ==
X-Gm-Message-State: AOUpUlGvpGU5VCTsmKt6erjoW2NGOcng2GhbwZVccjkm8QvdMVbPSuuX
        oFk1ZJUQbLNiHEl7t5Ej1jUtIWw8Nmj4IVdiohflxw==
X-Google-Smtp-Source: AAOMgpcU6ca+HBw1B7cicjyvL17rDIThHvELpWKa6dB9dTpRw7rxXZR9EegD1GOU06I8EDlV+EDZJzZmmHzzha8M9xQ=
X-Received: by 2002:aed:35ac:: with SMTP id c41-v6mr13204073qte.267.1532364343324;
 Mon, 23 Jul 2018 09:45:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2edb:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:45:22
 -0700 (PDT)
In-Reply-To: <20180723140801.GA4835@kroah.com>
References: <20180723140220.7166-1-romain.izard.pro@gmail.com> <20180723140801.GA4835@kroah.com>
From:   Romain Izard <romain.izard.pro@gmail.com>
Date:   Mon, 23 Jul 2018 18:45:22 +0200
X-Google-Sender-Auth: X-R0uOtZQeopeDoBIdkrnY2pVjM
Message-ID: <CAGkQfmPbuK7-f=9GcvQPH6mkHXwsaGpjqv40DLgFUJmbOCpbgQ@mail.gmail.com>
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-23 16:08 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Jul 23, 2018 at 04:02:20PM +0200, Romain Izard wrote:
>> Some modems now use the Android Debug Bridge to provide a debugging
>> interface, and some phones can also export serial ports managed by the
>> "option" driver.
>>
>> The ADB daemon running in userspace tries to use USB interfaces with
>> bDeviceClass=0xFF, bDeviceSubClass=0x42, bDeviceProtocol=1
>>
>> Prevent the option driver from binding to those interfaces, as they
>> will not be serial ports.
>>
>> This can fix issues like:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=781256
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> Cc: stable <stable@vger.kernel.org>
>> ---
>>  drivers/usb/serial/option.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> index 664e61f16b6a..f98943a57ff0 100644
>> --- a/drivers/usb/serial/option.c
>> +++ b/drivers/usb/serial/option.c
>> @@ -1987,6 +1987,12 @@ static int option_probe(struct usb_serial *serial,
>>       if (iface_desc->bInterfaceClass == USB_CLASS_MASS_STORAGE)
>>               return -ENODEV;
>>
>> +     /* Do not bind Android Debug Bridge interfaces */
>> +     if (iface_desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
>> +             iface_desc->bInterfaceSubClass == 0x42 &&
>> +             iface_desc->bInterfaceProtocol == 1)
>> +             return -ENODEV;
>
> Shouldn't you also check the vendor/product id as well?  Otherwise this
> has the potential to match random devices that are not really adb
> devices.

The only random devices are those that already match with the option driver,
either with the whole device or the whole reserved class. It reduces the
amount of potentially affected devices.

Among those, I do not expect any of them to use 0xff,0x42,0x01 for a
serial port. But if it occurred, it would be necessary to revert this change as
no userspace hack would allow to rebind the interface.

As this is only an intuition, please discard this patch if you have any doubt
about this.

Best regards,
-- 
Romain Izard
