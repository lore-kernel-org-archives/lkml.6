Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52536C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E42220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E42220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbeLJPOQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:14:16 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:58110 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:14:16 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 10:14:15 EST
X-AuditID: c0a8fbf4-501ff700000014c1-ac-5c0e7f41b9e0
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id D5.2A.05313.14F7E0C5; Mon, 10 Dec 2018 15:59:13 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0415.000; Mon, 10 Dec 2018 15:59:00 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: RE: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support
Thread-Topic: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support
Thread-Index: AQHUkGBmIovKdbc/yUOSMcqr6sJls6V39SaAgAAaUFc=
Date:   Mon, 10 Dec 2018 14:59:00 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4066F2EA76@WILL-MAIL001.REu.RohmEu.com>
References: <20181210081437.GA32228@localhost.localdomain>,<201812102217.lQnGrdFE%fengguang.wu@intel.com>
In-Reply-To: <201812102217.lQnGrdFE%fengguang.wu@intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.240.186.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURjn3Hu9u06vnc0Nj6uM1oNemlbkpaQnwUyFqD/KsVjXdnWjPfTe
        aU2oFDVyECU9oDWd4assKpaFllGNrGWQUlZUVi79R6WysoKU6l5n5V/nd77v9/gO56NwZRWp
        oSx2J8fbWauWlBN3zo35E9cfjDEk9wXmMidDAyRTVneZZO6/qMKZE+NNGHPVNw6Ypze8JDNU
        9p5kvA1BgqkePYmvi9S9uyXTtXneyHR17YOYzt9cSep6n7eTutvVF2W6r/6ELTJ9VFoO6yza
        ZsmzL12zK8pc6r6O5/8g95WdCoESMBLhBpEUgitQKOTD3EBOKeEzgNrae0D4EgTId+I77gYU
        RcI05H4pk6AKzkPnbmZIFBx6CdTY8wOTjGJhJgodDWFhThaqaVgulVVwFRob7ZigEKL0TEUL
        IWEabkX99c0T7kpoQbdqMiQYCVejYKkgMQCciSpLPk4ocRiHXg34sPDEENW3d+FhrEaD/b8m
        XzIHnR8ZnuQvQbU3v5BhvBg1nh3Gw6kK9PD0AHEMqD1TbD1TJJ4pEs8USS0gmgGysRZrHuvk
        UpJ4rjCJd5ht4rHbYfOD8HeOtoLfgfQAgBTQRtP9zhiDMoItEly2AIinMK2avjYsNyhjchwm
        l5kVzEa+0MoJAYAoXKuiE3Npg5I2sa5ijnf8bU2nCG0cre/6qVdCKXkPx+Vz/N/uAoqChwea
        u4GGsDvsnBbRsw6ImQqey+P25Vqszv9UjIqUguQalcDZTRzPFjrNRmk/jIK4IFIrWpyhdb8o
        p4V81iZWw9JOMI96UPnNiysnMjRxdFO6OCiUSOZC+7+IIRAnvjqWrpUmiBb3/J/DkGiOiebW
        Fkwyd7L/W5oS4G3d6wx2xOpfd2cJI1f54Obs6L7MUkXu4I4KS1SqJ2vajKZr5d5N6+9uny6o
        j769cuXghfnd1KNWuPbDxj7j59RgXlHVsKp4565Z91z4goVtBQkbGnpR16HZ/cuS4w1PfHO3
        LSyAxpUuRWzi8W+yTu2l4+Vfk7M/HTlc7TedVj9O0BKCmU1ZhPMC+wdZwsUcpAMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: kbuild test robot [lkp@intel.com]
Sent: Monday, December 10, 2018 4:19 PM
To: Vaittinen, Matti
Cc: kbuild-all@01.org; Vaittinen, Matti; mazziesaccount@gmail.com; broonie@kernel.org; gregkh@linuxfoundation.org; rafael@kernel.org; linus.walleij@linaro.org; linux-kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Haikola, Heikki; Mutanen, Mikko
Subject: Re: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support

> Hi Matti,
>
>Thank you for the patch! Yet something to improve:

>> drivers/gpio/gpio-max77620.c:33:40: error: expected '}' before ';' token
      .types_supported = IRQ_TYPE_EDGE_BOTH;

Sorry folks, something that should not have happened... Please ignore this patch - I'll send new one where I also do ensure the max77620 gets compile tested - tomorrow.

Br.
Matti Vaittinen
