Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D5B7DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116B208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2k6gT4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8116B208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936044AbeFNLHV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:07:21 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:38123 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936011AbeFNLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:07:18 -0400
Received: by mail-lf0-f41.google.com with SMTP id i83-v6so8770569lfh.5;
        Thu, 14 Jun 2018 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2//mq/7ZT35UuVAPJKdw1kMRXIvh/pxwQWBd/vKnl/0=;
        b=P2k6gT4n7hxK/fdiERBmvhcmF47f0pvwLucHUaLKaH6cJJtvdGJNo7ycx1I5lXiQ/Y
         K7Haph+3ief0TLTbW0mi40dg4hM7AZ1cC/m1IXY7v7socvI1E1vCpj9EpHWsxyaIWFBp
         WxEMjGdzUqtFTvQgne2fSfvVZeHdpScF3qWt3izz/7duCfHwTbzuXKM+TkdoltYFDgj4
         uyQppROtWaubH7KtFpe0bKsSw58ChDrBUJAf2Kj1Ie9LFul7hlbg5f4fyVTbODALrrMh
         RSjytbF8PYQwz3OFwRiler8pM4rg/mqKr8fDdaBxrPOGkvu0PtFNmOFQnbROwaRuKP+p
         nfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2//mq/7ZT35UuVAPJKdw1kMRXIvh/pxwQWBd/vKnl/0=;
        b=K/t0ecz9HrIrv0epwjw1EN1t6VtTH2EZQY85DYJwhtVWGyqG4UywTtTmxJvlu6gSck
         WiUwcVAvZr5e02YtDz+V40FPyuJkNRa70t65XzK5lfgtvnyuSRfi2/4DVn5ifj6IZRfh
         79Kgh3x7ZGTd7YTmR64QuOppS4QET651MhzOZ184uXHgllo9n1JKOVY6oyZI7hI/lbx3
         jEDNlsTmk0f9ScV26TIgHk4mONS8Kr3VPS68hsC+tiblVJsXpq8U7Wvzkn/TCvvmbTtQ
         sjdmxBij5BRDuFtRz8JvKN7MpwxOAeWUD+aZAoe6Z/pkHUMY2M4lpeimN73QaJWXg6nk
         9SBw==
X-Gm-Message-State: APt69E1ZjTwCVMpul7vyLbUusCqWGx2R/nebzOfw7E/xh6ZKtzIl3Zgx
        YX6BtSJEBcvvq7D8M9J0cqL9O2E+uLNpDiB9r8LBkvzI
X-Google-Smtp-Source: ADUXVKLpRX/HUhO88JhjrxeFiVdMw/MxllpQT/TWBftydfyKzJPJTyhpJ3Sf15apyjB/aFXrRrTxvH8C4/VUVOnAOU4=
X-Received: by 2002:a2e:2f02:: with SMTP id v2-v6mr1550278ljv.113.1528974436163;
 Thu, 14 Jun 2018 04:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180614104820.GC32411@localhost>
In-Reply-To: <20180614104820.GC32411@localhost>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 14 Jun 2018 13:06:59 +0200
Message-ID: <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via sysfs*
To:     Johan Hovold <johan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan
On Thu, Jun 14, 2018 at 12:48 PM Johan Hovold <johan@kernel.org> wrote:
>
> Hi Ricardo,
>
> On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> > There are some situations where it is interesting to load/remove serdev
> > devices dynamically, like during board bring-up or when we are
> > developing a new driver or for devices that are neither described via
> > ACPI or device tree.
>
> First of all, this would be more appropriately labeled an RFC as this is
> far from being in a mergeable state. Besides some implementation issues,
> we need to determine if this approach is at all viable.

From previous conversations with Greg it seemed that RFC labels was
something to avoid, but I do not mind reseding it as RFC on v3.

http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-March/018844.html

>
> Second, I wonder how you tested this given that this series breaks RX
> (and write-wakeup signalling) for serial ports (patch 19/24)?

I have a serdev device (led ctrls) that is dynamically enumerated with
something very similar to:

https://github.com/ribalda/linux/commit/415bb3f0076c2b846ebe5409589b8e1e3004f55a

and then I have a script that does adds and removes. For standard
serial port I was not testing the data path, just that the ttyS* was
enumerated fine.

But  yesterday I believe that we found the bug that you mentioned and
we have fixed it (check end of mail). I will patch the series and
resend after I get more feedback and also implement what Marcel
suggested.

WIP is at
https://github.com/ribalda/linux/tree/serdev3

Besides this bug, we have used the new driver for over a week now with
no issues.

>
> Third, and as Marcel already suggested, you need to limit your scope
> here. Aim at ten patches or so, and use a representative serdev driver
> as an example of the kind of driver updates that would be needed. It
> also looks like some patches should be squashed (e.g. the ones
> introducing new fields and the first one actually using them).

>
> > This implementation allows the creation of serdev devices via sysfs,
> > in a similar way as the i2c bus allows sysfs instantiation [1].
>
> Note that this is a legacy interface and not necessarily something that
> new interfaces should be modelled after.

I would not consider it legacy, it is the only way to use an i2c
module without writing your own driver and/or modifying ACPI/DT table.
Just google around for i2c linux...
Thanks!

>
> Johan
Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu Jun 14 11:30:27 2018 +0200

    serdev-ttydev: Restore/change ttyport client ops

diff --git a/drivers/tty/serdev/serdev-ttydev.c
b/drivers/tty/serdev/serdev-ttydev.c
index 180035e101dc..b151c9645a1d 100644
--- a/drivers/tty/serdev/serdev-ttydev.c
+++ b/drivers/tty/serdev/serdev-ttydev.c
@@ -16,14 +16,23 @@ static int ttydev_serdev_probe(struct serdev_device *serdev)
        struct serdev_controller *ctrl = serdev->ctrl;
        struct serport *serport;
        struct device *dev;
+       const struct tty_port_client_operations *serdev_ops;

        if (!ctrl->is_ttyport)
                return -ENODEV;

        serport = serdev_controller_get_drvdata(ctrl);

+       serdev_ops = serport->port->client_ops;
+
+       serport->port->client_ops = serport->tty_ops;
        dev = tty_register_device_attr(serport->tty_drv, serport->tty_idx,
-                                       &serdev->dev, NULL, NULL);
+                                      ctrl->dev.parent, NULL, NULL);
+
+       if (IS_ERR(dev))
+               serport->port->client_ops = serdev_ops;
+       else
+               serdev_device_set_drvdata(serdev, (void *)serdev_ops);

        return dev ? 0 : PTR_ERR(dev);
 }
@@ -35,6 +44,7 @@ static void ttydev_serdev_remove(struct serdev_device *serdev)

        serport = serdev_controller_get_drvdata(ctrl);
        tty_unregister_device(serport->tty_drv, serport->tty_idx);
+       serport->port->client_ops = serdev_device_get_drvdata(serdev);
 }



-- 
Ricardo Ribalda
