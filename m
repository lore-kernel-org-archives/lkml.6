Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116862-2-3204508037553950861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116862; b=sAfqUklv3bdzJo4cV8wtVkY2iRge3uG34c3QS2zZF0P/ppm
    qjAG+swyPPKUrp+4S0kIA09yPpW1dcpikFwlaxwwdiROMDncVCXvna+u6MmJnXvc
    6hbUjdFlqZUt9uZPcJOcCj/6hqik7bKgYjvJxRMR42MBOS1GvxhWbmMVA5nSg5xs
    Cci9mUcgVBDgOA0x7Agg5TAg+2Dfz0PP4cPs1IikNM2PIt0nAyyrczcYRn8oAl03
    hdhUw3w7kfg7WOSGvhqOYnyjypGyDriBGVaD2RMoFK+AaTLZC7aSOdicP+yKYXXp
    42aL52Sgv9Vpa0bkkCRoErcUA0xlRTDFPPnFUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116862; bh=wy5aWg
    4hgjwQHKK2bjIb//vQSUiDN8ke2EA3/pdX8SE=; b=Bzt4ZuOX/JAfQvKmzHQ3R/
    V+h2LuMNeil3Va3yl2KOKXCIE96a+zL9I8riCbIv4pMK+1bEB/9LVMGg10prS4HP
    7Z43lDe+XcFvLLe8n0NhNb1djnIObnTyr5m44MRM9Ws+o/WML1If7fZglascEw4C
    kDTJF62VZU1LuX3A7F0ofb/5Xlf5Sz/cJFiC4/J/DhkvMPPdyeXOc4HKfUt53lyu
    YCk2tRrQhxrVDX71nPGSpFp9XR2Gjm1iyalbO97HdRDR9nAZVKkUmdsfptGXBx++
    aB0BljsGvHZEe5mHMLf5PEtSeLSHHWLKWjfud03I4DdZAZQgCo/N7utaE3DR/6yw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JQ4/kPjv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JQ4/kPjv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935324AbeCCWky (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:54 -0500
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:62430
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935051AbeCCWku (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 102/115] spi: sun6i: disable/unprepare clocks
 on remove
Thread-Topic: [PATCH AUTOSEL for 4.4 102/115] spi: sun6i: disable/unprepare
 clocks on remove
Thread-Index: AQHTsz9sEUXzW36pZkWdg6VnENbm6w==
Date: Sat, 3 Mar 2018 22:31:50 +0000
Message-ID: <20180303223010.27106-102-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:WDwlTuzQq/7HfN84UtHOcdvJsmL6xM2x1XRGaOQ5lpgaW005EQUXJj85/nhRzMQpozNBYwaakUlTTVLuSZzvGDr1S43jvVpT1kRjfzXUBaqYa8hTEnC1OuGlvzvpWk3nd2SCNEnu7KZrG8g6zRgcAGeKYnYZ6QOpUA+VNoOE49s88gZdzsxCjLcpUFYDSUaQWVQFkaniW8A3OghKY+TsCJMausk10lpBeDJyAxPXHob5BQY5U2qBOO1glA5sk5jB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81e1adbd-8441-42f1-352d-08d58157cf03
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093957FD8B0907A30D87BA7DFBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BoWLBYVf1T4gl+JPkzWSwMgJkSjY6R3HojbusO3Ymo8vRGU9tTkstaMCFE86/dnMagtaSfH98OUWq4PaofTlQ2BcjIgeEsO1kXullBc0mQYM78PrGsAaO6xMTUUS30ef9S6AFmmhCp2sQk2Gc/DJUqLUCvTkDdtPIKlNGn4R06k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e1adbd-8441-42f1-352d-08d58157cf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:50.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index e77add01b0e9..48888ab630c2 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -457,7 +457,7 @@ err_free_master:
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
