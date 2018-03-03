Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124344-2-5361658663346831224
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
    t=1520124343; b=CLepHv+wazuSgO71hcZ5DvWxzq2wDEZLldKO1RENn2NBmPm
    xhUqsomTdQ31yLSIqA8HQz21IbMPjncrPnbhss2pMb29BA8WAfqpQyLTHPXLeHVh
    s4AauFfVj0MkGEZVvoTnHkBjOKPJeSVXiWyukZ4Mow1IaU9Bxsc9unNYxazxlemY
    +suiDX7RWOaA45k6/ua4DiGY0R3raTaGi97u/8u7EoIP77CebsiKtZLL+ol9RDBd
    qaXKzNbOJYWTlgxAG0QQbMbTz5GWZTz72NUI/jPFbn3VjvJkyBVrgdiX7KtZ5bqF
    ul4I7NmVmBLYfGZXmEYRDRCzbPbKLXKPAwx+SVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124343; bh=1oyzEM
    I2sHChMSo24VqjexecrT9O3Z/PFjuRivG6GhM=; b=V1agXSHJIQbIxYDQNkW56O
    GEacx0qFOJ7Wtk6ErngewuBEbCURnMq7If2NxXCPmZalyvKe8s9jAR+DnUGI8iPC
    q1fhp9oPn5OUdOHONYXIFubmMIU6o7OC4XZaQDJn2Se8OFGMiYvXMANUea0TAAec
    XqvX8LJ0YzqjHbexQ1PIIBDBnOBZMsHOrVI8fatvtPh9k7jI8ibg3aodbhSUW2+u
    F/emw4GJb0TfoHfRrVd3qwU0ARD4NzblAc3kRPeJw5mqp+6A7RcIFnDDyyp6rtaq
    PDVKAyM4XWn1vhhraPkgHkJu0ktLO4fCq/HIhn+q7Rt5nTje1uzTuEPuj6Vt/ZmA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PbX6N7QV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PbX6N7QV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeCCWZs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:25:48 -0500
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com ([104.47.33.137]:13182
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932455AbeCCWZZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:25:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 029/102] rtc: brcmstb-waketimer: fix error
 handling in brcmstb_waketmr_probe()
Thread-Topic: [PATCH AUTOSEL for 4.15 029/102] rtc: brcmstb-waketimer: fix
 error handling in brcmstb_waketmr_probe()
Thread-Index: AQHTsz5jp29BaU94okSmU4CTrIuAlQ==
Date: Sat, 3 Mar 2018 22:24:26 +0000
Message-ID: <20180303222318.26006-29-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:SHLPmUtyLzc6e4GVaRWRsowv97euGCouan49Wutt6M6njeQeRRE2IUn0m0aZu62Kq9lzWGV+cKwp6KxN6R5WcBxHIiTxBqR3PUpdU1ydn8wj+e3BTnpbMoe17M/m6UEbb10dh2PDtoCkSfOuzj4dNEMFiJonjHkDhlEML10uulPVMJG3EuftKkfNDSUKedRDbl61gSV7tYw6VMrxlRYnCkoqePqBg7kIigW4h5ujrEKn013B+jjSuNjsFzMmL4RQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1e14bf4-1862-4217-82a8-08d58155a783
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3533FB8FFBC8C90C6B047A4FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(4477795004)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 3LAlK0KQL5nzUaB+tGELl3WMFlTlL/Jtu2Lw02zCx7qZvcGd2BI6+SBieudTdO473VkdWrWdSM0FsEQcTPpnWlCOovr+/ViSiKGU/QTr0M/h9ER2ziocOJtUdeeCTDKLIHkrXlQ5a++1KWd1vVdNzQZWM+qmotj8uKvcItwv8MY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e14bf4-1862-4217-82a8-08d58155a783
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:26.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
