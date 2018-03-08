Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487019-2-18254870717610824489
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
    t=1520487019; b=cGPjxMrerJDguyx/NNGSXtZ1P6mOiIDZlwJ9HE//mRqX2A/
    xDuv6CFgNdv+hi1DX8qF3GgydJNhhxUZBSrWFcrAdR77ou4vHaXXUFLzxZAl4cOg
    4F0GRQPuFnB8UIdm0Iklr6p9Az1wLqz4mef5HCPuz2rc5OlMcQghhRFrZ3wAr2zt
    Yf3f+F25J0nwqkb5lwJt0+nk3gxlLdg2BFxTdpgSo2pUxxy0nI1vH8S9N4fA4aXT
    KgoKMHWF/8tt4oUlLpw2RWQLg/BPTfFRRAw6rOP3ffrsp6Y0jesaIdsF1eQwY9TU
    db0VCGgfXg+UMbFzqhqkF+ho0KxmJ9aN2fT/x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487019; bh=mSNu/2
    YQv8UCmKjpdTCOqAzM4VTMxcjHkCokKdOJAEg=; b=Uq2zGYcQVZE/ORAyLi9dVe
    ACkNvfvh0xfFX3v83m3b5pTSDzLeNkINNWIL79BJ7mHBI1M/C45KXcLPID3xQAdu
    JA5UzYlNg4OaxOXrkmxnwY0e1nrQUQAMBl2MVSKDH6Vd9VOPI2TvqolQYIrMvttd
    7fSDCt7u2Uxbvsk6MZkWC6XH4kA9DVdMvXLwIfwJ7nJsISe/XeNclPFk7rizAfx/
    yQUkkt76jQYpwxnL4Ujwg8PcSPkaOjJC8e3sfQvrCjd+gc6QrhxHyGrfP3j7z0D9
    9kQn5uLRTU+iMoeV/EKbAoNW7M/4xYiefgMFFoyxXrNDeHxF3OlEEAuLHdF/mb6A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AKl5UaBE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AKl5UaBE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934897AbeCHFaE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:30:04 -0500
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:24832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755398AbeCHFG4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 067/101] Input: twl4030-pwrbutton - use
 correct device for irq request
Thread-Topic: [PATCH AUTOSEL for 4.4 067/101] Input: twl4030-pwrbutton - use
 correct device for irq request
Thread-Index: AQHTtpqWxQ3itWNdQUSVzCTxJbdOIw==
Date: Thu, 8 Mar 2018 05:01:59 +0000
Message-ID: <20180308050023.8548-67-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:1ExvrG0eA2wlMm4hEjw2/ScUsX8Fwrms2ZyLLvhf7U8qHSUT8tlzZB4EU5dv373rOf72CBMym1MKHspae+NLKlyWqhx5WpqkZw8aI2zbn6KOlyNXcxCxgjvO1V5XKrnEPzPwIzn5MumSU81nDNy5TCr7cQLjf51ms4vQtdjEqcb5B6nI8ZpqEHL4nL1z6dfqieSrraz1I51fAcPMwYfYJlXlZt2SiIxOTc1X9NRxsVluuik+DdfhM9ol/aSrCXrM;20:JQdyTu5r0FCMNS9yznfm+5WboZV9Q+ITOuUwGO1B1Beuzm3G2NCZjglqUtRFWmm+dqoXHeVCHbl3nkbGFe1fTCfS+cgeSoTs7171tV5WnqkmYVhY4nltQH+vCJrmLwRM6dnG+q8hRV19nLMk8QovAGT6Fcg+gIQlumgXZhd7xQ8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2ce28d2-5ef3-4380-8342-08d584b268ff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107750E8F5DD58D85A98966DFBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(39060400002)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: En5uwIBrcQnkMfqiICq96Z1838IbwIZrmb3Y+nJj1OzFl/3R4YRoRbGL+JjLncl0DY0x3gixblrUKmui2iIjy8HplNtDXHyhNMYf65J4X1MSE0vBU02axENiFZ60gZjRIhk4grJ85aHa4OGeSv6VGpdl6caps3Z/NkqC821Zi512wOkAUS3unKT7trJzO/HAFrVQGN6ld5KDHIbG1MFLGoaKdAGmu+lE458RkYnN2XKnSszoobcbvoS45DY7IrJcp3+sToOf/LTPydq361o7c/NL9eUxGn+S6EzZBhIKDz3T5PBzBIPbB9iuSEW/jtlUCn/yDpA7CD9sN3ZAs6UdQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ce28d2-5ef3-4380-8342-08d584b268ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:59.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

[ Upstream commit 3071e9dd6cd3f2290d770117330f2c8b2e9a97e4 ]

The interrupt should be requested for the platform device
and not for the input device.

Fixes: 7f9ce649d267 ("Input: twl4030-pwrbutton - simplify driver using devm=
_*")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/misc/twl4030-pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/tw=
l4030-pwrbutton.c
index 603fc2fadf05..12b20840fb74 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struct platform_device=
 *pdev)
 	pwr->phys =3D "twl4030_pwrbutton/input0";
 	pwr->dev.parent =3D &pdev->dev;
=20
-	err =3D devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
+	err =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
 			"twl4030_pwrbutton", pwr);
--=20
2.14.1
