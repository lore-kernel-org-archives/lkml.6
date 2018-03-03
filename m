Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123093-2-17676212399057817292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123092; b=NHWhoj60tOrqvTWUYl7WKv0pbxeH6fbUEF0qHFPTcoFtZFS
    xPnNI6oDJHyq0NNNjtylFMTUmngmCYHS5DdSXJ6lp032W31KV8nJSddozX1wXDfq
    Dp1K/sj6J+4eaLiDq3bf+LcQYttfxNhE7xxmOW2d1JSXXTLYR9Ah7DBM8TM5UWIk
    lvLJtdTKO19re8tFOmZ1hsiLPAhg+2DcKmB+RYuUniBazIchtyKXMtQEBGqd0ep+
    aAevenOtVzS1AlVFWhHrH6R5U6oeU9efUzp0POF417ZCHboSoIvp4+6FvTmqn7lG
    D8TCQFDrRYptjOf9suiiF7XMTZ/VM8PYZXlj9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123092; bh=1oyzEM
    I2sHChMSo24VqjexecrT9O3Z/PFjuRivG6GhM=; b=f7Gt3CGeRZjyOpACnxiuTW
    xWIqKedBYXnW/Tq6V9V6xHunoqnzP+eDqdh95y7/JHGA3O2Tq+JT1PtZf1UrbWqT
    4nfzJIy5Ir3NAU+ncY6HQ7mGl+cH7Cg3VywW+NdEQH8kVCf6Fnh6h3MMyI9JJUo+
    bDoKeDvvqyiSbKsDi5CX2ezrJow8WQj3yEtYbj6ae+YZ0BTyQ9N/vrcL8EPxYCia
    +0/9P8uSVArrb5hLilZL67BON4U20vPahkHt/TPjpynuSC8EzA0I5q+tdKEBLlhD
    f9Zs3iSnyS/WyJ4q7NzBKy/zZ7GzQ4ncvtP0HeZXnw/G3B9azQ4mamuPGqphh7HQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y58xRaU1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y58xRaU1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932847AbeCDAYm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:24:42 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933185AbeCCW2S (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 21/84] rtc: brcmstb-waketimer: fix error
 handling in brcmstb_waketmr_probe()
Thread-Topic: [PATCH AUTOSEL for 4.14 21/84] rtc: brcmstb-waketimer: fix error
 handling in brcmstb_waketmr_probe()
Thread-Index: AQHTsz6iRSi3aenHgUy0tI3pIPdrpQ==
Date: Sat, 3 Mar 2018 22:26:12 +0000
Message-ID: <20180303222518.26271-21-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:ABfI7fIwUaLg3d+zQIseHtqhpvhCs/5N1TCwwnNMghnikv69uFTuUj8l/ZXFU9Hcwbrwii8KGmoMjuhMAaFRLjq8oXzh88l9zWh9AaxuPee4wi53Sr9w/GodaGITO8LcWBd/5pocZI5ANvKklWx+ZWBlraG47HWNpPh7vST66Pn7AeVDbd28C9PLDehpLzg88y65x73AWki5nWXGs3pQgORdMXatjy+WF6CMki1vJQ+gltKsmsNwVTT5w8G8kDCB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7eb32829-e856-471e-ac97-08d581560f8f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11158D127C8034391573A341FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(4477795004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Cc7JxJv295iJPbPYxKzveMi3L1kw0a97Ve57UXXMvNDnUptaGM8m8/i646LSRBCSkfddFd357zZKGxrKVWCpMFxtF8eO+yqd4v+crFPjqcwGDWYjKURVTtuAlOccnxRSbzEjyLmtC5N+ZT7+CWXQALPpdHL3ibCgLlvLcG4Uknw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb32829-e856-471e-ac97-08d581560f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:12.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit f2eef045de9defbc6fc6b72b17f0941cbe26c81d ]

brcmstb_waketmr_probe() does not disable timer->clk on error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-=
waketimer.c
index 796ac792a381..6cee61201c30 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -253,7 +253,7 @@ static int brcmstb_waketmr_probe(struct platform_device=
 *pdev)
 	ret =3D devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
 			       "brcmstb-waketimer", timer);
 	if (ret < 0)
-		return ret;
+		goto err_clk;
=20
 	timer->reboot_notifier.notifier_call =3D brcmstb_waketmr_reboot;
 	register_reboot_notifier(&timer->reboot_notifier);
@@ -262,12 +262,21 @@ static int brcmstb_waketmr_probe(struct platform_devi=
ce *pdev)
 					 &brcmstb_waketmr_ops, THIS_MODULE);
 	if (IS_ERR(timer->rtc)) {
 		dev_err(dev, "unable to register device\n");
-		unregister_reboot_notifier(&timer->reboot_notifier);
-		return PTR_ERR(timer->rtc);
+		ret =3D PTR_ERR(timer->rtc);
+		goto err_notifier;
 	}
=20
 	dev_info(dev, "registered, with irq %d\n", timer->irq);
=20
+	return 0;
+
+err_notifier:
+	unregister_reboot_notifier(&timer->reboot_notifier);
+
+err_clk:
+	if (timer->clk)
+		clk_disable_unprepare(timer->clk);
+
 	return ret;
 }
=20
--=20
2.14.1
