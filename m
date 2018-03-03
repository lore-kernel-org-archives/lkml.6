Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116629-2-12557204481959870446
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
    t=1520116628; b=gfh1YSePwOzMaFxFnadOZBGXUvOGRhJp+sfCuCiM4yA3ssE
    6Ni+/1uUseu/VongGaLm2DA/ZcD2OFo2Ih0P7qd0TND7ZhEOLnn96TSONZXGESLK
    V2xgHQg4lo+oOqQcWF3x5kPvkZhhrJuWnnw4B1b69vBCkUHt2Ui8lLjzsmdsYwAF
    2DteJv5I+w/9JJF8Pj5lUTiQ8w0MnbHRXs2DH521fsZB4zVUuqRwnNzZW5Bv5D+3
    3dB7eKZFyFLeKjO3TRI2saAfDGkfPwGhnNfUbatc9CHWItkfTId/y5qxPhgJV9BN
    O/esq/nL2WRsx+i9XmpoXT+yjN/6gnsEcJZbZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116628; bh=v8kwMN
    576/ofL5NkZEy+oAXpIxLdWP7RT2KuUPf9ze8=; b=sUMB/O0y6Tkh4+6VVU68pw
    8l4wHvd+fSmPWw6FBW9Sv47qPYFMUMQBOuYzW6y2Kr0oQbKnPezcDqSbp4z/0vAY
    dBwdpZo5G3sVnz0Oi8+QL4/AJFLJCzTyVng97Az4JCGYGRxQnZWlNcBO1xJ40Hhq
    N4usA6fTtjlQfwx3oZZOikxlQAGXqSgg/Mbqw5sPwtTlt11s7ixl6euB7823+/iu
    fLE8bLs3X9W933LnUffUvxGw+YoSG/wejKMhfOFZuBhU588aOq8TBx9Cj3IdpglT
    ED7d4Jux7023FvqffUu5lwWRGlFXT7YjETiPdlGnC5dnfL8T+EOg0NWdoyl5hPNQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d5kSkFB8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d5kSkFB8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934668AbeCCWhG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:37:06 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934658AbeCCWhE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 202/219] spi: sun6i: disable/unprepare clocks
 on remove
Thread-Topic: [PATCH AUTOSEL for 4.9 202/219] spi: sun6i: disable/unprepare
 clocks on remove
Thread-Index: AQHTsz8mFvVRWjqbjka12wpViReI5A==
Date: Sat, 3 Mar 2018 22:29:54 +0000
Message-ID: <20180303222716.26640-202-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:Ux9SAqHg0L/F5qmosJYSCD8F5OSDQ3eNRDvWLJsWnVVthaPUbDY/LMgsnL1mqm6+jann2td3zmBsGi4s2VrM2pl2WsoNylSa+eC5ZN2WNBCKNnQDCfMCvpEFma17nc6hxKL//pXdtLOuviJ9rWqjo+gq0mDVBhO06+Rkft96OGHVcUHmq2rIPuNDa9aNsdtvcvaIifLb6/tLmaPJEp6t8faAVr2R7bb/OFAmcbjLKt6i8Cs0hv6r+GzQBcBeDsrl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a48ffedb-c9c4-416f-44aa-08d5815743bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969D11DF38AE02227DD6FC1FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sT8iFJBd12Bg8gfGXGe9Au4FDJbeA1fKQjWdFo2x9nG2zNLFT8oRVvT/eV+Y3JJl+yVPbvhrl+v66eOz7TCIwRsHkGgUP1ef/f6cxPIMhxK4ewsupBpQtBjq8nzaU1keTC1sqJqeNpNI5CM3PETYfdD3wYKmUqJAvB7RUvy/mjo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ffedb-c9c4-416f-44aa-08d5815743bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:54.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

[ Upstream commit 2d9bbd02c54094ceffa555143b0d68cd06504d63 ]

sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable
clocks, so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
disable/unprepare them if we're not suspended.
Replacing pm_runtime_disable() by pm_runtime_force_suspend() will ensure
that sun6i_spi_runtime_suspend() is called if needed.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3558fe900e8af (spi: sunxi: Add Allwinner A31 SPI controller driver)
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 9918a57a6a6e..7e7da97982aa 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -464,7 +464,7 @@ err_free_master:
=20
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
=20
 	return 0;
 }
--=20
2.14.1
