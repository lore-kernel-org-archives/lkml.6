Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121837-2-13872329989692343271
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
    t=1520121836; b=SsQP6ovVgAipQcnvH5prt7UvW1PFG9SruMzMBqLbeAajEQv
    ppb/zjraoqO2LHWJzv7XPCDMNExTJanxLjsSWAiqF2cxCQy0SEoO73SC3I/1brYc
    x9xuVgwodq9wt7IeVloHMByTqChh9HzuoeN2vx2YbGnDWEIYUTkXjMrUQ04dP0jw
    l9mL5JDtwv7B9xpMtrNyslO6AWqiK5ed9xHh/Wzp6c+E/Xp5Jc9eduEZUYtXfvP/
    6is4RTrO7+VaRW5YzsoSTHuBg7mMtKKZI2MadJRwKg8h1wUclwxzMOPtvBquSidI
    BTraGqllgsWw8QWxvBT4Dgdylz0h8BrFHmpuRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121836; bh=7w0UG6
    SmTf8ne5iFTlmtMHphNNIKRXKMYHu9ifj7xI0=; b=nZ3VKr4uYb2Xus9uh84sMq
    OF/rVNB3vO9oJjjkAkc33t1qqpnk9oGhL9IiLnHZJLtE7Q48syc5uYDV04SbnCHh
    I3IbI65c64Fi4AB33wiCJunltV7UtYvz/IHoy0AefYZ9P09W5Doaf8afiLxtOMvp
    9xbfgomdo3KklVtlk0xyPNYOtJIZ53BQ4dTA5+S+DbtNraPgUtIgQCXfziMpFDVF
    e7R1Oz8eic3TdgFnaVmVNcReqtmjVKTY4PNp3Aq9l2q422/i/H1RJEUF5/p+GcVo
    hT8GIYt/RVtnapTgaLuo8Hi8OyovI6w3DTA6l7v8WiaRBkUsD+W+cuqjSsRf8XmQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jMPjC/nb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jMPjC/nb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeCDADr (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:03:47 -0500
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:49722
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933695AbeCCWb3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quan Nguyen <qnguyen@apm.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 030/219] drivers: net: xgene: Fix hardware
 checksum setting
Thread-Topic: [PATCH AUTOSEL for 4.9 030/219] drivers: net: xgene: Fix
 hardware checksum setting
Thread-Index: AQHTsz7qHgGg44mIJU2FkMeO2C7xxg==
Date: Sat, 3 Mar 2018 22:28:13 +0000
Message-ID: <20180303222716.26640-30-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:h7PC3SREdhU+ZiT1kPoMUjGvdLZ9DBCwjKvOqa5z7DF0whAdYur/SzcHA+NpOMHqYXlJZcW0f4VJeQWYvjJ+S0yHsrO1TKDV3DiLFVqtEaxWJeVI+Mh8xnEHcTeORbHVfNh1RY7EysaMDoeXN098mnuRC1AzYOeNBvQNmlnX+RTHqN82oDxrueY/WF/9Xh9c1pt6bs5juqkqq0ubyUXkafQ37wlpDIemENwWPxVVfER+K2NH6kvY7qoGegO6OXle
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8e2db51-150b-48e7-f9bb-08d581567eb6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09703178C015ED97666F1AF4FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: K8iFWOtdziInlZzPMAFH0n8glBrPMM1u6oV5KjANjVktVhal+0Sn7FaKrU7TUP/Jz9JR9sqZ5y7n9aoe6DFyJn4ep1/8nlYTdYDeMQDfmZ9bTMBQi9eL8Cv7v3TI9qLqWctU0dZRF40gW1spf94CZJ0EZqfRJesLqlNKyreJ044=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e2db51-150b-48e7-f9bb-08d581567eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:13.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 5390ae89136c..71611bd6384b 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -560,6 +560,7 @@ static void xgene_enet_cle_bypass(struct xgene_enet_pda=
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
index 06e598c8bc16..c82faf1a88b8 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -163,6 +163,7 @@ enum xgene_enet_rm {
 #define CFG_RXCLK_MUXSEL0_SET(dst, val)	xgene_set_bits(dst, val, 26, 3)
=20
 #define CFG_CLE_IP_PROTOCOL0_SET(dst, val)	xgene_set_bits(dst, val, 16, 2)
+#define CFG_CLE_IP_HDR_LEN_SET(dst, val)	xgene_set_bits(dst, val, 8, 5)
 #define CFG_CLE_DSTQID0_SET(dst, val)		xgene_set_bits(dst, val, 0, 12)
 #define CFG_CLE_FPSEL0_SET(dst, val)		xgene_set_bits(dst, val, 16, 4)
 #define CFG_MACMODE_SET(dst, val)		xgene_set_bits(dst, val, 18, 2)
--=20
2.14.1
