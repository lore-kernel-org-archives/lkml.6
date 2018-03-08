Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490527-2-15106382287019646868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490526; b=cClDY14Jn0oeHNgZ5XZa25TLRIosfHdZTkCf/PHUE4YVs4J
    UqlqjBCDvUxEOg/DSz6aIrOEXlWnav/q7ehGnENIoAB8Oofy+TIu02saSl5Vk9hO
    uCQYy9wlX759PEjnXBhZNdXBfdjGd4Hn+/4ApHY3+fEGgcSf6CfNtJlCVea5nXHD
    gZHbNTH3VTti+8PAfXzUVsm4RT31rR1c5zWU0WBcdrpbJMvwBJWAhr89AIWih18Z
    AH0MhLHpp5Rn/l8bfaDW5j+esThQgFVo4pR0paAE80uzCHKRkTa7b+v6K0tka53p
    NZkgSS/9gh5ZvtF+n8jKeUFceHCr6R/IWhTx8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490526; bh=TeLtpx
    2CyY5sKWONIel1/U0U5QqM8NQRwtO3j3Xc6i0=; b=VD8b4vv6n7Ro8K+kF1ng6p
    spHNOXpi513VVuzjT3BlOJgtcawEw1bV/1gUNxf7BEWU7GNpHs9wUqLXO9imZf7U
    5VxtADON0Ymf3K084qtS4vn18O82DAR1QpuK6fjO15Lx/PuF+qgfFm8m2QxU2n/m
    ix8orMtmyD0+G5VUHVRQnWiPm8ErMqWxwbFtXlSUrvxQpDrnEmiDxpCyGPuY9pyp
    kDWVITn0aT7XJukk8fo3GoM+pwC3XlgFZqZpvLP4Hl3SVCTSY4k6ZqEVBK2Q253y
    ujNGdDQpdsz8bjV76tppsUKIx4Z3zOozQPlNYQDbBoOnANij2kegG1YAcHzB1SUw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RW3MSnQp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RW3MSnQp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965727AbeCHG2f (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:28:35 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751536AbeCHFAT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dong Aisheng <aisheng.dong@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 027/190] regulator: anatop: set default
 voltage selector for pcie
Thread-Topic: [PATCH AUTOSEL for 4.9 027/190] regulator: anatop: set default
 voltage selector for pcie
Thread-Index: AQHTtpot/oYpDz/6jUirrw3rb2wWOA==
Date: Thu, 8 Mar 2018 04:59:02 +0000
Message-ID: <20180308045810.8041-27-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:k19JFg75y747n3ZMHe2YYx+nUFA5lub2qrdNCgPVjft7+v4k7AKgEgjkrMWlJAHflQ7QSGjvXkVfr7CaXqzu6hRgDDnr2KC8Ieb/eQzaFd7nI2qctdmaljL4KpxUX7hkQ5HryAyS1BmmDTJALmqF6VbrDhj6+R1xltoWlxD1ceByrkaKk02aMNQXchLiZM/38J5yMDaPG1M0xB2+G2q1bm8v35D7hjCWsOoirZWdwJxDpV/Mgbk/cUrS/OwKGCQa;20:MoRnCSo6QJT/75OX3IjRUhnDWbYxHjYtwg26FR2mqElmDrymTlVwUAlCVVsRTZXXGru9AwTYFNYMAp12pEJn7LyM6cPWpYhfurzSSf6DcZGcIKkQ2K5GWr3pK4eziiwjI735SGbRXOodQq1h3MvgQDzG8Mroa9yFIUhdVbSr/60=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07d7611f-4837-4793-cf95-08d584b1744a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09833C985E5D2E4FA50F6946FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(39060400002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(8656006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5utNqKd4nomMN/qNpEg0JUkBuTw/8LIfpMvmAw4cPawWAfljQYVzOxdlc1qLurQ+/o78UT2pXdBVfv3iutfqiGpzWAy2Or8MAk2cmw3MHJsVlcgx3trewZZmrevco9ZDUVAqP+GACiWbSQ8oJ/d58Qjh7B1B5GeWjtsdyMA+qLb4ZMmcZ6vn1VEugjeYLB0uAQTtn6zblVBWvCm46okXcfZOzkiJRDesWaR1xTUFpYPSiQozUI8YGmGpJvqJgXc76Y/zjGc35Djs/7pKJj15kJyPjXM2JnzUJnQCpEOtd0zEjgetSDxvah4Y1a9zentSbNXEPRw5rEGg28G8ePywYg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d7611f-4837-4793-cf95-08d584b1744a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:02.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dong Aisheng <aisheng.dong@nxp.com>

[ Upstream commit 9bf944548169f6153c3d3778cf983cb5db251a0e ]

Set the initial voltage selector for vddpcie in case it's disabled
by default.

This fixes the below warning:
20c8000.anatop:regulator-vddpcie: Failed to read a valid default voltage se=
lector.
anatop_regulator: probe of 20c8000.anatop:regulator-vddpcie failed with err=
or -22

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/regulator/anatop-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anato=
p-regulator.c
index 3a6d0290c54c..c5e272ea4372 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -296,6 +296,11 @@ static int anatop_regulator_probe(struct platform_devi=
ce *pdev)
 		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
 			sreg->sel =3D 22;
=20
+		/* set the default voltage of the pcie phy to be 1.100v */
+		if (!sreg->sel && rdesc->name &&
+		    !strcmp(rdesc->name, "vddpcie"))
+			sreg->sel =3D 0x10;
+
 		if (!sreg->bypass && !sreg->sel) {
 			dev_err(&pdev->dev, "Failed to read a valid default voltage selector.\n=
");
 			return -EINVAL;
--=20
2.14.1
