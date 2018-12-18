Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9FD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoCeipWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLRKY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:24:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44539 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:24:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so15118744otl.11;
        Tue, 18 Dec 2018 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yo7Facm+uSYKgarZQ4xUxE44ZtaxU+yeTJgTB+RxuT0=;
        b=DoCeipWgtTObf1Tdh3wWrZagBXIJM5ER3+NFm/HmgSmJN7g1hJenXjpkmfsvUpAJyX
         V9y6SRJc9CjB37efxJFzrZDHDOYsc5UrruqOv7SttCLhGYVlHZY1wdwG7MAQuvqdFG2b
         NQRt69okHxgGmMKRHcGd0vrhhjgP1v1xX01GKkBNzWQP88FjAgmj5+m646HKLpVeGB7g
         V4zO0j6bt6vIKCiBUWkFSYswIF9HMuknk+Hha/IgvuOjnhZXZ52FVZhOgLlDbJ73mEuu
         lmUrJbMEiT95g+gOsIngC4daKM8S/X4iuER9DypFd8BXQvdvZeVKLXuqbdOC+j9D0sit
         5uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yo7Facm+uSYKgarZQ4xUxE44ZtaxU+yeTJgTB+RxuT0=;
        b=kb0qjlniiN6PMA2wyzcWeBXz6LzfyDLs2u/aqGnbX2ek/83yOouq/PUiFo8JfpaoYk
         HEOARRducYUouse9HC0LOKUIAVJPy6+D7HoIXH100TzRF0fD0bZLTBPZlfQ4OfrONSfr
         OwSK2dJ4sIo+Z90THml88fSR/0uGrNtm0263UyVO9iaUYuhqfAEJhip1O3qrleI+F2Gd
         RZVDXeK8bBpNeNgtRt+yGSNMm8kuvblrE/of5D1ZS8/dPqphPqChEJVtiGusw90/cTSY
         HeFBNSAmrT1ffLcZr7sp/W5e0whCQ+SgGMqJpjx9GYcv/wBJkh6tALMazshjEgMKdVqq
         t2Yw==
X-Gm-Message-State: AA+aEWaUr9QqGXCHxcsV2Z/hEV6mn7xZ3NCo9JjFAM/3Jw2zLWPMBGxC
        uy60ptdJCTmwwkRNFVv6e73N/1Iz3MtettZant2jnA==
X-Google-Smtp-Source: AFSGD/UIY/FTWyCQeuSxVhLDdIJHQw2yDs06WOA6Fw6acKSMAU4CFGKmoRCvw5FSH7KkT9q6DFZjc1tO4F9uZiDpDYE=
X-Received: by 2002:a9d:282:: with SMTP id 2mr11560721otl.287.1545128665354;
 Tue, 18 Dec 2018 02:24:25 -0800 (PST)
MIME-Version: 1.0
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Dec 2018 08:24:19 -0200
Message-ID: <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, Dec 18, 2018 at 12:56 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> On i.MX8M, some of the bus clocks' rate could be changed in TF-A,

Do you mean ATF (ARM Trusted Firmware) instead?
