Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F23C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3E320656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXpGZ7aU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeLNNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:47:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53624 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeLNNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:47:04 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so8906664ita.3;
        Fri, 14 Dec 2018 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JVq3UHJQ1wtaQ2sS7Es2r5dHS7vW4s28RK2ZRRYEezQ=;
        b=fXpGZ7aUO7AVDsc1mBD7sgosoOUH0dMhPCeqKUA8PdOadyT+pmUV4LPnaCwfV+MNmg
         3kySsFhtie6zI5rB5nxgOXkVJ6xOz8oRrt/FiWudwif72V/F6QLv0EongFEF+enBhwr0
         m36WKdXOerZ/whcTgki+cq7E2OYQRY0z9LRgte0/G/RAWi4eGplqmDVpG0lgCv481zjW
         2LkP4vXpc/L1PWRxJcSC1yph9KZ+jpFD0Imt5+2wEaXZICbpPdMcNImYAaGQrunZNaMX
         tFtZIUApX+6QRRF61e+4bnztdq69LqSW+J4FInxNScjr6tUwhY5qvuM3nHrseeAf3Mvz
         Hwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JVq3UHJQ1wtaQ2sS7Es2r5dHS7vW4s28RK2ZRRYEezQ=;
        b=aYspxRIDYTSgDIEG9oe3ER36eJo3ayug6SLdNEx0Qb10epXTrQetoP7IMQA24hbqT9
         /2w3q/XTKyUYnGxGGuBQrF71UURpzYQX7/5Tfww3Pe6Gle6jbpE3iUsKFqZE5mHXJ6UN
         mfYLjGmuU6n9SIeSO0eug9DHgHG+B6X3orY2I/66FIGFYP/AkHmoMacPLnWrOZI2xROO
         bzYUoS7EJJ2279YwvhYrGJ9Ac0XdIAQkI5WPNpioeRTpHxN8jQ+YFE0nfaMNKvm3xg+D
         a5nU+tYFVfQgg4a+kbVgltl9P+YindnGWgL5pwH39D76TYfHkpt6C5AKh4Naa1xF72MZ
         Kaiw==
X-Gm-Message-State: AA+aEWYCaoenbfN+ByP+uu1SI6xmdh+3sxvIL7ZZluQg6I2ff9ykNgrH
        uZKxUY637ZQLvn2qjvUTL9rUIvLK3EjXR2beHsbbgolMckQ=
X-Google-Smtp-Source: AFSGD/VFFUSa7AFc00YEZtM65YZ6HhGRO2W+uvCGiTNdc4Woj/J/Z1nM9zVkS/GsDeRa72aNp2Z8XhbutlK0l6WfCi8=
X-Received: by 2002:a02:49c9:: with SMTP id p70mr2679829jad.40.1544795223196;
 Fri, 14 Dec 2018 05:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net> <20181205004228.10714-8-peter.hutterer@who-t.net>
In-Reply-To: <20181205004228.10714-8-peter.hutterer@who-t.net>
From:   =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date:   Fri, 14 Dec 2018 14:46:50 +0100
Message-ID: <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 5 d=C3=A9c. 2018 =C3=A0 01:44, Peter Hutterer <peter.hutterer@who-t=
.net> a =C3=A9crit :
>
> From: Harry Cutts <hcutts@chromium.org>
>
> There are three features used by various Logitech mice for
> high-resolution scrolling: the scrolling acceleration bit in HID++ 1.0,
> and the x2120 and x2121 features in HID++ 2.0 and above. This patch
> supports all three, and uses the multiplier reported by the mouse for
> the HID++ 2.0+ features.

Hi, The G500s (and the G500 too, I think) does support the "scrolling
acceleration" bit. If I set it, I get around 8 events for each wheel
"click", this is what this driver expects, right? If I understood
correctly, I should try this patch with the
HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
