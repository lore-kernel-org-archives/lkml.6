Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2823FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC4E2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC4E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeGJIHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:07:32 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33117 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeGJIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:07:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so9618176vkc.0;
        Tue, 10 Jul 2018 01:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSC29yqAph7kBxRZEhLw4L4nrHPUaeF+YWOYNTGntHY=;
        b=sTwug1uiFdw2uUXHgu9svxBou1ozUwWG0bBvWadicEKXVFyqAKpME0N4kzh93/BzPN
         dNNa5gL2FXLyX9aG50/0wjRIzdZpmREToGwOmybQmakc4zbIClEoE0NTOXK8+PxlbtOu
         eFjC5LqwMid8CsaMP+fIDvrjBeGtC0kcKco4jrZ2fERSeLbchT37B+kb6NLL1+LBUMRv
         MIr8c7VYWyq0xvmMzHLaq6qH9QzJi0IHOO/6vmgjFmlenjEFgeBKbM6F1QepQLPgJlQw
         JxYjW5p29NZCOLmG4fpMa6W65Ucq1vHA1CP2+9863PdENfb5QsWnSFjxVpfHozyVEe7B
         bOyA==
X-Gm-Message-State: APt69E15XxTNtCueobfoxra35bi73etHSgeC96N6OoIa/Mgvdy7UcWsD
        pGzVBOD3h+sWajvuL+/XXcPghiBqeW58SeS1yVY=
X-Google-Smtp-Source: AAOMgpeXCSJ+9ScdfLrqWCk3epp3vDEzHCCschFflZtFeKT78WE46nzcdNpcgwAlCSnpVax/2EZoeGBSWVoGOTF1ekA=
X-Received: by 2002:a1f:3701:: with SMTP id e1-v6mr13353562vka.50.1531210048413;
 Tue, 10 Jul 2018 01:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20180710080114.31469-3-paul.kocialkowski@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Jul 2018 10:07:17 +0200
Message-ID: <CAMuHMdVgJuK5G0+szV0BAWDBybxWV0iDWE5kZKuTdgNiGjpnEg@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] fixup! v4l2-ctrls: add v4l2_ctrl_request_hdl_find/put/ctrl_find
 functions
To:     paul.kocialkowski@bootlin.com
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, marco.franchi@nxp.com,
        icenowy@aosc.io, Hans Verkuil <hverkuil@xs4all.nl>,
        keiichiw@chromium.org, Jonathan Corbet <corbet@lwn.net>,
        smitha.t@samsung.com, tom.saeger@oracle.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        jacob-chen@iotwrt.com, Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>, acourbot@chromium.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        posciak@chromium.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, samitolvanen@google.com,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        hugues.fruchet@st.com, ayaka@soulik.info
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:02 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> [PATCH v5 02/22] fixup! v4l2-ctrls: add v4l2_ctrl_request_hdl_find/put/ctrl_find functions

git rebase -i ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
