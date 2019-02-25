Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCCDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F666213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ddzZZ5Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfBYQp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:45:26 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40694 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfBYQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:45:26 -0500
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; 
   d="scan'208";a="27247350"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Feb 2019 09:45:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfGjG9FVOlceAobnuNDYb3BkezFlmzJgzeKNh2JJ8ko=;
 b=ddzZZ5Z6uDVqqhv2BLGk60EruI+Nb9Km2wM170Hqh5J6gVDa5r5SEQBZy69GPe/dphcXLWL2rH6nkexu9X4uoLLrc3snQ/NArf8L4YVnkgJbZKbKcuDlpKrdSNT/+BKa77E4vG7AHjqIwCc4Ng+gK25+ptYUKA0dOnRlZ7HJsl0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:30 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/5] add support for the new SAM9X60's PWM controller
Thread-Topic: [PATCH v3 0/5] add support for the new SAM9X60's PWM controller
Thread-Index: AQHUzSlgRVo5uwyG0kSdlu17b8dUJw==
Date:   Mon, 25 Feb 2019 16:44:30 +0000
Message-ID: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b7ba4b9-425d-4fdd-a7d2-08d69b4082e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1662;
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1662;23:ogbnOtuZD7Qc5jO1m/zAMJgIt8e6OCyDY27wHGb?=
 =?iso-8859-1?Q?J5Z7u3EAvbtJqEfarjIG4mBJyz1PWHfcTMDjBMRdVzTVckxN4ocaPh4sfk?=
 =?iso-8859-1?Q?ypSt+Tq4RWw6H8g+a6hBFSxR36Cu3duuXJz888f7RqkVrwPrM2m65OZaHh?=
 =?iso-8859-1?Q?nFX2WfZ3hu5y4mbFlHNt0LAQ6q4DPRfdAKtY36kunXTJODNrqTrSIgLa/K?=
 =?iso-8859-1?Q?34eQQrYNVT+E2K+r5Vh3T48KMZYINjtIha8+yTH0oxUSxrZRvvyWEcHKT6?=
 =?iso-8859-1?Q?mgDlavvWUcgdTBDrrUi2KCsCQ4OvWvwalhVPwXxOsf0wxGXUx2f9HlecNh?=
 =?iso-8859-1?Q?KUoJjWKB+2nlFuwx6UBn1dAB2BGaJicDquJ/iYm++a9wTxY2V9Fa9yjkLs?=
 =?iso-8859-1?Q?MXydufMr9pmkFTnvWtJSfGVJmuhqIBV40CJWuAGej0LonW31vkMWYsYmvr?=
 =?iso-8859-1?Q?bAAmxjuEXKNd/mogoIznZzZj4Q6CoO9Uc3Y+kpnDCxP0cWsqw3VoUFARgv?=
 =?iso-8859-1?Q?uhKg2NmDo7sguYo5SnqzSofsrEfwbRqsHWWjM7onhM9lETzgVR1BiOWi3E?=
 =?iso-8859-1?Q?gB1pbwiJhmCMsPgyJ4vrLvzoAkck1PGPRrkAETWFAqGwQ5zvdVU0kUfp8Z?=
 =?iso-8859-1?Q?lJvE64GhSPQZZgmM9gBBW6ns+RPRvrDkji/w3LpJBcP0+Y9v86Qb1mdENX?=
 =?iso-8859-1?Q?IWNNOf1haw9zCAvF7uIuuxJV3SR3+xZg93LfD/o0W+UmaYr+9VBsmi0f7z?=
 =?iso-8859-1?Q?ie4yN8d2v7+EOHvJTu6oz0KHdG1SgEcpX7xead2Y+JVQZd/8wfGu3ybjsY?=
 =?iso-8859-1?Q?dDOu6Yt/DS355fXHJ3QtQcg0PuOQf3di1G2q5tokqtDqxsREanCtuRkKOT?=
 =?iso-8859-1?Q?iUv5Ts/673X3OWv+fY7Umv1lNBQGzI7cMXjpIAa+/dIa5qGAVmUhaIUj4M?=
 =?iso-8859-1?Q?dX6+WfsEbAtQl/GgJB3f5qAPa1ldtygipfqyIZcmcU6296VCSfM1dpt9rJ?=
 =?iso-8859-1?Q?K4C7jbOyJUwX0lRJ80bNbjw78JzDStMiCQ1slo4fFL3ylAssO/fjHl8J+u?=
 =?iso-8859-1?Q?voxBZWwjLwheJTEYSPFaBPVIaZEICbvwDkaokGidjGKVP0ktj/GWTQPHZj?=
 =?iso-8859-1?Q?t2PI4l1MP9jc4lCeCd0E3R5YBsxVVg1Q3WEI4HeXEHSoYu8fvkI4RXGwbk?=
 =?iso-8859-1?Q?iAP/DcGcn/X5E4Tn5ZHpQnqRZJ7J14nfTDibnwth48tp5VGvSTMHAlOWcp?=
 =?iso-8859-1?Q?gR1KMJmTfHGQPjRXNFORRK2FgoRozG/FZihGirg=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB16625D349FB8AA46B86D85C8877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(36756003)(14444005)(256004)(110136005)(54906003)(316002)(86362001)(99286004)(6636002)(52116002)(66066001)(2616005)(476003)(72206003)(6512007)(6506007)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1662;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ib/PrjVSfwhUmco7HgezWRyBD53ZWnFl5GXDuI+h66R096M6g50djAuZgfh3WyTrAinSne311XDboQSyuzhbsDaYaDspdiLyb+jFdkWj803bxxar1mk3XPAYvzanTOeY9FMKGYSDBWmGKP0pRbc+WKjQomOBUa74NKQtGXOVN+9LRMpZUl+N+6seEX84buQcyh2E1edkSIR6GDhb5u151GL4KHar6sCaoXoeuu1W2zRvNBaejESPx2sVkX9Kcb2ETinwnmq/OhpiUcIBRR9D2ZLAE4Sq0BRNOss+IGgKSWLWo1yNOM6pm8b/LQhEaMXtOiL4vn2Eyxqxzp6Iq4vqj/JqN+KVWydLRR40Qvjz0oGmhWgoQMPcOV2D7RyjzkfCckF4NY8CjdMKPqwO5Ob20BBo3WED2V9g4BHssCDIdpc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7ba4b9-425d-4fdd-a7d2-08d69b4082e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:26.7391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series adds support for PWM controller of the new SAM9X60. The differe=
nce
b/w this one and the provious AT91SAM9X5 is the counter size (32 bits compa=
red
with 16 bits on the previous version) thus, allowing to generate signals wi=
th
bigger periods and duty cycles. This series, modifies the driver to take in=
to
account per IP counter size by embedding this information into driver's dat=
a.

Changes in v3:
- collect Acked-by tags
- introduced patch 3/5 which changes the name of objects of type
  atmel_pwm_data
- changed a bit commit message for patches 1/5 and 2/5
- use mchp_sam9x60_pwm_data instead of atmel_pwm_data_v3 for SAM9X60
  compatible data

Changes in v2:
- add reviewed-by tag to DT inding patch
- move PWM_MAXV2_PRD from patch 2/4 in patch 3/4
- change commit description for patch 3/4

Claudiu Beznea (5):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: rename objects of type atmel_pwm_data
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 117 ++++++++++++++---=
----
 2 files changed, 79 insertions(+), 39 deletions(-)

--=20
2.7.4

