Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9703AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE7B20844
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpcZ3btE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE7B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeGBXOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:14:52 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45699 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeGBXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:14:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id m2-v6so124355oim.12;
        Mon, 02 Jul 2018 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/U5q+eIZfjDIYKctrLb08XSTIKz3yf5Nq4NXswsquiI=;
        b=IpcZ3btEWP0W5Uqd9sxMdT2wqilAU/KgL18mzze+eby83G96SKLJqKeR89W7dI6J+u
         wCYyhafzp0O0PSOYqk8Qyg/tUPBPjCUAwU8ncDM3ZPkHf5fJPtCLQyjB9ky7Wd/KBp7W
         TN4XD1LsvqlAyYpZSwF+SI050WhGFD/amGxonRAkuMpDNmOVjnjGU5KJ/EQeA4L+Q7PK
         aZmXqyzZPeOziIstY0X09xDSZGpCN1MHIjYiYBPyLTFX9f5vPzUcaZsQYwx7QoZVrxvP
         aJ4Ssxu3j5HeivGEOZZUV+LDayyDHkR8+fSiFqJEqZ9tKAVVgCho4KM27gaX2V+N+lUh
         2uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/U5q+eIZfjDIYKctrLb08XSTIKz3yf5Nq4NXswsquiI=;
        b=GtRG3xKWnTIIM6Oy4tM3W6uvlDAIe4e2akaRsssTTnfEzgu2EDl9KRpU9h1XukAb5P
         Id0K1bvEiG+oCLgbx84TBsI97e2jtkj/lSmxkyFaXifRzeu5L9RAuRJlWTaLXFZd4pVJ
         ad+Jo0N1AcvcnXXPn/LjvDvIngKRDllqB/U8nSE+kF7fZuA+YcuT4Ul6BhBEoc8Jqnr2
         8bNg74bdmetf9XYLtWOE8P6tgnbw9CQ+4P8174L6+swi6rRu0flbdQliGL1aj+5srhBt
         hAQgsmXpx7yHY7Ad4XRmcgToXvvn/jHep9gRe6Lml/LrJ5ZWBZTybUaxzIfSdb06rwdM
         i6GQ==
X-Gm-Message-State: APt69E1JOglD6kG0xIYcVXAA4nFsqDQtIr9MtOqfCzVW3moK86rqL4oH
        wVofY5CnfFxvVNLYV+UyJUTQbRAkwfE6FxOWxgE=
X-Google-Smtp-Source: AAOMgpd3k1L6ughjEsjOmleWC6rW5OpoX2eOYBdTfrp6712qpuioqqmlEoOjzalPvJlknXSTD3fyAsZX78G69eSmO/0=
X-Received: by 2002:aca:3ac6:: with SMTP id h189-v6mr18999694oia.336.1530573290162;
 Mon, 02 Jul 2018 16:14:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 16:14:49 -0700 (PDT)
In-Reply-To: <1530526335.15665.13.camel@nxp.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon> <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
 <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com> <1530526335.15665.13.camel@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Jul 2018 20:14:49 -0300
Message-ID: <CAOMZO5AxsvOhWi47goBm7YuqiLEhZ5fgK4BtCqg_hyLtdWfqfA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Sun, Jul 1, 2018 at 11:12 PM, Robin Gong <yibin.gong@nxp.com> wrote:

> But in fact, the original dts is not correct without 'regulator-always-
> on'since SW4 is the critical DDR power rail, although, it's kept on in
> the previous kernel by no switches enable/disable interfaces provided
> in pfuze driver. Adding new property which can be done totally by the
> common 'regulator-always-on' is not a good choice. Keep the dts patch
> adding 'regulator-always-on' ahead of pfuze driver pach adding
> enable/disable interface is enough for such case I think.

We really want to avoid  breaking old dtb's running a new kernel.
