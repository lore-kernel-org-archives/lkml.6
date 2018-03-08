Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490153-2-2115988436383730086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490152; b=eYDD1zX4+d41U6d/S/x0E/fLo/ECzsVDW1ugf/hmaH1TzTy
    LRnOwKfT+e2J5huxeX5O9FYl7Rm4lml06AhP8o9fYi3QafEUwl6FSKVdXRlhh8ka
    Hh8gpXpCc3Q7pRAlfXIBhQ9Fz/USOVvkvOtZ2QGJq2vSTVt0IaqOddlS5xrj67y3
    zp7XVNfw/EAjDV+I7broQRQ0CAzZ8FptbxpPSRIEIFXOQxI9rcm16oc/c1liFyo4
    I2tsHqyY4i3SfbMHN2kHYhXWiV6eqGHqhydkTq5+8mAWaR7rhq4O/kjM3RW7Mr4J
    0GiRK15inO10Ufb7FtfOYRn5o0YSH2RwKahBv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490152; bh=e4ZyCt
    yxbFHhn7HtSWsEqQPTmGtWU91rD+nYk4T1FVk=; b=OkoFg88np9JKh80phsIwex
    9HFms60QN0+V93YA70/61Le1R/o+QRYCEoTIUUKSW+/OrkeazoRPoOesSQzBjLnh
    QakwcLEFRVbjzKAzuyHTS3JcGGoQa+/FvwMDdkBefk2zv7RgLNjNs/RBk3KpenOl
    veUFrvs8rOn7CYh0StQwjbplfXkaxprB1xrwHxBT+iasO7D9oCAQpXRvv/3uwsMr
    0hmZ353gMpN0aqiZT5h1p//56TmZFlzb4iyZ+vQAAmdFpC+mom7R98HAH9KZA5DF
    JLkkoHoRrsn1gW9ZR5fEucadkNaThcDTwkT7mfarquNnMGGH+epQwOoT3TQHp0cQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RD2RkOZp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RD2RkOZp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965594AbeCHGW2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:22:28 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935415AbeCHFAu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 046/190] clk: ns2: Correct SDIO bits
Thread-Topic: [PATCH AUTOSEL for 4.9 046/190] clk: ns2: Correct SDIO bits
Thread-Index: AQHTtpoys4TItrMY9kK/3FbjB55aWw==
Date: Thu, 8 Mar 2018 04:59:12 +0000
Message-ID: <20180308045810.8041-46-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;20:wLKAmfiaomXNZrIztAbeso4OPqZEOmp0DI7/yTLqgbcD1jgnHLniBFfNSX6pzSTj0ccthJkokdfk0JEU55ka/8+W/d5NvN35ouUfRQLkahEaAHT4iF7ytobGA/rQ7V3dGaiozR8cyjvXOFjV/GIhKmAmlCdW3nlZV4ELMDvbGIs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 490c97ed-0264-4759-5e48-08d584b18ba8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110947B8FE94B2BD5FCEB25CFBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RTZ01MwhvyaJFCvsG32lVH7mwO33ih4NnsYGzPgM5MDmoP6vdygKVQE6kvWRhxswzFZeYtKEp5ZGTkA40NKkTmG7e1xjziKqCiHLjGfAbYpVK2KwAXzRbU/MnNa5AczBKk2K0alTV09RUXY3zF6FojegR35hOEgZMUjTCcC+tnq3gPNGkVrJqaKfzoMOidM+2maWmMJv4j25lw1O44r6kEAJNzc1vWRZ0BCI/TaewIKyNCxEYPXr4+aVyGa5nEKPNrciSY2rqgQxdDKphWBDV69fy85j/NyZ1h1+um55ohvFIKcCJoCmOT/3b5xoxZKlB70w5XTQVACQS78cROUruw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490c97ed-0264-4759-5e48-08d584b18ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:12.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>

[ Upstream commit 8973aa4aecac223548366ca81818309a0f0efa6d ]

Corrected the bits for power and iso.

Signed-off-by: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: f7225a83 ("clk: ns2: add clock support for Broadcom Northstar 2 SoC"=
)
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/bcm/clk-ns2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-ns2.c b/drivers/clk/bcm/clk-ns2.c
index a564e9248814..adc14145861a 100644
--- a/drivers/clk/bcm/clk-ns2.c
+++ b/drivers/clk/bcm/clk-ns2.c
@@ -103,7 +103,7 @@ CLK_OF_DECLARE(ns2_genpll_src_clk, "brcm,ns2-genpll-scr=
",
=20
 static const struct iproc_pll_ctrl genpll_sw =3D {
 	.flags =3D IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
-	.aon =3D AON_VAL(0x0, 2, 9, 8),
+	.aon =3D AON_VAL(0x0, 1, 11, 10),
 	.reset =3D RESET_VAL(0x4, 2, 1),
 	.dig_filter =3D DF_VAL(0x0, 9, 3, 5, 4, 2, 3),
 	.ndiv_int =3D REG_VAL(0x8, 4, 10),
--=20
2.14.1
