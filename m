Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB07C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B4A20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUOrc1Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfAaVrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:47:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33281 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaVrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:47:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so4264637otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kL3+GDISpQZ58uwge/BkM8/zP44zX0DhbSWXoUUF9SA=;
        b=jUOrc1MrRT08E0dwyXHhA71uDuyjdfXWS8+4yFHWmkt98ybVJw5P93J3DfbNY2Yevf
         kdTPtsvL+JipSQttZiUqLjJ/BfEIKmjpt+kcJU1o7Tliy8pctozRxX5ZikqbK5Fg2Fwj
         f511KUNPUrKZh2BYIipzDUX2Em72uqgB2s3IoY9lInG74TlmAMGGvy+YhQlT5kmvAeHo
         yjJ0uR5/3dlwxyl22RnFEw0m1t5TublZpVEBAHKNM3NqXNsX1D5QfDkH1xQjwEqc1cWG
         PVePcxpGJgZa2/fU96ptXPaL/hRLH4GeV7TwX/RTN9jGqasx9XuAmdG3JwqQS4RVZOM5
         klmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kL3+GDISpQZ58uwge/BkM8/zP44zX0DhbSWXoUUF9SA=;
        b=lN+sPZIiJJcAh6PPP5Fl1cjAYAleuI053pCYj4bKAANisNBDxQ+EKgV/Z+D4OpqMEH
         FvuCMjwZNilX6rAyEUzJepBVg9x0yx79kXV1+xTj6AEQz4KjXg6FCJeacXkA4k5q6TYi
         07avtoAHpykyLaYi2/s4d+gRef1Lc1gLcb7W8QrtAA+n2y8fx/DPBlER/2iwRcj7a9qn
         1MMrbxkWRJj9ZeiZoXwPj7OL2ZfwIBYsXrqqfAoQj8ctRizwynBTFMwBRhWsnaH0CN9g
         ia04o4143NRJxYThFJkMJj4lWexp7TXFVDTviteCktVdfusFpyG0qqG5cP1cMHON98co
         e9VA==
X-Gm-Message-State: AJcUukf8LUheqoR2ROieKiZhW9gz1Oi1XQ08z24EtGP/YkD3b/lkRIB0
        mlqMjWjdse17YdaUUgBj2ZEbKCCfkzjQWGP1nqc=
X-Google-Smtp-Source: ALg8bN7TI3U5L3SG3mgwt87r70JQeWsyKD1APwwwVJiKY7H8kxex1+kIuc/86beJ7A3jlSVWHs0EKVpZrhNHSP6KgEs=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr28414254otq.255.1548971236353;
 Thu, 31 Jan 2019 13:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20190131204524.1218-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190131204524.1218-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 31 Jan 2019 19:47:06 -0200
Message-ID: <CAOMZO5Dgz1TS_KgCR5ikdYsM=VAS3iJ-TDGuythzxvGULuaC-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Make GPC default interrupt parent
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey

On Thu, Jan 31, 2019 at 7:11 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Now that the GPCv2 driver supports i.MX8MQ, make GPC default interrupt
> parent.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Lucas has already submitted this same change and another one that
selects the GPC driver as part of a series.

My feedback was to send the GPC selection patch first in order to
avoid boot hang when people try to boot without the GPC driver
selected.
