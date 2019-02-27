Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1961BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC764218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXDYrYGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfB0BnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:43:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35751 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfB0BnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:43:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so13005794otm.2;
        Tue, 26 Feb 2019 17:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ePahqNB+NAIQktminfToWaR6W6q1o8dl+pknU+Oug8=;
        b=bXDYrYGlVlnwVA0Uw3rnfWSp/TCkYI5Y6IfmAJ0TdyhbyuVco2uOy64+IYGufqSEXy
         nuIXA/vM8bmleJpQao/cvOAPx+t29A8n7SmNGukKSs22u1zuUeJ4d9idJBWI4nDpk2sY
         +zQjhGoCRmLcT9Rwm3HdB6WHMeA735PEBgdtSZd2yZv+9GALI8nWWCaK0MrdXA5C13e/
         /dwnqZtvJa4cWXyXUz5lt0SyJroMc3FDvAHTMzrSfjsDwUN+HC3LdDMVAes0eLEiBa6v
         Rc/D1OnbhPIkCpB8of1Sx1sxVeM2W3q13gFUpxcq8NRA0t4GHDZhM3aZAXTZsavRFbhk
         r6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ePahqNB+NAIQktminfToWaR6W6q1o8dl+pknU+Oug8=;
        b=QRo0ppcTNJRHIzE1mUUqKJ1vcbzjMgGoCesY/XxWUXr8bZSmcirMLx5VfVOHTfNjLX
         QS1k4GU7A8wElgpgup3XkPAK0rKrWbabewyCIoOUxBqjH1Y0NPcUln3ctiZhMAUZhGH2
         qrR8U23XVbd+n/lw1HziH2h8XsGa0XjKK19LSmDjTym64opakZ3DAR7SNExhpUilf3sd
         L0dMXEvnGciPyNTPpt0BU38c4pYmBobV1rTJuYAqBQf7LM+SgUZy0kFQYtHB4WXQ1Mon
         99+OYvPCEQIe5aM/8G0ngfmLWs02go6ZRzkmgznd0kKsE5waEabqycorI0tV5kGHMxUk
         mlZQ==
X-Gm-Message-State: AHQUAuaBGimEJwyKsNVY4Ie22OF3Ryu1WceNpw0+BIgtva0sLP97S/cB
        d+NcB9SJv1PrRaWdWVpCQl3VR/Hjt0yE8rtjoV0=
X-Google-Smtp-Source: APXvYqzKVLSr+oXMH1RsvLJ9BPOZZxFkxDhAmIsLK0hM34vcBg/7oAWVWWnmOQ7nHhyuOx4L1aeCTFXw01ZhwC8TN/4=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr615500otn.203.1551231791522;
 Tue, 26 Feb 2019 17:43:11 -0800 (PST)
MIME-Version: 1.0
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com> <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 22:42:59 -0300
Message-ID: <CAOMZO5AddhSfB0Efuy-Z5GjvpXMwyBGHB8H6YTWcztXzCOWVyA@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 2/2] arm64: dts: freescale: imx8mq: add clock
 for GPIO node
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:29 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> i.MX8MQ has clock gate for each GPIO bank, add clock info
> to GPIO node for clock management.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
