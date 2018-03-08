Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485790-2-12432860808434216465
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
    t=1520485790; b=uL6LWCWDdhR7sw1w4ulN8EtYBVotE0abYR76iRZtlYw/Z+q
    xvwWrezKCSfFcPM60b0ZDIxI2cMz/wY+ZXQlo3jRF2WZaKYqlq0luVfjqpsRXden
    fe+JMGz1CuPlzV+4LIgJ2AaL01tKo/BH5Jj5j7KQS3WKehHUhbBD7pz4YJexfrEC
    clDB15z4JYGphjB/LbX5X6Hq64LNmGAmH7iUQFcXeh3LjqcGtQkNiy+Wry6WF9P2
    nUOL3llzYHNsO/maniK8IlWJhMglsJ+pSx5CedjTS6XCwfpGaJDdjHWGc7xxzaMd
    yM8OsO1uYuK+eZcEYbL5aFs34OfEeTzmTU1caNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485790; bh=gK8g5O
    4MkHKWwFe7NYbBlNf9n7rdSSp9He/JribX9EQ=; b=Pj2443v4SjfGvK3TVHB9Tz
    T3eZZz2UC0GADqs9hqNBhzfp52SVV97bE14PjIZ1LcJGZH4NIts3HhD6EVfZWSSN
    521Kt3mNn5WghzrmaTkNgZmAyp9K+PqfFE76HWkDPZu9JJa8wTfnr9o08zrpm8xL
    2c1vRbWrsycOSK92M1X//95Gg9WjBOC40YsA7sXbQk2x0m8+kSOZ6OQq5X7waJ5c
    iKbHOW7j1zrMlZicQymWoGFW5TWZCpxGbJdcCBQz9WO3FxKJ9swdASop2vpbiYZk
    xUtUUInrPMb8X/B2Y3HdFUMD0aKLV/0CKmgmBM3TedAlRpQOx6U+fq+CfOdpfj2g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l3nC7Xw1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l3nC7Xw1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeCHFJG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:09:06 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:61856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966793AbeCHFJC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:09:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 27/53] mmc: host: omap_hsmmc: checking for
 NULL instead of IS_ERR()
Thread-Topic: [PATCH AUTOSEL for 3.18 27/53] mmc: host: omap_hsmmc: checking
 for NULL instead of IS_ERR()
Thread-Index: AQHTtprGZ8EKO0hpRkm8plac5RZaNA==
Date: Thu, 8 Mar 2018 05:03:18 +0000
Message-ID: <20180308050230.8876-27-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:+6HfR48p+wHLOdHt5iwgwBTSp/j4sJiJEHgeqr3yU4fTTJTbHLQoOGP0aMrON+leijRrgA6cV8ZhZhFIdSJaxgxkajkBx+f/hSWi7fWfiFqT4HHlXoakRyXimeOXFc+liiUfpbCTEsYMD/EUGjcGG0R23poJA1Rgl5BOWMllo3LRgyVqSV4V2ETNW5EHPmo2Czhx0Jv6hpNzxYdztb5CpE+wgTuJiuFN7rGDZcN5Eyi6YT+9QAMzYWtB9ODJgF3Y;20:DM6ZGH3LP5NhMQmbTkLHJjg60XMkw+iMG7sIz1XzQXGhtk8xCtMXRpTZqTe1IvT3R8xo2dIkq7AkcUjpGLEZfrsQUhAhOjCFr2ePFnrGeek3XAi3dDQlAN8qCUds2hY9lsEznU3ensp6La2c6zCzzK0YNwOpu+0THyS2PqsykEQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b33eeb8f-6395-4d14-da7f-08d584b2b356
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10309CB7826CBDC34B1707ACFBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(575784001)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vkgjzaiJIVGqVOyX8yxnZY3v64RbrHeFCCQ95w9ENjMkgPLkGNIlrKzxAc6mQaeksr6lhO/jlVP762UDsjE9v/GhhVR8m69kXVv1Gb/zKneHY8IKWg60qwBb1UP5+YxrQgmd8+8g6u4bAkcBvLyDqVNgqNm49sWTE82TLh2Dz/oV/ic9I/iA4E7phc+y/8aFcqjQ4Ug3z2+nNVw4O41HFxePusSOFjRFEgeca0vKW5u+UDKdzL5kb8u0EPlB0htzY9+DGa5qxEowCNaC5I/Q6JHW1goZgnjWNTmlCfoX1B2rX8+7T7d/wKjP69aCJRB8BH67aoS6mTqQ3m1tyolXvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33eeb8f-6395-4d14-da7f-08d584b2b356
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:18.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ec5ab8933772c87f24ad62a4a602fe8949f423c2 ]

devm_pinctrl_get() returns error pointers, it never returns NULL.

Fixes: 455e5cd6f736 ("mmc: omap_hsmmc: Pin remux workaround to support SDIO=
 interrupt on AM335x")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9c2b9cbcbce0..e4a159aa0e1a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1757,8 +1757,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_=
hsmmc_host *host)
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 		struct pinctrl *p =3D devm_pinctrl_get(host->dev);
-		if (!p) {
-			ret =3D -ENODEV;
+		if (IS_ERR(p)) {
+			ret =3D PTR_ERR(p);
 			goto err_free_irq;
 		}
 		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
--=20
2.14.1
