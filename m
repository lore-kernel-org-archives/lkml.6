Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823B720874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JW2dmZA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbeLQOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:14:37 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52519 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbeLQON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="22366018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:13:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfL7X0b3B5YjBnM2HDFj/FM/xyJZEsMgCFf8ly0kq3Y=;
 b=JW2dmZA3ioXYO2kUa/Dmmz9Kar6sY44GDYu96kmsD/JSaXsAfJRCZMNbNk8enqEcssjbzX8edn+Vc1p4Req/5HVpy0i+ugMl7RpzzqSl60PZXpQ4LZddXkp4YQjf2N/gvQEmHNenjVWJCW2eVD8H/w+Px8nzXFDh9nKbGMc+C8k=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:53 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 5/6] pwm: add documentation for pwm push-pull mode
Thread-Topic: [PATCH v7 5/6] pwm: add documentation for pwm push-pull mode
Thread-Index: AQHUlhK9I49utgtcdEWdXv/ljRnxJQ==
Date:   Mon, 17 Dec 2018 14:13:53 +0000
Message-ID: <1545055999-23950-6-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:laQj0meJvHY30HUSa6mnci1XRv2zWylnT9IGjMd6PjUSgnp1/ZIu7rQUw37nyzkS12pUzD4b9h3E5hWGG/Zs/SaANDAd9ogQAfElKj44cxJBt9j9ggMOblwpZuxA25lXAOCliAmJdgdZA/wQtzV59Qq9/sGtRZFhfActjST3j5TPfBC2s1CMRpy70lNU1sWqI5XMX942WJAVwwXq8sJKkbJgmbS0K3aG8eBAcLZPrwXNIH3EYMv0pz+EHT5csbi6IDrJcC9r0oMQQ+DesbdaDbnIzMFCzFvLBdkzBHK1dAXSgMAnHUszTb6WvbReQcT0IvHXdBOq6iuJsbdhwQsoIeU+HQqWUv3cJgZPk6byKg6kQfkp8vdATenK+YU8njWYsU3kerInSMtEUl73mQGQtmQU4E5qZTV+jhKD5F6Q/d92Fj06omtYDAnXZIRKxiHvZaW70wYnUSme9kYBYWcFaw==;5:oHOVE4HqOIx605SW5OXfgx+KAAnsFEpbXoGKjEInaQLKGBkv6559R8DlqIAayF8RLX926/RR5OOXQG2tXWRWJ3oKILiQXwavbvavBQtVcnxpeZ8Jwy3LZQ5F0U/WHNLna5vOkA+SllBCS1BcU4VjQ8KZEa6ZmAI9OqL4DxxX6mg=;7:8MeaoqQ7JjjfUvyrdx98Kt6vU9djQAZIqge5t2NsAzMPQ96wTfwH6A8emnRsZkMaNOEgkNucLwDy6/oGTL0eNMSzHusVaxWDgCU8gO6Jbg1+VrjDE8qITJ0vESmAHTq/xE++FqhnzinxJW9XjlrCmA==
x-ms-office365-filtering-correlation-id: 2b029d4a-237c-41db-1566-08d66429dfe8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB05849769705D82D1B9E7792787BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(4326008)(2201001)(99286004)(14454004)(11346002)(2616005)(446003)(2906002)(76176011)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(486006)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7lUkR90f7ZIfSAU8oL8WfFoIDj0QGK/UtsT0zB6hvcxfrkQyCxow5wIzcy1zO8Dza4qc1Gdm84C7Yo6K3RX1z9r1FogGQRWV11Q4yKnoMIYTNbxohloW2p/r9HWNcVfVvj+BM+MXOYnd7A9z5WgHoPD57A0psvJDeFB4pNeJTZpclWTI2eIAFlp+uUvuoBsMBny2QqVGkSVduU1pZsagmaZJRzvigWjzpkiKHigWl2OPFssjZ/fNSXL6ISmGtkhPeSnENAI6jtwF7CrpMzxF7FFJHlgRbewBetgRTWVyEpzarU5l9GQMUk0lJgKuH5AX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b029d4a-237c-41db-1566-08d66429dfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:53.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Rob,                                                                    =
    =20
                                                                           =
    =20
In prevous version I had your Reviewed-by tag on this patch but I removed i=
t      =20
in this version since there are some changes b/w the previous one and this =
    =20
one. Please see bellow and let me know if you are ok with this.            =
                                           =20

Thank you,
Claudiu Beznea

Changes in v6:
- remove bindings part
- use 1/3 duty factor ratio
- use '^' symbols to emphasize the beginning of a new period
- use PWMx_y to refrer to output y of PWM x

 Documentation/pwm.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 669fd4c9cc8e..80552627627d 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -130,6 +130,22 @@ channel that was exported. The following properties wi=
ll then be available:
     PWMx_1   |__|    |__|    |__|    |__|
              ^       ^       ^       ^
=20
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel in push-pull mode, with normal polarity looks li=
ke
+        this:
+              __              __
+    PWMx_0 __|  |____________|  |__________
+                      __              __
+    PWMx_1 __________|  |____________|  |__
+             ^       ^       ^       ^
+
+    If polarity is inversed:
+           __    ____________    __________
+    PWMx_0   |__|            |__|
+           __________    ____________    __
+    PWMx_1           |__|            |__|
+             ^       ^       ^       ^
+
     Where '^' specifies the beginning of a period.
=20
 Implementing a PWM driver
--=20
2.7.4

