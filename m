Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486851-2-2305295503619324392
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
    t=1520486850; b=gcz00OUGp0kKVs+qc/PwX0xixoMFO2HjfBrEZFHiz9PQPjR
    PjumpQuUPZIk2jENceZhrZDLmbj3WIDCEnGbZFO60/46lcVcXfpW+BaFXcPnui7k
    GyE9CCJKtjtInccqm7URlJwa/jv50nwV2RWpgo2pxEKfhdspW6fpitoMzULzOYq+
    ZhrF6Gk8xCY6AMrtmwe2fdvvVrgbUCopPOQoBR02BOwh23nCbfe0LPhBy3LgKCnl
    B0SNL6IHyR8xdyfL2EtRnub67HSxZXLj9t6eAa4dsHd1hBfKgDqACFvPi3iviIfM
    S2QUr/ZfdsPf0pVYenqQ3rx8Olu9/ObT1zryuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486850; bh=MkI5en
    v9KO1XVHSp83prYALZnLTvWjVYcSYfBJLybC0=; b=O2V+Bb3DY7fM5X3aSEybYe
    mHZ/AyyQmCLRPC6P0aHiA5uTwMuauMaXoPXcK4m8QxsV1vk0t5ItJJh3KahnYqfI
    56tN8UC29fDgYfaow1GULsJsABardFgDgsfnem++3FfMiVTB1qYbVrYUrB7bi30q
    dNe8aOK+USL03Uo03LQHLgbpYZWc1N+Ep+G6lvgNpCiIrOrsZdMFaLK51TrgpJtO
    6fP4DAlA0tEoHxqQQ6iZ36gmrTJnJUMnRMw88B+WvRYD1Z3h4QgIgkFazm+h78aA
    sytFOmd0P9xOgd5aZcxaE4pz3Sbyk3kri1poEDVBSx9mCZMOY8oy520VL7/YKxfA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=huFbVKKd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=huFbVKKd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966539AbeCHF10 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:27:26 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966537AbeCHFHH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 075/101] rtc: ds1374: wdt: Fix issue with
 timeout scaling from secs to wdt ticks
Thread-Topic: [PATCH AUTOSEL for 4.4 075/101] rtc: ds1374: wdt: Fix issue with
 timeout scaling from secs to wdt ticks
Thread-Index: AQHTtpqaEFlSgSXHEkiF9S6ZDjz4Vg==
Date: Thu, 8 Mar 2018 05:02:05 +0000
Message-ID: <20180308050023.8548-75-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:qnWfKG2SWLMp1ka9Q1JVTCqrpE1eI3tjLEoEKa+BTh8Qg95gxQj+DGNMlSbCpxBKTaXJFn9YGuiLFeQgnwuptohdOuf8GbZ8AZC6q7XBX/1R0wPrHIV87W0pOG2IYQHXkQDqjWWlTOyegy9weTD0Dy6rmE8GtCs1eRGdBLF5eX+QjkVrf57p/67fSX1BUvK4o7Gx1V5w/YNwTrG5uezLb1cyH4qFWZTRtnM2N7wZTGAaH4iVyOEYq3oDqqUQk8Ww;20:oUXhtd+Othmi06sEdbAQDHuKoy/hv588L1ZTfa28nDqn/DTeKYdSKcp2v2XoPacSMMqemeQBZpJ6MFqarz+eLg7/ZLX8yJarQSPLgOcRcR0/xk/OrMwuj2JpvU77Ewl14CtRrEu4G0mouZyjgGS1q2askC4Be8c4mOx847cjq3A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a95f8212-46bf-42f4-87d4-08d584b26f42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101641BCCDD8E33B744A3429FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2WCb0A4JOILz6dkG8Ujr5+ymLng8XO9pGl1hX5Qe4wg4p66ErqC2rVy3zAHVYNpUSYEo8UTI577GOqipCKgIwRlKOIwpyrunGfnANb8DqUDaRj39Li+PPWsSUvpyXQVwn+x91+YF+OCDdtUmNBMieJeblHq6DAyUMBUXMJoDMjaLr4xje16gMY6jUn0AqCq8PXzDTYwRnwr3sjwKvb2LFICS4BuJt1s/KynKz4KOBFr2yU5jQw7+KtYL39xyLFneu5CDQ/eJjAC7dxgeoVTnceEUvY5YV+FCODsWHwTU5b7yl5UlvDNJaBfUj4taac8MzRPmkR8rcLO7eZG9ue04WQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f8212-46bf-42f4-87d4-08d584b26f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:05.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

[ Upstream commit 453d0744f6c6ca3f9749b8c57c2e85b5b9f52514 ]

The issue is that the internal counter that triggers the watchdog reset
is actually running at 4096 Hz instead of 1Hz, therefore the value
given by userland (in sec) needs to be multiplied by 4096 to get the
correct behavior.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-ds1374.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 3b3049c8c9e0..5b5bc7dc3a1c 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -527,6 +527,10 @@ static long ds1374_wdt_ioctl(struct file *file, unsign=
ed int cmd,
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
=20
+		/* the hardware's tick rate is 4096 Hz, so
+		 * the counter value needs to be scaled accordingly
+		 */
+		new_margin <<=3D 12;
 		if (new_margin < 1 || new_margin > 16777216)
 			return -EINVAL;
=20
@@ -535,7 +539,8 @@ static long ds1374_wdt_ioctl(struct file *file, unsigne=
d int cmd,
 		ds1374_wdt_ping();
 		/* fallthrough */
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
+		/* when returning ... inverse is true */
+		return put_user((wdt_margin >> 12), (int __user *)arg);
 	case WDIOC_SETOPTIONS:
 		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
 			return -EFAULT;
--=20
2.14.1
