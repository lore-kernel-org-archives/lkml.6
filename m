Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761692075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761692075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIEOzW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:55:22 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.212]:2656 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbeIEOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:55:22 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-west-2.aws.symcld.net id C3/F8-29357-52FAF8B5; Wed, 05 Sep 2018 10:25:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+JIrShJLcpLzFFi42Jx8l0noKuyvj/
  a4PwhS4v5R86xWmzcfJvF4uFVf4tVU3eyWGx6fI3VouvXSmaLy7vmsFksvX6RyaJ17xF2i7/b
  N7FYvNgi7sDtsWbeGkaPnbPusntsWtXJ5rF5Sb3Hxnc7mDz6/xp4fN4kF8AexZqZl5RfkcCac
  Wu7S8Fspopv+36zNTA+Y+xi5OIQEljJKDH/wU8WCGcPo0THplb2LkZODjYBfYlvfw4ydTFycI
  gIqEmcnqcPUsMs8IVZ4v2582A1wgK+EhduNTCC2CIC/hJtF1YyQdhOEgt3HAWzWQRUJC4/28U
  MYvMKGEk0Tv8AtewYo8SsyW/YQBKcAoESPzavBBvKKCAm8f3UGrBmZgFxiVtP5oPZEgICEkv2
  nGeGsEUlXj7+xwpiiwItaDm4hwUiriDx+eA8NoheHYkFuz9B2eYS2ycvhZqpLbFs4WuogwQlT
  s58wgLypJCAskTDFd4JjOKzkGyehWTSLCSTZiGZNAvJpAWMrKsYLZKKMtMzSnITM3N0DQ0MdA
  0NjXQNjS10DS0M9BKrdJP1Sot1y1OLS3SN9BLLi/WKK3OTc1L08lJLNjECk0VKQdeWHYwzVqQ
  fYpTkYFIS5ZXx6I8W4kvKT6nMSCzOiC8qzUktPsQow8GhJMF7Yi1QTrAoNT21Ii0zB5i2YNIS
  HDxKIry/QNK8xQWJucWZ6RCpU4zGHPOOTp3EzPHnPZAUYsnLz0uVEuedD1IqAFKaUZoHNwiWT
  i8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuY9BzKFJzOvBG7fK6BTmIBOWXKgB+SUkkSElF
  QD47J2nZ6b38sWPBarl07dE3u8ctmp34K/gy4s7EuIYPlWufr+r687N/lb7FqwyELsvbT9fab
  4gnXXXRK8vkkoCy/UelWuKuRTuPXsAsH5T6SPb5O/0/lpbRu706y/WQa7tf03ny3c9M4z9+En
  Lddv5kWuIj9fqcUu2nbC3tviSW7p9uKXVTtdepRYijMSDbWYi4oTAW53R22iAwAA
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-6.tower-365.messagelabs.com!1536143139!154546!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27989 invoked from network); 5 Sep 2018 10:25:40 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-6.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Sep 2018 10:25:40 -0000
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 5 Sep 2018
 05:25:39 -0500
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0415.000; Wed, 5 Sep 2018 12:25:37 +0200
From:   "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Thread-Topic: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC
 Pro
Thread-Index: AQHURGPzIwyHLmDZAE2D+R0KNiU+YKTgHY2AgAACmgCAATsbAA==
Date:   Wed, 5 Sep 2018 10:25:37 +0000
Message-ID: <20180905102536.GC15467@agonzal-linux>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
 <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
 <CAOMZO5B26iFCY2DeBHa6_=uRT3zgdP5J+HBqzpPY-=7HHgP9EA@mail.gmail.com>
In-Reply-To: <CAOMZO5B26iFCY2DeBHa6_=uRT3zgdP5J+HBqzpPY-=7HHgP9EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [10.101.2.194]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47934663C063D24DA764197D041FF55A@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio, thanks for the review.

>Missing a panel attached to the lcdif?
>

My intention was to add the board support first, and then one or more panels 
as independent patches.

Doesn't that make more sense that adding a default panel with the board 
support?

Thanks,
Alex
