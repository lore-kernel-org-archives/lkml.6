Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487622-2-7834898387685527534
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
    t=1520487621; b=qimjmEE+p6xQ10jR21TldbN4u8Kbhca4stl1GZqT303Xcpe
    S1iKGx64lf+pZNjmStpI1HUuHQi0lB86O00Ayv8VXDvw2Bax9Gn4XFdSLaDy+80B
    bp6Zz6xAtnsPJZtknfe9fn1GhqcV6UYeZ/JisnoMmVUrrh9mV6AyIkKhAUavlBVE
    YErr5IiGVycV0l3PU45bu9G7dp3bLNkEqWYd/j9FuMYGhyBDUeySiW0reAfuz8pt
    g9EpAeC0j9QnKQLGFmTWzrHy1WRPMOfqB2B5gaTEPTAhqpubtfqtP5eOMmgyfxIy
    bxYrilqNMLIdiZ8kWWKj1Rz+fv3pLvCmH35KJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487621; bh=76riDn
    pLFuKFM0VXiWYy+06MIVVpnvkgqzfQwoa61mM=; b=cE3NCooBWIoywEdotxaGF4
    WaA8oMBvmWn1avX+WTT4Ubk3OJnrvX1pqiUuNSP7i8MD7jHv5Hc75z9aVMjZnH/W
    liJFWkYCLzbRtr0wD5+V6iXVsC+v8GQ9b41NFLKro6Py0UesQcuc35XoLnFjcOr3
    kPlzaHoF+ALekN3A3mSkSdHN2nG8d/774yegO4HLC+3uRSY9Tp0z4ZXsO2ICQ0+j
    Sq0LajrwXBsJIOKi7FvE1eX1i73wylIY2X4B2F7jXHq1xSEyNtTnTt5XbIr3x8Tb
    6jLI4hjmzUpVvY1Fkj8teVzs55bM16a8vLe+45Lb07FTw6MoNJ1Efsql1r3T7ueA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V+Cu0vkG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V+Cu0vkG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966230AbeCHFkT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:40:19 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966228AbeCHFFY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 024/101] spi: dw: Disable clock after
 unregistering the host
Thread-Topic: [PATCH AUTOSEL for 4.4 024/101] spi: dw: Disable clock after
 unregistering the host
Thread-Index: AQHTtpqHgh1/CwPxBUOS6k57u8P93w==
Date: Thu, 8 Mar 2018 05:01:34 +0000
Message-ID: <20180308050023.8548-24-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:BM/qG4pU/nwZnQRX7/68IAWciSb0L3jxv4+/cnKydR64NtrymjB9ozRRTowJErdXdRQkRr9jzm3QJbX1D0Jy9wauw0mR0uLLYPd9WpH64iyBGa8zMqDJJD43r+dbc4ym4DbFPkmvw8NFsRH+Mz0OHZ+rdbc2NHlweZaXS2ULbxc6NIClKQ1Ml9A+1AGWg9ehiIdsNeNSKNPu4dWAgpOfxkh1amDQHAmKzbUYC5rehaug/B9y+KiKuzRXQ+2CWKaN;20:3w9rG41eEhvwEVsTA4/IEKNzjMb8boqbskTIXFMTfjZ6lNrq4XimRB8gS3aLC9S0eOTJ16EfIfC+YBPIS3OMzsx5+w3IrPIGC3t9vx6HazMJfkZW4GAl0QjI47r3I8huYA+gk3iVoaNfWQYdMDvqJdgcY6P3zZo3J2adNjzUnQo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe37cdc9-9add-4a29-d325-08d584b22d94
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07272824DADE1E1C0670A4B4FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: b78/Y27i37clFz+uBWgdryvJCQ2zNk7MKGy0qsmMrWe3e2qfWc/BK38XRVvq+FDzqzhGzDuVPPw5M57sx13Lh4iOEf87XXseIuawY40AYzzOAL9V7/0jBrF3/XnUGaMQ0YsxYsFOwKYhgJrpuJ6te2q3ObLKBf7IGJpZAuZrobnOUXtMIfZYIZEpEMdgQOsFtIiszMLlRxlxD57kOCZtOz5Qv5etsMSgQlvpSjMuS/fJ+sPWpGfA+KCfKbZMNMT5VHbFk2/MUtJhCud0YsbiEjOpUq3X5RybhlPPBBJzgSLcyrDwLoTeTwh68EdYyyoYbuxKEb4lZ5A+f1vuH5FHJg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe37cdc9-9add-4a29-d325-08d584b22d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:34.1189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index a6d7029a85ac..581df3ebfc88 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -120,8 +120,8 @@ static int dw_spi_mmio_remove(struct platform_device *p=
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
