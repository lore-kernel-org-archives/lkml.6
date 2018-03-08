Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486268-2-7248371428586275378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486267; b=mXxUpZky9HTmrpk6F5DgYlZbrAviqpfbCJgNlKdhl2QaRjw
    GbOjkTlh4RPBomHT6t19jVbvLjinHSPtoeQfdVQvXdLhM/qbpexPIbxit4uMBP14
    2+w1xMojlOCd8DNpG0jd0PBLgdyzZ4QMfqbuiZgtG1zscVw0+n4HAs6HCEkvq7lX
    vZBEuN2++rvakw3AlTmePE3QA/32cDD32WRoSKjuZSCBOEr7OTkB56JfeiKrbpOd
    6ZGh0hGs0NAvns3Y/EdichEV8rhE4dHn3WLQL2uoEpteHoI7cH47vbuk9yQmIdUY
    p4gHUpSH3XusPSdz1UcDe5yq3oZpymhrMz1DDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486267; bh=AmMR0S
    UnAaC98pcwdSUC4+c/6NVRTuL/t4FwUb8mm4c=; b=NKyB9DQ+aomPJny8TTD4ST
    cq/C/3x23Pq1XW0egSXNbCkDU86YsN7Ec+VOiUFBUsT6cICFuj2SFd2rhY/zPCWz
    q1EDYChRvtHB114GYH77B+MDv2FR8WH6ev0knOORQZaAXyi22refl8V74cL/TDzB
    N8Aa/EH7+oOKeKdhpp1lp317wU2x5J6GXlA+aIM4mQ1FhKyEMtZeG+ShMT4CH3il
    D6tt4ev26OWXOi0JI1YDlIdZUFlB/AAwR+mcvHVKa4ipaLa/cr4n1nXz2egNiN3j
    LCLxW2ItsZuPThS8JF/SIBaSobdtYIMuoHJJfK4RIwwFdPvYUy45t3ahxEq9iLyQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AcpUN+aO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AcpUN+aO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966452AbeCHFRn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:17:43 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966277AbeCHFIl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 17/53] spi: dw: Disable clock after
 unregistering the host
Thread-Topic: [PATCH AUTOSEL for 3.18 17/53] spi: dw: Disable clock after
 unregistering the host
Thread-Index: AQHTtprDy/l2mYzuxUKwByhT3NXUNQ==
Date: Thu, 8 Mar 2018 05:03:14 +0000
Message-ID: <20180308050230.8876-17-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:Q7VM20biZDU1hyDYYVjO9jHkLwZva0lzN/KqCHJTA36C5xliJq/w39fRE8RulwmZFwz8rkNGilU1MLtk0g+paIep/whuznK29O52Kmk+E1k32O0GxV6u01qaNuj2jArtg5VNu76cx8FyKgS1N0UAiNjfdf3smwrDk176F/HtncgfZHcaUlD0KU0e8uqPsSlBhJVRLsoagUg+yod+NXnQnNmhwFffnK6fE2wD/suroH3tuQAwa5b1qKruJtp7VALk;20:MnHLL9E9HdFqS1A8VHryvm2fazJI3n2OM4iwUicM5DsFrHSzbP6iBzxNa3YfUQGECleBTzPwcTnetKXFRSR/pmsUa+Xo3klqv8zYWkhg3nmwaITaVlhKJdzkTdxOoSSXNe5fvneALocUO1zRo0wJm5gaUuvt1DfqYfHvHrVNEp0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47df822e-ea7c-422a-67c0-08d584b2a6a5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871180063CED4CDF4253FC9FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(575784001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7PFg4QS2DNQrbxil0LLdQtJZVXWIqFVjI5X4/xeARuQ7PeXLI0JYi81J/DQDc6YD61RWQHHGAeyCPTCY0F4P6+KlQvAxyUQEmpZxynh3uvewG0wDVh4jKymMY40hEg3b/JGBLjMhWZIZa2qMEL8V8eeAbXsztxFSYx3DnqWakS2sQDDEin+vwrzgCKtnm2V1llronrZM8oRxHoL3Y+cnLqH+h86ETLksXbNe5LWspswWAQBC7Ah7VDN4CMVrJ44CsRdBsBDttxd6Ktx5kI4QCTq/pYY5sL/qriikGXzcKizl1qZpeXuUP0dxqqk9dJTn2KkqdKy8BxBfFc27nOmdjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47df822e-ea7c-422a-67c0-08d584b2a6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:14.2461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marek Vasut <marex@denx.de>

[ Upstream commit 400c18e3dc86e04ef5afec9b86a8586ca629b9e9 ]

The dw_mmio driver disables the block clock before unregistering
the host. The code unregistering the host may access the SPI block
registers. If register access happens with block clock disabled,
this may lead to a bus hang. Disable the clock after unregistering
the host to prevent such situation.

This bug was observed on Altera Cyclone V SoC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-dw-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 21ce0e36fa00..d3b6501db535 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -118,8 +118,8 @@ static int dw_spi_mmio_remove(struct platform_device *p=
dev)
 {
 	struct dw_spi_mmio *dwsmmio =3D platform_get_drvdata(pdev);
=20
-	clk_disable_unprepare(dwsmmio->clk);
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->clk);
=20
 	return 0;
 }
--=20
2.14.1
