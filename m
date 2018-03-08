Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485905-2-2713470798454322030
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
    t=1520485904; b=D12IYnI9JHPt7SOok8HW9Q8exi5qpYnq31JI7ChwRoD0l6B
    vdOy6KFF4VxjaZb+fhdrZ/Bar3e7meRF2PiNXwSlB9kwJXrBCoTF3aPzF0bl9dBz
    EnU7SA8YAJ0LTZWvlhgZIQPOI6HQPE8+Di2RyG+WZHRD7pHzI6VnBtO6PdSgBDYQ
    PIQgLwJMYXffZVwqXUZFXM6NVg5rUHGoBUaOQal1/nhj6I0YqOpbQZ04K4/6+kHs
    b7MaIFm/g9b5dksEus8ejBOEAPf0TpW/0EX7Jg8Z8o7edEpzB35mRkGgiA02na4Y
    Qc8QOv5OMjm58J3GyX6FKk4CvCYG2CHMoyuIuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485904; bh=oOvd+8
    1OTXPtdFvwcksMKdA15ZnNLAZs/OoR5wdiqY4=; b=ia6wU0CmuLzj3Q6pbZ4CCX
    QCvHd8/NXjNh+WZ5cS+SlwRgFu8oslPy0vLIj5ePpIDV108zGEB0ne01GfRep5a+
    BCt2OpyxYZqEipGg5/iJ1mplFzxKXNsUbR/v6/C60kDqMMDrMnv+vyQ1lNz2HEaK
    tzV+ixXBuht6gkcRfLPslJbJPq46/1iYI4gcYaqnhJvSCJZ/cE0/6K648X6tcKAF
    Xgs4CULF+BGymaMP9Dn/6c1XXdAZznonsxvm0fHdOMYXzbgZCCGUtRvAlv/fOWyh
    GhN2LpwaNyRnpTNeq3oGBJqYLGPuVr1bfnhtij8mN5iHGQkAjg2QSDalajEW+uMw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MNAJbKxO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MNAJbKxO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966624AbeCHFLm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:42 -0500
Received: from mail-dm3nam03on0122.outbound.protection.outlook.com ([104.47.41.122]:54928
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965874AbeCHFLc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 34/53] mfd: palmas: Reset the POWERHOLD mux
 during power off
Thread-Topic: [PATCH AUTOSEL for 3.18 34/53] mfd: palmas: Reset the POWERHOLD
 mux during power off
Thread-Index: AQHTtprHpe5dSBziXkekv4lmr/uFHg==
Date: Thu, 8 Mar 2018 05:03:21 +0000
Message-ID: <20180308050230.8876-34-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:avPzludkFjjNLVhQ05kvof+LNavgqO/HRhUxWUVWyL0Juz52Ww7TqU10mYc+9PPeGAx/EXaFlQ9EZuMJXpEKJx3dY+euhus+/gfb2Zz6qyXK5yIqVkbFppfK1omzkRXFlGpMBd72knCVsXhFtNusbWpaXuO6i+aS2pJwjOmirH/wwc2P/kpFDEctGKczxYLGaG2C1b4IvHPZfJCPtPjJDts/Lhk4LDoVfthLIMhiHQiWuxmgOvy6NCjM7A+v0RAI;20:/Opj2ex47VIXcr41xz6g6TVZ88I8RENLBCEe2xpVxILsN928LatN2E6K++pKPUgfKUmrrjSSIOh8O9VAuHhpXVqXL/cZKR687YsI8vHHSfEgls8Ul+Pbx4nPpQwQw0VXNGwQxSE0yFdAD0KXzt0KtEWLP+3MqsITe+kdqHmclco=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8ff6152-c8fe-4840-8893-08d584b30d88
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112ED9160B73218A417B75DFBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(575784001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hUS3zIxG12bMax+AtAR4SK+NIq5I4aYf0nIZodCgOGRgxQP6gWEm10hEQ5H+KyOV0M4AiucMoLbSuLM1Z3SBGHhqU+nOHtEqQcHJqF0whyuFxJ8Vf/RjuwmS2rP5xT4GPncpRmo4f+oBbPrDhZ9mznwirL263PwR8rLY8nN2ptszJZQj+/o7qjgnYBQZH7uOsyTPVbnni6JkJgxE9rKoiAzVhXZ8/GJFJ+KbYwRBf2hVHVdyvfzCUmELjtte5FpTToCCeBAHQEjbeG6/C4GS6fmRRf/yuCkHzog/IDnqL/Ik6heb0ykVkXfK7m7tYx9pKY10qqsI4HENTofJCY6tyw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ff6152-c8fe-4840-8893-08d584b30d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:21.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]

POWERHOLD signal has higher priority  over the DEV_ON bit.
So power off will not happen if the POWERHOLD is held high.
Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
and the DEV_ON bit to take effect to power off the PMIC.

PMIC Power off happens in dire situations like thermal shutdown
so irrespective of the POWERHOLD setting go ahead and turn off
the powerhold.  Currently poweroff is broken on boards that have
powerhold enabled. This fixes poweroff on those boards.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/palmas.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 28cb048f4760..907247bc2501 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -430,6 +430,20 @@ static void palmas_power_off(void)
 {
 	unsigned int addr;
 	int ret, slave;
+	struct device_node *np =3D palmas_dev->dev->of_node;
+
+	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
+		addr =3D PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
+					  PALMAS_PRIMARY_SECONDARY_PAD2);
+		slave =3D PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
+
+		ret =3D regmap_update_bits(palmas_dev->regmap[slave], addr,
+				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
+		if (ret)
+			dev_err(palmas_dev->dev,
+				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
+				ret);
+	}
=20
 	if (!palmas_dev)
 		return;
--=20
2.14.1
