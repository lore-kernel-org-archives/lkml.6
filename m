Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1A7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB8125615
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrpYbqjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB8125615
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeGBNNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:13:21 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33567 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeGBNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:13:17 -0400
Received: by mail-ua0-f196.google.com with SMTP id g18-v6so7295209uak.0;
        Mon, 02 Jul 2018 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n/MqK4k3iB8Vh+iLaFPREgpMP6/ek0YaBkZ83aBZhdY=;
        b=SrpYbqjOJ8o/J40bDtcd2x9dyJCcsYNXLQzNIZADX/KhbvlYZzDpW710WCsoWKX/a/
         YdskpLPAiGAE8RHqdrAFqCllj7NpXZ3cKpsKEdSqK5hedCeqD4nvmlA9dYfWzDBMLKD/
         4sekqCvaQGCLrWvvs4CQDH48cYGorMH3xWRkVkPTQaBZi4YdjXAaebKWYXI1/qADesUV
         g0oTcNMwbWTb2R6wLt5LpmgIAHvdxXUReHcqHr2iR+6O+R12G9FMequdaMB5ZVXPj7ZE
         lRiG3Zv+TIE9d4NJlD/CWzFzdoSAakt7oHSa8rg5ICOPEJ3GxhpgFurhyiCFlt+JNwcA
         0OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n/MqK4k3iB8Vh+iLaFPREgpMP6/ek0YaBkZ83aBZhdY=;
        b=bWh3Tj7n7VAIG4YcEpIDeS/uAEufUZXW4WuUbdDTEQYrosTlyOl3uZ9im1o8XZJ5Go
         tD/EN10TXbh0E3g+ElhcFeUrTRkqNCsEHFsRcmIKv1ySNR+w15ibYIyZ2ZwNS6vJUVvl
         MM600X0HQMo0E/JTasafA7l4iBXLwe4kUv9LF8dXo6r/08vEQg6BCaqmNHoHSggrapVD
         9jF7CMcVvplsOQMJVXJr/fjkLk5eR6HaLUxu+FKLEBo5Kjczg/pK/lhnNdvmIa0jk+co
         xVDhJ9Ee9UfUx+MOc2635bXw92MoClmtqCyOHXJ5HN1oxAvdXgjAg/vlucnMZP8lfUuO
         /qiQ==
X-Gm-Message-State: APt69E2u79MpC387b3FTDC/lao41v2UNodZlkjvlnfcDTPTheAmz4nGy
        qj8ZCj0oQnt0aTjPM+3hC+vNJIv54EZ2wRNAN2o=
X-Google-Smtp-Source: AAOMgpfv7padiuVt6l/N6qkpa45HxhKmnULdgyXeS+98+8giVeUWBhT5sB1rXkw2JViYPzO/ExdaV9G0WFpyBZoyUGg=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr3147771uaf.199.1530537195910;
 Mon, 02 Jul 2018 06:13:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:13:15 -0700 (PDT)
In-Reply-To: <CAFv23Qk_scxPrPMJ6aWhEMqijaS0dJ4LUB73bKfr_UAWqbx3aQ@mail.gmail.com>
References: <20180625002940.117141-1-delco@chromium.org> <CAFv23Qk_scxPrPMJ6aWhEMqijaS0dJ4LUB73bKfr_UAWqbx3aQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 16:13:15 +0300
Message-ID: <CAHp75VeCfqDJgBQwhuOnAUEELpcBLtQRqb3KEbi2-nqsA+K_Xw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-vbtn: Add support for dock mode detection
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Matt Delco <delco@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 9:25 AM, AceLan Kao <acelan.kao@canonical.com> wrote:
> Looks good to me
>

Pushed to my review and testing queue, thanks!

> Reviewed-By: AceLan Kao <acelan.kao@canonical.com>
>
> 2018-06-25 8:29 GMT+08:00 Matt Delco <delco@chromium.org>:
>> The Dell laptop I have has an ACPI that sends 0xCB and 0xCC on entering
>> tablet mode.  On exiting tablet mode it sends 0xCA and 0xCD. Based on:
>>
>> http://www.traby.de/medion/DSDT/dsdt.dsl
>> https://gist.github.com/jprvita/5737de3cbb670e80973b7d4e51c38ab6
>> https://osdn.net/projects/android-x86/scm/git/kernel/commits/
>> 7cbe5a330687b851f32dd9f1048a6ce182d0ff44
>>
>> It appears that 0xCA and 0xCB are about dock mode, which for my
>> convertible laptop seems questionably tied to whether I've put
>> the laptop in tablet or laptop mode.  I previously proposed no-oping
>> 0xCA and 0xCB but this revised change attempts to add support for
>> detecting dock mode--this detection will essentially be broken for
>> my laptop (the main workaround would be for 0xCA and 0xCB to be used
>> to provoke a query of the VGBS method that reports the current dock &
>> tablet mode [which is accurately reported on my laptop but based on
>> the prior workarounds in the driver it apparently can't be trusted
>> for all systems]).
>>
>> Signed-off-by: Matt Delco <delco@chromium.org>
>> Cc: Darren Hart <dvhart@infradead.org>
>> Cc: Andy Shevchenko <andy@infradead.org>
>> Cc: platform-driver-x86@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/platform/x86/intel-vbtn.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
>> index c13780b8dabb..06cd7e818ed5 100644
>> --- a/drivers/platform/x86/intel-vbtn.c
>> +++ b/drivers/platform/x86/intel-vbtn.c
>> @@ -17,6 +17,7 @@
>>
>>  /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
>>  #define TABLET_MODE_FLAG 0x40
>> +#define DOCK_MODE_FLAG   0x80
>>
>>  MODULE_LICENSE("GPL");
>>  MODULE_AUTHOR("AceLan Kao");
>> @@ -38,6 +39,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
>>         { KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },        /* volume-down key release */
>>         { KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },        /* rotate-lock key press */
>>         { KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },        /* rotate-lock key release */
>> +       { KE_SW,     0xCA, { .sw = { SW_DOCK, 1 } } },          /* Docked */
>> +       { KE_SW,     0xCB, { .sw = { SW_DOCK, 0 } } },          /* Undocked */
>>         { KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },   /* Tablet */
>>         { KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },   /* Laptop */
>>         { KE_END },
>> @@ -121,6 +124,8 @@ static void detect_tablet_mode(struct platform_device *device)
>>
>>         m = !(obj->integer.value & TABLET_MODE_FLAG);
>>         input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
>> +       m = (obj->integer.value & DOCK_MODE_FLAG) ? 1 : 0;
>> +       input_report_switch(priv->input_dev, SW_DOCK, m);
>>  out:
>>         kfree(vgbs_output.pointer);
>>  }
>> --
>> 2.18.0.rc2.346.g013aa6912e-goog
>>



-- 
With Best Regards,
Andy Shevchenko
