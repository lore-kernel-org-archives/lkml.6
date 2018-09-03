Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34144C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D607420645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D607420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeICMeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:34:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39205 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICMeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:34:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id b19-v6so5146437qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 01:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHpT9Y1EBeN8VEZdAgYh5ux3KRdWLwuNH0x4RuHBggo=;
        b=CVJUNDVP2Xt9NmqbijKv+RDtLaHRA7NZTlY6kjdUbphviq+0uF/dqpXkfKGd2lf9tQ
         5r7mDYDJp8khJny5thKwmKQG6sUaCekGbGuIJQ+tce5xVOtql/mPBmHKigdxnVIjpaho
         tau6aLlCzBzChteZVGiQHz6JhEc3HGRrIiOuBjFSCiHfod7cGQQX+EFgGIMi2389/utg
         4KGJ5IyNiCgEYa/3Yh1NPwoFMzlNXyhjlrE+SfhiF3TTv/81D7svGXn+RFjMe1Nba70j
         zTWaPmQJ2a19Vb+d9LUKKgkvdb5UfpnPFXe2D9xAzuIIk5fmGaOC8X9JAYoRk58EqIph
         EptQ==
X-Gm-Message-State: APzg51A4g3STIf2dbsgdgBJYchXbuNb3LnsHaOSudACqDHak+/2MsMWx
        zCygrBQ+GrzRBeByfCGny333kCLt6H4rEYtgRDQuVw==
X-Google-Smtp-Source: ANB0VdYmiV/Hg8wDJ+bMYNX2ocDludWxtjs4FxXLsFFJOQ6FW83ZU9hNLeqinb8/OHUVLZGb7oO07GXHPl48M0s8zlA=
X-Received: by 2002:ae9:c30b:: with SMTP id n11-v6mr9792496qkg.194.1535962519391;
 Mon, 03 Sep 2018 01:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180830215622.47550-1-hcutts@chromium.org>
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 3 Sep 2018 10:15:08 +0200
Message-ID: <CAO-hwJL6xz=b4wA5WnSeZw1PO+exVgs3isyPO6ZFWVemiJU9yA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add support for high-resolution scrolling on
 Logitech mice
To:     hcutts@chromium.org
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, jiri.kosina@suse.cz,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

On Thu, Aug 30, 2018 at 11:56 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Hi everyone,
>
> This is v2 of the patch set adding support for high-resolution scroll
> wheels on Logitech mice. See the linux-input "Reporting high-resolution
> scroll events" thread [0] for previous discussion of the evdev changes.
> I would love to hear your feedback.

Series looks good. I just tested it on a regular Logitech mouse and a
MX Master with high-res scrolling and everything works as expected.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Thanks,
>
> Harry Cutts
> Chrome OS Touch/Input team
>
> [0]: https://www.spinics.net/lists/linux-input/msg57380.html
>
>
> Changes in v2:
> * Changed the REL_WHEEL_HI_RES code to use micrometres (a.k.a. microns)
>   as its units, instead of 256ths of a millimetre.
> * Removed support for mice connecting over Bluetooth, due to a bug where
>   the mouse's high-res mode and the driver's settings get out of sync
>   when the mouse is power cycled.
> * Moved the creation of the HID++ 1.0 function and the refactor to use
>   the LDJ_DEVICE macro into separate patches.
> * Added a couple of explanatory comments to the Logitech driver.
>
> Harry Cutts (5):
>   Add the `REL_WHEEL_HI_RES` event code
>   Create a utility class for counting scroll events
>   Add function to enable HID++ 1.0 "scrolling acceleration"
>   Enable high-resolution scrolling on Logitech mice
>   Use LDJ_DEVICE macro for existing Logitech mice
>
>  Documentation/input/event-codes.rst    |  11 +-
>  drivers/hid/hid-input.c                |  45 ++++
>  drivers/hid/hid-logitech-hidpp.c       | 311 ++++++++++++++++++++++---
>  include/linux/hid.h                    |  28 +++
>  include/uapi/linux/input-event-codes.h |   1 +
>  5 files changed, 368 insertions(+), 28 deletions(-)
>
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
