Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F9320651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwqUxcTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBZNKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:10:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42249 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:10:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so10973520oto.9;
        Tue, 26 Feb 2019 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EArR8rhNWZekF6rsLjjqi+vFLF5tmLAxYkTWIKoQGM=;
        b=bwqUxcTsQHZ9Mgt20p5DslZ/cNFCPHQDHc/0hYIEgKWRBMV3j5ypDxc1VR1BemvoSu
         ATCS+1Q/FjY4pZr9Sl5ZPaV0UwR7kmjFpePIdEt1/haZAEGl+r0Fw2xVlM8A+uAj9H0H
         pHXsYfvEYjG156GPIDNOL4mh8miW0v5AwU1Uftwe414o+RghAKSJ0acuxIG2XJF38eQv
         iOXveMXPA9Ev3WdNbY3a/4Xoq9ALTrioYqJU36iNAuZegxC92ijy5RUgDh0bvQlWEnuL
         iBxjihRgvr8r+XmujjzgpaWsfj5dWEVQwXGyDnuzvKk/9ICXofjVyOd10R9hL4TpsgaO
         wecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EArR8rhNWZekF6rsLjjqi+vFLF5tmLAxYkTWIKoQGM=;
        b=ZL0dTgEpaJek+V+tSiN4/KGGbdAYDrZ/bdRt2GeReJzQUHkjLDDhDeBakc3d1Ys5ZF
         aUUzVo2IrOLuEWgcqAqcWd+Gegx8/t4LJqVRWmr8Br7nkzsO8DEUZ4PRmDrvg1jJZ9X+
         CZMDg3IHS31NPZqQpsWglHdIiYz0xQ/3Rw9avEkQ3U9mBjVcEhYD5WPIyRKj+rPdVLXS
         ehU6+NjdH2JZzbCaDG0rQ/MMY1qEKepIW6ExALzRXIjNrKrZMgnw8PcMQc98se7zNV8O
         wDAzRYfF01LTHnabcC3X4baFTv60ahXzMZC3IXqumAEqpt0qhTPuI85cNXV59dyP3u/B
         RtvA==
X-Gm-Message-State: AHQUAuY+hyujVeOyhsSUrsTHe62WsgZtEGfyexliEjFJ5s6MCm2J1FfN
        AUuPK9ytayDN3ZgWX6pVK7qH8xEbY1RIqczqLUY=
X-Google-Smtp-Source: AHgI3IYJZEx+LeSTjQLznF5XKAYJTInOGzkPDk7wzOxULVtJcwUtxEDb/o5WbO+gHlt7XnMoEEYR23ZC4bx7glHho9A=
X-Received: by 2002:a05:6830:1547:: with SMTP id l7mr14510496otp.196.1551186617179;
 Tue, 26 Feb 2019 05:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com> <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
 <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
In-Reply-To: <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 10:10:07 -0300
Message-ID: <CAOMZO5DTR8aLphJBCqR=oLOz5aZXuNfPVEgUk6K_YOdVD0UK+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:05 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:

> I get your point here. But for the moment it is identical with
> "fsl,imx7d-sdma" so there is no need to add it now!
>
> See the discussion here, and comment from Lucas:
>
> https://lkml.org/lkml/2019/1/28/194

Lucas' suggestion was not change the sdma driver code and I also agree with it.

The SoC dts should still use:

compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
