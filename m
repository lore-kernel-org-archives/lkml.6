Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B946C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FC420663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwjFB5lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfBYOCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:02:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44268 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBYOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:02:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id a81so7263275oii.11;
        Mon, 25 Feb 2019 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+IP6+JPekbm8jAsqHfQ3Jf4WF9cDnYSkNQYtrDYJ8o=;
        b=EwjFB5lcJmCLcgEPexRP9rjGc4PxtyBW/atLnZLFuX3k5lbSwHsvzorA90feQ0bCqf
         VG9WIldyQR+b+5GjPdF9xKZ7pfFlNT1lgs1d95VeUMuyjb4PxUXbnImcCbuY1pSIqqK8
         2OGqwes2e/g2pdfyfgXv21Uh4QV66spuIpzyYsIucsZzurJjjIGj1Kd2pUhaLPHg1TEp
         gqJddc1i3haCV5AEVGZEYBWPsrsyLFMZXezhkS8tMWqLfkUX2v3+JV6DWIrpITnQFffD
         QJQWHD0Xt9KLYZW0GWzWEJinA23H/CHR52arNO0hgGfFJ5NJZI7mh8iDP4y2q08AvaAr
         MyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+IP6+JPekbm8jAsqHfQ3Jf4WF9cDnYSkNQYtrDYJ8o=;
        b=f4+xHxvfe5P426mPX+ccN6MbuPZI9BeWFFgR9i4rqIWek3Sl5GgqamD+Yy1raWq8nt
         W9WNFNRUUvZcyS7bxyOo1fGGzKdWskgQqxuxr3ZDKmuFdBtIdn9CiRfrFb22R3D1VRH1
         I6f7CH5j/5SPthV3kJeykaqej9257guppafX0HhXiNyQUw5h5B1Dcsh07apyOFuMZsJG
         1HFt9C5HdxbWwYUVbRk0cD0peGZ1iC/6PjFENwlWcIeF1+rWNfmXpYBwavOnAZf6QaKN
         TBGShIYfYpljAcINiI9Ovsksyi19pHShExVNKQQmxPnLNR7/dUHSjxEGZIHKpWdV2/Ih
         VfAQ==
X-Gm-Message-State: AHQUAuY2DbYq0//Wg4N1GfpKXiJKMd5taeLnKVfIo8uyBNISrn4Wm8FB
        1+bwptfNKK+KIJ+A5Mkp2jUy2oc5c22ruoFmTCU=
X-Google-Smtp-Source: AHgI3IbPkn4fcMh2B0k9NfZBp611Uv0f0xLQiL2WAeZJKaY3fsVDix/v94nbjEkceLYNo8fva+o09wXo0FBj/5aBDxA=
X-Received: by 2002:aca:b886:: with SMTP id i128mr11368051oif.65.1551103352609;
 Mon, 25 Feb 2019 06:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
From:   Chris Spencer <spencercw@gmail.com>
Date:   Mon, 25 Feb 2019 14:02:21 +0000
Message-ID: <CAGUNXRQdETxnJGP9uQs91mn1w9qJrh4PhZz72bwEh63hrKCX7A@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, 25 Feb 2019 at 13:26, Daniel Baluta <daniel.baluta@nxp.com> wrote:
>   arm64: dts: imx8mq: Add SDMA nodes
>   arm64: dts: imx8mq: Add SAI2 node
>   arm64: dts: imx8qm: Add SAI pinctrl configuration
>   arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
>   arm64: dts: imx8qm: Enable wm8524 codec

imx8qm ought to be imx8mq here by the looks of it.

Thanks,
Chris
