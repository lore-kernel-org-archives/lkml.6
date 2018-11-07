Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346B4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE45F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W2bsSF6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE45F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeKHAnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:43:14 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57252 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHAnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:43:13 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="22491154"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Nov 2018 08:12:27 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 7 Nov 2018 08:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shZo+4rn5TJxpEdDZcaRPY5SCtMMiK59NN9nzTciAho=;
 b=W2bsSF6S8Ve9yh1KZqtCT47k3PX0PJecHKif1x8B3/bqa3235R4PQam/2be0VCIbIhVwYoxvG0c6zKwQdTV5dYijL/HcLFyetgUn4wViLLYn1NJvBVJY5t/VC1dLr++0zbglDsda66hljfZ8R7yd6HRaPFQOzGuzyE0qlqaP+qs=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2257.namprd11.prod.outlook.com (10.174.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 7 Nov 2018 15:12:25 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:12:25 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 0/3] add sama5d2 PIOBU GPIO driver
Thread-Topic: [PATCH 0/3] add sama5d2 PIOBU GPIO driver
Thread-Index: AQHUdqxKvyhV8gyVMEW+6MKHyFZS9A==
Date:   Wed, 7 Nov 2018 15:12:24 +0000
Message-ID: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0097.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::23) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2257;6:I6G27ZUXdrGpCzmpZTc366IWj4oCyUwodYhO9Q8MnetkMrTLc9rS4sWrneMwz5fyPOlvwENZTbLqWnFheoX7Cu/NWJgm+lXvTY2khtEyaYgdYm7ufjASDpKDZnWkrdmUYeaW1b7oZ56fyaJsaAIpXhfYBHsoQ49rkEgERMoRmYPKO5D3a2pPugscHlitzN7wlTS0UmXTxxqGitxwRknV0bpOcFbLPau9R+rh0pqylEZFkuD6wkjLb8tBBVjcoo+VcXuqOmueD/RnS+k+gSFxvncAOjjyh4nicr3Uz41eNjlCmJ/TrvpZaioZ/jENqCz3gyWg7+lFyvWruF+flLKp/ba5kWNHzklvibRc2ycWSp2BjSO2L1YHeVRaE3wbhmc/ZCSKFou8I1PPXMvApp5XMxlSNYusb2442IIrACWKh7HJIrllT/9KzIoqrHNOXKWyjPEUqXl6mKV6OlafpDXRnA==;5:bGo2pPCXj/fg4aCW+KzJVPl/4uDCNfy/bPb5RaXv+zNxcffOt3kfJ4n5e3jntrvz5nT6BLKysTxrBoFSAzmWKAD4KfNmDpaDBcp/FKuJ4/GpJ6wKwIf99HmtsbqfxrgYreZLoEa8W0xYfh8Rc3yxhyfxAu0hY+jGsccjGI0Y+40=;7:GMiFcWNcsX0lxDaN/V9LnqXwFrvW4V9Zr6AZWvvd1Y95L7BbJB/1MUE7kJTxEbfbxZ7xegGuNmNdFwgId8eOh0wNMbmzhT35PxuIASh7VdE5CE+/e6xriYDHx+0VzoYadD1wyyeckx4w1DU4/vetdg==
x-ms-office365-filtering-correlation-id: 6656e1e5-2bbf-4456-6905-08d644c36bf6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2257;
x-ms-traffictypediagnostic: BN6PR1101MB2257:
x-microsoft-antispam-prvs: <BN6PR1101MB22577A0C0A1EA50792E1C174EDC40@BN6PR1101MB2257.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2257;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2257;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(2501003)(5660300001)(99286004)(8936002)(4326008)(97736004)(105586002)(72206003)(386003)(102836004)(6506007)(14454004)(8676002)(26005)(81166006)(52116002)(86362001)(81156014)(2900100001)(68736007)(106356001)(217873002)(476003)(478600001)(36756003)(2616005)(53936002)(305945005)(256004)(14444005)(6512007)(71190400001)(71200400001)(7736002)(2906002)(6486002)(6436002)(186003)(3846002)(66066001)(6116002)(25786009)(486006)(107886003)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2257;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R1mJKdv3BPzm9Az585BYAf0u2Oz3VBEfc6MAJ9gFVjfwfLpvLGd86cBlgonZQDfD/xA3wR6SPN2rVeQGQP8amLzzfW8dZr/CFfyqfj4zWi4X0D3gKBEESpEXW8bUjCw4aDGqMMSHHumHV40GOvSajPaUx3wJ1AjQtprZW55cJtcM9Z6baSzrzUcDFl8gpsfgEB7V9CIOOx8/W1e3rchEFOuQSNy8fhQ/rDEolhnWU14sv6/FNkhS7Jsif4wnkQI6lvp0Vq3rbUO+mncwXc08yQa/GwZxd/PKfrwJCM9gqCu5a60j65QrdSAdwk06e6mk39LkgACyk14ennVdPZV4qDM6UBnvGVkkNj8MYKGzZrA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6656e1e5-2bbf-4456-6905-08d644c36bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:12:25.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sama5d2 SoC the PIOBU pins do not lose their
voltage during Backup/Self-refresh mode. This can
be useful, for example, when the voltage must remain
positive for a peripheral during Backup/Self-refresh
mode (suspend-to ram is the Linux equivalent state).

This patch series:
- documents the driver's necessary device tree bindings
- adds a MAINTAINER for the driver,
- provides a basic GPIO controller driver for them

Andrei Stefanescu (3):
  dt-bindings: gpio: add sama5d2 PIOBU support
  MAINTAINERS: add maintainer for sama5d2 PIOBU GPIO driver
  gpio: added driver for sama5d2 PIOBU pins

 .../bindings/gpio/gpio-sama5d2-piobu.txt           |  23 ++
 MAINTAINERS                                        |   7 +
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sama5d2-piobu.c                  | 254 +++++++++++++++++=
++++
 5 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-pio=
bu.txt
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c

--=20
2.7.4

