Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190CAC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A0920874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jscj1tJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBJXrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:47:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45702 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfBJXrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:47:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so14615226ota.12;
        Sun, 10 Feb 2019 15:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAYbqwJcUW46KTniQbU/b8ZTSLhhpyn6+1bDFZ1lWZ8=;
        b=jscj1tJl8s2UI0RMHHHQc6qNbDvHL/G6KPwXt+i1wVeVspvMxEsDV4o/k+ezw2rR1V
         SV9QHUIe756eji6HvjUvxjD4j7MBDk3DQwQVJa0TObHqorL5WfsXCXJZ+xVJbPKTA3Du
         0wyW2TuhuECk/d+8cdXkRkAEhqf/uQL81syiDImAFHVD0NW7TxX3nb22+QIlOqiT3ZJ6
         o4r/6m3XcNUHkW+g1iq8M7owGM6uZta9Dv+J3dwOVMj2KBu0aQL5o4C1YnLIGS0eHwDh
         HyZ76dl6XJf106phm7qyf+4ygK7FKwtYyYPOH0lsjfvUWUbmo4nIlObH2A94Exzuw5hH
         2EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAYbqwJcUW46KTniQbU/b8ZTSLhhpyn6+1bDFZ1lWZ8=;
        b=R8nxMUVFz7+UKUIoZpVUahX8W98K0lY31Tr/XvAGC8Hx32YqEl/+ZlSQU/rUj6FWQd
         /cNw1nMpqS4V64NV58czaWpV+H+1T2p7LkYXzNt1szHrlDY5bA3TR5qoXyLks8NiyC3v
         a/QW/9muUxMLnTVJ4tAsIiJBj0RhLwqUYaBfO8bbW86HHWyF4yR7lDCBnS+CIl1owZJI
         ETeYIbLYTCPjB/oGFuNejDdyEHU/MbdjNsCsCU+tYt9bGlPcXRxBSb9SF+hRJwP3CJK/
         6T/104AEHv63YCrFuwIHqexihh693Xka88FO7tUueZbj7FlmGtRS6G22FQBAqLZFv5cO
         mFww==
X-Gm-Message-State: AHQUAuZQxxh53S/ETOejA71gAOqVFt/fOdSgaGaJsczfMVhWsnlZM4Q0
        s59qoX7OqxvfL3vpR3b/pVUDkA2G4Dx/zhCg5ks=
X-Google-Smtp-Source: AHgI3IYFNtdIZiaa/52yzdSCazvmIAKptr2cvKasDw/vKnLl5ETqMeAg3vG/zaEYUo19DIN4w9dGuel9IIdDpGU7Z+M=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr25291400oti.245.1549842442453;
 Sun, 10 Feb 2019 15:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20190209172058.GA24435@dtor-ws>
In-Reply-To: <20190209172058.GA24435@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 10 Feb 2019 18:47:11 -0500
Message-ID: <CAGngYiWX5CzRnjZ1O4gMe-Zmc=G90ccLDGS6gwiw-c7ppjgQ0g@mail.gmail.com>
Subject: Re: [PATCH] Input: qt2160 - switch to using brightness_set_blocking()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 12:21 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that LEDs core allows "blocking" flavor of "set brightness" method we
> can use it and get rid of private work items.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looking good !

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>

Good job to get rid of that led_lock mutex. It didn't serve any purpose
but more importantly, it could introduce a sleep in brightness_set,
which cannot sleep...
