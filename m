Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27908C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAF720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow8Yy9LV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeLEWcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:32:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42010 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLEWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:32:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so20206343otk.9;
        Wed, 05 Dec 2018 14:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQgjYBbWU7NbhKGvBPrvYQ9pF87sANU/6VeFT4lR2Kc=;
        b=Ow8Yy9LVbxQul5KeH8lou3ITFOMtY3/J75rZlXXg0VS1pRgpcKwSsncVysawpGDphQ
         gmEE1rmSVy8fTOcchpBeNGT2JABLObJK7HY/e8ONqXDp1xI+kVqR+79rP4Zes61n8QLt
         a+CdMULG+1GntvSoGY7BxKJUtkVpL33crrU+owui8VXOoFWE+W/3w35zU/S5oGa5yDkQ
         7TjOEb4Hw1T37aRngP6CGLbP4LSAwKAIMhCsfEyaYo+I9nct5h3Py49gq/wUmjyM6vF6
         E7Nvz3OjGjShuzDWA68Qx/DmS0PO6BdU9RlVu5Wa0ibNnbzfC1aURPpb/U/qZYFfSCEs
         Zvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQgjYBbWU7NbhKGvBPrvYQ9pF87sANU/6VeFT4lR2Kc=;
        b=CNPmknqJVYM/xvvIkzVtC97TwBfdtfpFdOd8Rqn3x8qkSu7rcgPt5b+EjgLEtprBLz
         L6ok2q8LL0OHD+aT0iYFes7hG8YR50W/7hQYOCNXux4oKRCcdxuy6ArHZS+SB/h2af+7
         WvY/TdRLbRL1vBtJr/E1MaAm//Iad6FGcN9WP4kS1qurca3DGpQ9kTtdUMhQQbyxduAz
         /rufCW8d4F6VmLJ/Y1CgDJNUxkkNRot6SJjIGSNvwtL8OW0LmUhhJrFhdYo0UIEN9r1s
         oEXzIy60KBqt4+bV8mrm72hXmUQjnzwpt5LSJk6JE+v72jfpRe4t+2UhHqlRA6PhP4kL
         CTDQ==
X-Gm-Message-State: AA+aEWbEipaXKjvJxLBNo6gEBSYVyLIrRvqMNhdZvDI85hGJPAKy/lA/
        IS6TTFPcZGM0TTQvTOP+gWoskzR4JF84H3XNQxg=
X-Google-Smtp-Source: AFSGD/VwSNp5Zmvv1d2LwAKdH35xDB1u4GZP64xE4QHd9gydeqAo3n89yXU4pGF4NtIThXd8aBLJlafio/Xbqh3TQGg=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr15607844oth.279.1544049150384;
 Wed, 05 Dec 2018 14:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com> <20181205101659.GA27058@kroah.com>
 <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com> <20181205191724.GA434@kroah.com>
In-Reply-To: <20181205191724.GA434@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 5 Dec 2018 17:32:19 -0500
Message-ID: <CAGngYiWG74nDt1_hN0-bKCDRxm-f=N-Rnjtk02Vd7dgKtGRaBA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     gregkh@linuxfoundation.org
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks :)

On Wed, Dec 5, 2018 at 2:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Great, then call it a 'fieldbus' class, not "fieldbus_dev' class.

Small nit:

Hardware connected to a fieldbus comes in two distinct flavours:
- clients (e.g. thermometer, robotic arm) called "fieldbus devices"
- servers (e.g. a PLC) called "fieldbus controllers"

Their userspace APIs will probably differ quite a lot.

The userspace API created by the patch is only for clients a.k.a.
"fieldbus devices". That's why I'm writing 'fieldbus_dev' all over the place.

For simplicity, we could change that to just 'fieldbus'. But would this get
us in trouble when, at some point, we want to add a userspace API for
servers a.k.a. "fieldbus controllers" ?
