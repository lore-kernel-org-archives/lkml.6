Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475169-2-1783911744406844614
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
    t=1521475168; b=Y0TRdREhVZi1WziMusmXS8uXj/4djYTnuSOvHfTsBZE8TX6
    mksRcTgcZeieOu8fINO4YozqJdUXIO+FTeVT5Csfdx6hOqNsn+DoUWcy6nrJAzky
    tWaCxWPtQUH1BLOfoFQT7cnVCiQMl2QZ7RXU5JykRIH7L3Vb5X2Bubv3+7jYSCw2
    Ggt807htiAxhqippIbhDaCthxCO1XX0PbxlJt1HiuZYJI/cyhywGahfCE6VWBoIM
    06jPoFfvofxlZQHmUbwqPLtBP06o7jVvNbGbhGJZudDGOpxcJ8q+9LsIfmiIZm8+
    CcrqW19lj47nr9ZILc27ozJj1tJIvBbYYTh6HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475168; bh=WEZcbf
    AxQudeYWVI7J2icp2ZgxIABbsKrTRuGfS0iRM=; b=saaTpL34x0CMUhQ32Gp8sv
    7QC4MkbDd6HnBX3gStO0f6sOaNF9M0JlZMlSE7j4n5zApVgJeHzXbIvtG2+NIYK8
    1tCqjS6m7Zb2vqlmtU3g8wSZoMrD0bQi2Ilnjx8sBuOPt8W+v1nXYK/0WpGjlS7A
    ZAomjPMOL5KW3k29BGyNHfd4PdwWfBPWFynwO/rUYF+ohtIB+326hIAln3puLoxj
    JrpuK5Awhq1WYl7W0Nl+hGOEvSihY0baYp3fsMJhhvqYgd/uW5LsEW6m9tMnbxh7
    KD2uFWruS9Yxbjmn2hQ9X/kxOAsRkgcX24kVtNqgNGQi+JWH2M1eaXQggUKzSmtg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k4m9EqbF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdejieenucevlhhushhtvghrufhiiigvpeejud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k4m9EqbF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdejieenucevlhhushhtvghrufhiiigvpeejud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965090AbeCSP7V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:21 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:23168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965079AbeCSP7R (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nicholas Mc Guire <der.herr@hofr.at>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 044/281] iio: pressure: zpa2326: report
 interrupted case as failure
Thread-Topic: [PATCH AUTOSEL for 4.9 044/281] iio: pressure: zpa2326: report
 interrupted case as failure
Thread-Index: AQHTv5snI6aF9D/qBUmwNgtW2hlVMQ==
Date: Mon, 19 Mar 2018 15:58:42 +0000
Message-ID: <20180319155742.13731-44-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:/98xSVJ07u7AriU8yZYD1NC7a7QhKouB0XlknxitpWtCHRpX2QcxNsuGJwe4eCgim7UK2gdbD7RJic1O19CU44G0ta4dxcvZnwkmA/PGmncPXjKX4ATZSWLQ6bAh74KSyvTKdslqQbh08mEwGd5r9czzggreWuCZ/GJIZLfsVa96Lcs++crKl5Bfxoik+fDLwZN8AXh0YGb70/EFLYCoA7fPRS43LnpMUoyepA6n7Uiam8WxB/GiN4oJj75dysAs;20:Uqi+h+H9487+05A3zySD1NHJ3AirHn4GP9z3xagPfe4rnosG4Wwu9x2sIU76hwav53JeECwZQFJ2a7XZ6yryejbAT75szvGSNfsLbqDQmXILd+HkPomOM2TfEWuYZyR5pb8VRfg0X2ppXz54aA4lD9Jy4niNHoTEi75z+iYpjXo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9f20d10-e39d-48d9-c490-08d58db25c25
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10154B5AC18B583EA5E86B92FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0tw8z2T6K3IAZUqBup6d2bd9NftBv1gIXtId1him9kAASwJtoo0kE2CuYloSlpiCVmRH7R0vxd07aAhIPqLVcs0yeW76CiFSsJoLPsL++4YT3Yk86/tM13L5EEMzsrYme+zsefaDWB74HXEdGPeSo/hkJoz6GGURDteRW+O3ocDkS/RWprxY2IaU9D+sEYq3AhaJgd6nfPLIohCHw3CcsZBCIWnGcjbT9iU3vpnURe15HfF7HbM13Z/JGFvQFmxRZd1B1G0V6ow/0L+cRc63Aq7WAnoCrWbT4Eupv9P9RoQapobcmWEldRlP/5k2xpOH8BMrju2KBrocuHIfJvTSXQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f20d10-e39d-48d9-c490-08d58db25c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:42.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Mc Guire <der.herr@hofr.at>

[ Upstream commit e7215fe4d51e69c9d2608ad0c409d48e844d0adc ]

If the timeout-case prints a warning message then probably the interrupted
case should also. Further, wait_for_completion_interruptible_timeout()
returns long not int.

Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer suppor=
t")
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/pressure/zpa2326.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.=
c
index 19d2eb46fda6..2a4a62ebfd8d 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -871,12 +871,13 @@ static int zpa2326_wait_oneshot_completion(const stru=
ct iio_dev   *indio_dev,
 {
 	int          ret;
 	unsigned int val;
+	long     timeout;
=20
 	zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt");
=20
-	ret =3D wait_for_completion_interruptible_timeout(
+	timeout =3D wait_for_completion_interruptible_timeout(
 		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
-	if (ret > 0)
+	if (timeout > 0)
 		/*
 		 * Interrupt handler completed before timeout: return operation
 		 * status.
@@ -886,13 +887,16 @@ static int zpa2326_wait_oneshot_completion(const stru=
ct iio_dev   *indio_dev,
 	/* Clear all interrupts just to be sure. */
 	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
=20
-	if (!ret)
+	if (!timeout) {
 		/* Timed out. */
+		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
+			     timeout);
 		ret =3D -ETIME;
-
-	if (ret !=3D -ERESTARTSYS)
-		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
-			     ret);
+	} else if (timeout < 0) {
+		zpa2326_warn(indio_dev,
+			     "wait for one shot interrupt cancelled");
+		ret =3D -ERESTARTSYS;
+	}
=20
 	return ret;
 }
--=20
2.14.1
