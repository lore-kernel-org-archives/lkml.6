Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520119128-2-8489573547482673205
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
    t=1520119127; b=fs0v6eaIXP4QClAJkQANTZjRGJTybFO6K5tmY4BtQZbL2q5
    Ba0Lu0wpqg0C/SnSekdfiNeaP9GbON7D88epubN7/o7Uy8TFaltJRf7DAKl0kzm7
    1m3GLP0apLDBUSI6734WZXjC+NtvzDLrzhc+plvwi8vNkOn+jl14zPsFp04049Wg
    T9uTUe9JKRsNCPziD3C4Z2z+5Yo7+CTeTZkYLk95+CQi/DTGCTjuppgHxDYtDu7Z
    Iv6xuKEbTNok3z8zRMdmiYtirFaN8ZovV4DksnEbXRi928EzVuW7uLLTsTf+bJH1
    zSNY5VSQHfAZSnOB7zgngg0gOhvqWuSdBLFvP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119127; bh=MriFU9
    0OR3oVTYZFJfiRTfOlov8TxubrwKXSw2TUX2s=; b=FM+qBeqC65UskHb3mzP5x7
    q91TI50YKy2QPUBmV2rvDSnrXKAF7VJyVq71n3Xd+iu+0e3JiiNqj4ZtsufXQuBz
    tS9uyo4zA/D7RF4qr9iChm5FubDVFWhyeaBdKwzbCYatJtzn3DrlhfcwUGYj0z1c
    EjCb3zBS6kXHHjYrxIo24TdwmVAk13i3+einlk3wCc1tbbVDO0BL7wxm4wjCjYaR
    SzoTLIAxfFdYykoFe6jHIdo3TP+Xf4iVbuoJOX7cTV7apZTqByHH17PEYopqmvgr
    f8QHjweeolgvDN9Q4ub1dMQKV0XHL71un1F1hotHgTXUdB5Ilw0KAFoLus/PbEZQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GrXR1Bjb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GrXR1Bjb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934860AbeCCWiI (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:08 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:16253
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934842AbeCCWiF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quan Nguyen <qnguyen@apm.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 015/115] drivers: net: xgene: Fix hardware
 checksum setting
Thread-Topic: [PATCH AUTOSEL for 4.4 015/115] drivers: net: xgene: Fix
 hardware checksum setting
Thread-Index: AQHTsz9LOWC4TUTKfUeV3nTsZpUUWg==
Date: Sat, 3 Mar 2018 22:30:55 +0000
Message-ID: <20180303223010.27106-15-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:rOuYwx3HdojaHSCebIzX0e9nccuIkZR2WDY7/jCTLld0H/RtTFJ7bQd7VwO2595VD2bRdMQbotHiMv52N1i/CvR8FtEJ+2LjSzgXkvNv/s2eLPLls4QgXiNmcGvBmMCQOBW/Z19l7JSMOU/yMfErHolMbNDMzvqgey60Q503nwjZhjMRwiQxGhlhBmvHZx25NfXBGFR/J9qx+mh9JXCbhPxyT2uem6BcdM9fBwS2GOBpjHjkoY2tfBrYpE0sDBIY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f430bf2-3655-451a-9fad-08d581576c7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09380487F5358E530B208CD9FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: B2aATMTl2TeHOzm11LjFZyu8oIC5C38rhgbLljECrR8j2P8e6fs4W166TIctb/ja3zC1QzIVlqPtusXhI5vuJ9BdcFptG1assACSd1mdTkzwf9HFGh+PNUcYu99l4FNemrythw9eE/L/1RvOQIcoZYIlYXZgxweEImvL42zA1n8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f430bf2-3655-451a-9fad-08d581576c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:56.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
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
index c31e691d11fc..e8d31640058d 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -604,6 +604,7 @@ static void xgene_enet_cle_bypass(struct xgene_enet_pda=
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
index c153a1dc5ff7..480312105964 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -147,6 +147,7 @@ enum xgene_enet_rm {
 #define CFG_RXCLK_MUXSEL0_SET(dst, val)	xgene_set_bits(dst, val, 26, 3)
=20
 #define CFG_CLE_IP_PROTOCOL0_SET(dst, val)	xgene_set_bits(dst, val, 16, 2)
+#define CFG_CLE_IP_HDR_LEN_SET(dst, val)	xgene_set_bits(dst, val, 8, 5)
 #define CFG_CLE_DSTQID0_SET(dst, val)		xgene_set_bits(dst, val, 0, 12)
 #define CFG_CLE_FPSEL0_SET(dst, val)		xgene_set_bits(dst, val, 16, 4)
 #define CFG_MACMODE_SET(dst, val)		xgene_set_bits(dst, val, 18, 2)
--=20
2.14.1
