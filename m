Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C9B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5xc26WY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfBTTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:52:19 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54766 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:52:19 -0500
Received: by mail-it1-f193.google.com with SMTP id f10so18273935ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BxRN1w5KBrDLff4fhPcjMLaq71ZFlS4sz1Lvgzj/SQ=;
        b=I5xc26WYy8/3Zfmp9T/M98YqLRkidiyuMJAcE+6z9Z+xAeT4UgY8gEyL26TnxjKG/3
         uscNOyM3EAHauddaef2H2GQzsaJfrWUaJAUvjD85VDnjbqTX9ZkYp5sya512RE20piYt
         j+SiuC/nJgsFMBMAqxpVSpeMjXGj3pxMWRoj1aX45rL7plhKYktWY2IiEvAncWK5QdcL
         /JeICfTy4HcYtSDgr3huHOTuvvOgFzEGcQfzSdLcnv2JBD1foBqzyBZtOxn8wOo+ETy6
         6n+8ztGqX54pi1qVPbHhDyGyXWsOnQ65/s5suP3/CFKgkI5s78AJ9e7iICUG87CtZCLe
         r5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BxRN1w5KBrDLff4fhPcjMLaq71ZFlS4sz1Lvgzj/SQ=;
        b=WqwbUe0iZxo3ZjUYf3qVwj31ziygLMrOzqn003wz7bPRH0omjhtYbDVmJ6ulPoWIqt
         b6XiouZbYT5rr8TmxjkBEWAv3EFeXYzuRObQzY9/YN4wM6PFHpnQUOZq586c+3V182rK
         FoCxR3fekG70RoB/TkvRhYrkgzKffBPEENRpt2LTEoXL+2KluUo8VdNAeNcH3NA7Vc+0
         liVKmemcl82C0veQkXX/urr1Qg5wc5IEWXN/1rDGHlVlRZ4rGioSzJOyrasgcLQIa92w
         5wR51HXW82fjx/7FLD+zD2H5wqFREMbIKQXCYcl5ZiexA8G2IxKY2pyre+2CzBJZBdVf
         spxA==
X-Gm-Message-State: AHQUAuarZ+HIHmrT69w6HPGRIEZWQ6TclDmHd8dSJJYHhAAtrotbp+Lf
        Ops+DEyJMD9+ubWNUaE//h4HJs3wVRrE4H2kGMo=
X-Google-Smtp-Source: AHgI3IZi60NsuhaMCIJLsnlVt/WAaqaVv1urC2JmSMkvrSyoywbeuqIq8XTVf/COIvNw875Ol+T7PMaOupnKUSQkuTg=
X-Received: by 2002:a02:3c07:: with SMTP id m7mr1650349jaa.26.1550692337655;
 Wed, 20 Feb 2019 11:52:17 -0800 (PST)
MIME-Version: 1.0
References: <1550669914-10704-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190220150753.GB17103@kroah.com>
In-Reply-To: <20190220150753.GB17103@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 20 Feb 2019 11:52:05 -0800
Message-ID: <CAKdAkRSjZB5MJ=vPwDTUouTTYF5Gu1d7iWjzdOzd+w5HJ=1CFQ@mail.gmail.com>
Subject: Re: [PATCH] kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Kay Sievers <kay@vrfy.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 7:07 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 20, 2019 at 10:38:34PM +0900, Tetsuo Handa wrote:
> > syzbot is hitting use-after-free bug in uinput module [1]. This is because
> > kobject_uevent(KOBJ_REMOVE) is called again due to commit 0f4dafc0563c6c49
> > ("Kobject: auto-cleanup on final unref") after memory allocation fault
> > injection made kobject_uevent(KOBJ_REMOVE) from device_del() from
> > input_unregister_device() fail, while uinput_destroy_device() is expecting
> > that kobject_uevent(KOBJ_REMOVE) is not called after device_del() from
> > input_unregister_device() completed. Fix this problem by marking "remove"
> > event done regardless of result.
> >
> > [1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d
> >
> > Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
> > Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Kay Sievers <kay@vrfy.org>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  lib/kobject_uevent.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index f058026..7ec4165 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -466,6 +466,13 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
> >       int i = 0;
> >       int retval = 0;
> >
> > +     /*
> > +      * Mark "remove" event done regardless of result, for some subsystems
> > +      * do not want to re-trigger "remove" event via automatic cleanup.
> > +      */
> > +     if (action == KOBJ_REMOVE && kobj->state_add_uevent_sent)
> > +             kobj->state_remove_uevent_sent = 1;
> > +
> >       pr_debug("kobject: '%s' (%p): %s\n",
> >                kobject_name(kobj), kobj, __func__);
>
> If you really want to do this, put it below the debugging line.
>
> But I would argue that this is not ok, as the remove uevent did NOT get
> sent, and you are saying it did.

"It is the thought that counts" here. The code was added to catch
cases where nobody even attempted to send "remove" uevents. It does
not guarantee that an event will ultimately be sent (we are at the
point of no return as far as the rest of the kernel is concerned,
there are no repeats or do-overs).

>
> What memory is being used-after-free here when we fail to properly send
> a uevent?  Shouldn't we fix up that problem correctly?

This is the correct fix (in spirit, we may argue about whether it is
valid to call the flag "state_add_uevent_sent" now or we should or
collapse both it and "state_add_uevent_sent" into
"need_send_remove_uevent"). Other subsystems are in their own right to
not expect to get uvent callbacks past the point of calling
device_del() as they are tearing down parts of the device environment
(even though the device structure may stay in memory for a while).

Thanks.

-- 
Dmitry
