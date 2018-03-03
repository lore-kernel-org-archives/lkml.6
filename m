Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116977-2-42693744963541200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116976; b=A4WX5GvqH2jni1YWNAapVBg6PZ2M/3yQMhQJC2cdjiZviwS
    jt01efoVD7AvmPF0hqm+dARHaIUnIk/gRxpDkBXe/CcXGcgPVqEf4ROICZdu4CJJ
    4souaeu76O3FlwN+jGf7InykNOrlynahVK+bNstzr9qQmsvrt+tu3oHYCn+1P/nW
    7qqslhiEhI45g0FLXF7ABd4ZeosPUDvYfszc0f2uYE+f8rMPIZk/UVND17EMcfZJ
    cXLbpYYBkJrAtBwnW0+2Sag9PjVtN7xtCrVZhzvphkkSCHTL/j2foLXFGEgo59bh
    TVxHLmH5tt64NDf2mlunxwjn001SoQHyYf0pdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116976; bh=6PmwUA
    Yv6V0yV8ylaYdyIShHtxmvhVO8hlSMU2KbcYg=; b=iJ29tyApPdUSBNubWGy9ZF
    mjUL6p3vLTtGKol4nGZiTFJF5/a/wdBKJ5Yz+6ff4z81+w1OlHLXNmli+23CRyuv
    rH3zcnT9ehjuf1x8SovIPw0ToFwMpX66sjR/H+ftTMNoDpcriXFiI9mCgq7BXn3K
    Zm8dzgyVhggaww1nZCh9W/L+gdlB5tSI2adOBxTlIKWylun3+ogxLQJUg6p8lIdU
    1LHHIiZ0I4XCJrapbbe8H/ZoBFoBsjVIQajPuNxjS3i5UUwgO5XGX9ZmRL5veziM
    3zAN1I5pBfeK8Az3xfmRvFD2sSxIf1P5hIG3UdV5cStgb1kzef5RRI1aghmCU4tg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lWISePqj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lWISePqj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbeCCWmJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:42:09 -0500
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:22992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933295AbeCCWmH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 56/63] spi: sun6i: disable/unprepare clocks
 on remove
Thread-Topic: [PATCH AUTOSEL for 3.18 56/63] spi: sun6i: disable/unprepare
 clocks on remove
Thread-Index: AQHTsz+vUkHavadOtU6RdGKBWeXtiA==
Date: Sat, 3 Mar 2018 22:33:44 +0000
Message-ID: <20180303223228.27323-56-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;6:9pMIG8r5rXDe7kn93UptqPNpCu5Zr0I5BVPwgS6B2dMlp7EpAb9ClS4ixb/aR0+7E7f+9KGWgY5QsDW/4qeuNF1wawcZVY0LNTrOFcmVmdqZICB9afFXUeKQq/2k7GnZNT1pSycHQUa9uZdbxkdG0GaDpOURD0MARFohNPa6hthYUjPK0kTbd4hPwDiTDPfXCtFo5SMiUUHKd+VfZ+vIxmUOzKPBCCHUNPS0g4ehvuu37m/fhXeLb8SVPILxGFdS+O8ADH8Rn+jW/2B+4U+4GkKzg4iG9+JGJccA5lXkSUe5E2qBHPd13W6LQHfFdlf/cRTBwFVjz4FcwUA9ka3mOJoTDNlCBo/Lu3bEOVJK5L2KP5/gAVUu+nM/tmt07Ztx;5:z0D6KfAX4XnVo4TCESfTxw2tqaqwQ04R1Prta/S3/H7lFny/xvgek0qHsalmeD3UHNiOwGgLPAN5KQvVj27HNGLFHDEitzPEiUdHX1OYbspYU5crIA+rx21NbRmyKZKGR7YHGxw9xkdA7NKskh6ikKHgizvLjSxKf/GG6PxCqSE=;24:ntafqLkQAbKVAxxzfiAQXOcgoeeqU1fDDm/TNK868/CxB2DVk0XSp/qK8G0EtKd0RhJqaSnYmhdbcb33c591MrcbNZce+cLrsmisss+4hGg=;7:yqArqLgz5x2dZw9u+UF+CyLO69Rs6FGFDrplfbkVTwGtvCMAszk/hEdGRca649gqMWCaXnLkZ9YYv7E9obD9IM47eOo37BWD3dsNQ+Sc47KLoC8/EHdeV+0a1CDErCsi4IGkjDnYYJxtipY9jrnBNNDwu68a/qPz3cA9aIE/P9k3R7hvYqv1+7uSOf3Yo8Z/ou1YJjSaS0CoyLpS4/QsMtt7QFDHjg7e8Iwh/ilr8PX3hLouYyPXhpodI/mskurb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c028fe9-1c3c-4c62-2102-08d58157f92a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB10189BAB5FAFD91B186492F8FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: VAimdTA6lqYfKgaDkdWXkPutEsNUkZHHcsmZ2jIoSew9AkIAyiMXz3edvL8afIv30XJ8ni8jWkGM0E7OvM/W6vSv/mQR+Y90TGQzj2feGhstz3+licGPVCRx09iQzzgtDrAxLKlH7Lec6l3A+e/nCQFYJg2tlaxiYsyluZ+Gk+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c028fe9-1c3c-4c62-2102-08d58157f92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:44.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 04e90851504c..6c042384a8c1 100644
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
