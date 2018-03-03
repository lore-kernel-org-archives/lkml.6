Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117760-2-7715172636329927244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endade, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117759; b=LO8lIp87vWTP61w7CmTtFOLbUK6Xrgj1Edk04C/PCm5PQ3z
    m98s1MTjbNzFB2SgEqkNyoS5giGsJ1Pna51zHZG6ulsv3Ryd/iHgAxQt0oRS6bR6
    h+s/WF2H1LczCDTW2JkrFFPIfd0q5jfpEE954ZwsFmzSeSq/WSZoeoyXAU8bsy4V
    /1qIAOLps0ujJZLB0E/l9Ro/y1vv7U5ziyie+RtxmxKzrsXeafUgHha6qWw1nL3Q
    /ayvqYz/1Ro+E0yhwVq5VDVIEYp1RUuORtBD8WTcmFMz2Pgnw90u/AzHSleRhZlc
    EUgIsgEFVVOiz2Vy0WIxTH8OL2di6R9+vPD33bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117759; bh=VpPBWp
    gyemzlN/oL/ZBDcBy3P1C4EsH/IpOMOZWDixI=; b=D+PEu++T+RDhZulrdEVuRs
    yKOGrLnII2yqpksMsV36Fl0hlf/VDu4ofYTJd99w4PD/RTPcNHXK3rbtyRL5noqq
    FjZnn3wmmNcpXjis0PLOswq5aaxIGdAzxiyo9CSHrjOAfQLnthlYyI8OxZfjmqSX
    5edY8lm5CO8oUVWdj7sKsZaNRNnVe1nHXJGbynURO8IC0ZAiHs/cKARTCiF7M9gV
    Et8cIrSpMUaTdZr/h5lnNvsH2ikHXqFzhYiIO5M+AjfaqtDDl3CJ6Q5+JE9UXM6A
    jqFb+SDLzBoB6ety4CfOpXNOjcQooxQEK0ZHx6ebfZnN1QjU+yPEvgpzFNKZTwgg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=blmy+7HQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=blmy+7HQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeCCWzw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:55:52 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935363AbeCCWk7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quan Nguyen <qnguyen@apm.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 08/63] drivers: net: xgene: Fix hardware
 checksum setting
Thread-Topic: [PATCH AUTOSEL for 3.18 08/63] drivers: net: xgene: Fix hardware
 checksum setting
Thread-Index: AQHTsz+dWlk3/MMfhUyal9wBCiwJcQ==
Date: Sat, 3 Mar 2018 22:33:13 +0000
Message-ID: <20180303223228.27323-8-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:tBse8s8PVdQJ4HbxHNhQHjLvFqvByJ5qCipj4BLuh6N1molMhWTndkcwmapC4Xd8EafksZz/3G1HiEv7J/Y6/2NTVMo145TsVr7SwPPnimaN60PHLGph4F5sJpna7eoBAMM1LX9rxyYI6dGAj0ujYqWPNJh3JRu9itpxs+UM/dSt6CMliXxTe+hcH1+4U1dKzsJ5GnyKWRqpiL6nTjidWbKYOdb/dBG2z+vKZbvgLJFb3ROJbHXHXmk2854W5+sF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0b3bd13-33e4-4ab6-19a5-08d58157d4f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09407537602862098222E76AFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /p7p6F+iPcFWluVvhOUpSGXCwJeNxxa7KpHqhAZsJGNcXuA1SMGUh6NeIwF/8R9RGAiTI5mW44YhngZPmDiYBxbggMyXoFTuf4xPZLLIQD47y7HVI+ypJLTzRmiSRwgsiG/IIStAOmEIaibeIteXZHFjh50pXpRS3N1JIUdp5Qc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b3bd13-33e4-4ab6-19a5-08d58157d4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:13.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quan Nguyen <qnguyen@apm.com>

[ Upstream commit e026e700d940a1ea3d3bc84d92ac668b1f015462 ]

This patch fixes the hardware checksum settings by properly program
the classifier. Otherwise, packet may be received with checksum error
on X-Gene1 SoC.

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c | 1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/e=
thernet/apm/xgene/xgene_enet_hw.c
index 7ba83ffb08ac..570e5284ff5f 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -535,6 +535,7 @@ static void xgene_enet_cle_bypass(struct xgene_enet_pda=
ta *pdata,
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG0_0_ADDR, &cb);
 	cb |=3D CFG_CLE_BYPASS_EN0;
 	CFG_CLE_IP_PROTOCOL0_SET(&cb, 3);
+	CFG_CLE_IP_HDR_LEN_SET(&cb, 0);
 	xgene_enet_wr_csr(pdata, CLE_BYPASS_REG0_0_ADDR, cb);
=20
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG1_0_ADDR, &cb);
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h b/drivers/net/e=
thernet/apm/xgene/xgene_enet_hw.h
index ec45f3256f0e..66c3d0cd506f 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -143,6 +143,7 @@ enum xgene_enet_rm {
 #define CFG_TXCLK_MUXSEL0_SET(dst, val)	xgene_set_bits(dst, val, 29, 3)
=20
 #define CFG_CLE_IP_PROTOCOL0_SET(dst, val)	xgene_set_bits(dst, val, 16, 2)
+#define CFG_CLE_IP_HDR_LEN_SET(dst, val)	xgene_set_bits(dst, val, 8, 5)
 #define CFG_CLE_DSTQID0_SET(dst, val)		xgene_set_bits(dst, val, 0, 12)
 #define CFG_CLE_FPSEL0_SET(dst, val)		xgene_set_bits(dst, val, 16, 4)
 #define CFG_MACMODE_SET(dst, val)		xgene_set_bits(dst, val, 18, 2)
--=20
2.14.1
