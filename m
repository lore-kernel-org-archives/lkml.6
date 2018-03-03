Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122594-2-6736389439389124506
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
    t=1520122593; b=HWfyDPwt9ubdBchAo6N6SquMrxid2s85fEHw9LmDFUpiQyq
    OpImvI10nwSh4rMBhnG1uu8oSwLlySIwujcT4tZfljsIkAdIGg7mUBH4z9kkHr0i
    7685jOiOT//MRy9gHJHv5Dl8yaVgPIsWVxk1qdNEO7MSVtL2p2/KssWdJJbsYkwa
    cc121smrn7/EhduNixGqF8XAmoIVpZuHIhHiuB/jkls0OWrd9W8v4KsDF7vkaa5L
    wAA4hUAQwIEJETO/LfW6luBv0hJscSG8BzDqIR4sUN9YXAw1nX245pJHKGwNHNBk
    3TD39EHJsx9GJOuGqUUbtgoWjjrlDOwRx789h2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122593; bh=DlPsDI
    inIRD7liVo6ehTl8uTMrRHFaDwVmQDq11L5gA=; b=i8yZWL4Bli+Y7fXbLXbkcT
    YyRMiL9zyAvFJnYWlvCUJeVjvWlNJYuH0vBoh2WcaPwTUyIeCRQUXCXfX7jxWkcL
    kraL2zjI6o3C43oYDKDUZdukDPre+72HlXJSsJcJPhTlXRgHRKSPCQhbsdhcOBYL
    Cr4bLUpeczPFahe6aQEAQyXlfIJ2Io7G1GBt33LrDNTPJ18E5TumjWfS1BCz+EVm
    U6W9oiRvGcrucdxcxxOcuowh1qnJCNXYwgsEJA13Eu6KpSHkfWnIvbHIec7NGEQw
    Bzny+AIoUGP44poFjB+APIqYDIbhn6Bwg5ykSle4Wwuyc8CW5Qd1CCTcjuUc9VsQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bxrG089a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bxrG089a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeCDAQU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:16:20 -0500
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:45024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933429AbeCCWaL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 56/84] spi: sun6i: disable/unprepare clocks
 on remove
Thread-Topic: [PATCH AUTOSEL for 4.14 56/84] spi: sun6i: disable/unprepare
 clocks on remove
Thread-Index: AQHTsz6uPqJ/FaRQmECqpfq8oNAjiw==
Date: Sat, 3 Mar 2018 22:26:32 +0000
Message-ID: <20180303222518.26271-56-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:YKKQJcvevbesUnEPC9DRCe30Z5UN6brI4eb6b7/tkVQpdifxV/wDHusJ5Dq54nGRGXjDlEB1BjK8vPKvVGLneq5i8VQJUc4usTdVXvG6duw9mw1iiq3MKoLgH1vhk0yEGfXt/h0YYtV0TggOUP0WyrPv8spdW7ZY++x6kE1JBehMh0kxMDJWr6HNo0/Q9IKu9IGeaSxvbHBXNzL/XUaSJU+LtJt7y/Ured+1WuEn/tGjOg++nIDpinsmHG1P4WwR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7aba70ff-2942-45d7-953c-08d581565178
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065704459934E1C7FD220ADFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bJXSkPv8vNQyoY29ofoE3/fDBCJ3D4zGDsDMnyJAE3votLf5/p17MWTsqaB8S6JKnqFk3/vGbLIKZAArTzXMIlAwkEeWg2CuDMe87aDGWmSK+aoDfqbPXcSI8G9t1ccol5pTJQU/1NQE9SP1YRUHkHU19SNYfXnx51y/0nj7hyo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aba70ff-2942-45d7-953c-08d581565178
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:32.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
index fb38234249a8..8533f4edd00a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -541,7 +541,7 @@ err_free_master:
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
