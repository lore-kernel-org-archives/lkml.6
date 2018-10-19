Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D0ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2440820644
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvzF+EPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2440820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJSU6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:58:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39954 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbeJSU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:58:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so26705774oib.7;
        Fri, 19 Oct 2018 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fuw1h4GK8wNV4ILgy/wPRw3Q0q49RLc7Bf4oU1kaISQ=;
        b=kvzF+EPF2m0gTwA5TSFojpjSQROFYxRnmXSZwM94DwPF503ix8ai0lxB7D3x1/Vz6W
         D+/SIjo/BSoxXugofmPQHVXKHBhbfhqk8dKL2IvCBW6Q+Wr3rXQV6xFoH3zEIJFlwgGY
         QihBJV6K5L+8WzcMGRTg1T1vcUuxnZeP7QWIUZkfVYdNocCf+TEsxb4vZzSILGLKero5
         Tkd5x4lsryHqY9QUpXC5jkpDKA+j5ur7vn7SPrT/QSwU4kZoVzUpJdbg0pzcduCCYy9J
         SAIxrzLBcHvNC9aSbcbC1KZglyHrL/e64lt2LPPIROfpqX5pq3Gdrj/KkqjNxW10sTza
         i90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fuw1h4GK8wNV4ILgy/wPRw3Q0q49RLc7Bf4oU1kaISQ=;
        b=TaQ9xxSQiVezy0bOy9MDC/z+XPXQGD9zrK4Ap1wqWij+3CHk9b3DK7RciR1+wAzUZm
         iN/rhLVFXekG0GwdmhYhoTEnjBcO6xQ2YJea6Yw2gYLvU88TtmHcZiDCHZ6CNWNo+kP6
         XZ/g/MahznTdgGTfb5NLu8AvFfAkMV8g/nD4ZXPb1sRwMbz1jQvRlbJ/boeyPD47j5rr
         9+Nj7HzirNdm5xikJrrTnaQT2kleIEuqU266dZVwjkqXy9nFdXABpARdY1pyf2mZbsIU
         bmFfasvr/sMRHvjw0Dw/stbpiT3+J8On9WKeR+ITmr69JY9vbDr0yJErTeGG8sj6IND6
         ztcQ==
X-Gm-Message-State: ABuFfoj81AQH+wXcCPv8D3hiVqVZuaMruQANqZNxL3kLrVS37oeioNP7
        IdVhfkWYAWAXo9odI/92bCxHozjvrufT6jCOBU4=
X-Google-Smtp-Source: ACcGV62KnlTAgPkH2gFDe0e2krT9rOPZV7jjMTTSvRh7Q2SnZcrXVJNEJrStaY6SQ2ExxosyrOFzT8KKyCBUGk+j8bk=
X-Received: by 2002:aca:3006:: with SMTP id w6-v6mr19052781oiw.342.1539953525489;
 Fri, 19 Oct 2018 05:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 19 Oct 2018 09:51:55 -0300
Message-ID: <CAOMZO5AqZrYmc474NjvG1nF94ZNvgHyv7Q3R+QxrLmSN6EhYDw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
To:     qiangqing.zhang@nxp.com
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On Fri, Oct 19, 2018 at 6:43 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:
>
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> CAN transceiver is different on RevA and RevB board.
> It's active high on RevA while active low on Rev B.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts  |  5 ++++
>  arch/arm/boot/dts/imx6sx-sdb.dtsi | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 6dd9bebfe027..092b8de142a8 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -10,6 +10,11 @@
>
>  / {
>         model = "Freescale i.MX6 SoloX SDB RevB Board";
> +
> +       /* Transceiver EN/STBY is active low on RevB board */
> +       reg_can_stby: regulator-can-stby {
> +               gpio = <&gpio4 27 GPIO_ACTIVE_LOW>;

Don't we need a  gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>; and also a
"enable-active-high" entries in the imx6sx-sdb-reva.dts?
