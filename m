Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05560C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33A42082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33A42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLDTOb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:14:31 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:48448 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLDTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:14:31 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 14:14:29 EST
X-AuditID: c0a8fbf4-519ff700000014c1-75-5c06ce8ef48f
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id FA.57.05313.E8EC60C5; Tue,  4 Dec 2018 19:59:26 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0415.000; Tue, 4 Dec 2018 19:59:25 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>
Subject: RE: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Thread-Topic: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Thread-Index: AQHUe0fdW8Mz1FW0uUqQ8Q7xdFN+k6VoDTEAgAW97maAATqoh4AACBHE
Date:   Tue, 4 Dec 2018 18:59:24 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4066F2E07D@WILL-MAIL001.REu.RohmEu.com>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
 <20181204071315.GA31204@localhost.localdomain>,<154394767367.88331.17679291261207728780@swboyd.mtv.corp.google.com>
In-Reply-To: <154394767367.88331.17679291261207728780@swboyd.mtv.corp.google.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.240.170.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxzGPfe9wDWXCukR3Uwq2QdRNoMxJ44t+zJyF7dkaswWQgKX9UIJ
        bSH3tip+mEVljGYyFHxZQaEKBEkmtBoD2EUsRoWCiMQqikrSZlvBlzgxmBVk9/ZO5dN5znnO
        73nuSf6XwfV/U2lMic0uSjbBYqQSiP6OmHdD7U0q75PLnkw0dNBPowM/f4YWB7OQ90QXiSL9
        1QDdnf2LRDMthwCqPNFMotHRbhr5wiESHb48QqMXvzwikeenVgKN9zVRaLo9DFDg6B8ARTzD
        GGpqu0GgsaEvUbjjKY0W/T00ehPyEmiirhFHwUv2LyBfdXuB4sdDYzj//F4VzTc6xwi+1/2Q
        5kfablP8GX8U432dNRQ/GfJT/PnWffyZ2nqS751z0nzthU7Av/R9+O3y3MTsQsG+a0dJse3j
        zwsSzdfcDVT5ILHnVVOUdoJbuAvoGMhtgi/65jEXSGD03B0Au38P4trmOoBTZ88pDsNQXDZ0
        TdAqkMKthVdOheMAzgUZeDPWQKjGCq4AnvXPYNolAfpmD+GazoGxriOkqgkuHQ50Xo0Hsdx2
        eO9pG6WVhXA4dL8+fknHbYOTlU/iQYD7ANY4n8U1zhng/Ugzpn02B1v9o/8/IRVGw29ITa+F
        c9VaAc6thy2X/qE0nQHbPTO4VpwMB3+LEHUg1b0k1r0EcS9B3EuQFkB0AmgVSizFgl3cmCmJ
        jkypzGxVlh/KrD6gTc9sD1gMfBUAHAOMSSwdpPL0pLBLrrAGwEoGM6ay3R8pR8sLy0wVZkE2
        50sOiygHAGRwYwo7qXqsSajYK0plb61VDGE0sLmj/+bqObW5VBTLRemtu5phjJC1DStgsiQW
        i3uKSiz29zbG6NTwhLQUWbSZRElw2M356mDky8pkqFaS0qsfUXvlcsGqnGroEFiZZmDn3WSe
        nlMNs8P2LnYaGJTXrWB3qliS8vu8o6aVQEwJtFzA1EC78N5KcwKmeoovXb2s4cHX/RMu57qc
        K4EH9TrPAN31aODP01PfN3sfe9dkXa/aqoude57xzYbsyv1inWH4Rr0j9unV6d7oWPBx8dyW
        4e8eNjrlI1v7jkdNletf5/568mC6Cx4uivBVC019NZHNCyeR6eLLVcd25+xlYwM/iu6Za6WF
        R/OL2rONhGwWNq7DJVn4DzunlFH7AwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,
.
> > I think we should use parent device's node, not the paren node in DT,
> > right? But I agree, we should only look "one level up in the chain".

> Are these two things different? I'm suggesting looking at
> device_node::parent and trying to find a #clock-cells property.

I thought that MFD sub-devices may completely lack the DT node but I will verify this tomorrow. BTW, I already did the patch version 6 which checks the dev->parent->of_node if #clock-cells is not found from device's own node or if own node is NULL.

Br. Matti Vaittinen 
