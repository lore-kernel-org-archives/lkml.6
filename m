Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DE2C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4AA20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eSkMNWxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4AA20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeKEUdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:33:36 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24478 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeKEUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:33:35 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="20663182"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Nov 2018 04:14:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 5 Nov 2018 04:14:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHF3Pid0sB8/RDwMGG7eZRlvPOUyhm0hmqNXt0lPifc=;
 b=eSkMNWxEZmvQk4kz3HEVQKvyKUkSLEIZccNGv1ZrrW1h5kSxicZmhtOa3m2kBebfj2Raes1BxPAxxPyGkwnGbu9Btbi5r24ALqHJnLKx0lGvFheIeE6AbYuJfrovv1WwUKSh1YOPmL4r1mkzpXHqBdS3z10QpjRDjgwgWfr+w1Q=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0630.namprd11.prod.outlook.com (10.163.159.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 5 Nov 2018 11:14:21 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 11:14:21 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/4] power: reset: at91-poweroff: cleanups
Thread-Topic: [PATCH 0/4] power: reset: at91-poweroff: cleanups
Thread-Index: AQHUdPizBxRgNlHZ0UK63L0p5o7HOA==
Date:   Mon, 5 Nov 2018 11:14:21 +0000
Message-ID: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:802:2::35) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0630;6:YMv/XrLEwxolY+RkOFtiaHzaL3asWDKrPx03HgrOtUBwLasqNFbe+9rFqsU1ZCOQfxrNedO1ovkg/pn+GdfN2hPfzDKIDZTqKDDLpH0WR+So9vfrEPggEOQqXqeR37EcdOtRf/orHjPuXQEV/ar9vhN/KmstubXFMQRE8/FSoz4ENkQhBosrciu/thXV3eVydyuptqkfb3qIKJUp9DjzR6N8icc0WSZc6u0aaZM81df28/hfW445aL0hEmkgTr2UiA9YOn05UX+p4fIHnZSTzNeM8yBIBxAXgWf8lpjDU/L+tNcpwqnDgce3Uf419JwiS8D0TjkYsJXBnUenX2JTVVy5A/z13cfJB7MoTDEk3Uq5y7+VkLYcs6e+ER/MtBmHaEX/xOj8FRwWF8tq0SchJ+VXbLeoCu4tAe6h7LstDh8VENFqtEXarZkunHXI8KcTnn6QmOM5e88aCF2sAupO8Q==;5:luPUrGrTjTmvKcIVkvbYO22kHqAwYWSIoteRl5o5b3EshmYCSM8DqmqudPR859sPUo9qBRwnwpPcnSDBPhBPwV1CtrarHOZPooLLwHg30dnTPuq4TsLNno/7UR1Yo9mVhcgkVht0NdyfKhJBi+MfD2H0MDX2ofxYfjje2sQYibA=;7:Jt150FJLQTKnlLdck+X9erIFEX1QaNJQOKYYd8Gi3UyWcqdDvNW7ayet1ICxje2L6q1EjLVSW+i2Qu8E2mry2cQPNOwvqdgFi326QhaivMRkcDPGugAIg7bfCXbVo5hNmR3w5gu1BBud19I191mwSg==
x-ms-office365-filtering-correlation-id: b49ec7f1-f778-4fd0-909a-08d6430fd5c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0630;
x-ms-traffictypediagnostic: BY2PR11MB0630:
x-microsoft-antispam-prvs: <BY2PR11MB063057A6F2F096A830C25FA887CA0@BY2PR11MB0630.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0630;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0630;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(14454004)(486006)(102836004)(5660300001)(6506007)(6512007)(386003)(86362001)(966005)(53936002)(25786009)(72206003)(2616005)(476003)(186003)(478600001)(26005)(4326008)(36756003)(2900100001)(71200400001)(6306002)(71190400001)(2501003)(105586002)(52116002)(97736004)(8936002)(8676002)(305945005)(81166006)(81156014)(68736007)(2906002)(6486002)(106356001)(66066001)(7736002)(6116002)(3846002)(6436002)(256004)(107886003)(316002)(54906003)(110136005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0630;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P1XDAJV5Y61wl1GERE02mkNWyPULnOdMCvvnzHsIrZux6eViN9IGn69w0aQ+CHwJJXGI0uB707cM9Z12diSlkhQSEnsYcTXn+3APPlNOvzO9EUV2Mbds5OC0QgRRoL458Y+aR7ywzgHpa8JT3+eX3Ur/NZldW6MTDYmXVELU5P41OvtHkVfE9ONGYXRbyjlQZgNgJoSoZ7e+3Zl+yL6MTJnkKRRHxSnDT6PTKXNdCUm5Uqteh8xDE4r/u5zTdTWB967XhX/BvFf9/hEo6e7A2BVCsJi8SK1Mmc6NCC5Iar1wiRMRzrtLJEWBtZqdIO0+MeWRw+5GdRBJqgLtgARDgYgAJfdlrYx/XY+2mJfYV4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b49ec7f1-f778-4fd0-909a-08d6430fd5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 11:14:21.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0630
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series includes cleanups for at91-poweroff.c similar to the one did fo=
r
SAMA5D2 Xplained SHDWC on series at [1].

Changes were tested on SAMA5D3 Xplained, SAMA5D4 Xplained and AT91SAM9G35-E=
K
boards.

Thank you,
Claudiu Beznea

[1] https://www.spinics.net/lists/arm-kernel/msg673559.html

Claudiu Beznea (4):
  power: reset: at91-poweroff: use one poweroff function for
    at91-poweroff
  power: reset: at91-poweroff: move shdwc related data to one structure
  power: reset: at91-poweroff: check shdwc data structure at the
    beginning of probe
  power: reset: at91-poweroff: remove at91_ramc_of_match

 drivers/power/reset/at91-poweroff.c | 101 +++++++++++++++++++++-----------=
----
 1 file changed, 59 insertions(+), 42 deletions(-)

--=20
2.7.4

