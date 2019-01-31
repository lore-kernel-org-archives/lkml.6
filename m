Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164DAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA05F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BP2exMI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfAaM3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:29:16 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24423 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:29:15 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="26139716"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 05:29:14 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVQgwxOAfsSaFBTBG+Lj3oaJdyxlWnEntQSrbIu4IyA=;
 b=BP2exMI54HKZpoj3qx784qv9A2r/0fByCYb74dM5HcyGKuxKkSTOtLezH8nMsBBiNiHnkToIu5PcGHUA+nbyCabGoIPx92lF4tDGwivHp5cdwebHRMRBuQ7sy3Qj3ijFBNU3HGYuIMMVC5awpBXR1o+wO/3YEMXnBjDZxHEwssg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:12 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:12 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/7] add support for SAM9X60 pin controller
Thread-Topic: [PATCH 0/7] add support for SAM9X60 pin controller
Thread-Index: AQHUuWCSpvS2KbRwaEKRGWaTrGVUuQ==
Date:   Thu, 31 Jan 2019 12:29:12 +0000
Message-ID: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:800:90::22) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1454;6:4vFabOHQTbvQQKEtgEmAd7Rn4qtbv/RbGRiHrdFsAu2JMasioQ9HzCkDYq4cANbojGdXAyjFdXoyBZpAGIJSzXd0ZxXnEuUDg8S6Hgg3zw7jZ+JmBSb8qMYIVTMnt+JZ95H/J3RAH+wqlxNdvumEQ2/PXURuJ2Dl6sFf9OpwG8GaGX9xiN/u0SYIDX9YAwZOCqgSx7TyND6zEjamB/gGXlfF0II0HTlAGYUB4Q4cImB14P/Ujl7GKDyJ3EDSQQXp91OTC2+iczfpYEmwkx4CcAF57o0zfZPy1g4abf/Q3048Eyz2twNlRNkT7yJ6oSnVW5m510yLiUv5IRvMEa3tOjx8DC2X2SzhivWY6OY2RsDkxDi5LQKqkanK+cTFlfjpDkabVQ1pkVw2f0dhKF3Cuq0rokbmaXuRm4tG7l1nLlKogM6owPVx5oHVAuIFn2JctRtQ3qnOTaapdwZeQj+dUg==;5:77K5JDDNT+N1OXSOqmm/XN24W+riTUd/HxGJiqMUyudYH0xOU15ySeCeq8zFvBFrj2cxveXFb2VqbjCKFmGQdqHA2EVIOjqG4PSJKg33LzkFRiZLPpwc8tA3rxf/3wlDvhfSW946lbQ2TR185x3BGqEkvICquP0uuM+aZN9Yyiz4ePodGq/io4lKX5/72xEvtuPh8ldmsr0UVjwiPc46eQ==;7:icl7IhfZ8xVFXxXXwML8uEZNeiZCpOSwSafsg5YXHRlNYqVZ7oz6xMGc9/XzVy+w6KfspOKttCm/H5wurAknuD1OxQKecghS2Jh1HU+FKHy4Nw6nUvHEcT41ggzOLs+E04G0RxRdNK7cz3fE5o//TQ==
x-ms-office365-filtering-correlation-id: 8685c5e9-d2ba-435d-aa82-08d68777b454
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1454;
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB1454868EE9E7F700312F33C287910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(4744005)(52116002)(99286004)(6436002)(316002)(6486002)(86362001)(54906003)(14444005)(2501003)(256004)(105586002)(6636002)(53936002)(106356001)(26005)(71190400001)(6506007)(386003)(71200400001)(102836004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1454;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nUaPTOyZw2kQ5sFC0CZ0hdDi3A02YnZLBJRHz25Cmm+1zgk/cxh8ox1lY2sKeD27ZzSfthLx5Xow1tFH727VDLdMrzrqOalO3c9tuvmKGa7hckHiAxeIFtEPNhHJ+69wxu7ce6kdkN7aPRYZYmmWWELilGeJg1hIn1kzI7JyhunSaTpjMGPuqvwpqeme8kDKquQc03+WeX0XJoGomMrlQ2uhRFD2dMd5CEpnTX6tkKXkH8Oab+uk4blBxeXTtc0q27B30A2RM23+Z40OPI34oTE5oOf7KHNu/OwI/29Oc4gNIpZm0UUr45XVLpf/bHATecKNB4qSxPsuNPWJ+5f4edxGAJeBo/ZpBdugR+daSR2kVO/uYdYfuCeu/ZnxDGRY0k/GJlZpOowiNnWIvx/hcxd2u73x+PBeudSctUs2i5M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8685c5e9-d2ba-435d-aa82-08d68777b454
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:08.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series adds drive strenght and slew rate support for SAMX60's pin
controller. For drive strenght we could have 2 values: low, high.
For slew rate we could have 2 values: enable, disabled.

Besides this I took the chance and adapt the documentation for at91 pinctrl
driver.

Claudiu Beznea (7):
  pinctrl: at91: add option to use drive strength bits
  pinctrl: at91: add drive strength support for SAM9X60
  pinctrl: at91: add compatibles for SAM9X60 pin controller
  dt-bindings: add documentation for banks
  dt-bindings: add bindings for SAM9X60
  pinctrl: at91: add slewrate support for SAM9X60
  dt-bindings: add documentation for slew rate

 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |  27 ++++-
 drivers/pinctrl/pinctrl-at91.c                     | 134 +++++++++++++++++=
++--
 drivers/pinctrl/pinctrl-at91.h                     |   3 +
 include/dt-bindings/pinctrl/at91.h                 |   4 +
 4 files changed, 155 insertions(+), 13 deletions(-)

--=20
2.7.4

