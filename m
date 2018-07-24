Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CD8205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CD8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbeGXJ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:28:58 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37213 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbeGXJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:28:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so2107622qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 01:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ol5PE3bdZzm+SUyyEOUUcSGUlBOkB5pTp/BEJ8iyNWI=;
        b=BC30fELFbREIxmTKlcByUmulYwyJ3+JJOF6Oyl441cOpyuiIA4XVCHNUQ+1jdjYKPL
         +N7grDP1BR4CQG16v8N2JAqiB7YSGkp+zJgG5SM0AuYALZ3X24If1HjKHy/FSFUC3/db
         VN6+HT4HgdPVvImPNAeabMsxLUzbEZoBNhd6fj7EVgtqb+jvfp5qTOlbtpVUvB3vLa/1
         urxGWD1p/WFbxvtRu9alq3EckiUxLlEmN20V22pxCfch8Lwmtga2I/W1X8snKIMkzl0P
         wxRxuxvrW3sK725y7BIiUpE9m8T8sUNQP+m7pKNdchW+M12WjKYjelt6fNKC1pCN6YM+
         IIHA==
X-Gm-Message-State: AOUpUlFeOQJk1df/Zp8olz2I89RoRMdd9U00EVoY5/CXZ64CoZScuJr1
        rzUjLI6IJzNl9fOEVXwr82haOuGWsXjArUmcOT0NpA==
X-Google-Smtp-Source: AAOMgpdiGUWwZ9DwvZjTVwT3FW6hQvfVGt4HylTUN3pthogLCpVLWGUppa40JK7hf1QINFnquYsrSbY7FKfDsgk3U2k=
X-Received: by 2002:a37:afc5:: with SMTP id y188-v6mr14832324qke.273.1532420618649;
 Tue, 24 Jul 2018 01:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180720215122.23558-1-nick@shmanahar.org> <20180720215122.23558-9-nick@shmanahar.org>
 <20180723223347.GJ100814@dtor-ws>
In-Reply-To: <20180723223347.GJ100814@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 24 Jul 2018 10:23:27 +0200
Message-ID: <CAO-hwJ+BoWdXbH1sbde2+qb_sgFBMarM0156a1VrRSQdhNf3xQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when
 slot is closed
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Nick Dyer <nick@shmanahar.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        l.stach@pengutronix.de, nick.dyer@itdev.co.uk,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:34 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Jul 20, 2018 at 10:51:21PM +0100, Nick Dyer wrote:
> > From: Nick Dyer <nick.dyer@itdev.co.uk>
> >
> > input_mt_report_slot_state() ignores the tool when the slot is closed.
> > Remove the tool type from these function calls, which has caused a bit of
> > confusion.
>
> Hmm, maybe we could introduce MT_TOOL_NONE or MT_TOOL_INACTIVE and get
> rid of the 3rd parameter? It will require a bit of macro trickery for a
> release or 2...

I am not sure what would be the benefit of adding those new tools, if
the input_mt code discards them. Do you want to forward them to the
userspace with the release?
This reminds me the discussion we had recently with the touchscreens
releasing the slots with a MT_TOOL_PALM.

Anyway, better include Peter as he will be using this new MT_TOOL.

Cheers,
Benjamin

>
> >
> > Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index d7023d261458..c31af790ef84 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -838,8 +838,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
> >                * have happened.
> >                */
> >               if (status & MXT_T9_RELEASE) {
> > -                     input_mt_report_slot_state(input_dev,
> > -                                                MT_TOOL_FINGER, 0);
> > +                     input_mt_report_slot_state(input_dev, 0, 0);
> >                       mxt_input_sync(data);
> >               }
> >
> > @@ -855,7 +854,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
> >               input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, area);
> >       } else {
> >               /* Touch no longer active, close out slot */
> > -             input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 0);
> > +             input_mt_report_slot_state(input_dev, 0, 0);
> >       }
> >
> >       data->update_input = true;
> > --
> > 2.17.1
> >
>
> --
> Dmitry
