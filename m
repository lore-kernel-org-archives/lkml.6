Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81292C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C26A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+StIK6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfAXSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:08:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37674 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfAXSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:08:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so5609919oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ezo+awBOjrpJlK03mbbZ6iqVv9J7BCb4fL2rQwvuK/k=;
        b=j+StIK6TH4QKYF2OTW1BZLe5Vo+u4NePaBnyBW5SEiOHG6B816E7QlMB+gToWtpnsJ
         cAG/c4XSHZucxvdJ3aESTzp803wiYk681Nyq9a8qaI/nAWHmK6rMrb19E+n2R3cbrths
         7oZe1atsadtJlueK7+SHCAtf4CoPBbUFLhramI6rOpcKhACRl1TAhaA2xaiW26VF8Vaj
         PJGA4bHloiG+eSD2VX9aXuE9xk/KPzibiIcrJVZwg8lPZmzjsWDMpi9S4qdOhvr87qE8
         ZcMdHS5VALYz7zgKWi3vazkQPBh/oYZJJyXKcwOLoGyZalqKv7ix248aje4bAlsPn2Gs
         FSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ezo+awBOjrpJlK03mbbZ6iqVv9J7BCb4fL2rQwvuK/k=;
        b=MvZ0L+8Qxkc8hlB3NuQIRWmMghZYNMieaIgU1cboEFng1RW69ASu81s3NhLKNUgjnD
         s74ZDyNVi4vohnMCdIXkS5Ynd+U9D+uIPqridyp+4CPbp9Dac1u8qOq6RshmD6pn3htA
         AoD0Bqm1ZFoB0Ur9QLYPwWNQk8XHT2o0QAshmIhuDhgcpzs6Dfn7lhFBFH4wj6hrtvdk
         FDK/3EMFMf2SB9Zlp7D4ztbCzXG/uVJsDPZBR3xBEiZ7McsfNTCfispZGHXEbD6eMZCd
         2Ix88jDu2fF7U8Fy9MHbVBLzA6ZB5C+4PodijO8IJgETKph3GMKGvB7oEhqithG0PYdu
         YMtg==
X-Gm-Message-State: AJcUukeIGP/uzcPn0waj4XyIqcyFD3jL/sZBcpY0B0ZmSR2VyvAr5efP
        RsIgIi+9XPwBXzZXxGITxq47zO5J0vnTCHKP90o=
X-Google-Smtp-Source: ALg8bN47xSa9znDM06RA8L7tgCaadSWVxfBZTgiEmbiSI7eUA24uZzZRylPYOW6kgcFyxsteuZ4lFHmrg+Y6t5YlLkk=
X-Received: by 2002:aca:db04:: with SMTP id s4mr1759932oig.248.1548353290018;
 Thu, 24 Jan 2019 10:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com> <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de> <20190122185246.GA922@kroah.com>
In-Reply-To: <20190122185246.GA922@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 24 Jan 2019 13:07:58 -0500
Message-ID: <CAGngYiU2kLqQq5qkcxda9m__VWx62bsC=+ni4HAGMsOAxAtUzw@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> SPDX "GPL-2.0+" please.
>
> > would be if this code was derived from v2-only code that can't be
> > relicensed anymore.
>
> Are you _sure_ you want v2+?  I ask as I am forced to :)
>

The licencing choice confuses me. Why would I choose a different
licence to what the Linux kernel itself is provided under?
If I did pick a different one, what are the tradeoffs between GPLv2 and GPLv2+ ?
