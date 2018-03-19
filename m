Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495598-2-12494305695192539161
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
    t=1521495598; b=uHMDoxx3pEEkuiVE563oM/6DXeLMUV5gyQlP2Syal3PxFE1
    Yfh2hOm+Q2lktrZRJ5qJZ8JBGQOSFgJQZ9vVAJALYIM2WLDXosuZNq/OGdo+LYWs
    CIDN9MMUhR89lTN+iiLf947bC8PU7HWcQzxZyiS20J0zmZBNTG3PxHyjel5eiN2o
    0yjCMXfNdw62L7a5j0MCDZ1S8rev+3OujHBpIOy6i/dswCq368MoFe7u180viVHc
    5/3ciH76n3SficVeaA6o1Vb+VGgFvCszmS5Wdt6WDTQTFdYKNNe9DMrGC+DnGVj2
    7pajoGPFd59UPplfepqQV/lfUQFdtz77TtZRF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495598; bh=DLZoe9
    /cZ0zZP4vc4AkeN93+D7CRVLVQvR6tTvmR7M8=; b=E63hhb6GBTgfndx6g4L/rH
    HsacOpDEEow3c+D5N2gBRM1NiEVr58FO0s4MbQ0sQUc2dgUYiyCDwU9Lhzt5LbN3
    Co/Auk8HC5Vs4vT/b7xaIvU3IWvQQdqtqDccUwuC0a5EC1EQ7SqY3/lL0THqkdHZ
    Y6zb2v58pfrMIDO/lWytExmtO3blbIFhRg94w0hsYVCvWXUoIMViZvs75IQvymVN
    8YEwwpDti2vZNytTd+4/tpDofIhs+/RzozmX5tO8EmP25mr13ATGpvOPi2ACLEpC
    WrwSf7opNolof4XdCpzN8z753CkY5DPG8HSbxgdBUGtm8E23ut9ihSXIN7HkARqQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SzzqdlGi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieduieenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SzzqdlGi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieduieenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965053AbeCSP7L (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:11 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:17872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965043AbeCSP7I (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 041/281] bus: brcmstb_gisb: Use register
 offsets with writes too
Thread-Topic: [PATCH AUTOSEL for 4.9 041/281] bus: brcmstb_gisb: Use register
 offsets with writes too
Thread-Index: AQHTv5slBfTnXXSjJEKWxTFTLxr4pg==
Date: Mon, 19 Mar 2018 15:58:39 +0000
Message-ID: <20180319155742.13731-41-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:0Jli167MdREitNZ7PGEo+IpESdp7fR0WshaoDepNf05NSsBG98dm2idWv5BlttingnaS7+SGgCzZ/OkPD0trp8drM6DnWto19oJVV8UPEAVQJDBY0UvHndtpTfLS64+ZzHY69zNYn3gktVYXXOYkz1BPencmP8MVw1FHd3cYVCGRrk9EtDmI7UqppKlzUAaAqTIYAMw7hx3OhBeZ0XxKMhu6RYOAHKNMKMIlgqExFeN+dwHMqIDYXsqMUSxQ8VOK;20:Cke17pYsXej2Ms/m4T+6saawctoA9CDtFA+7hMxBUYMSLwXIRZg+swHT6qHdaXMjHMl+dRDVnGRzLWVPKOXDw/dx/78GuS/lp2+dIM04M0LxOeMshjQZAPA1pgF6AqlfZjFknqshCjGSvOBVvI3og6CcA/V708JdZQ2P0Y1Gywk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16650545-590f-474e-2f27-08d58db2569d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015DA9EF3B3AEED4C5FF5E6FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(39060400002)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(22906009)(2004002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: OHpoXYj3t6p2Y1G1iQFWoxJc7BP51zpNpjmZygFdrGyCctiFIXh1nXuMUo3k5lEBCNNTS975sLEl3Lm7UKdd0jpmiDWUVVeulY+KLIiBm1yVLYwJREl3DDt75qmcHVkK92TvneClhDhK5pJz3j9dmoHxFuuwNmVCvs0sbcXeOKnFrbUJcXR3q7G/Y8H74U+3nrNa5wZCLQmqp43OMsTIHdTcVwHBnO4jmZKldae8gUS+N1+TKIZZ1QYIgqLc0mwlb0BgeSEgdzY2+Fu/pihHTdD04tZaHDTqWy49SR/tMmneIZ1h/j7AlS2n7zwu/fX9K7wFm6l/ZsEIMxY1xIpfIw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16650545-590f-474e-2f27-08d58db2569d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:39.1070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 72fe0a5a8bf3..a94598d0945a 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2014 Broadcom Corporation
+ * Copyright (C) 2014-2017 Broadcom
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -127,9 +127,9 @@ static void gisb_write(struct brcmstb_gisb_arb_device *=
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
