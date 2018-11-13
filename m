Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425E22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NADQWZKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6425E22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbeKNAqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:04 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29739 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbeKNAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:04 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="22763950"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2018 07:47:35 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 13 Nov 2018 07:47:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlfmNGbURveAMRTsS0Wja7M/LcETOxE74I8MXNgJwGg=;
 b=NADQWZKlZ48OnoHeb0RwLZcNYBXhADguEadFkPY3MnUEcyuahr9Ylyfa4M1wl68lUCu9/wWdEslWRT3F6IARYNQPmWXN7fnFJCUCGENeMu3s1VrBow6Ee4z9tcI+oNscM43MdxhejU22sYXt7Km4Es0HKShyzAs61m7NNhJdJjU=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2131.namprd11.prod.outlook.com (10.174.112.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 14:47:33 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 14:47:33 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 1/2] regulator: dt-bindings: add regulator-state-standby
 bindings
Thread-Topic: [PATCH 1/2] regulator: dt-bindings: add regulator-state-standby
 bindings
Thread-Index: AQHUe1/P0ivJEHV9Zkq4IQCbZ53osw==
Date:   Tue, 13 Nov 2018 14:47:33 +0000
Message-ID: <1542120469-15450-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1542120469-15450-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542120469-15450-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0057.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::19) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2131;6:oZ7CXjy5jwxcnc3HOjmtbkXPgf3oqa4Z0nCyzxwLfQQZ6NiRRuzH0+D5RoFmltqfzuf1KwwATYHjNPGcPIO+Dm5Ea6BVDNhyN2mjDGrt2jxzUtaYAzyFslS4qnuNMATFEtK1lM/9h88nlRt9E1YjONjFtob9XGf0pOqvS7fN70nDc6GIZjLSoUSu5lZy5bxBuI7gcplgW5bmL3hMT0nHqYxT9an2TkhBekhwGezF1JF17X57nw1DPfFENLKrH2TQbDpFLTz4nEbfdxIbl75U7cEBKTdFSiGZusygl0hTKH3+yLYBjig3CjM+our70djFprRw0aZogbrcDECFuuSB9dJx4Jpz0tYA4RNOdolig5wm1oF13zEJlO1eO6m3UonAxm7UpwceSfOw4tCYewMvT0E4PYgboSIq3ejTHW4rvgE2AzoOl9nKzEhjPNl9RMrBtaZ5pEh8J4By0YtDZcXK6w==;5:9ZbTQ52tTZghQAJB36XJ7pi0CSwnV8avlwyNKRFKtyrSk7jRWmbG1vGULn7iPLzaxtmR/Q5C+mYKvj53C7Hup/zgI38w0eWnpqPllgrx9DX+bbPqdUBc9988t+K/Qd1DMAywHhevlzVCRp9s2eqTTTnKEcHsqcKVPX++EBZH3gc=;7:FylDgBMeNbZtkNLqp1x/s6W4fVD+CBc2abzXFlr1iqt1dyWFZIJI76Y1ODnmFfl+oNG4uJ7N5hpXpqSEv1wm/61/meJlqQlvlxK3VaEYWrYoiJf0Mf+E4FDSTCSK1gL2BHk/rBzSiMS074hST8cjvg==
x-ms-office365-filtering-correlation-id: e99d8565-71dd-465d-d39e-08d64976f1ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2131;
x-ms-traffictypediagnostic: BN6PR1101MB2131:
x-microsoft-antispam-prvs: <BN6PR1101MB21318E36E864D08743CAD015EDC20@BN6PR1101MB2131.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2131;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2131;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(39060400002)(2906002)(446003)(110136005)(11346002)(54906003)(106356001)(72206003)(99286004)(4326008)(26005)(97736004)(386003)(52116002)(25786009)(486006)(2616005)(6506007)(14444005)(76176011)(476003)(105586002)(102836004)(256004)(478600001)(3846002)(6486002)(86362001)(6436002)(8936002)(81166006)(66066001)(81156014)(107886003)(36756003)(71200400001)(71190400001)(305945005)(7736002)(68736007)(5660300001)(316002)(186003)(6512007)(2501003)(6116002)(14454004)(8676002)(2900100001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2131;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LjPcbSizvpzrfz2dPoNybckGOLQN+HualUsFOaijbgdWMUDFYm8Jj/AoE9kEEfVaGNCQRE01ZzOH2dXJMPXc4BsjTQfZJHhaekDgNFqt/N07tcXzs9tUTNz2N1HOlm6+5S7yqBlPsbU7AnWCv/WMKQU1dDX2I1FUaEq50Mmsl27wdXCPcu7JwrVFDDpPvspbh65HMZbveLw7zPzHbH/khEOSCyoDwbaE6uS517zHxfsV5AtVVKpc1vygLpuakEDdIiOLgPPpOME5HGAhtA62fQ7By68MnvL4pSKLp9HtGWAbbzqXEoSOyjXiQCn3H3EB1lQjxWVh+b7eFmIpP+yIdkhdZAJTlnvhphBjQMNBRx8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e99d8565-71dd-465d-d39e-08d64976f1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 14:47:33.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2131
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For state-mem and state-disk regulators can have
various parameters applied such as enabled/disabled,
current mode, voltage etc.

This patch adds documentation on how to set these parameters
in the device tree for the standby state.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Do=
cumentation/devicetree/bindings/regulator/regulator.txt
index 0c3a243..0a3f087 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -33,13 +33,16 @@ Optional properties:
   decreases of any level. This is useful for regulators with exponential
   voltage changes.
 - regulator-soft-start: Enable soft start so that voltage ramps slowly
+- regulator-state-standby sub-root node for Standby mode
+  : equivalent with standby Linux sleep state, which provides energy savin=
gs
+  with a relatively quick transition back time.
 - regulator-state-mem sub-root node for Suspend-to-RAM mode
   : suspend to memory, the device goes to sleep, but all data stored in me=
mory,
   only some external interrupt can wake the device.
 - regulator-state-disk sub-root node for Suspend-to-DISK mode
   : suspend to disk, this state operates similarly to Suspend-to-RAM,
   but includes a final step of writing memory contents to disk.
-- regulator-state-[mem/disk] node has following common properties:
+- regulator-state-[mem/disk/standby] node has following common properties:
 	- regulator-on-in-suspend: regulator should be on in suspend state.
 	- regulator-off-in-suspend: regulator should be off in suspend state.
 	- regulator-suspend-min-microvolt: minimum voltage may be set in
--=20
2.7.4

