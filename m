Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ynsFILGQHlucBgAAmS7hNA
	; Mon, 11 Jun 2018 15:09:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6AC24607BB; Mon, 11 Jun 2018 15:09:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4caaoKG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D439360541;
	Mon, 11 Jun 2018 15:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D439360541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeFKPJf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:09:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34507 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbeFKPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:09:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id o9-v6so31101494lfk.1;
        Mon, 11 Jun 2018 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9n+a6xTvvEIZABtWTS6vuxUxqPoIVPx/5Wc4t2mllf8=;
        b=D4caaoKGro5SPI+549bZb6Y0uWcFpdtfmK/jdhDgLXKsrLH24dHraUcg+x8+EOFTr+
         blUJqx38FIW0+N+S3LJrHXTrsgTdD2QAi5h2nCiDngclWvCO3SdvafPvAjhawC8nU9id
         QGGCtNogQVh6RyQ6pbTGRmshUgMTcoQnUtr1ReOJrF8rzaNlQSg9kMfr/arGSaEkm9lo
         RDYCm7GUpUAu9f7vzI5bx5g2zelYgNZfTZwWWV5o15Ct5L4yTLwSzZNTiSd5LSpW5tsl
         CoBmNNjV43U8fo5Xf4jXtIE7G7/6VrAUYijvTQxDSgWjxbUMmjDUIpDVgTLi4lhAXOqI
         5tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9n+a6xTvvEIZABtWTS6vuxUxqPoIVPx/5Wc4t2mllf8=;
        b=ag0khNLCWa9LFuoTubyamyIgXczFYLePiIOk2niAg1keGNWXnkn3pRwNCVI52jbQ3x
         LOulaO2NWyxC9AVmCajbSRg4rkF8gy3E9eP/jUed7DMZ6vKWBaYceDXTtfi+sY7OQO8M
         V0kFQLuiwlvjQVBFX3InAQYCNLil6sIa4SVjZGUQ7DohvbPbqVGCOz9OVGwJtxNM+Tmw
         54047fhrKtGiRG4RMazbkP5orTEpT4sbNkunmykorVeiU0ia5ztYI10sfSppotUCSeHX
         L2HNFAhp93xcqkxKmjJpvp6MpSGKp1++lo8KEm+J4U2I9Co3VrEmfkpJqljHZi98WugZ
         x7hg==
X-Gm-Message-State: APt69E0jvEc/WgGByPe6XJZACVgWTQ9xwpTiHqYBPWwE+izvk+0/sBqV
        X2E/VXcVOvDBuH2PcaXjIds9rvVQh3lgk/G51Rc=
X-Google-Smtp-Source: ADUXVKJuoFuHWkCDwYPsGccHLvskI1Aa2MExJCrxcD+Fr0rpmN4ohUdLZtOIxjC1FIFreGWiS918vNw6p3PTuOnVpb0=
X-Received: by 2002:a19:7:: with SMTP id 7-v6mr11103880lfa.62.1528729771374;
 Mon, 11 Jun 2018 08:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com> <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
In-Reply-To: <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 17:09:14 +0200
Message-ID: <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Miller <davem@davemloft.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,
On Mon, Jun 11, 2018 at 3:01 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
>
> the commit message is misleading me. If I build something with ACPI or DT=
 support, then modinfo will show all modalias information for ACPI and DT c=
ompatible strings. What else does udev/modprobe actually need? Is something=
 broken with the modalias export?

The main purpose is to autoload drivers for devices that have been
created via sysfs or another module.

Eg1: We have a serial port on a standard computer that has connected a
GPS module. Since it is something that is not in the ACPI nor the DT
table the user will run

echo serdev_gps > /sys/bus/serial/devices/serial0/new_device

Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846ebe54095=
89b8e1e3004f55a/drivers/tty/serdev/test_platform.c

Modprobe does not know what module to load for that device unless
there is a matching MODULE_DEVICE_TABLE
Today, we have the same functionality for i2c devices
https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

I guess the commit message is really bad :), sorry about that. Any
suggestions to improve it?

Thanks!

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
