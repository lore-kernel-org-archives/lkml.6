Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3445FC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D895524BA6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN7agN6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D895524BA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936167AbeF2Vqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:46:43 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34949 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeF2Vqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:46:40 -0400
Received: by mail-ot0-f194.google.com with SMTP id j8-v6so8682842otl.2;
        Fri, 29 Jun 2018 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rYsRQI04gyPTcPnwgGdlGNB3ccLRJa0foohtvMQIhiE=;
        b=BN7agN6XxbLJKesliEn0qsWuzlpqz/cXWmrv95QUEimmOOqz8bNVXLuXrgHC3DuA3W
         RrAfr8cFmT7y8jFIMlsHV5qlL84tjkWIDwDhfmHE76xMssF7soJLNTW15SwQ4Fqp6leR
         E3iQUdzzJicUQwOEcVgFaVqCJbiBkcBr9WZeFOkQPnreVK+nlF5cVQzdwLOAZx4tZ2D3
         DPKr11RqVAN4/fmMTlZ6e4N6y+8pk3I7uDjtIWKLyJ5uk7iBn566gqEAnFvw7PtpjcMr
         1vtxgcc73BCzDaQo1EP5RvxwwamRjGsp/6drUbXMvFpZWydAJJB00znHCwcSW8jG2haW
         wHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rYsRQI04gyPTcPnwgGdlGNB3ccLRJa0foohtvMQIhiE=;
        b=QL0QTU/J0D/jTorVTjK27f/yuUxeQ0I+RZmBzL4THqccU+6uJ6luEdXrji9FMs8LC7
         tyJ6JPVjcPYIzN+fer7PNhoFpQck+OB0haIhCOde34Z9rWwAU8oHmUOPa/Oyt1fDXtCS
         /aAKoZmE/wf5R3EcEJvoR/isMuq4fY902tKeW2wK75VXoSeTcC3HhszVG79cmjSUnnMS
         LbWaxImYTLvUsDAHu/pUlhcw87d5k4JrQtw5f3xkpKC+cuOJYyj7peRfeA19cKf5rUHH
         J3qejiGUvkMtqMQcT1nenFVOawWNOAzdSrE8D/y6Hts5j1qmWFL+yC9UzDtyjaysubqM
         IfDg==
X-Gm-Message-State: APt69E3LCo2rqCKf0sC6A8BPOALREHQpBhdOStPXB+uHyP56hVM2QzXd
        bL2yClND0ieWSytDSO2+ty0nkwgKQ55MR+PJXj7g1g==
X-Google-Smtp-Source: AAOMgpcIlHkWfPLysy2SDulzMRhvc+Yj0yycqL1+wD/rP0SWCABreM+nlx18yrSqXeHiWfA909HBVri+hRaVS6rYaSw=
X-Received: by 2002:a9d:211d:: with SMTP id i29-v6mr10579495otb.38.1530308800235;
 Fri, 29 Jun 2018 14:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:46:39
 -0700 (PDT)
In-Reply-To: <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de> <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 29 Jun 2018 18:46:39 -0300
Message-ID: <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Jagan Teki <jagan@amarulasolutions.com>,
        jacopo mondi <jacopo@jmondi.org>
Cc:     Philipp Zabel <pza@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Fri, Jun 1, 2018 at 2:19 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:

> I actually tried even on video0 which I forgot to post the log [4].
> Now I understand I'm trying for wrong device to capture look like
> video0 which is ipu1 prepenc firing kernel oops. I'm trying to debug
> this and let me know if have any suggestion to look into.
>
> [   56.800074] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x000002b0
> [   57.369660] ipu1_ic_prpenc: EOF timeout
> [   57.849692] ipu1_ic_prpenc: wait last EOF timeout
> [   57.855703] ipu1_ic_prpenc: pipeline start failed with -110

Could you please test this series from Jacopo?
https://www.mail-archive.com/linux-media@vger.kernel.org/msg133191.html

It seems that it would fix this problem.

Thanks
