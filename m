Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120102-2-15757618794137677016
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
    t=1520120102; b=RDTIXz2r3+LRDX37yAFsR/iJ+/ax9rltNvlDHK0+aMSDD3x
    9KW94fGuUOMyADL/8kX/yHRD0MFXnXDCOjqm1ytWD9d0YiNIF8dX+yIGNUnxc3V1
    K5ba5SQZAUBXaPTYuVhJWPCjMkUfbuGV3EW09fHaj4L5LnLfxQZ31Y/z2luVYjsp
    zrD3b4SQRY+KI/osKXWEltB2iYdef+jylSg9hrBShNSkZBBMt1XF3fi176ETFoxw
    eg3FplVi7qIeI3q77t5GSiSiTLoYcMCCAJIjqoki9Dz9QBUP17if/r5eaO0wR9UK
    WBc15AsjZJOMNdOKyp7jxZehw3xbzK9su/rzU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120102; bh=CvU2xT
    RncdkMGYx8E7xz5d90UT8oHQcuDmtgZ4lif4M=; b=iHQl63lNA8ziqlpnX6hZ6Y
    OwNmwUVUhJ+/QbqzYRwMbXFfS8MP0Y7RMa6q0UOT7I5Cnyf101CaApfyxmcwFU2A
    //1PvcWPpYEcoc4ItZTdNXALR9sOnYCHcqz/fIwQRsZLIrG1tkG1ReQEVFESrNGo
    KEjs3q1A0vo0pO6y57YkRdlYzw6sHy7E9H4Hq8PbqQ7ItLmMAbkkTPUYz+1vphA3
    CRvLk1M4+1w8TOKAeWKKG9fDt+f3TkzHRmcf7vlj7FEprTNesBsqJMb/k1xZh656
    NXjKJmTZBAwDz/vfq3RC19juurAz/k4s6WKXs/xi97mIDwUqvPYkZSlzbPbiOUzQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JzKXcSSl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JzKXcSSl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934243AbeCCXe6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:34:58 -0500
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:8222
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934450AbeCCWfz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 162/219] clk: qcom: msm8996: Fix the vfe1
 powerdomain name
Thread-Topic: [PATCH AUTOSEL for 4.9 162/219] clk: qcom: msm8996: Fix the vfe1
 powerdomain name
Thread-Index: AQHTsz8ZlHpgRTGtyk+CtZEbBsWtRQ==
Date: Sat, 3 Mar 2018 22:29:31 +0000
Message-ID: <20180303222716.26640-162-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:1HAi/0bhnchOiHGuRwDLkYyLVymxxp5xhLITQuU1Ts6YswiFfpV0C2Iid2kca1fgPUDYCjamQXrshNUDfAc0IXuR+POgTG1HuMke+PFLcvN2w06WOlr+fo4bltMikran3NDh1KyltPc3sBIcDuZb46Kq/bVfpI5VkEEpI35jQUNdqn1k9kWnSZ7imATpcxPqb81uGXA3AdXyu+MkfvrnVnhPCOZwF1cDYHhtHwA+Tyi014AZb4LgXTR7Tx7sqBbm
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92086290-94e4-4053-2589-08d581571b84
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034CB619772572AA21286B8FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: J/2mfTC/gLb2d6pkfld+5bxcxhAEdlEsYA5oaU8fweZoEMaHcpJaI13WBWjS13mc+khmxxnNqgbjYogdxyJGr2dWet+mq5KLzFDGKGHmzwOSksA0ao2nDz9iEjXyw15T01EZZyLczpMRv0ej2pcnvhUY/mvmGGwbs22a4Ogi244=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92086290-94e4-4053-2589-08d581571b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:31.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajendra Nayak <rnayak@codeaurora.org>

[ Upstream commit a62ca337b36e31621b582cbe8f17d9404a48e120 ]

Fix a typo which caused both vfe0 and vfe1 powerdomains to be
named as vfe0.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Fixes: 7e824d507909 ("clk: qcom: gdsc: Add mmcc gdscs for msm8996 family")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/qcom/mmcc-msm8996.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm899=
6.c
index ca97e1151797..3b171bef913a 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -2984,7 +2984,7 @@ static struct gdsc vfe1_gdsc =3D {
 	.cxcs =3D (unsigned int []){ 0x36ac },
 	.cxc_count =3D 1,
 	.pd =3D {
-		.name =3D "vfe0",
+		.name =3D "vfe1",
 	},
 	.parent =3D &camss_gdsc.pd,
 	.pwrsts =3D PWRSTS_OFF_ON,
--=20
2.14.1
