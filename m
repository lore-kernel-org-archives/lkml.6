Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C93C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2220870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWbyEfTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfAWMFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:05:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40690 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:05:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so1667790oth.7;
        Wed, 23 Jan 2019 04:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9TwJ1j5yEdIFN1A7rT9eyqiW4pldLuvYW0t8/NNdAo=;
        b=YWbyEfTih1s0Fl0lYFJFoH/ijsMJ0+UcS9pImgtlgYIRaUPD33vKhytk7SYD5cMgN5
         AqkOZBIsMXdmqtg3o+KAZFgqFaJfPQpYrXARcQPLA6EPrtbO8ku8cnRJ/669SRLEFpQM
         V3SUcMkIQoF0j3vAh5/epfTBi5ZSSCMYoTiuSwFA1HUrLciKA/8CvN3vKLm2d0/DCb/R
         Qy6MimNPS79rqdzbbC5gIldJIozMpBNXd+kojDWHNECRPINmx83KWp9oZDXHQb3k1KDN
         9RO+zukX+NUxap/odvokJI4BDJtq2uWLR+ZmfGLSM8il9iX58bMnXFRAwuYyjQKPXe4w
         4sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9TwJ1j5yEdIFN1A7rT9eyqiW4pldLuvYW0t8/NNdAo=;
        b=DwmJQ0fji81py2jwYiwvvooL4S3iq7zB2p28Fm1fmQV4m7Ho/WZ2gV6NGa+GdHzusY
         xcgZqgts6dRGGMhBGEWrvLfi0LYCKuJlzYXtahB572dgQkP665H1rdd8MTvXjicVjd+/
         iVPHs5/GD/Y9eq9g2gomrUrq0no2GpZ6AgL1xEqkDBna4pkV5WEvXp2ekkJ7U83I7M3K
         ejkCMP2y0FPBj0P/ahqARCndKHWhtmcFzXTmVspktQ0lonp5TlUAUyAtbhpAgzIrQd3w
         EWy+g/pNElAh3Dw2qoRtnZNVYlhntpVowoMfDWPHuQ1Iu6idnsKh3qML33bS3BRwn2nj
         qrdw==
X-Gm-Message-State: AJcUukdLjmcY3qBbFNZn3sYqwLJ3krur1iZFQoiEPUwtoCyvOy7Qm5/b
        eZuDPIhERvruIEF+06bXevHhwsnFtORSQiBfPi8=
X-Google-Smtp-Source: ALg8bN5I/iLqRsN3OrLpP0ETcUXnmageQmFJf5kHhHo9uoVbU0a7eGuADpnjcXNqunKxS/cGmzhqwul8NboXIfss5SY=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr1323530otj.228.1548245111137;
 Wed, 23 Jan 2019 04:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20190122164958.30666-1-aford173@gmail.com>
In-Reply-To: <20190122164958.30666-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 23 Jan 2019 10:05:07 -0200
Message-ID: <CAOMZO5DvotRNhzeDEhz_jPVBmme8ozJ80KhjLH7mBGBd-K3BFg@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Jan 22, 2019 at 2:50 PM Adam Ford <aford173@gmail.com> wrote:

> +       tmp102@4a {

temperature-sensor@4a

> +               compatible = "ti,tmp102";
> +               reg = <0x4a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_tempsense>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       tmp102@49 {

temperature-sensor@49

> +               compatible = "ti,tmp102";
> +               reg = <0x49>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       at24@51 {

eeprom@51

> +               compatible = "atmel,24c64";
> +               pagesize = <32>;
> +               read-only;      /* Manufacturing EEPROM programmed at factory */
> +               reg = <0x51>;
> +       };
> +
> +       at24@52 {

eeprom@52

With these changes you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
