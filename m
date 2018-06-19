Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE75120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOAywvh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE75120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966571AbeFSNqc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:46:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35428 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966111AbeFSNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:46:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so30245231lfc.2;
        Tue, 19 Jun 2018 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8hCdK/cIBgzKCA8ImsFegwYA52ZYYjh4Mth4AGiafo=;
        b=KOAywvh+Pq8IiuER9++IKT0Y2vK0ZqSVgfvf64jRU3pgR9XIzzazqO321D6k78D0EV
         qkZswv7yfqfoxTU/xLaHYlgkXcFKIr1OQWHGaCHxjJnUSd5gLScOpOyw01y9SPvEjnPq
         c0SWDbbJ1z+UXc/t12pLPKMpH7hugsTFMBP02d2CQ3TciHrABuf5j3yPRMC2MKa6UyBd
         JKOQewnm+5pCf4s673Rve3NtCiupEQRsedM5CdoKvRQkOwXem7SAN9p+Vtj3pXzsKslR
         u8Y9sXMQ1zyFR6kfpXhVOC8kxUNoHOereX+Aj83nXyGriavxp51ju3nuxrLyau5ML5U0
         cXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8hCdK/cIBgzKCA8ImsFegwYA52ZYYjh4Mth4AGiafo=;
        b=QpU/4XHrbNDAOnBCqcIx+NNvhiCOIqO+KHk5aLqs32+5A4nGoopkiruCcH1MvmG9a1
         wir4lx0NV1fj+1Aoouvboz4zn6PDegpGf7PTUfQFP3wJpISPWl2iJro297K8453nkl1l
         rBfUTbz8rwfvJUUri74dzkV7mv9Z/wcJriwdMex5i0Sknm6ttt2O+6kUaiXuU0HSoWKR
         KYokV8a/0MQYOPS2Bnh7V3W/hDeIOcd4tmP7GHpYo6Kg+cO8l3x14Up8MDtYvHusCtLw
         9/fm9LwROUThKQSiK9nXkl/ej7+uuiX+KCDsAJOkE3vEaRD19+qP1jEDlUgNmxt8wBOl
         PsZw==
X-Gm-Message-State: APt69E1bL2/d/PVPYshW/x8G8ZfGNczF5CPV9GYpGdBdI4pdghDqAPhM
        bYpZ2ldj3ErkyIN0pSwhgDzIq+UkFVLmpYLEi2Q=
X-Google-Smtp-Source: ADUXVKI2akSRlquGCtT+6udrHsF2BU2hyYVzxyUFNhztP4K+i9vr0ATNfENA/NGB+L5YGTmJehB7zGhkK3+VTbvcw3c=
X-Received: by 2002:a2e:8590:: with SMTP id b16-v6mr10815425lji.131.1529415980929;
 Tue, 19 Jun 2018 06:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180612070906.5305-1-aaron.ma@canonical.com> <CAN+gG=EDc8WsC3MjbY1VnYyo7G1ZBUboM2_T-Zd8r322dOvwTA@mail.gmail.com>
 <32d6c8c8-7662-3ab4-ca92-2357ca668f4b@canonical.com>
In-Reply-To: <32d6c8c8-7662-3ab4-ca92-2357ca668f4b@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date:   Tue, 19 Jun 2018 15:46:09 +0200
Message-ID: <CAN+gG=Fn5bpnWYMJGprAB0-8WoH8ju-5MoiqVHiaO9QMyhpjnQ@mail.gmail.com>
Subject: Re: [PATCH] Input: elan: enable middle button of touchpads on
 ThinkPad P52
To:     aaron.ma@canonical.com
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:13 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> On 06/19/2018 08:21 PM, Benjamin Tissoires wrote:
> > On Tue, Jun 12, 2018 at 9:10 AM Aaron Ma <aaron.ma@canonical.com> wrote:
> >> PNPID is better way to identify the type of touchpads.
> >> Enable middle button support on 2 types of touchpads on Lenovo P52.
> >>
> >> Cc: stable@vger.kernel.org
> >> Cc: KT Liao <kt.liao@emc.com.tw>
> >> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> >> ---
> >>  drivers/input/mouse/elantech.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> > Looks good to me:
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Aaron, our internal tests show that the P52 shows a lot of lost
> > synchronization in pre-v4.18 kernels. Do you have a fix for that too?
> >
>
> https://lkml.org/lkml/2018/5/28/694
> should fix the sync issue.

Thanks for the pointer :)
I have missed that one.

>
>
> > In v4.18 we need to fix the elan_i2c module as right now the touchpad
> > is muted when booted with such a kernel.
>
> Does this touchpad support elan_i2c?

Yes it does. And starting from v4.18 the touchpad will switch to
elan_i2c by default. However, I'll have to provide some fixes as some
elan_i2c commands are not working :(

Cheers,
Benjamin

>
> Regards,
> Aaron
>
> >
> > Cheers,
> > Benjamin
> >
> >> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> >> index fb4d902c4403..67b061dd4494 100644
> >> --- a/drivers/input/mouse/elantech.c
> >> +++ b/drivers/input/mouse/elantech.c
> >> @@ -1175,6 +1175,12 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
> >>         { }
> >>  };
> >>
> >> +static const char * const middle_button_pnp_ids[] = {
> >> +       "LEN2131", /* ThinkPad P52 w/ NFC */
> >> +       "LEN2132", /* ThinkPad P52 */
> >> +       NULL
> >> +};
> >> +
> >>  /*
> >>   * Set the appropriate event bits for the input subsystem
> >>   */
> >> @@ -1194,7 +1200,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
> >>         __clear_bit(EV_REL, dev->evbit);
> >>
> >>         __set_bit(BTN_LEFT, dev->keybit);
> >> -       if (dmi_check_system(elantech_dmi_has_middle_button))
> >> +       if (dmi_check_system(elantech_dmi_has_middle_button) ||
> >> +               psmouse_matches_pnp_id(psmouse, middle_button_pnp_ids))
> >>                 __set_bit(BTN_MIDDLE, dev->keybit);
> >>         __set_bit(BTN_RIGHT, dev->keybit);
> >>
> >> --
> >> 2.17.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
