Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22C21848
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C0mXpBzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfBRPZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:25:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52214 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfBRPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:25:48 -0500
Received: by mail-it1-f194.google.com with SMTP id y184so42060298itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bl6rs6RX153LdwLHI2UrqaYAKdWkw0C1baNVJVgsEbA=;
        b=C0mXpBzmrv+hMytXXriS0AZKnClVeKejq7zbg+X8qgz6U1wHJIgIgfOlOXEWSVRYPf
         lUslz+ngRsKLQCqW5OaktWe0/LirWNZ/h5Gf2fIMAI9ZU64y18Anxd0Vff9p4cE+KZh4
         aOElwqgAnym74Xc4Pi8Wlrk1IvTTrJZdaFos4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bl6rs6RX153LdwLHI2UrqaYAKdWkw0C1baNVJVgsEbA=;
        b=m7T3tG/DpWFz0v90EuGd8ijv6pwnkTXXMulklQ9WpGuh6Wg7RqX7Q7peUei/tr/6Fs
         tQ2P1e4IyAf7Td00NAVQ9CE9RisIVXzrY6GmDgZODE7Kq+XbBTgiAEgCiLDdZHa1Eeh3
         HfYaLrsi8tLqNMRm3G6dfC+oYVycWccEsmAPYvgZ5fuYkEfNSZkiqlwK5R1t+FEVlBzO
         jsEtOYaqhX4PsYSBupvskdG08YlRfQ21loyuHzX9rkxbyraIVPwVkUlboQA6rBsoJTLm
         dhSZq6C2xeqO5vf8T83fT3pvKa98tyeZ0yu/htviYkWJR8i1TeRnFvzxlDzpT5NEHn6z
         S7oA==
X-Gm-Message-State: AHQUAub/MEPOZboOu6zviqsi9mHjagb0lsuRT1Am9t1HjO2jAtoVEft9
        iM6op4vo91V2j+0fhOGeRbzu1gTzSfi2fmEyWWcplA==
X-Google-Smtp-Source: AHgI3IZEHmQu7SZBcBLxGZ7OJuQM/p41Mvmj6kmOAc44+EvHewQajec932gtylnd0jb4Eyx6QSImbyVRyY2+AqIl7dE=
X-Received: by 2002:a24:385:: with SMTP id e127mr11667120ite.32.1550503547783;
 Mon, 18 Feb 2019 07:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20190212204109.3528-1-jagan@amarulasolutions.com> <20190212204109.3528-2-jagan@amarulasolutions.com>
In-Reply-To: <20190212204109.3528-2-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Feb 2019 20:55:36 +0530
Message-ID: <CAMty3ZA401nRh+nqFUcVMOv+or8NWoYU+y72gUPONy7ovyqgSw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry and Sam,

On Wed, Feb 13, 2019 at 2:11 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
>
> Add panel driver for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Tested-by: Bhushan Shah <bshah@kde.org>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
> Changes for v7:
> - rebase on master
> - collect Merlijn Tested-by
> - add tabs about drm timings
> Changes for v6:
> - add space b/w msleep and comment line
> - use multi comment line style
> - add sentinel
> - collect Sam Ravnborg Reviewed-by
> Changes for v5:
> - drop drmP.h header
> - order include files
> - add empty line after kzalloc()
> - drop gpio set for reset
> - drop backlight put_device from probe()
> - drop backlight put_device from remove()
> - collect Tested-by from Bhushan Shah
> Changes for v4:
> - rebase on master
> - adjust the hporch values to satisfy the refresh
> Changes for v3:
> - use simple structure for command init
> - update proper comments on power, reset delay sequnce
> - fix to use set_display_off in disable function
> - move mode type to structure
> - drop refres rate value, let drm compute
> Changes for v2:
> - new patch, derived from another dsi series

Pleas let me know if you any further comments on this?
