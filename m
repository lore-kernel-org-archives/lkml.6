Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480636-2-5510509354062518197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480635; b=ZtoXRvVOGpkbJ7ofV0YF+ifrDZhCsYxlzYTRtX4OeZpJuIC
    y/w5dystzYcEp88bIL+dS7xYuCxisGaNHdEnwBqUGWa3W9OT0GeLWyhSa26vd8fl
    KvqT6eomntirbbPNoun/Ey3YtYuQLGYTKH++OY6/XUUaBftLgETBWEyIHmsxCcTk
    3/WJN8/xBt8wpwf5g5i6s5WvUJrbbflbLRzEdHNYuYLBuHTcfG6Stb4rTlWxnuft
    ymRN6bqOcL8Z7Ra1NjCIVritrqD1QprsgTpLGXbROFjNxheKE+NAVei9aq5uBLeQ
    3A308MK6EztLm62DyAUyOS/GaQkWVXvlVcMp0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480635; bh=s9XqCt
    2k1FzIyR1o86Pxrhip/Gsfg//VLIRT3fTPb6E=; b=fMx8VbxDGjJjXvDIBPDnTz
    G3YHpqyALPz3HivjU4YAlJ3M+Ze2fmexqdQoOOw7ZNGs5kuvhznxSnwuSala6gyu
    QKKToCg35tLUH6oT+BucMJPdum56rnBI7Y5q0nw3gMw3b44i/IoVZdpIbtrl2Yxa
    RpUqbcunv12vb5+w+89dpxjDV7NNTIABwkf3FEPZ6cUkXti++xFuvgFxhBDoAdfU
    U1mGhlD/eK53SE0w2GEciKx/+5EVY1RasB6aAcQbR0qn2wca2AwtjaJ94cVK+bOC
    kd0ZEzRNGQjMvhNKqMn/8/Ke80jb8LJU3irBfn0JjGNkbVBhty4eCspU1205qG7A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=InCdatr/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheelkeenucevlhhushhtvghrufhiiigvpeehle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=InCdatr/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheelkeenucevlhhushhtvghrufhiiigvpeehle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965620AbeCSRaU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:30:20 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966100AbeCSQHE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 030/167] bus: brcmstb_gisb: Use register
 offsets with writes too
Thread-Topic: [PATCH AUTOSEL for 4.4 030/167] bus: brcmstb_gisb: Use register
 offsets with writes too
Thread-Index: AQHTv5wrZt2qKQJR0E6Z4ZOoGIM+wg==
Date: Mon, 19 Mar 2018 16:05:59 +0000
Message-ID: <20180319160513.16384-30-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:n9PHxnYJQRxbYX3kymwmWfMEpQXS4Fzm8O8boidVLBFVz8egVRjfeyViU+gTVc837y98kTD4t4DDa+fC9VHhl5GZzEXjtSsD0mf/nyL15qp5cTmZU9XN4WNWe/xUEGPzMJP1kp84AkIF3G+ppR0RVbOh7vC30Y4461xL839DYAUuXXAYTltI0+1y45tl3tvXpFmRvRhDVfrpCveKXmc2sE2/SiXvF4WaprRoTR7ylPm00VtRNtYKFOsCUN24p8zL;20:aPjrvI3/2GgMnzmzc/oRw/wBmBZDKU7ICNF7AgNdlCWuDy7JvqZozZp/qkLg9FOE8xM/74TG3XPUxfbA/vpDCeC5TPddwDXflP0XmYnrOlOsHFPPnwT41Wj7K8tA3JT0pCJBZ8TPEMOWtDqAzAQHKTvrVTazG8b+OTPp/yUiQXY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f99a42b-dfb7-4f9c-cbbc-08d58db36fc8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109371A4471FC53D4161744FFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(39060400002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(2004002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /o9QUBwzUQFdaNOLwkWjl5w5QSxPSxo8ls5XPkVgmI4RMH7pAE7sIp6+OeejLh1stB+2CSnxWUrIpX64BMQrL5fPCi2gn5wcc5PoS5FJ9HLKs3jsG6vVDCnyMzlFNs4L3zYXAaQYq7+q9OC3sdbdwtACUPsWzgsIxGH2pJ/EWLhwLLfoDhjRrPGFKgvE+TY6rUFuCa/0ffHbKGbsDbjlekdZWoNIbNvyFgkWfL3tVKE2S2j/seiSPoxLqskcvnsfmu+g4nXpyjaD5A+zaDxFZu40Gaf6Bs0uo79o6F34TuSTETMbDkHCsF4uI2Mb05+qi8BTH29A8RyRsxIhA3MS4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f99a42b-dfb7-4f9c-cbbc-08d58db36fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:59.1175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 856c7ccb9ce7a061f04bdf586f649cb93654e294 ]

This commit corrects the bug introduced in commit f80835875d3d
("bus: brcmstb_gisb: Look up register offsets in a table") such
that gisb_write() translates the register enumeration into an
offset from the base address for writes as well as reads.

Fixes: f80835875d3d ("bus: brcmstb_gisb: Look up register offsets in a tabl=
e")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bus/brcmstb_gisb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f364fa4d24eb..4917d649fa41 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2014 Broadcom Corporation
+ * Copyright (C) 2014-2017 Broadcom
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -123,9 +123,9 @@ static void gisb_write(struct brcmstb_gisb_arb_device *=
gdev, u32 val, int reg)
 		return;
=20
 	if (gdev->big_endian)
-		iowrite32be(val, gdev->base + reg);
+		iowrite32be(val, gdev->base + offset);
 	else
-		iowrite32(val, gdev->base + reg);
+		iowrite32(val, gdev->base + offset);
 }
=20
 static ssize_t gisb_arb_get_timeout(struct device *dev,
--=20
2.14.1
