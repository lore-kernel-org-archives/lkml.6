Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520489191-2-17707920895841658564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489191; b=XtPWGsIiRX6sBkAG3MY6z8GQp4zZ8ACoLretyRltOdVgQPL
    JF7YoammANcVChD4W4TPvhdL86zAmkd0SWjgrsDeb7HjeFEpYyd0XNAi4lKan14k
    h/lrcw3OcaEtBcIMfyQVIuhKuCad4dWvBmkc5Ly2enk+TvkBvm6hOFj389cjP199
    xfEqVWj5iO1ue0E29tgMlm+zD+L3eOIUKsDNGRoKPVzpZV2Ld9E5EH2xn5n+yQqI
    5diP3awPYXcsBEA7Or05gWnoqGM/ObjfiQ4QSsQ8OWZlN/KyhMn7/k3I8v0JjKOq
    wyXqwjDdbnuvmMwsx9iulMa8lIVch20+N4Y2eSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489191; bh=AsnLLM
    MAAJ2LALJIl6ONIg9MpW25rnCw9O9nWT9ShN4=; b=S3NcjrlDknTuwUiYuvPZVP
    HfcukyX7VzTsbdfhEvvFnchu84FSF4tNc9Kmkm/WnrnRee7iGv/toiV+fSnzBcoz
    e2MI21fX/v3T7KeUUXpz95/d4i90DWKok9Tbz3LNJ7v+j4MqR9524iHhqV/PmtfY
    Lvwurmbl86Nv9z15nmoV1CpY0KE+cKljqz1BNbaVauvYTew+De+++T3agjsezl7x
    n3t9hdPELLsvU4lO7GX+y4LyCqfRcL5DkGejQjrCeFtl6VyEGZLsWyI3Aex0BU6n
    9AX3NOkrAXtUg6R5L7x69MNoO+TaxNKmEGcGQvdD2vQnivKfdXny5upEogiqYFBQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OUEnEhgo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OUEnEhgo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750705AbeCHGFz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:05:55 -0500
Received: from mail-by2nam03hn0237.outbound.protection.outlook.com ([104.47.42.237]:45201
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965828AbeCHFCS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 111/190] ARM: DRA7: clockdomain: Change the
 CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Thread-Topic: [PATCH AUTOSEL for 4.9 111/190] ARM: DRA7: clockdomain: Change
 the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Thread-Index: AQHTtppEYDzD7KyG40yBwQfQAY5T+Q==
Date: Thu, 8 Mar 2018 04:59:40 +0000
Message-ID: <20180308045810.8041-111-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:57QNsdslNw0cGjQaBD2hELAgEnfRFuLWOvuqvjTfEUPlVnNC2istbtwnndl7q5XiZgxn/9AqSRGYRI5qaoBLMThLQ94VWp9FznGWLRS5ihAN3Z0vbaMMG+vpTgtCNaR9PEf3UbDwxMg3hffEBfiuYEQyKD2bKW5L8rRl62RuPkRoUbM5w38HiQmWKkYwtOTmObwM6wJWSQNVNaZRgg6aPjkh+EoWXRtltQ0MtYvPFqrjiAWkTtej7TxIB6R7xfLE;20:PL8tar37q3HxSNt/0T/nDyXoSFSc6UF+iZmmTC5nxdxlJV8vqDjOgsCACh9JlUn2m8zfX+7+Ao4FP8+m49/3jB6TzOgUsLZd8TCZaydLMrPzJH9bIBg06phZSLZeIi2dEJZQDJXVn8jIW8ie9z9Hltr7ms4DGP+aUA2rMEqNkdA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c69f0322-ba22-4190-eda3-08d584b1c317
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997F41F399BA1C080A165F8FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(121003001)(133343001)(217873001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: w14kWnyrppQEuBvedCekL+h6CeCWiap1B+w2Tg6D4DhEA86NZsIv4fmfVB3bMP4R3xlIx/g2U26TdRlpzPNE2R6CG+8P+GT6xklZaRAVmDmVJ6vLBIrDVluCEud1ykdXCMMy6cb7do3+WBBbtgwfB/+7xOazG3yhbuF4rmumkDFWV8u+vaOaz+7OsotMuvpvXNX0mNnu267zyDqX+gX0Hyt4ZFsfQIyQDzUzMU9LO8DkzZPKlmi8Wr16xcZBNIachanEqBQ4LP07IFpfn0Tm5s4gM9icekSNRAW7eTf92+AGUqUJgAMqhk0Szu+n1paVTkG7TUFbZrpv4oDt1usTFvqzAAyupdwdOAncQleKPFP4MzlgX4JIpEI+cH35VnHWalgQmAFBS7k5gTbsykHCIw==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69f0322-ba22-4190-eda3-08d584b1c317
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:40.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 2c949ce38f4e81d7487f165fa3b8f77d74a2a6c4 ]

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-oma=
p2/clockdomains7xx_data.c
index ef9ed36e8a61..e3416b40e82b 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@ static struct clockdomain pcie_7xx_clkdm =3D {
 	.dep_bit	  =3D DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  =3D pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  =3D pcie_wkup_sleep_deps,
-	.flags		  =3D CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  =3D CLKDM_CAN_SWSUP,
 };
=20
 static struct clockdomain atl_7xx_clkdm =3D {
--=20
2.14.1
