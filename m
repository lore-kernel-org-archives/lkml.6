Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B458C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520FB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVIgQ5ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520FB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJJW6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:58:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33981 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJJW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:58:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id o17-v6so6156850qtr.1;
        Wed, 10 Oct 2018 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jTicQiJRtWcGfQbmYHpFK7rK+qrlYjc9oV/jAzfLO/g=;
        b=qVIgQ5ribxw7ef8FgWc4QVsiiorIBPLKxTOGOdT8qbvdlvCqnMYn7V5LR673cUqq3w
         Pfke2jugNlReJPUxYj5KZfJ+Caz7+uDfzaXEm58twdWBLRDm/lVm9zcsii/ufpKpkTfM
         tzJ7RPLN4MfzMM5ZwRMH+bLm6xVFTZV1R8p+oFcRc33bHquS1MNmfLA5+nXQjvTxaO4i
         us5w+mjwMyeEG+z2Oxdji8cwV1BijhxLGJ8JSJM2CkGSI9hbEYYc2h70lEPBnI0aDA7N
         zSWIMk6JJBS/9W6ZElwCtUBZSno9/js7D9tnohzjpBnS1AcZjY7o2upuOBw4zpIW7Ig2
         Y4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jTicQiJRtWcGfQbmYHpFK7rK+qrlYjc9oV/jAzfLO/g=;
        b=tcuTcHiCLwoShvXC9ExB+EF+q5D2rRav8DKy9hz6l14LMwaMcQzNpxekUljc8ec8YX
         qcLcDyswT0O5odl0AcNHPgzq8xYyHG6YQDQJB1fSjRL3k1qpQ9y4ag4hvvRb5QLNTpXm
         KZu7C25BG9hrHNzDscO/U0+xYEbmjW2M8FiN6FXmEmrQPEx5/9NaY7OcvzD+5S6tYrM2
         nlx3wwFoJcPQFQKOaLL76vniDKAipdAIa9gaJjBSV7oWrrAgXnPYsMYEUlEC/hcXfBaF
         eioCLOEF0kI1yY0hXaWEqqHL4TzfFyTp5zJ8ZzbQJNXvaV9iBCZjihB90x1N3K8Y1iiH
         aWrQ==
X-Gm-Message-State: ABuFfoiD9bL0p82yT5zSr05vE45Xhrakdko+eHehBTRIBvIxmFgZLW/R
        ITZmxr51/y2+NzPCkIeYUwXwp6gyM0e8TAQGE+w=
X-Google-Smtp-Source: ACcGV62qdrPIu87PAa0KXx0NhapsZ0U1xUwWvz8WMwlyOYVPgncGIqaeKu+Ta3c8s6CY8nYsn9oWW9T6JsVrpyPplCs=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr5990868qvl.40.1539185730873;
 Wed, 10 Oct 2018 08:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 08:35:29
 -0700 (PDT)
In-Reply-To: <20181010151801.21489-1-robdclark@gmail.com>
References: <20181010151801.21489-1-robdclark@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 17:35:29 +0200
X-Google-Sender-Auth: WCBX16gaCQ2MqF3uY857pYqCJVw
Message-ID: <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
> BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> FB_BACKLIGHT prevents it from being built as a module.  There
> doesn't seem to be any particularly good reason for this, so
> switch FB_BACKLIGHT over to tristate.
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>

I don't see anything immediately wrong, but anything related to
BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
and FB_BACKLIGHT is really fragile in Kconfig, because of the
way those interact with other options.

I've applied your patch to my randconfig build tree for testing,
let's see what happens there before you apply it.

      Arnd
