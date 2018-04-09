Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237411-2-7376811403093591418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237410; b=kcmtoTwQOqwnU/qewyHEXdE2+ogFNcIm/pK8HBZgfnVNPUzzoF
    Gslmrh46eMkxL+7MtIkO/Cp3qt6ysB4ArA4zIQkGYwAvp6i036O7GEcOW4Xhp5Ou
    16DxKNNYoZDodL9sUFwibdYpD7psUhIS3MRUER6DABlpitqw2jfkB5csdgS9Hw2h
    2l4KUw5KRY4lYhmJcL3vfwkeKfKKIWKWC/F9dobHXPt2ke7wTimseNCG2LfkYR0y
    XISmcbzCMgknPeZpW8CdZ2w5RrOz4AbuxVBR+nhXeXE57xM2tAgnvqnA46fTgH6F
    jAeKknjbS3knK4i2tlGi+UI161g6QdL95ySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237410; bh=nvTl3Nq3iA
    wuvp+wreEu4IWoUJosFpczniiFxAv+fZE=; b=g8YnXZkuUgyZkmM8vTNXYqQD2A
    TskAXkT8pgaPqbmxJkKOugo9urkpv4eol+j2jBkq1IUXgzLvqrBU5E0agw1AWaB7
    DvaHSUNvlMhn8dp/CG6kRwgahpuZdmQ7g58ahYs5ZxtJPJUhDxvvSaTCjvJ4SL36
    hw9JzI6PSuZokI1RooM+smAZNpIP2OhnAs820CIovz+JgWNl3kFvprKzkb3CAHGW
    kGBoNql/b5BHXpiX4BXvau66EmUGFXmw9iGDubI3wjdMtbjVGHB+A3AlFpsPbKjL
    4r7x5jiuPJyUMQvYDkwtWwnsgNwWzpWr327VZp0CqdIpCVRI4FBGkJ8QRhGQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FqIjh8R4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FqIjh8R4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFtiwuFTzYnJVKRvESz1t25PgV1Uvtmq+qHtB8BFxPfePpDTcY5jVlBRpyJnSE0IA6ZkJdSbl4zrPsTpI6TfCNbRWbfqnuZrojV7JdTNbcvBR8vzHYjH
    jkHtihgUERXMircDjns2vuiU/tQ3bstwsT9r/M2Bl+gHhuNCI2MgDknGcFeDbMXUYb9znkBqNIY5i7e3kr36m26dYN4BfjrpUCaIRCr8AGf4C+Le7LfG6XdX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=lOoD4gDX1kpuODFa1F0A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeDIB3w (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:29:52 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:40736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756643AbeDIAgA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 048/162] clk: socfpga: Fix the smplsel on
 Arria10 and Stratix10
Thread-Topic: [PATCH AUTOSEL for 4.4 048/162] clk: socfpga: Fix the smplsel on
 Arria10 and Stratix10
Thread-Index: AQHTz5mn/cXP2IrUXUm9XY2/+Gqb2g==
Date: Mon, 9 Apr 2018 00:28:17 +0000
Message-ID: <20180409002738.163941-48-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:31wS3Wncz33724qxNlLJIYFSCwiWDZCwzTHqqKhtdexyE5pdU/1N3JvK2ZX90XZ23iEwf1QmWPhlULQn8/6eCCpwI/SdIj2HQ9N9LURFNSliOhnpLo5WS9T2VNt015kF5jK1zGykELzbWg4tZmAJUC3qyIPMKNQETAhTn1VCsVK3+3ty33JvFS/vHyEDAzf0r4FhlxwZyz5ZyTNUZzYeaEc8iAIR0UmstuDvwBzQuMclnIQTqdup9DCIoIcIhYJ8;20:kA0LgDoUVeKS2YQ3omwzyurmsiMOw/njQrym/uDtjytigZvXDC0QQkXDzQ694uJNoKOCSYBIpFTAOVA+myOG4vIRQdKNGR7FY17Wk1RMUShfQBAdGSlBhDrIWVN16kGQRLpisGJsBPoaY6wqbqiN39SI9gsBEbX34+/0PGKPUCM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: adea328d-bc08-4ce2-72ae-08d59db1dcb8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10156C1042A36090DC4C3D97FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4lUg45nQ3WxnLZd9oxQwFgOXDCxoHSDUNwsSvejgf5uJ4GPz9vYEhhRdm76Ad/v6QZ1IcXXeP19v8kEW5kHVoYAwMCIsr+vYEkdp12X6sYSeWTvUqAplJzJlDAHNmuWh/VkpvG/qqlbavtYF0SXnxwGiIKx9LsuywMU0tUdiW5qMGxtZxuyKdS5a9mjSwwUuvjy2Fpc4bD9FfHwWzZCGqBylmHQ8gB4ROlgvTGdhYriBD4Ypv1EEfR0YLDqS3XqvYRD0jLFMFoSNXjHr2+NF0gCPjHOhhjsmfuVNMYq5MsAeRGLa4/W8luOzKB8tIaz960ODvnIZxVHcn9S86sZN1BsiS2vEwLFeFnFqCS5C4D5lfytzwNKM4iUPImsasXVYP1kk7YZBFzK5f3pfOQ54ryCG5LnKz74L8jmgiSm8xw4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adea328d-bc08-4ce2-72ae-08d59db1dcb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:17.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dinh Nguyen <dinguyen@kernel.org>

[ Upstream commit b7f8101d6e75fefd22c39624a30c9ed3d7a72463 ]

The smplsel bits for the SDMMC clock on Arria10 and Stratix10 platforms are
offset by 1 additional bit.

Add a new macro SYSMGR_SDMMC_CTRL_SET_AS10 for usage on the Arria10 and
Stratix10 platforms.

Fixes: 5611a5ba8e54 ("clk: socfpga: update clk.h so for Arria10 platform to=
 use")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/socfpga/clk-gate-a10.c | 2 +-
 drivers/clk/socfpga/clk.h          | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-g=
ate-a10.c
index 1cebf253e8fd..f55b36bbb7ae 100644
--- a/drivers/clk/socfpga/clk-gate-a10.c
+++ b/drivers/clk/socfpga/clk-gate-a10.c
@@ -86,7 +86,7 @@ static int socfpga_clk_prepare(struct clk_hw *hwclk)
 			}
 		}
=20
-		hs_timing =3D SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
+		hs_timing =3D SYSMGR_SDMMC_CTRL_SET_AS10(clk_phase[0], clk_phase[1]);
 		if (!IS_ERR(socfpgaclk->sys_mgr_base_addr))
 			regmap_write(socfpgaclk->sys_mgr_base_addr,
 				     SYSMGR_SDMMCGRP_CTRL_OFFSET, hs_timing);
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index 814c7247bf73..9cf1230115b1 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -32,6 +32,9 @@
 #define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
 	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
=20
+#define SYSMGR_SDMMC_CTRL_SET_AS10(smplsel, drvsel) \
+	((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
+
 extern void __iomem *clk_mgr_base_addr;
 extern void __iomem *clk_mgr_a10_base_addr;
=20
--=20
2.15.1
