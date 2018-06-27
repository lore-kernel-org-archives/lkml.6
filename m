Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361ABC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A56208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDc6criH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A56208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeF0ObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:31:25 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34573 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeF0ObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:31:23 -0400
Received: by mail-ot0-f193.google.com with SMTP id i17-v6so2428359otl.1;
        Wed, 27 Jun 2018 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GDQ0F9n3tQqWYyJvM5W5GSWXgU899PDW2ivSkTlDswk=;
        b=tDc6criHVgH7huvuG6EucskanTAxsB5S6AqUCdxOWLjNX5p5Ojvh/pP4jEQAEUbuBw
         xl1MSuLP+s3Z0udYJqnxNO3mdG3oXWoBodY52s7oEmsGJRx0BLic7pb6L9pDQAnX8YND
         JipymGXvqVlSX0eH3jGXTYm7W8BBYa6XtH2nrga3/8akPFP5mB7eEJ/qvP5i4ZTkQUgP
         9CGRL56q956Kk3aGcOSqMJ4bAjr6WAJJDCpX54CounK0C4PmTfawF5pJtKFilOcP9TAt
         difD1ErVuwYNVY/r5X9/2d8kklik4tfVhxAn+3auyGn423MWD4skxXyaavXjXWRQwns0
         SDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GDQ0F9n3tQqWYyJvM5W5GSWXgU899PDW2ivSkTlDswk=;
        b=XONxkLbnfSHPOCUeYKM6Wj78gMOG+8+V0OEYYSrM0G5c5dCBTSKtehGImLc0kUCBRc
         9P/qNRiMILYtdsD050kJtt6Qc9kGrhjmSoZbk4dBIQouWLBCqVJaondYkNTUZ368RIiJ
         1MD9qXJg943YuRbVcqaE2uYGxdRWRir6IocZYXGwlPTWKWG4RfVOgg+EG0WYMWwsQWlN
         jUZsMFhLfYWjdla4jNu92WNz1qxtlVd8hcoE28zBuirIxM1PPfCbVj/zFCGhi/gbTijA
         ookyZP2nDq+lcb2Ht++J8o6RuIxlkHLmEvYyikyiPh7g42Aj3gqbXDhUL9USRxjidhxi
         cJOQ==
X-Gm-Message-State: APt69E2qnIMvMnRkebuatHl6ittVoGcvI/EUNTVvYaVkJEG9wI7Jm9i4
        N54L9hiNq2BHSY0EbtP6YaHzjE3swrHvjdunuL4=
X-Google-Smtp-Source: AAOMgpdhJf81L3QBSieD49HJ3G30txayQtDBCL1UFoU0Zj/HMVQdtQTfcSAQ2FahmX/IfzqfbyT+XhvRC7Qt40EB6f4=
X-Received: by 2002:a9d:30c2:: with SMTP id r2-v6mr3703557otg.25.1530109883302;
 Wed, 27 Jun 2018 07:31:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 07:31:22
 -0700 (PDT)
In-Reply-To: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
References: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Jun 2018 11:31:22 -0300
Message-ID: <CAOMZO5DoRUSOfV_oh242w6s_1Zs8yAy9Kf4D+WdYym5c+6nucg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Jun 27, 2018 at 5:36 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> +&usdhc3 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc3>;
> +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +       cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> +       keep-power-in-suspend;
> +       enable-sdio-wakeup;
> +       vmmc-supply = <&reg_sd3_vmmc>;
> +       status = "okay";
> +};
> +
>  &usbotg1 {

Please keep the nodes sorted in alphabetical order.
