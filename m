Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F976C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A8D208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BC6uPyV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A8D208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH0RJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:09:55 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34194 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH0RJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:09:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id r15-v6so9493296uao.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPnz0fgryrSEXTGMu5JB310eOGGV6oxfJCPad3nm3cM=;
        b=BC6uPyV895v4p285ANLmzwub/6N+bkXrdX1EVgX9yR/NmDx7UWFPc6Re9Jj6eKjkfT
         gsnfRMeCtqH1wuRPm8ZC3PDapPv0Ngp3jcT49M56IhnIEo8TY1YZwFZ0xi0pAiyoFaT2
         95ci+BbRVxk84Jy4snI5ukkARqycfoE103syg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPnz0fgryrSEXTGMu5JB310eOGGV6oxfJCPad3nm3cM=;
        b=mqhbXbn3aNUUh3+SSTAO1fMXqWBI2QQyZ/mIDkZyw2RG9xK5SOOlqq4k1gD85SWrv7
         cHre1Z+WFMS8rsFMOyjl0F4VPqv3NmC90nyYdz1KfRCytiEuanfgdA+JsW/Sm2DAgvGO
         joyKiz8bQVhJVXhjE2oh1HCiGU9vcw9iaxmDkVAho5h+hvCqsfyRbxbBLo9KQhWgwiUE
         vtvMnpf4b176cazTl0Gu4GmMnbYXWyVBV3FFiIFDFwzuiMirS779SdIP1arhAtHzilUq
         XTQIpL+p0WoFldl2or9hOf5MkjBNvne4/yFTDC6zdXTirvDzNsLoB4ZeJsMy8uaCQbAL
         Evjg==
X-Gm-Message-State: APzg51A2fFG/3Gix/XkL52aIZXZkmQ6lGp+uRablM/9xupFEMxHN54cY
        /nzigX3uAzvgKP+6CnXBJJnVf8SGseVetdKGw6MyLQ==
X-Google-Smtp-Source: ANB0Vdam45Vliut20r6Ns/B+pZkr77zHnUFtsho3jwJlHXPpYeTP7gGaoGyU/aFCZhwhlnstAlhhYArLrOeI2uc6bdg=
X-Received: by 2002:ab0:49e2:: with SMTP id f31-v6mr8909505uad.117.1535376195475;
 Mon, 27 Aug 2018 06:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws> <20180823233211.GD53155@dtor-ws>
 <20180823233424.GE53155@dtor-ws> <20180824084933.GA29856@jack.zhora.eu>
 <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com> <20180827115145.GA1567@jack.zhora.eu>
In-Reply-To: <20180827115145.GA1567@jack.zhora.eu>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Mon, 27 Aug 2018 06:23:03 -0700
Message-ID: <CAGAzgsqmYWUoCoi=uVr6Ygt+61H+BD-KZYP70vZjk969eRLz2g@mail.gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
To:     andi@etezian.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        johnny.chuang@emc.com.tw,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, joe@perches.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Chen <james.chen@emc.com.tw>, kt.liao@emc.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 4:52 AM Andi Shyti <andi@etezian.org> wrote:
>
> Hi Derek,
>
> next time, could you please avoid using html mails when replying
> to the mailing list? They are not clear.

Sorry, my plain text setting was reset for some reason.

>
> On Fri, Aug 24, 2018 at 04:07:41PM -0700, dbasehore . wrote:
> >
> >
> > On Fri, Aug 24, 2018 at 1:49 AM Andi Shyti <andi@etezian.org> wrote:
> >
> >     Hi Derek,
> >
> >     > > > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
> >     > > > > We only need to wait 10ms instead of 30ms before starting fastboot
> >     or
> >     > > > > sending IAP on the touchscreen. Also, instead of delaying everytime
> >     > > > > sw_reset is called, this delays 10ms in the function that starts
> >     > > > > fastboot. There's also an explicit 20ms delay before sending IAP
> >     when
> >     > > > > updating the firmware, so no additional delay is needed there. This
> >     > > > > change also has the benefit of not delaying when wakeup is enabled
> >     > > > > during suspend. This is because sw_reset is called, yet fastboot
> >     > > > > isn't.
> >
> >     ...
> >
> >     > > > > -       /*
> >     > > > > -        * We should wait at least 10 msec (but no more than 40)
> >     before
> >     > > > > -        * sending fastboot or IAP command to the device.
> >     > > > > -        */
> >     > > > > -       msleep(30);
> >     > > > > -
> >
> >     moving from 30 to 0 is a bit alarming... what does the datasheet
> >     say?
> >
> >
> > We're moving from 30msec to 10msec. We used to do this in an older kernel.
>
> That's not what you are saying in your commit message:

We still delay 10ms before fastboot. That's what this is referring to.
In the change, 3 delays are addressed: fastboot, IAP, and wakeup
enabled. The fastboot delay is changed to 10ms. The IAP delay is
changed to 20ms, and the delay when wakeup is enabled is removed.

>
>   "... This change also has the benefit of not delaying when
>   wakeup is enabled during suspend... "
>
> and indeed, in resume the "elants_i2c_sw_reset()" function would
> be called without any msleep. Or am I missing something? Would
> it be correct based on the datasheet?

I was told it was correct to do this, but I wonder if something can
race if we don't delay? I don't doubt that nothing in the resume
callback needs that delay since we just enable the irq then leave the
function. There might be something like calibration that does need the
msleep after sw_reset. I'll need to check if we only need to delay
after sw reset for just fastboot and IAP (as the code comment
indicated) or for any i2c write.

>
> >
> >
> >
> >     Sometimes delays are implicit in the system where you are testing
> >     the driver, so that without any msleep it might work in your
> >     system but it might not on others.
> >
> >     > +             /*
> >     > +              * We should wait at least 10 msec (but no more than 40)
> >     before
> >     > +              * sending IAP command to the device.
> >     > +              */
> >     >               msleep(20);
> >
> >     I agree though that it's not nice to wait twice here (even though
> >     as Dmitry says it doesn't hurt so much). Wouldn't it make more
> >     sense to remove this msleep instead?
> >     This way...
> >
> >
> > We still need this if the delay is removed from the sw_reset function. We have
> > a total of 20msecs delayed between sw_reset and sending IAP in our old kernel
> > which should be well tested. There seems to be no reason why the delays
> > increased.
>
> Yes, that's what I'm saying, removing this msleep to me looks
> more correct than removing it from sw_reset().
>
> >     > +     /*
> >     > +      * We should wait at least 10 msec (but no more than 40) before
> >     sending
> >     > +      * fastboot command to the device.
> >     > +      */
> >     > +     usleep_range(10 * 1000, 11 * 1000);
> >     > +
> >     >       error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
> >
> >     ... you do not need to add an extra sleep here.
> >
> >
> > I added it here since I removed the 30msec sleep in sw_reset. This prevents us
> > from sleeping on resume when the touch controller is already on for wake up
> > capabilities. This is the same delay that we have in our old 3.8 kernel, so
> > it's pretty well tested and shipped in production.
>
> And here we fall in my first question (and also Dmitry's
> concern), Are we sure we don't need to sleep after resume? Again,
> what does the datasheet say?
>
> I don't know the answer, you might be right, but I need to know
> why you are removing the sleep after resume and why, instead,
> the original developer added it there.
>
> Two more nitpicks on this patch:
>
> 1. by adding the usleep_range() outside from the
> elants_i2c_sw_reset() function, to another developer reading the
> code, might not really look clear why we are waiting. The
> comment you copy pasted does not, indeed, refer that we are
> waiting because a reset has been performed and we need to wait
> for the _reset time_ before sending IAP commands.
>
> 2. this is a matter of taste: to me "10000" looks more clear than
> "10 * 1000", which doesn't add any better readability of the
> number itself.
>
> Thanks,
> Andi
