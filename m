Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489678-2-3484333332973235798
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
    t=1520489678; b=DLFDHfow6LxCWdv5NGNZeTwGeCYVaLaHAeUpDsFGPKoUmo/
    djheRGzIGeCoO/D5z3ybGURV5WmQoMqELWKbIBFgIbwkqjl6mkpWeEExnyDx3iwJ
    WRxv/aUk0XHL8/au74D53l9+zGquE5M92HHXU/QTGaJ//RlhTOh0BIL95eRjotHB
    /T9gM1tigK+vTDa2JRqaCI7pDPc67ohftmmX0tFLedyI/fzEIvJ3H7ryBEYFlwtR
    lZw0w0K45rVggC5imD0+5+bRgSdBWhJ51Y9JiyNcElzMuEfiRjSSfNwp0bZ2Xw6C
    rGEb9Cbr07P3Q4zxS1dQ9hle6qM4lSpKP8Nu52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489678; bh=TSXkl4
    VEkICPRFgflTwSSleCNBR+FXtKqVXEUPpoGZY=; b=wGjwI5+agZiVlDp4WSn12J
    9yY2+Gb6EweX978nWjfRDdxXxVWPa8jHb8Mr4bcFYGAH3A9IH7hrqrQvYdI7G6e6
    5yrvt/wNqty3UBzj9F955dvwok3d2Qd3Ad3Sxre+nHD9JzsfcJC8RBlmYUXdUXc4
    2AZeX4eL4ng+fXHndmR8887UgIst4wZKSf5dwMejc6M8E5/W9GJ8t70Z/NV6YAMN
    SzWAX7WaPFBRKz4PNG+QApP/dJgfbCelcIF7OqDjHOyp56dvfhsXD+cl2zaqGUap
    kRizK4ZGk2dfBsjL5KAGUxZEuFw+3u5DQhWv0TKW6wOcIEl1VqhrbWPG/5PRZwSQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hteL1Kp4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hteL1Kp4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965405AbeCHGOT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:14:19 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965717AbeCHFBb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 074/190] gpio: gpio-wcove: fix irq pending
 status bit width
Thread-Topic: [PATCH AUTOSEL for 4.9 074/190] gpio: gpio-wcove: fix irq
 pending status bit width
Thread-Index: AQHTtpo6NnF8Icqym02cvQwU4WxyAQ==
Date: Thu, 8 Mar 2018 04:59:24 +0000
Message-ID: <20180308045810.8041-74-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;20:aCijKDDOHbCwjmgwLQuf1Xwlqq2SEmpeUh68dW26wbR9nePut8xlxDSYQctxRXxufPUtZoAJ/tdrw7OeBRjRZQr5wmvT96nG6B/rs3U8scFUMIwHiGNqVqojnXEhdQxi+3d8tKLQ8Ht4c7DxSRT2n7/F6YKwo4xw3+PZ1jSa8MY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 512e976b-bf7c-4b2e-8844-08d584b1a4fb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090101AE1FB84A5050F8C87BFBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(575784001)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fus3bYBheWozGHVnp13vKfS8ywTWdTxjCSkkKo0s/7viN7yVmzASLoMVonWNuOZrc7r06z5Z0vjBllGGG8dLFVLmdf/YEPLhju3iwMTvEHZB+4L0C9C3q2dMB5m3DNOOd4asJV1iKLxLm0Wnz7y4iXuB17dlF0THAO6w1hJnMMlXq4iizhoPZ+7lZTTxAOx00120Uo/TGHbgUqC9BufPayDbamRxI1VSD0kHJzVJMG1/Tat/EuoZ88U0TXyDLugNHo5cx/o7X8mxxjuZtdgi2mQvp7j5cWQZQner9mqelyY1BgZWPMyXth8g2hNBi5QbLMGMCz7EDyXp64aTSvdhuQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512e976b-bf7c-4b2e-8844-08d584b1a4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:24.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.co=
m>

[ Upstream commit 7c2d176fe3f8dce632b948f79c7e89916ffe2c70 ]

Whiskey cove PMIC has three GPIO banks with total number of 13 GPIO
pins. But when checking for the pending status, for_each_set_bit() uses
bit width of 7 and hence it only checks the status for first 7 GPIO pins
missing to check/clear the status of rest of the GPIO pins. This patch
fixes this issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index d0ddba7a9d08..1012c86925ad 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -318,7 +318,7 @@ static irqreturn_t wcove_gpio_irq_handler(int irq, void=
 *data)
 	while (pending) {
 		/* One iteration is for all pending bits */
 		for_each_set_bit(gpio, (const unsigned long *)&pending,
-						 GROUP0_NR_IRQS) {
+						 WCOVE_GPIO_NUM) {
 			offset =3D (gpio > GROUP0_NR_IRQS) ? 1 : 0;
 			mask =3D (offset =3D=3D 1) ? BIT(gpio - GROUP0_NR_IRQS) :
 								BIT(gpio);
--=20
2.14.1
