Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BAC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6F2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GEPl0rIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfAFQh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:37:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35145 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAFQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:37:29 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so7322026itp.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QZ56yjxySLn0thfpIJSe+YPYEKZ+xxKsG5yu5enR5sY=;
        b=GEPl0rIHklUrvo6aLXzaGd9bPihGr45Sy27bz70MqdIaRBR+NaIXjj7osQPnOR1TWm
         yd1mGwaECpA1WdlKq7EJvLkX0lJSQccx8fTio3CkyGCIpvBo2HmwFM8BRfOFWWAdXLQ9
         6N70BDj9scnxi1CRyJm0u2H3N9px/8xEd3ub4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QZ56yjxySLn0thfpIJSe+YPYEKZ+xxKsG5yu5enR5sY=;
        b=C0KoNujs5IcYV7Wud4GODn1PcqsqLJAzSBJobuBnDFWTN8MXZmCeMqubqhDGKESeqO
         SlMYc12HXzgfi8kHJARltD2fy/LaovqXhGaYClpVJmbAGhCNMPUhnRfmHD0CuAxs61Ee
         3XLbqMh8rWrHSXA3LEq9ozXXFcV2SYzMuy+9RiWRBmXxrwZbpEIxuP009h96U5BmptF/
         yRzeJUGTjhsMj5sSSQMskHZ6pA48iExkmWU9g8MIT4A/v6w38cWsAugg8oafnjKnpcxe
         GFjLT9QWH8umSTzzIu4U2Wx7fIwmWBT7WfJBinZ2IxAHAnYKn6Ip/pMMA3xbgvvk+lby
         T7Dg==
X-Gm-Message-State: AJcUuke9o/Klt+jKIeiu2dUKkged9I2rO5U6NSU/weWf8KlBuDIYDkrN
        BrkiB10rnFbuT/nB6vghiqtYL0vv1g/MGh586m+oAVZ0
X-Google-Smtp-Source: ALg8bN6RQ0RoqrCxOqywl95tjrxsvjA5LhyfrzGf8eicudD0X4+JHF/knyv2k+9A0nqf7Kd4uhqdB5tdeROwWf5S9/8=
X-Received: by 2002:a24:5411:: with SMTP id t17mr5183806ita.32.1546792648257;
 Sun, 06 Jan 2019 08:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20181214204640.9789-1-jagan@amarulasolutions.com> <20181214204640.9789-2-jagan@amarulasolutions.com>
In-Reply-To: <20181214204640.9789-2-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 6 Jan 2019 22:07:17 +0530
Message-ID: <CAMty3ZAXfyCn2-WC6b71uZwTE3aC-ThoRDbvozhqfrO-q9SU2Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/panel: Add Sitronix ST7701 panel driver
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 2:16 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> ST7701 designed for small and medium sizes of TFT LCD display, is
> capable of supporting up to 480RGBX864 in resolution. It provides
> several system interfaces like MIPI/RGB/SPI.
>
> Currently added support for Techstar TS8550B which is ST7701 based
> 480x854, 2-lane MIPI DSI LCD panel.
>
> Driver now registering mipi_dsi device, but indeed it can extendable
> for RGB if any requirement trigger in future.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v6:
> - use sleep delay value as per datasheet
> - add panel_sleep_delay variable for panel specific delay
> - use command sequnce display on and off instead panel
>   functions
> - add proper comments on the delays
> - remove delays from command switch
> - move mode type on struct display mode
> - drop refresh rate value, let drm compute
> Changes for v5:
> - found the chip from vendor, so added new panel driver
> - here is v4: https://patchwork.kernel.org/patch/10680335/

Any comments?
