Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD21C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13A92186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icc2XmBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbfBKTaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46426 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbfBKTaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so19476185otm.13;
        Mon, 11 Feb 2019 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKAzz2XWoprRBdkir+vqxJ/iQwVJe2PSVps01FW5WcE=;
        b=icc2XmBak//btrTimEluXCbFltzdckF3x/2AASq48Eru+JAooR+aQt1P8YG+cdIMEH
         AenYZz8Qp7D2j7ltMxeKuUv1OsYQYKryb+CVArAA/wqfacNA0ng0qR9F/V0kqLfNBIFb
         Gos+AsLMygXgEd4/jFDmWmZ5ISUqjh0DgxQkhACZFaZoU5+TfJyN5QbOd5+YP47Y5N8J
         UX8YSBBkd2XpZGvTSC0FP6OGP0sJlZNkVyQJfee0qGOuzx8GCmMXTpnhqcSl3wxBE/qx
         chJLUBO3V9LyzTUR/tMPoHcUuwI8bKqSwYQ6x72fOo6THVhxOd0NhhyBTRoP87MvUF3h
         yg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKAzz2XWoprRBdkir+vqxJ/iQwVJe2PSVps01FW5WcE=;
        b=ZNplpTapzHvfyDCdLmyN1Z3Osj16Bhe50imOO8p51wqT5wK6lSjLh7xUlsh6NUWiEW
         7Ao7frlszpHqS19N3ZYgee/oBfPnOwAoO3kMPVxYcEF4f3rEiB/yeb+ZfSivVAEPF7iv
         xzxlybpy4QvtIOLd7MSpTK7eV1h2Us1X7caREtTPku9tHoRVwySEE2fBCskkvgMHeKle
         wMr4Hneq326VEHBmW/ww2wvvxls7q/qvPi89YzSTTgHaevaxA+oUJwZhIPieC5mAAH4g
         qfhq8BiBncOmNsWrgl776+cvEEvRyZYy3J3Di/UzaDf+D8cw9K4o3AHPx/E6RvwGCYNf
         zKDg==
X-Gm-Message-State: AHQUAuaWRYQ7BCmAJADBQK1gQW3wMq2WsLAwWkTnEFcCPq1LSYzsD/BN
        OZi0nqQWUiI52AoojEPuw4RjGtkFyq8taYwVF40=
X-Google-Smtp-Source: AHgI3IZT2WGNybPLA0Hk5aCWWYnO5OZEjm4uY+YJLFa1nj0zfOiwbG/8cLcr7KxYh3D79W3igVwkE7BajDmIyebPe5A=
X-Received: by 2002:a9d:781:: with SMTP id 1mr28018388oto.250.1549913408913;
 Mon, 11 Feb 2019 11:30:08 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
In-Reply-To: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Feb 2019 14:29:58 -0500
Message-ID: <CAGngYiXPsj-TAZxC43UtAZYTkbztFtDB-z4jW29CthmaoeNy_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 3:39 PM Robert Eshleman <bobbyeshleman@gmail.com> wrote:
>
> This patch adds support for the ap3216c ambient light and proximity
> sensor.

PS

Why not use the chip in the mode where the interrupt is automatically cleared by
reading the data? This could work if you read the data in the
interrupt routine, store
it in a buffer, then send the event to iio. Then when userspace wants
to read out the
value, don't actually touch the hardware, but return the buffered value.

I don't think you then need any synchronization primitives to
accomplish this, such as
mutexes, spin locks, etc. Because the interrupt routine is single-threaded.

You don't even need a memory barrier for the buffered value,
because the iio core uses a waitqueue internally, which automatically issues
an mb(). As far as I know.
