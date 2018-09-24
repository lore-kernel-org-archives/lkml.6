Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8651C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B5020877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hici0lEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B5020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIYDJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:09:20 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:42638 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYDJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:09:19 -0400
Received: by mail-qt1-f171.google.com with SMTP id z8-v6so11093721qto.9;
        Mon, 24 Sep 2018 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0iGmRWQN1VPL7Q+N09s9mGLwuclNz8H1GpacCjqkGg4=;
        b=hici0lEAvV3MJhzPnhGQWtnPulfVdjStS6IRLybIPqqdnns1Zmhs+gCClhuKXPgHbA
         8xPMagO876sMHgfJfeNG0QRTAyRAdyd6bsVBEj5+2onztkgXiA3qvPaSmWDDTw7jIhdY
         QvRp3RHoC026Sj1hghxuEuiE4+3Q/AEmr1aIhf+7w/+XkXSv29ogiAN/xZyZ5RYe7a+F
         m3B2YxvUqV3mmts72VxtuFS9HiYCtHQawGNplzikRzVEZlRCEQvs6QLSHCxkmJYGtboX
         YLvr7XSlH5btWcESJUFk07vYq1K1NRouf0zGbtNMEKL37n1EKw4k3eRwablgZk4Gr190
         dzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0iGmRWQN1VPL7Q+N09s9mGLwuclNz8H1GpacCjqkGg4=;
        b=gijnTG4f1Q/kTz4PvpS8JAoStmNrsLjS4ObaFZCj2qnvv/CGFOBrdG7g9lXHCBTE3E
         ZUHT4BnNCUjru+p8OAddcEJjMChePfN7541qx/EEy8t/TC7HKYKB0gtr5j2xnrbymS5t
         78RQKZt0l688PqxUqKCW8TvFuAPHXGvESklG/OKeIjT1fgFelR8lJypUFy/oFICWc/Pw
         slJ6CEadwnuSVGhxnR/6Q7riSqRz6fwIZeGMXmb5Cin5zoqUDXh7Qq4/Q6zQnsGbl5/m
         jlWF9DWsOya0ej0zqgq8RQSybwvd6uoZ1yfXC631GTI5pf0B702xcoYQqgBLegNrso7I
         c0Wg==
X-Gm-Message-State: ABuFfohONv9I//vrKV2FTuPCDLJFA2Tp6rIXgm1EKOkrIYicU4Y8hbQs
        9AafJqi211Ue+7xn+Ki0NbiPt489heZn39YrLJ8=
X-Google-Smtp-Source: ACcGV62CCn0XEsl3F04z7PCsoh4iQEyaijWEIQ0PlVNspJk1aKwmejT2gB/i0TRVGoHrJjfQs25qRIPMla9aXUpATNw=
X-Received: by 2002:a0c:9557:: with SMTP id m23-v6mr554907qvm.138.1537823112816;
 Mon, 24 Sep 2018 14:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com> <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
 <20180924135935.GP15943@smile.fi.intel.com> <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
In-Reply-To: <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 00:05:01 +0300
Message-ID: <CAHp75VdDndQi9nj+hAR6wkFrgkf52QyQ+0iCsBFiJs1PS45iWQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     subrata.banik@intel.com
Cc:     Rajat Jain <rajatja@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>, aamir.bohra@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not top post in the open source mailing lists.

On Mon, Sep 24, 2018 at 5:50 PM Banik, Subrata <subrata.banik@intel.com> wr=
ote:

> You are right that this ASL code is not same with Intel reference BIOS co=
de because BIOS sources are different between what you are looking vs what =
Chrome OS is using. In Coreboot BIOS, we are more relying on EDS spec and a=
s COM 3 is dedicated for CPU GPIO hence we are mapping, 0/1/2/4/5 (whatever=
 present in EDS vol 1.1)

But how would it possible to make interoperability work if there are
*different* firmwares for the *same* ACPI HID?
ACPI table is a part of protocol by which firmware sends data to the
software. If one breaks this protocol they must use another ACPI HID
for that kind of device.

> We have ensured that PCR ID and offsets are correct in ASL code for respe=
ctive community, I don't think anything else really matter from BIOS unless=
 you tell me, that you are having any required that your drive code will on=
ly probe for 4 COMM for LP and 5 for ICL-H?

See above.
So, I do not see any bug in the driver, but in firmware. In this case
FW may not use INT3455 HID.
This is my understanding, if you would like more details, ask BIOS and
ACPI teams.

> First of all, this is pre-production chip, so, I don't think there is a b=
ug in the driver (yet) discovered.
>
> Looking to the above ASL code I may conclude that is definitely is *not* =
from our reference BIOS.
> I have checked two versions of it and found that in both we have the foll=
owing mapping:
> for LP variant: there are only 4 communities are exported for H variant: =
there are only 5 communities are exported
>
> So, I guess the problem is in ASL code you provided. It simple should not=
 export that community at all.
>
> In case you need to do so, there are ways:
>  - contact Intel and ask for a change in reference BIOS
>  - acquire another ACPI ID for the case, or, perhaps use special constant=
s like
>    _HRV for that purpose (also need to contact Intel while doing that)

--=20
With Best Regards,
Andy Shevchenko
