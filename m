Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41794C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C36223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5vU9eWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C36223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeKMBDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:03:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41820 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeKMBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:03:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id g188-v6so7396885oif.8;
        Mon, 12 Nov 2018 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XewShTb8OK7Ia+MHfRiVu1VBL0Z96GKD2pViMG0gi1Q=;
        b=G5vU9eWPGgxV9GnYcYP4UJovDwnFeJT8WdXRROV+BapLaI36i5n/C/Ryfmh32n9VKk
         9Yh97DoF44YWgtiFmeOspoHRYzN5jDVFZpmMnfG8bjBV7NBPbE8j8l426L12mupK5lLl
         KaZYT68upiSuXB6rm9rDSjxvKZE4AoD18QhK1NhHXKfJlV4sKpY/b5dfucHzVta+NhFl
         X0H0GKl+exnJl/w6P7i1w4ql7MQ49ruxPc7CISb8VJdZamB76H0dxcyjklOTZunL/r7+
         wr0+Xmmnweksw+yJmOJks5wXJOGIF+ef4ZIR+st7OzGOIi6v+wEf+mMEae+9ZYWLo2YJ
         2puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XewShTb8OK7Ia+MHfRiVu1VBL0Z96GKD2pViMG0gi1Q=;
        b=AJUuA9WNW/BEO02SZNJ3NttCL7+3YfiIYrlUaEI4zqUH9FHdk680CnZvUX58U5coGp
         LUtClntgF5DLE7vzz4xdRV1qmsw8vQ5AxhI9Nfrrc8U7uUlMzzG5VNDEPt3pj+uDB2+6
         clr7gsjBIx0u5oriBbedK/RtF0eAHJ5vJO1oYstc8AfXAUzlvoX71zwFjHpMJdqxksGM
         ruAxGI4Vtb2582KLocY7C8TRsSerCIIWYgq/cAKKc1gLP1rs/AChboFhbBEplORFrRnu
         zCBvDPIrPmRU8HYhS4Kj+Wbe3+qzF946ewgRUsmKnqTB4xbfYhKn6XDlb6pAaCIYXivR
         Ix7Q==
X-Gm-Message-State: AGRZ1gIthApg1AHGvhWxq7QwvkNPcuesUhhHZQrvmw+7A3bi05oJUJ96
        tgW2XWxRMhQc5+28mPJBWzz0YjKORxqIymC4nbg=
X-Google-Smtp-Source: AJdET5fK0VK+RHGItRprNXN2FMhe3FsZ8CsQUETdJ1n4WxerPBmmgM+sWi1JWQWPODHB2sOs1I+OuuqT8LMDVyt3g8o=
X-Received: by 2002:aca:308b:: with SMTP id w133-v6mr736370oiw.67.1542035368545;
 Mon, 12 Nov 2018 07:09:28 -0800 (PST)
MIME-Version: 1.0
References: <1541871439-4882-1-git-send-email-martin@kaiser.cx> <AM0PR04MB4211FE365D78EDEB0003D74380C10@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211FE365D78EDEB0003D74380C10@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 12 Nov 2018 13:09:26 -0200
Message-ID: <CAOMZO5DbuuVr7JVpK+DCsE4G=tksTg6CRrCGwyaNO55WDuyRzw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imx: make sure that maps are fully initialized
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Martin Kaiser <martin@kaiser.cx>, Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dong,

On Mon, Nov 12, 2018 at 1:04 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> Thanks for reporting this issue.
> The original code intended to save 3 common lines for both SCU and MMIO pads,
> but it did change the code logic a bit which resulted in a regression specificly
> for NO_PAD_CTL cases used on a few legacy boards. (NO_PAD_CTL is deprecated
> for new boards dts).

Just a clarification: NO_PAD_CTL is not deprecated.

It is not recommended for new dts as we should not rely on the
bootloader pinctrl settings.

> As you both had a patch, i'm not sure who i'm going to expect for a updated one,
> so I would send it my own with both of your tags.

Yes, please send a patch putting a Reported-by tag from Martin and a
Suggested-by tag from Leonard.

Thanks
