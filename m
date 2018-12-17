Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A455C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB342133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="GvGFdlzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbeLQODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:03:36 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:44526 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733058AbeLQODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:03:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24310650"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:03:33 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfL7X0b3B5YjBnM2HDFj/FM/xyJZEsMgCFf8ly0kq3Y=;
 b=GvGFdlzQtIkHmEdUkpMWOrJ0+BeD/wMFMiROAEjN+xg1F4Kz74/+RMJ8UYXuDiQQDSXkhhZ6GSlnBZUArc0dDGjRnNhxVEvtkWDlSND4SpDxI9AHfGrTTqNEiwe6KaeLscnyphEWqoINif69504BsFOLkYgyNVBRMtYgbnJd/g8=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0646.namprd11.prod.outlook.com (10.163.159.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 14:03:30 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 5/6] pwm: add documentation for pwm push-pull mode
Thread-Topic: [PATCH v6 5/6] pwm: add documentation for pwm push-pull mode
Thread-Index: AQHUlhFJC78Tfvz0ZUyNsGfLOQh1Mg==
Date:   Mon, 17 Dec 2018 14:03:29 +0000
Message-ID: <1545055368-23338-6-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0646;6:MoJTYK90PTeu+3UtJAktL3Wsa+M78TzVHgwJs/0wvNRimsABhHb4qOZrrGKO0sJp5DILwAgIiSQxRECeZZ3wWe/YRCq9GkhY54c4SEGI0qCrEeAmwsoOXAwda+TWAc/pp+zQEJ9rGoU+O9G+J2Gj/iqAS32C9VhaCW46QOxx+BMARI7LysH4h1dF6YunC3L4+Euz5o+ynCovmBtC5bF5Ktr8blkR55xXJjq6SX+fFjjPoOozWs2rsOsvyREiffLH/9jTnYt0UFwFiIaMk16cdBeHXw4Z7l3WLZMmMRXSbZHz1svC3+P+3qMlAX5jOECAQNBuJPxv+WX0kFqiw6MjrSDUmcQtCkTHhjt7yu1ZmoZwDmxYT7yiue/eAf2O29Eaihzxom7Lg6Da0OHSax1KiDubTLNHvP58gEyvucyVPMJggDIxcdzo7QAlAhUWyiOi4Xlnkc9jE56ABNJrTwLdlA==;5:EDdAtBXD6/sCLah+3aOVh+bjzboVtchD+tHQ1Ku8jrgSRwoC4R/W1iWA1pJ0SR+mGJeaAxqDuGLa7vdhytwV5e4lfMijOKQzEbMDupi0CBKlW4Eb4gtbbmu7nw2FA61V7KAeZ1P8qUNoDvzSAZWl+K+DAhGCyM1gVeq6Zn8Ffq0=;7:yTs0rR0eZNsWmDdDD4uon69g/13DwES8VdqblnBsrbgL66dKuF8sMHmlzQWNMTAN1CzYIu4W64oeZ8kHKospjxs/Xo4Kqw0IxaYwQfqxszV/AulOj9706/1UP9u5PUYQ0LxinTZc//fw7Q/XEBqtpg==
x-ms-office365-filtering-correlation-id: 1b2f6cb0-dd9f-4590-a71a-08d664286c2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0646;
x-ms-traffictypediagnostic: BY2PR11MB0646:
x-microsoft-antispam-prvs: <BY2PR11MB064663D5637C8AC5F471E5EB87BC0@BY2PR11MB0646.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0646;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0646;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(72206003)(478600001)(53936002)(2906002)(446003)(256004)(8936002)(36756003)(3846002)(6116002)(2616005)(11346002)(107886003)(316002)(110136005)(54906003)(2501003)(14454004)(68736007)(81166006)(4326008)(97736004)(8676002)(39060400002)(305945005)(71190400001)(71200400001)(476003)(186003)(7736002)(25786009)(106356001)(6512007)(66066001)(102836004)(26005)(81156014)(6436002)(386003)(6506007)(76176011)(52116002)(6486002)(5660300001)(99286004)(105586002)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0646;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: myHa1s9xEVntpSOwCgLdLPT0XAJux7WVRUQyZGcEFOZeh0efFhQuLz5yokiIM7J76Rc0ejMogSn7XLX0qZ5xz6ESXavGDDvze4oGisqjiApB+ANVlvint598QUePAv+FvoGIWNyBB2hyGtuS6jWFiLmqUPLNIzuEDRKsCwtM0kkuXNpBO7fOjcsSHYu0TroNkTAHb5KPjft2Qv/ZQCZdi6eMLD1fwc01/FzwvZvZ7DrrhxQ/Vn62+WIqfhIrRpZf+0h52Toy8SUYGMZQSGoZz82PcIBQY2kKOjqFsZOhikwZH8YcEZJo06KelRAWPnPq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2f6cb0-dd9f-4590-a71a-08d664286c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:29.9148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0646
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

