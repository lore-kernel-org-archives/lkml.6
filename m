Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D4AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D009F20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfVznJ8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D009F20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeGKCUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:20:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41866 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbeGKCUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:20:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so46421779oiw.8;
        Tue, 10 Jul 2018 19:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=engQVCfH5aJoqnWxbM+fEItlEwh6bmUbcuq032wKzvQ=;
        b=bfVznJ8VmH3bw4H3WjzxtKWKcpExLcs7YGOoUORjxcFphQtRpZ7xb5yUK/z5wI8rc9
         NRYlTUA8OXR2RhWse5loKstrpUfqsqC4MRwmmwRTNOYiFbsru01Uq4vd+jKfVRfUKtZq
         pwp9ZP98Lg1sefZOFPP07334JI/8OspNucURf3q1WxqygS2TBv/tdztfR6w37NbEIyCf
         Maxdp7KLs6vcrMZZxR+vp1hZS4yhmdl9rw5yIDWB5HLS6TK1z4LvtWYqkDfd6/fDWtae
         tBDkDaxMLfJPJUBF+7kgimyTXncFm4OyGpWxzFd4+MOC9jfgWJ0AN/d2Zc7bEtRF3J6u
         WY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=engQVCfH5aJoqnWxbM+fEItlEwh6bmUbcuq032wKzvQ=;
        b=OwBV1yfpevYnmtmWxr+gERR9AutLzzIyw23Wnyci6ABD4eo1dT+tlJLoNRnS2yuT8+
         iqs87INSp3ubnOkdYvsuPcJmUbeDmWYKBwNlKnUxN0267W4D2dX38k1R8XYuMQXqGRVS
         Mo11qQnYkp3V4V0uxpoWnUsXq9lRSvjmv1KV6KFWiHQmv0/2iiyBPgDF6KziPJyigf57
         Zet18i6GtDDvQek4DPCqdjj1mDvRDmHR41nOlV+rkL8p+7au7vlyHUD5J5n9KZhat1Eq
         KrFFfRWWrU61AyBvcdYfMeRiydykkfwDwffpeGJJ+klYRWlFf/Y37I+nWsDgggzB3Enu
         Bi6w==
X-Gm-Message-State: APt69E2QNMvksLVSQ1Pql9M/qXxJh2jiZFZ6O8VbCvXGHJ88V+O4t3or
        hMT0BcgfLesqTsIogJxP1DBVddsluvK0XiAblPs=
X-Google-Smtp-Source: AAOMgpcYgfJ/o8HQKScklpW4PE3H6o0OwSTmYsgjqgSatu5PTUYFfgofRHcvxYAVr2uPFdyxrTb49KuEOFKlBZITVLY=
X-Received: by 2002:aca:d4d7:: with SMTP id l206-v6mr28241260oig.52.1531275538118;
 Tue, 10 Jul 2018 19:18:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 19:18:57
 -0700 (PDT)
In-Reply-To: <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com> <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 Jul 2018 23:18:57 -0300
Message-ID: <CAOMZO5BLjAes7K-nGQFj9TeDOnTooJ-eZugpmGdNwktMS5Pd-g@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx: add ocram_s support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 9:58 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, enable it as another mmio sram.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
