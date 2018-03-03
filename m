Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123787-5-14035812816134941048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123787; b=KLAxRYZ8zCs+77bCzN1x13GFDtUBGA7/gVSoGexslWGgkjy
    swa8J85rvG/PpkQKHP4NJxSgEWu4rf6RanL6g6ylK0UlpIPzpWlJgK7rFWrqPNLD
    yA8x59MjlWipsatJBITOmvjhgjlYuAOCyDSLar43kEurZVgFb/7p8NTvwQRIHF20
    9gvx4V9mvSUY73h7Z39tMwDBnIQJI2kiiw0YW9eBvgRmk4c5HNJvQV2aBPH5NVaP
    XY+GWiYVX1eF+vqnqoOFn3xccTm9KU2DG3Zu5a0iy9To9iizIHqXhIwJp4VGxjVv
    gTiSGspnAWoWEjt8yXc6xavCyDdk2S2QVDJG1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123787; bh=DlPsDI
    inIRD7liVo6ehTl8uTMrRHFaDwVmQDq11L5gA=; b=H8ica/WPk/a9A+Wa8zwG6Y
    Mfgl0qz4uVGTLTXPq9HKrtPguork5Hw3kKV7GLm8s/NSkJgQXYLe5enj4+SvDEmq
    hikMXUKPBsLb4fBYC1BZ9jhrwaaNDq0ackbusbEhLdHbPzHUXmAHdQrOytJsji3t
    OWTPIVtvQofMhG9xHR5GHKK78XkayL2DpDqJyxWejwPqKf/rjCYAxXZBKyeIBf8c
    TblD7OhfRuppW4Ig7iZCrtgv+EUJCBQwZOS6z8sqs1k9kAoRI5FgmU14BeEpv/rn
    Dfa3Z+fhAIuvKMA80rt02US4X7ODXuT8+H7SbY17qlhOnjyHQpYhcbS6h0R7Mpxg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BDlUCNU0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BDlUCNU0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeCCW1J (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:09 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:53740
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932849AbeCCW1D (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 072/102] spi: sun6i: disable/unprepare clocks
 on remove
Thread-Topic: [PATCH AUTOSEL for 4.15 072/102] spi: sun6i: disable/unprepare
 clocks on remove
Thread-Index: AQHTsz5yErOmfZHTCk2rfP3yXbntEw==
Date: Sat, 3 Mar 2018 22:24:51 +0000
Message-ID: <20180303222318.26006-72-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:NkpSj7JWp6ZUX4n7aGhvdwHBGh4r65i/ymA8GypgEECe/MRLqUeJ8lJhFSukrUFkgMTlmFz+/7Zha8CFvcVms/T1BGAeq51aE1MkRY9J2NFVjUgc7XvWlXWKFctdpRDHYX6rzKYxxgvs7CheW+GdcaYN4rmkPS8kDuktfMZrbQ7ekd8/1lQM058zIh4/DhgEudmiuWUf5MRkiIsqBZxSq03UNJMVbhw6RGXa+lLlxcnuDK1fYcXUaEbfqcDnGbTn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92554e8c-7753-4049-028b-08d58155e189
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06547AF35A386C3242F754FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gUY/U6VoDvDH7gW3EL10aUFq4lO81CKkGHPosvjMhaoCoLOBC1cwN7eKLWkA6Q4XFIRdwMdVBZ/2Am6iMhzivM7lA++nSrWGM535WoJRud3jH2lDAX4UOzr9i5U35E+ZAX/zGd7oXy8rGIAXggl/bay8lTdqu6fyV68sjQ8btnk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92554e8c-7753-4049-028b-08d58155e189
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:51.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
