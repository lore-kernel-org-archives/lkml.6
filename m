Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582D02175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7kZcmY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfBEO2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:28:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBEO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:28:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so5895544otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1glb51HkHjX7PiXJmxshImHAV6rzwB8ggE3jjrWteQc=;
        b=f7kZcmY4BsDLvaPwtw0KqBHCaPEP6oflCTVjYme6yCsGU2018Ts41Iwa5tjFrXvD1+
         bIVpi7f+7IV4tiNU81+XPbQ/6ADWY8vOdWHb2HmtRtaC4X2TuWpZE1cBRW+UB+CF97UJ
         I+d32FNbawNUr2r+PMLTDw7+JEnCr3lvOAUcEs2YnlRYj7ImvUzFp+OqAFxP90c9FlX6
         niv/OQtOPEH5dfxJhfTHR8gCbqWmAfoN5Tvl3cVQXZTdteu85q3RWKE8BQgl1Jtxlybw
         0eyxWMID8dAhqMx2vRvFVUJqszHVOowUroY46L4k4vOhYWoDqMxoaLvnXT7HqxjYZrfH
         xrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1glb51HkHjX7PiXJmxshImHAV6rzwB8ggE3jjrWteQc=;
        b=qQpCSc4xZvO4fTiSPJHJVdQnq8sSk2pPdC6t+BXOZR7QXGoFKF/jBHMRuVlMwVSy6N
         rcYDykw3RZxeUQpsVktwsEEnUWCWi0bY6quTSBz1wuoTd4aKoAtUViYtAH9l+lgG8gIm
         oeH3tve7wkxKBNJCFPtFF1dpO7TbLdHixWu7RXR1yaJNlBOR3mawCzw5+XpDsV5nWuMy
         ufbFG6W6dYjS6x38LL1wsx0+7XXhuUIW/Gu74fvHE8HRLQIQ5IAAq0bhMDwg3ElTeE9E
         9Tl1TCriOXzQj8nnIMcqdSRtyAOhrjj65f23ZraOo3XSrb5nNQ2k20dWXeq6ZCfV0gqN
         /sMg==
X-Gm-Message-State: AHQUAubFyaoakJbuN9OwnfnLa5EjptA2PDuF9W9dJiAHTEus8+YoCEvJ
        2sDCGrucigouSIXQ6yuXIWQnOwNnSpfAH7EMoOc=
X-Google-Smtp-Source: AHgI3IYEOjdR0TEAGYGNivPThU+KB3vlp4nPis/+uTok3aXpTH8su5v1RLdNVeNfUlNqZ2ytfVmSDxaWyuHw22sFZMo=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr2795512oti.245.1549376880334;
 Tue, 05 Feb 2019 06:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-3-TheSven73@googlemail.com> <20190205082727.GB118684@dtor-ws>
In-Reply-To: <20190205082727.GB118684@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 5 Feb 2019 09:27:49 -0500
Message-ID: <CAGngYiWJhja9bF5vL_4mwTjPMtzOwvsahHEpkntMPgMXdBNg9g@mail.gmail.com>
Subject: Re: [RFC v1 2/3] max17042_battery: fix potential user-after-free on
 module unload
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 3:27 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Are there many more instances of this?

Unfortunately I think so.
A simple grep brings up a couple of candidates, but I'm sure there are more:

drivers/regulator/arizona-micsupp.c
drivers/nfc/port100.c
drivers/power/supply/max14656_charger_detector.c
drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c

> I am unsure if we need
> devm_init_work() when we can easily do the same in remove() call.

The devm_init_work() suggestion only addresses the problem for those modules
that use devm_. The others will need fixes in remove(). But this is not as
elegant and error-proof as using devm_init_work().

For example, take port100.c's disconnect function. It starts deallocating
resources, but the cmd_complete_work (scheduled by urb completion) may still
be in progress, and touch these resources after free.

At least, I _think_ that is the case. I'm not familiar enough with this driver
to be 100% sure, but it sounds likely.

static void port100_disconnect(struct usb_interface *interface)
{
    struct port100 *dev;

    dev = usb_get_intfdata(interface);
    usb_set_intfdata(interface, NULL);

    nfc_digital_unregister_device(dev->nfc_digital_dev);
    nfc_digital_free_device(dev->nfc_digital_dev);

    usb_kill_urb(dev->in_urb);
    usb_kill_urb(dev->out_urb);

    usb_free_urb(dev->in_urb);
    usb_free_urb(dev->out_urb);
    usb_put_dev(dev->udev);

    kfree(dev->cmd);

    nfc_info(&interface->dev, "Sony Port-100 NFC device disconnected\n");
}
