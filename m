Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94627C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9A021934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdjRV2Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbfBMDQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:16:20 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36854 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfBMDQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:16:20 -0500
Received: by mail-ed1-f68.google.com with SMTP id o59so687299edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGLmxX5ZZsqNrzRqmlY+znpV0Tv4SjK3drY64f4I7RQ=;
        b=NdjRV2AkBoCYs4CMtMmZD1P7f5lG91kzbO5Lpi23lRhde68jxHuElkaSkE5xJpRTou
         zD/pFfZAkm07OoViak8OAXUqPabC5YldpllHiV1sEqSD0YAY3uxpWwcjpYKqmCJ57j8a
         ObxWXA8lpCxg0x5Qmu+6dBRFnTK/btn/sannI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGLmxX5ZZsqNrzRqmlY+znpV0Tv4SjK3drY64f4I7RQ=;
        b=T0O0xbBzYX50N/ZqPKluneG5k5eqslqfUwezGUi0WJ5RAj8w0d6J2ZzwRQfTWV4fAl
         wdA18zFh1muvhKB+/bjC49q4hTbk26xxWZ2k4bnmIza9OhHcGLLpotjHFoxtX8EwE2oT
         Vi7IGRn8xUMbDMioa9iBy4vPcqMGRwTxwFtzsmDBaTYk/IRKqZ9NQ7jcYCkWcEtkb5Xr
         JW/qCwXahzojRu9oUl/skN4DPxmGTZZbXyxUyFSBHNHNG9J2rGxqCo2vPOKcYyFFCqUH
         vJobJ01t0tc8EOiQv/8msqtD2gEjlc7E+98PUubZJxUszedKeZHLFIx1Trd1yaTdWjuW
         aLpg==
X-Gm-Message-State: AHQUAuaXvTUOE0M1IkwcZ0LGxtl/Vt0JfWqjw2NMWAMCd5ZA0X6et5B3
        YkmVFWG3iXbO2Sdw+6u59v0fRC3SKOXCnXfr5NC/iA==
X-Google-Smtp-Source: AHgI3Iagdzfvaw1AKF2EX1ODY4PiP1tZf1Oy9WDHWF5NA3gs+48hPwOAjiM0GPckew/0120f9vY0o58S4jtdcXGEOFg=
X-Received: by 2002:a17:906:5501:: with SMTP id r1mr4927214ejp.167.1550027777901;
 Tue, 12 Feb 2019 19:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131093131.245531-1-pihsun@chromium.org> <20190131093131.245531-3-pihsun@chromium.org>
 <20190202001749.GT81583@google.com> <cc1407f1-c236-f0af-a6c1-366aeac259f4@gmail.com>
In-Reply-To: <cc1407f1-c236-f0af-a6c1-366aeac259f4@gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 13 Feb 2019 11:16:07 +0800
Message-ID: <CANdKZ0dMOsj_8oa1z8Uhs_UGotVkBpcqVP=uBM7n2XbHUvBWwQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 2:02 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 02/02/2019 01:17, Matthias Kaehlcke wrote:
> > Hi Pi-Hsun,
> >
> > a few comments inline.
> >
> > It's the first time I dabble into remoteproc, I don't claim to have a
> > complete understanding of the driver at this point ;-)
> >
> > On Thu, Jan 31, 2019 at 05:31:27PM +0800, Pi-Hsun Shih wrote:
> >> From: Erin Lo <erin.lo@mediatek.com>
> >>
> >> Provide a basic driver to control Cortex M4 co-processor
> >>
> >> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> >> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >> ---
> >> Changes from v3:
> >>  - Fix some issue found by checkpatch.
> >>  - Make writes aligned in scp_ipi_send.
> >>
> >> Changes from v2:
> >>  - Squash patch 3 from v2 (separate the ipi interface) into this patch.
> >>  - Remove unused name argument from scp_ipi_register.
> >>  - Add scp_ipi_unregister for proper cleanup.
> >>  - Move IPI ids in sync with firmware.
> >>  - Add mb() in proper place, and correctly clear the run->signaled.
> >>
> >> Changes from v1:
> >>  - Extract functions and rename variables in mtk_scp.c.
> >> ---
> >>  drivers/remoteproc/Kconfig            |   9 +
> >>  drivers/remoteproc/Makefile           |   1 +
> >>  drivers/remoteproc/mtk_common.h       |  73 +++++
> >>  drivers/remoteproc/mtk_scp.c          | 441 ++++++++++++++++++++++++++
> >>  drivers/remoteproc/mtk_scp_ipi.c      | 157 +++++++++
> >>  include/linux/platform_data/mtk_scp.h | 135 ++++++++
> >>  6 files changed, 816 insertions(+)
> >>  create mode 100644 drivers/remoteproc/mtk_common.h
> >>  create mode 100644 drivers/remoteproc/mtk_scp.c
> >>  create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
> >>  create mode 100644 include/linux/platform_data/mtk_scp.h
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index f0abd260804473..ee0bda23768938 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -22,6 +22,15 @@ config IMX_REMOTEPROC
> >>
> >>        It's safe to say N here.
> >>
> >> +config MTK_SCP
> >> +        tristate "Mediatek SCP support"
> >> +        depends on ARCH_MEDIATEK
> >> +        help
> >> +          Say y here to support Mediatek's SCP (Cortex M4
> >> +          on MT8183) via the remote processor framework.
> >
> > It would be good to spell out SCP somewhere, e.g.
> >
> > "... support Mediatek's system control processor (SCP) via ..."
> >
> > the example is less important IMO, though it's prefectly fine if you
> > can still squeeze it in ;-)
> >
>
> In which way is this different from
> drivers/soc/mediatek/mtk-scpsys.c ?
>
> Regards,
> Matthias (the other one ;)

drivers/remoteprocs/mtk_scp.c is for SCP (System Companion Processor)
on MTK's platform, and drivers/soc/mediatek/mtk-scpsys.c is for SCPSYS
(System Control Processor System). Despite the similar name, they're
not relevant.
