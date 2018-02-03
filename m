Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682486-2-4766345490374576761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682485; b=aDq1bPk3Qha8Z3HefRGecMwwwgdupUf3rZOr6fEalbFejCe
    wCjOr1acziNtzBHloQEv7EmKrrNlKRDjAGTtLDqw02f+s57npwc6g8jOmKusDzd4
    kJYBhTGciRZ6T0wGlTgVFTnL7EeQOHk7v05N8kHVKJAqvLNTwlVrNlkTfqS0x4XB
    3WxMz1lxVZRQF5YO55PCQYS8aF3Atsr+mMdbm3+VEaL3vayFpXb4gvK7ple3U5Mv
    q3pBN1pyXOXnhxbSNXG12pbpRdog9cLrDBOfHOTxGck9VV9NtQlx/2vXUHhvefi8
    TKRIaB1kZi1hOgvBJsYfVyqEWlgw0efq/gTsrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682485; bh=SHkoY6
    OBOKug9Jk7Gmh4yauz4pJF/gEK7lwo7Y1E+9c=; b=igPYTgOfM2fAdz3VNMfxPt
    VmAd3D8Q4lh9mXQmu0WIadPcL7YRebhib8jKFmukg7kRBFGaSS7QgWPgIx95BXUv
    ZJsxZrcUGpHKVrTn7YdLv5Bja/7WSjdakvbvA0MVUPYYrR/nB9r6rPpsvyDINAkN
    bHHvoZne4vGwSQpZ+K4AeYNInyxNjqHz2rKhl75mCJvs6LVSn1lQeG0NHgfSjwhP
    DD9LLKQtLpVJlC9MCi/IZ9ZV6JUTHWkNNfP1HSAs7200RX4kqpVmEB9MW3uckm3v
    wWDMNULOluvkpCD2YhFom7ImUdF+l9ztj4r3HxbQz7V1cL9MohOrFwer2NYhSnHQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lB5i5REG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lB5i5REG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeBCS2C (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:02 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:10688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753328AbeBCSFB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuval Mintz <yuvalm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 110/110] mlxsw: pci: Wait after reset before
 accessing HW
Thread-Topic: [PATCH AUTOSEL for 4.14 110/110] mlxsw: pci: Wait after reset
 before accessing HW
Thread-Index: AQHTnRkItlwDpgw67EigJtJeNsydzw==
Date: Sat, 3 Feb 2018 18:01:36 +0000
Message-ID: <20180203180015.29073-110-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:KZAN3tjdNz4JcTVyaXWdSEP/MS3qlduUISeaFSkbiVwaL6AEEEzXxY14F+4WtVmZnob5q8comDz3Lo4OWWm5ibaoJpBh0Y3GdJszOlN6HjG90T0UCGVPVlV22c4XDawl+o+1cSGhesxcMWvhvr1EYUdLDkMnxG7KLowV5YS+VQKbkkHE8zsQBM6VWB59zhnaJ98YfDnPhow5YhEGzmGm/bMFlGIxiudrTA44Rk41BbgLteTzL85QNDqbqtVGWuGX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a94c638d-3368-4895-1773-08d56b305a45
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099313E6091BFDD65B6F201BFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: BiQ4neJbDaXBPVg1NyJdmi+xifPKIBhvX9JMZNUVzseEKNCLLAVf2YyJZVkqTOqoH44ZhHH9mIxsk+AbLXzbHA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94c638d-3368-4895-1773-08d56b305a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:36.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yuval Mintz <yuvalm@mellanox.com>

[ Upstream commit 8e033a93b37f37aa9fca71a370a895155320af60 ]

After performing reset driver polls on HW indication until learning
that the reset is done, but immediately after reset the device becomes
unresponsive which might lead to completion timeout on the first read.

Wait for 100ms before starting the polling.

Fixes: 233fa44bd67a ("mlxsw: pci: Implement reset done check")
Signed-off-by: Yuval Mintz <yuvalm@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c    | 7 ++++++-
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethern=
et/mellanox/mlxsw/pci.c
index 23f7d828cf67..6ef20e5cc77d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1643,7 +1643,12 @@ static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxs=
w_pci,
 		return 0;
 	}
=20
-	wmb(); /* reset needs to be written before we read control register */
+	/* Reset needs to be written before we read control register, and
+	 * we must wait for the HW to become responsive once again
+	 */
+	wmb();
+	msleep(MLXSW_PCI_SW_RESET_WAIT_MSECS);
+
 	end =3D jiffies + msecs_to_jiffies(MLXSW_PCI_SW_RESET_TIMEOUT_MSECS);
 	do {
 		u32 val =3D mlxsw_pci_read32(mlxsw_pci, FW_READY);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h b/drivers/net/eth=
ernet/mellanox/mlxsw/pci_hw.h
index a6441208e9d9..fb082ad21b00 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -59,6 +59,7 @@
 #define MLXSW_PCI_SW_RESET			0xF0010
 #define MLXSW_PCI_SW_RESET_RST_BIT		BIT(0)
 #define MLXSW_PCI_SW_RESET_TIMEOUT_MSECS	5000
+#define MLXSW_PCI_SW_RESET_WAIT_MSECS		100
 #define MLXSW_PCI_FW_READY			0xA1844
 #define MLXSW_PCI_FW_READY_MASK			0xFFFF
 #define MLXSW_PCI_FW_READY_MAGIC		0x5E
--=20
2.11.0
