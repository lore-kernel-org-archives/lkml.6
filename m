Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFF2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16122087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iwoqB4DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16122087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJJLEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:04:34 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51647 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJJLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:04:33 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so6043442itw.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shfsJ7i3VSkUN4dZe1EbuI2jxy0OLrbqukZF1J1Xh94=;
        b=iwoqB4DQzYW/OovsT978Dm+cFvdv1d+Ur+nnnPM9wp9MrvZ9QbWLtIFY9CprGrCozM
         pWHDMikX2WhLeTf698CB3wMu/42LuqhA+Y6OHSr67qefrIumZceuf/apsDHt4dCnn4Ty
         nvE/wYIgipv03YkJd0nFWHeeRZ0b8Wcf1aW+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shfsJ7i3VSkUN4dZe1EbuI2jxy0OLrbqukZF1J1Xh94=;
        b=WAlmYFkSy/IPm510wJBGh+yJa/TXn5T8WGhll8t9LfVbQxeMN3goQVR0ZrjY01aY20
         PcqYDCx2iFzUYRIuX/dvMrsel8TO4gx9lmNvoE6wXpQfnhz9ylEzlDKVFboHzhpovmPH
         OKlO0gT4HiFz5m/vHvimv8zIjOLblrVhck1rbXysKkNdWFE6vHAF3y0gDDHvZB3eGyMW
         FPYFrqDpa4Ja4mN59aa+CG/lgyJLOJICsUqpEvhvliyC6tc1X4mbIsNYfCnFgp8MiXwM
         hvJwuktXkJblU2NWpOiy3WFT4+aarakxZrAy1quOUiMqaGmeSNpkRT2OpaUMgeNOkqe4
         sxCg==
X-Gm-Message-State: ABuFfog3JLM+Hf6vKaAug5RMnrnmANLGLVHVwT0Y5iukZrKjn10pXka4
        ugxdb5V8PoC6MHxIvE0YOZpDD9snwLx4NyRNmzyGSQ==
X-Google-Smtp-Source: ACcGV60T4IaslNSGQtpbZXnncr+ILTn0k6vlOZ/ZbvgaucETphnefaIZbQNbAxrc6qMLDjXu9osds7vtawnhkwIuJdk=
X-Received: by 2002:a02:1182:: with SMTP id 124-v6mr20380087jaf.108.1539143065131;
 Tue, 09 Oct 2018 20:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
 <20180928170818.32124-1-jekarlson@gmail.com> <84a0aba3-0793-1659-c70c-d5ece650f832@collabora.com>
In-Reply-To: <84a0aba3-0793-1659-c70c-d5ece650f832@collabora.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Tue, 9 Oct 2018 20:44:12 -0700
Message-ID: <CANLzEkt4FBZDSTiZqJNkKDFLojMtayVAgusg764nhOcpCDmSOQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event in get_next_event_xfer
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     jekarlson@gmail.com, kernel@esmil.dk,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,
On Wed, Oct 3, 2018 at 4:01 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Emil,
>
> Many thanks to catch this and fix. Some comments below.
>
> You missed to add the v2, please send the next patch with v3 prefix.
>
> On 28/9/18 19:08, Emil Karlson wrote:
> > Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> > be truncated on many chromebooks so that Left and Right keys on Column 12 were
> > always 0. Use ret as memcpy len to fix this.
> >
>
> That's fine
>
> > drivers/platform/chrome/cros_ec_proto.c:509
> > get_next_event_xfer uses ret from cros_ec_cmd_xfer for memcpy for msg->data len
> > drivers/platform/chrome/cros_ec_proto.c:445
> > cros_ec_cmd_xfer gets ret from send_command
> > drivers/platform/chrome/cros_ec_proto.c:93
> > send_command gets ret from bus specific xfer_fn
> > drivers/mfd/cros_ec_spi.c:598
> > cros_ec_cmd_xfer_spi copies len amount to ec_msg->data and returns len as ret
> > drivers/mfd/cros_ec_i2c.c:267
> > cros_ec_cmd_xfer_i2c copies len amount to ec_msg->data and returns len as ret
> >
> > so msg->data length is always the same as ret.
> >
>
> Instead of describe the different calls involved and the returns. I'd explain
> why using ret fixes the issue.
>
> > Fixes: 57e94c8b974d ("mfd: cros-ec: Increase maximum mkbp event size")
> > Signed-off-by: Emil Karlson <jekarlson@gmail.com>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 398393ab5df8..b6fd4838f60f 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -520,7 +520,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> >       ret = cros_ec_cmd_xfer(ec_dev, msg);
> >       if (ret > 0) {
> >               ec_dev->event_size = ret - 1;
> > -             memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> > +             memcpy(&ec_dev->event_data, msg->data, ret);
> >       }
> >
> >       return ret;
> >
>
> After thinking a bit more on this I think that how you fixed this is really
> clear. I was wondering if the downstream solution would be better but as is
> really late and will be good have this as urgent fix for the coming release I am
> happy with it. We can always send follow up patches to sync with the downstream
> version if is preferred.
>
> Neil, can you give us your Tested-by to have the make sure this doesn't break
> with protocol v1, I don't have such hardware.
>
> Benson, will be really good have this merged in this rc. Are you fine with this
> solution?

Yes, I'm fine with it. Let me get this ready and try to get it before
we run out of rcs of 4.19.

>
> BTW, you can add my in next version.
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>



-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
