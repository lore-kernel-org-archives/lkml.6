Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2131C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E7820989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bWXV/SO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E7820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeKUTVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:21:36 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:34765 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKUTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:21:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="23532957"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Nov 2018 01:47:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 21 Nov 2018 01:47:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbwD0sRN1MqfHQTSAcxBOs8XYXAL3aRc4LR9a15n+lA=;
 b=bWXV/SO5oUqT5ZzRxHV1QT6LKTN+E/IJDjEYQSZU2wf0UTaHk6QTvI7zABwaQyiu7t8/oDI1koGF9SoISbwWecYFiPWMYMfatzHJwMBfDhKK7JYzB0g4tYWx2wQPdgt2ArrSmIXLg4TWfU4C+2Yt+RzFlrXlmiydQ1oIP7gBmYM=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0073.namprd11.prod.outlook.com (10.164.155.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Wed, 21 Nov 2018 08:47:54 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 08:47:54 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 0/3] drm: Add panel support for PDA 91-00156-A0
Thread-Topic: [PATCH 0/3] drm: Add panel support for PDA 91-00156-A0
Thread-Index: AQHUgXbk0CpbqpgBb0CN8X4J5d/5zQ==
Date:   Wed, 21 Nov 2018 08:47:54 +0000
Message-ID: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::31) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB0073;6:WPRw05T3gv4nyp42XfKl2X3R4xG78BRClcgX4m1pF36P3WMp1c0MKweleBqEomq3vl7Hl1+cWwdpYXoWo2Aw3yXWvvrx+rWcMY4Mrsf0C4RF5Ao2Fta8RcGoCDesRqBEIC95OvZL/Wks7+GerNqxIDVu30awdSmWuk+OK6f0EyBmbS8/SYmM5t4z0LCQD7VaVb73S7wYHdb1IuvpEcku2ah5ti6nsKT5SDWc2ZdXvO7+i6ZfyGZzdK7Tx6KiqQ5R4y8dUwt353BWCZE8Fwa1P9Zi1/8Jb+DmbTsPMrqLGxOq5sjJw9h3p22ig8Jlc0SphhCOAKFEdzwpRFimkJhhw+8qRIUqZrYi4tKC+Lk25pqs5P2n2zv46wIi0FJ/MeHj87TUxsXrBihGuK6oan2tBwl+c0BZVxeRkI6cJdl83TdIcpqN0mKcWmTP5Z62dU3WZJ/GdcOLw64lebX7oCf9Zw==;5:VPL9GbmiPbr5KRlzi4JOflZNN3A/vXkD707xZbJMCMp0Sje3qAU7av2liS4+KmP36RS1VwDMd+9jpmr6GUj5c6578sCTLd6hub8/SI3gwUMNlRkRoXqrJm4ZEXK6mzgmxVeFi59dGhxcIwfsodeN6g8FBMyMP1+8DH75Xv78eOU=;7:6rE67H67kBqS+d0I3DV8rD2+gr0EUaQbq476tYffkh9aCImVYo/29UPBdPXNTOID1VJRhjv7uvhN4nCmd340Iwb+AdU9YI7Fv6MXMapKFN7O2SJ2E7W3te8V1uJ2Z78QWyzF4EzObakGoAftpXBC3g==
x-ms-office365-filtering-correlation-id: 3b2150b8-2a24-41c1-4046-08d64f8e0749
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0073;
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB0073A311B9C3580C387851EBE8DA0@DM5PR11MB0073.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231442)(944501410)(4982022)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR11MB0073;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB0073;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(52116002)(106356001)(186003)(99286004)(5660300001)(2906002)(26005)(14454004)(7736002)(2501003)(105586002)(102836004)(386003)(6506007)(81156014)(305945005)(8936002)(8676002)(71190400001)(71200400001)(19273905006)(68736007)(3846002)(256004)(66066001)(36756003)(72206003)(6116002)(966005)(2616005)(81166006)(478600001)(476003)(6306002)(6512007)(2201001)(6486002)(486006)(6436002)(107886003)(97736004)(39060400002)(4326008)(53936002)(6636002)(2900100001)(316002)(25786009)(110136005)(54906003)(86362001)(562404015)(563064011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0073;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uDhGWreUt9IXGTuGvpj5QpvreSrkHzcB9sx+y4d7IDvv0ac5XC7wAcQ13L+kO2QjvP8QemDowL2yfK08wdGt+5+CW+jT+l+gJjmVEY5zEO+kE9Sv7oIvHvywvnQufST67ZIOkQWBU5YSTKHMYch5I85VdorIHCvzfRvC4zGTcQNfM7Mx5U+cKNAxMAB1RpT8VsZDUZ81gO7ixsQgslu1m3FZifpC1e6nFhtPfNVqd3tXNDrIPfhtI+xH8mV/DgiCKpxf91+E5WY9x20HilTZkCpJhqh4dGCRguypiX3fAkZnHgz8iA/6H+QXyXWkT/4q6CFty1SEaUq6D+YjqMN0/XE8JpCP3U9+PsssXI0XD0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2150b8-2a24-41c1-4046-08d64f8e0749
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 08:47:54.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds support for PDA (Precision Design Associates, Inc.)
vendor, and for the PDA 91-00156-A0 simple panel, together with the binding=
s.

The series is on top of http://anongit.freedesktop.org/git/drm/drm.git drm-=
next
branch.

Cristian Birsan (1):
  dt-bindings: drm/panel: simple: add support for PDA 91-00156-A0

Eugen Hristev (2):
  dt-bindings: add vendor prefix for PDA Precision Design Associates,
    Inc.
  drm/panel: simple: add support for PDA 91-00156-A0 panel

 .../bindings/display/panel/pda,91-00156-a0.txt     |  7 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++=
++++
 3 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-=
00156-a0.txt

--=20
2.7.4

