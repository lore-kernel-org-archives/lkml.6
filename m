Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479203-2-9062742046489892131
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
    t=1521479202; b=WsNpcsbHQAyk3TkZKJpLGhjM5OxBTlMjCm9ic7RqrAhVH9o
    2rzoZDbtFS0BNrhJ/wMC8g90V5i6KwPlUJXX+KAYIRH+Gxs3qzwzHiYR8DYwLSMn
    uOlJmRmAt8hT6KKCJep6IToxUlF+XZuQzDrLjFW4lnYxiFdqwvDbapjlzuvriXzA
    ZkPDB+c3tZ3w0jzpyUNdggPDQjqf26Kwct4z9R18SaqjS+KV0LpfFTatIF8CYOLx
    aUyXxZOU0njSRumm4JkY6xzGFZxRmvmfI5+X+4ExDsBhrbVtBJDptVYgq8n0TG7y
    QjnY8mlIDosEIbcEK46UazWD3dq9zEuXB+7QZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479202; bh=0+Agbn
    4qyNQ6M7v4mxSCKnr/yj5mQH3ed1l7MedzGHs=; b=QKWamAfOndsMUZIq6NZ0nP
    cNWEt3m3zK45ItYgr+KR4KKjcInGvTISytPPWslc921HN1r7GXFOjDOEnZxjYNyz
    7D7dVum8sXXRiLJ25V708QGL9kCQ2cpp2Nhce3OEj43xaQ2FZbb6zBSmO1IcZHvX
    5FSJ7jf/DVGHj3LX1boiyky2EnlWtWovykwT0Rj1XQ4YSbGMtSzN4l3DpB2I2yvJ
    F48odCMf8F3l9lJ0bLhR1idQl/RAPyyfHRbzEDrDSi816XSKHaxGJofEBoFZ5PXM
    /bk7h6VbHjRfsz95KDFXjADIDeOlgRzUtP7zYCi5iUkdN1yDx8eTo+l7PZ5W4uCQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PollEEWX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhgvuggvqdhprhhojhgvtghtrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddvudefnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PollEEWX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhgvuggvqdhprhhojhgvtghtrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddvudefnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935120AbeCSRG2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:06:28 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:37952
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966686AbeCSQK4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christian Lamparter <chunkeey@googlemail.com>,
        Chris Blake <chrisrblake93@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 139/167] net: emac: fix reset timeout with
 AR8035 phy
Thread-Topic: [PATCH AUTOSEL for 4.4 139/167] net: emac: fix reset timeout
 with AR8035 phy
Thread-Index: AQHTv5x96YdyrZSQDEO/pJfIojT0LA==
Date: Mon, 19 Mar 2018 16:08:17 +0000
Message-ID: <20180319160513.16384-139-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:lgrlmLqmpt1eYl8oKhOgqDMtAiiVlMok8KH+BJJT1xwrkqj0orqSyLCp8QaGYsrpiVYmCLt2Aljnqe4OcHaZPpJXf+HO3tfqU3ZT86g7UGlCpuSOhsz3kzrt/bV4U5EEbEivvEWK6S2lx1qpark9XAp3XC2OMOM7y+Sr6DcDZ7nCoT5FNjN34RInxM2KQaogjl2bBNnqn4o87Jq/p83dAbpk0HZroRpCKoOT9f24dBfntU2uTjrotoO4QZrBpguL;20:CsOC+1K96JOmt0S7Q+/0HJZoux7AfiiNsiDaJQ6UWxGmnKvI6/VQs4VtuaaAEqIwXb1fWgwxxqvu9RRM9TiSFtkGggUIH++srOf6CIB6UUr03hEunjTSmthVi5Id0OWvOw8+nFzcMrvK2xh4DLHjm9LIE9zVsiVDMcLARKv4M2E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddeb91b1-d14f-4f56-8dab-08d58db3f84f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08885B83E54514A57DE877F9FBD40@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6486002)(72206003)(106356001)(16799955002)(86362001)(3660700001)(6436002)(68736007)(53936002)(107886003)(8936002)(81166006)(8676002)(81156014)(2906002)(39060400002)(6306002)(6116002)(4326008)(6512007)(1076002)(86612001)(66066001)(25786009)(7736002)(3846002)(305945005)(347745004)(5660300001)(99286004)(5250100002)(110136005)(478600001)(36756003)(54906003)(2501003)(5890100001)(6506007)(186003)(59450400001)(26005)(14454004)(6666003)(2900100001)(316002)(2950100002)(102836004)(10290500003)(3280700002)(97736004)(76176011)(10090500001)(22452003)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6/XSC/Hx+YPxG7wNpIzRkYsilnbPC1gqMnwtKxzJ0Q4riJrh+atzQB7IEeUGLARFIDIKaaRFvobibNsR8Sw2EWBz7zKug9OmW/2DCKdzTKEF4k8CI6ntCQY1pQV2Ee311DCxHBsx5GclZEHl5Y+mUDMBHt3I3Gp3NY8PGfhj2d+K/1U5BjJLoWA9Js6Z5NS4VdyGQLfH6v3EwoiyAR7UZnuCTW2a1rfPpRddpqXtaAvLWvYtHb54uX3dr3keSLmIJkoqHI+1S+Bd4hc5fiImer1JRG8Bjl7AjIRBJZQs6ZupV8TjGPrZMUG/Kis0nIFd1Bvg6fx5YuZWjrJ60K8rRg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeb91b1-d14f-4f56-8dab-08d58db3f84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:17.1773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Lamparter <chunkeey@googlemail.com>

[ Upstream commit 19d90ece81da802207a9b91ce95a29fbdc40626e ]

This patch fixes a problem where the AR8035 PHY can't be
detected on an Cisco Meraki MR24, if the ethernet cable is
not connected on boot.

Russell Senior provided steps to reproduce the issue:
|Disconnect ethernet cable, apply power, wait until device has booted,
|plug in ethernet, check for interfaces, no eth0 is listed.
|
|This appears to be a problem during probing of the AR8035 Phy chip.
|When ethernet has no link, the phy detection fails, and eth0 is not
|created. Plugging ethernet later has no effect, because there is no
|interface as far as the kernel is concerned. The relevant part of
|the boot log looks like this:
|this is the failing case:
|
|[    0.876611] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
|[    0.882532] /plb/opb/ethernet@ef600c00: reset timeout
|[    0.888546] /plb/opb/ethernet@ef600c00: can't find PHY!
|and the succeeding case:
|
|[    0.876672] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
|[    0.883952] eth0: EMAC-0 /plb/opb/ethernet@ef600c00, MAC 00:01:..
|[    0.890822] eth0: found Atheros 8035 Gigabit Ethernet PHY (0x01)

Based on the comment and the commit message of
commit 23fbb5a87c56 ("emac: Fix EMAC soft reset on 460EX/GT").
This is because the AR8035 PHY doesn't provide the TX Clock,
if the ethernet cable is not attached. This causes the reset
to timeout and the PHY detection code in emac_init_phy() is
unable to detect the AR8035 PHY. As a result, the emac driver
bails out early and the user left with no ethernet.

In order to stay compatible with existing configurations, the driver
tries the current reset approach at first. Only if the first attempt
timed out, it does perform one more retry with the clock temporarily
switched to the internal source for just the duration of the reset.

LEDE-Bug: #687 <https://bugs.lede-project.org/index.php?do=3Ddetails&task_i=
d=3D687>

Cc: Chris Blake <chrisrblake93@gmail.com>
Reported-by: Russell Senior <russell@personaltelco.net>
Fixes: 23fbb5a87c56e98 ("emac: Fix EMAC soft reset on 460EX/GT")
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ib=
m/emac/core.c
index 5d7db6c01c46..f301c03c527b 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -342,6 +342,7 @@ static int emac_reset(struct emac_instance *dev)
 {
 	struct emac_regs __iomem *p =3D dev->emacp;
 	int n =3D 20;
+	bool __maybe_unused try_internal_clock =3D false;
=20
 	DBG(dev, "reset" NL);
=20
@@ -354,6 +355,7 @@ static int emac_reset(struct emac_instance *dev)
 	}
=20
 #ifdef CONFIG_PPC_DCR_NATIVE
+do_retry:
 	/*
 	 * PPC460EX/GT Embedded Processor Advanced User's Manual
 	 * section 28.10.1 Mode Register 0 (EMACx_MR0) states:
@@ -361,10 +363,19 @@ static int emac_reset(struct emac_instance *dev)
 	 * of the EMAC. If none is present, select the internal clock
 	 * (SDR0_ETH_CFG[EMACx_PHY_CLK] =3D 1).
 	 * After a soft reset, select the external clock.
+	 *
+	 * The AR8035-A PHY Meraki MR24 does not provide a TX Clk if the
+	 * ethernet cable is not attached. This causes the reset to timeout
+	 * and the PHY detection code in emac_init_phy() is unable to
+	 * communicate and detect the AR8035-A PHY. As a result, the emac
+	 * driver bails out early and the user has no ethernet.
+	 * In order to stay compatible with existing configurations, the
+	 * driver will temporarily switch to the internal clock, after
+	 * the first reset fails.
 	 */
 	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
-		if (dev->phy_address =3D=3D 0xffffffff &&
-		    dev->phy_map =3D=3D 0xffffffff) {
+		if (try_internal_clock || (dev->phy_address =3D=3D 0xffffffff &&
+					   dev->phy_map =3D=3D 0xffffffff)) {
 			/* No PHY: select internal loop clock before reset */
 			dcri_clrset(SDR0, SDR0_ETH_CFG,
 				    0, SDR0_ETH_CFG_ECS << dev->cell_index);
@@ -382,8 +393,15 @@ static int emac_reset(struct emac_instance *dev)
=20
 #ifdef CONFIG_PPC_DCR_NATIVE
 	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
-		if (dev->phy_address =3D=3D 0xffffffff &&
-		    dev->phy_map =3D=3D 0xffffffff) {
+		if (!n && !try_internal_clock) {
+			/* first attempt has timed out. */
+			n =3D 20;
+			try_internal_clock =3D true;
+			goto do_retry;
+		}
+
+		if (try_internal_clock || (dev->phy_address =3D=3D 0xffffffff &&
+					   dev->phy_map =3D=3D 0xffffffff)) {
 			/* No PHY: restore external clock source after reset */
 			dcri_clrset(SDR0, SDR0_ETH_CFG,
 				    SDR0_ETH_CFG_ECS << dev->cell_index, 0);
--=20
2.14.1
