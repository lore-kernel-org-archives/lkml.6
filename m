Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2E208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NVcTg0lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF2E208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHYCrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:47:11 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45850 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeHYCrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:47:11 -0400
Received: by mail-ua1-f65.google.com with SMTP id q7-v6so5095401uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=90yea7WPdVOjCXaG2iz/AGDnSDQFx55W0Rltsk/U9Fw=;
        b=NVcTg0lzuX4DWmjWf2/PZlKsPlZCAuk10aevnj7bQluv4nXAGl6QgAHT4kdW+eKQ+7
         fVkYhSs7/mci85son1B+6aK99hzlb8H4MEg71r74zHCH0IGir0QgXM11HRKMv2AbMc/8
         V9pLclhnfocKRpcTXZEMgUGHUjhyDDvNdQGvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90yea7WPdVOjCXaG2iz/AGDnSDQFx55W0Rltsk/U9Fw=;
        b=I6elGUs7zq2C9sgvEosVsx6VMUnVFF83UqyWTe847CiUao7qPxLM0d3KC+L4sCOHCk
         h5YicUltvtoPA4RhwERrlTvTM0mMOdiG9VTEqcSyLk6SasGsJ+uEDgLuv6ak7SBGGXD/
         /q89wDw/F/scC4Lo7xCrlsYzvRYouLR09IqA/MujNypDChJ+bJtCR7O1CjvYCs5mRUs3
         ViGslUDtcp82eNFBUbJOhCxzL0s0kXLZKgRmvGf2cSK0HhdfmRZr3hywU5CCpbyo5QSB
         u/7RPA+mw7tT+o51njJ1yMtLqHMIQ5uCbIHnk8lDWgLg040qwmR40hZ4l66OxJiwF2aK
         7a8A==
X-Gm-Message-State: APzg51B8LTPgegU82qVdceKn6nsALzbeFmBSuBTFSaZ3DUCeFUUEzxjT
        kf6nuSk9i8w+F99naHlyzUZY2yyVSFexbpBoU0ULog==
X-Google-Smtp-Source: ANB0VdY8sSuiJqqB/Ow867inmx6EIxDOuO2IJYIx5GxuL4Oba40E4DUZrZlQfLeOg0RRXhvB3BNaDVokaMjpNs4PQA0=
X-Received: by 2002:ab0:1532:: with SMTP id o47-v6mr2298680uae.162.1535152228451;
 Fri, 24 Aug 2018 16:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws> <20180823233211.GD53155@dtor-ws>
 <20180823233424.GE53155@dtor-ws> <20180824084933.GA29856@jack.zhora.eu> <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com>
In-Reply-To: <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Fri, 24 Aug 2018 16:10:17 -0700
Message-ID: <CAGAzgsoxZBxFsy7_yhb_VCDXzsseRr6eU8wuUB91JFYdCSh49A@mail.gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
To:     andi@etezian.org
Cc:     dmitry.torokhov@gmail.com, johnny.chuang@emc.com.tw,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, joe@perches.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        james.chen@emc.com.tw, kt.liao@emc.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:07 PM dbasehore . <dbasehore@chromium.org> wrote:
>
>
>
> On Fri, Aug 24, 2018 at 1:49 AM Andi Shyti <andi@etezian.org> wrote:
>>
>> Hi Derek,
>>
>> > > > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
>> > > > > We only need to wait 10ms instead of 30ms before starting fastbo=
ot or
>> > > > > sending IAP on the touchscreen. Also, instead of delaying everyt=
ime
>> > > > > sw_reset is called, this delays 10ms in the function that starts
>> > > > > fastboot. There's also an explicit 20ms delay before sending IAP=
 when
>> > > > > updating the firmware, so no additional delay is needed there. T=
his
>> > > > > change also has the benefit of not delaying when wakeup is enabl=
ed
>> > > > > during suspend. This is because sw_reset is called, yet fastboot
>> > > > > isn't.
>>
>> ...
>>
>> > > > > -       /*
>> > > > > -        * We should wait at least 10 msec (but no more than 40)=
 before
>> > > > > -        * sending fastboot or IAP command to the device.
>> > > > > -        */
>> > > > > -       msleep(30);
>> > > > > -
>>
>> moving from 30 to 0 is a bit alarming... what does the datasheet
>> say?
>
>
> We're moving from 30msec to 10msec. We used to do this in an older kernel=
.
>
>>
>>
>> Sometimes delays are implicit in the system where you are testing
>> the driver, so that without any msleep it might work in your
>> system but it might not on others.
>>
>> > +             /*
>> > +              * We should wait at least 10 msec (but no more than 40)=
 before
>> > +              * sending IAP command to the device.
>> > +              */
>> >               msleep(20);
>>
>> I agree though that it's not nice to wait twice here (even though
>> as Dmitry says it doesn't hurt so much). Wouldn't it make more
>> sense to remove this msleep instead?
>> This way...
>
>
> We still need this if the delay is removed from the sw_reset function. We=
 have a total of 20msecs delayed between sw_reset and sending IAP in our ol=
d kernel which should be well tested. There seems to be no reason why the d=
elays increased.
>
>>
>>
>> > +     /*
>> > +      * We should wait at least 10 msec (but no more than 40) before =
sending
>> > +      * fastboot command to the device.
>> > +      */
>> > +     usleep_range(10 * 1000, 11 * 1000);
>> > +
>> >       error =3D elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
>>
>> ... you do not need to add an extra sleep here.
>
>
> I added it here since I removed the 30msec sleep in sw_reset. This preven=
ts us from sleeping on resume when the touch controller is already on for w=
ake up capabilities. This is the same delay that we have in our old 3.8 ker=
nel, so it's pretty well tested and shipped in production.
>
>>
>>
>> Andi

Resending since it seems my plain text setting was removed...
