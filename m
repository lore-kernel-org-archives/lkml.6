Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2B522360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzTZLO3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2B522360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeKNALb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:11:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36702 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKNALb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:11:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so11413970otk.3;
        Tue, 13 Nov 2018 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JB3vi4EeqWmIjaDzb8126yCGBVdL62uWNmyU9Iz5tts=;
        b=qzTZLO3/NP6Rss+HMJu8/S/s6TzuomlSg6btbinyo2ZDTqWqO7+dNrN6K1OvXFEqvs
         0blcGHFUrL5PdgZ/PzFro24osf/YdyQHgyeRz+wk3rFWVuzef5AmIMGTcHOc2roPdLUh
         SePEfkeTMB4x+PVil0L4AUZ24elSbfK1X6g8ApoUc5Iu3KbN0O8rrPE9R7dQKNVLNN1J
         F/+tD9ELZfOIfsFntuopP79K7k/MKWXQy1C7m3atEAJLxw1Rsbhb68HT7vlBTeNw/z/F
         lumxizBUzYubcTiE467KLI8mQ13n63jTXOLLahXOFg0mtMBoPn2qwclxHR0WVyR5xZ3Z
         FaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB3vi4EeqWmIjaDzb8126yCGBVdL62uWNmyU9Iz5tts=;
        b=A8J0H7XGTlWaANAhEa6OwOdM5K6qJlnBCJ6MX7aaodPHgqnpxlpe0KjL6XfzSeb2e2
         Mky9+1t7FBnbvh1Okk7HigjBOvLrSJKLDXTZJj5OlXhepmxg/dvQYpL/hfDfnSt3DQpx
         kt0wCMXhwDV5rkrXSJ7iIXUxYD8AS6cQ/71eBzyo5z8LfhfSfKNRswDqW8R+xIllNxOE
         6xXzyJdf4FZSVYHgCIOCkgSLh7X8LWj0VzfHlBYdM/7PJEvHtwGj+wQqgtRz4f16QA7k
         87E2/h2L7/TC+M2U6yOumsVMhyfrA6+dvqHV39XdIKxmnu2hpOY4VgB8RW6lD3Q+1VpD
         g8Aw==
X-Gm-Message-State: AGRZ1gL02gn3F+k+FQ748iJ8zDUxTmgsime4p13Yo9zs6X9Kxowg8QAG
        ykZJGQcP8LdYcgnjSGTA2BLoOQxFZGTQug7nNz0=
X-Google-Smtp-Source: AJdET5fpnMrQwOesirvPaplxN6VYumlg1Syp9wzdl2UPHRUVAVtFy+6ANnhJyzllYePU7B+dp1CBvV2/k4xrQ27t0kg=
X-Received: by 2002:a9d:411:: with SMTP id 17mr3082557otc.78.1542118390549;
 Tue, 13 Nov 2018 06:13:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <CAOMZO5CjFt1dyu8KOK+jKd88x8hwGNy9aJ-sGgooS9970TGTVQ@mail.gmail.com> <9a9616d2-a189-bd0e-e2e6-f84bdcb1dfd1@cisco.com>
In-Reply-To: <9a9616d2-a189-bd0e-e2e6-f84bdcb1dfd1@cisco.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 13 Nov 2018 12:13:09 -0200
Message-ID: <CAOMZO5DHfgV+iDo4ye7DV9CAA0QjSVXsYH1nbD2+5d9iE-uTCg@mail.gmail.com>
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
To:     Hans Verkuil <hansverk@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media <linux-media@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Nov 13, 2018 at 11:37 AM Hans Verkuil <hansverk@cisco.com> wrote:
>
> On 11/13/18 13:48, Fabio Estevam wrote:
> > On Tue, Nov 13, 2018 at 6:25 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> >> --- /dev/null
> >> +++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> >> @@ -0,0 +1,275 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> > According to Documentation/process/license-rules.rst this should be:
> >
> > +// SPDX-License-Identifier: GPL-2.0+
> >
> > Same applies to other places in this patch.
> >
>
> Actually, LICENSES/preferred/GPL-2.0 has GPL-2.0-or-later
> as a valid license:
>
> Valid-License-Identifier: GPL-2.0-or-later
>
> Personally I very much prefer GPL-2.0-or-later since I think it is
> much clearer.

I saw feedback from Greg to use the SPDX style from
Documentation/process/license-rules.rst.

Please check:
https://lkml.org/lkml/2018/11/10/232
