Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491709-2-11112247283997802451
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
    t=1520491709; b=i6gIRyCAx1vsvdRCKX5j3CnR86f+BCB+iGxleIpDWxNOi5T
    YA6RH61gutlVm/JKeA7zP8G4xKYlwMp3bNg4/1N9b/+Fr87nOF5HOKzdkx/q7NnT
    OFgOjl+gTOPjujOA9UR7fW8MFH5PKP5rEepctBZdgLg2rRoa6YgnLnwgcjfdaUGx
    +u1+whwPqDj70MraGrd8qcTf30prt7IugE4hSIzQRXvaILPvD+ZhyvaNnJKxYstP
    CEyrFsNydfd9z15T9GjwLk05nbue/YLKAQ1YcN7oiff1GoylWA6bcbprfAVGB3ko
    yEyae7PlZB92OAUZOF49gGLReFqzznIcQ9mtCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491709; bh=DNfCzD
    688T1LYXYtIMlz5HTw5nytUqaDRO4GUhpZea8=; b=Fo7MxpDivBwfZ0sJBBGmbj
    nfD+LNP7Tv6Pj2sS/q+1d67CA5LW4XgEHRvsqtZWqHJFret9Vl97SAIM2EgcoiTd
    VJ6sPe5+WtLj62z7DkYxqEeGWNQDxT24MEH9vu4ltsj4XqSZE1H5MSHYLc4tAadQ
    W1eDNq5duvbeJIoIhnNSH0qbNUq09JGsTJwutqu/8sCXNqmNAQGKU2cY+g+OgmEs
    8JTW70aYFx9VP/N8Uzjj1hPFmItoaar88knPssV3exGpjHGlyuq/V9bQqm/47lDl
    tAmh40M+vmID8QDL8uX3Z3/+cwlSd/vFnjgiI4C1/sgagNCYAtjrgGDvEfovGQ8A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZXh8mE/n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZXh8mE/n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935228AbeCHE6S (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:18 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:60295
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935138AbeCHE6M (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Richard Leitner <richard.leitner@skidata.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 07/67] net: fec: add
 phy_reset_after_clk_enable() support
Thread-Topic: [PATCH AUTOSEL for 4.14 07/67] net: fec: add
 phy_reset_after_clk_enable() support
Thread-Index: AQHTtpn4DsxzsJXEFEOZegRT9iMSWg==
Date: Thu, 8 Mar 2018 04:57:34 +0000
Message-ID: <20180308045641.7814-7-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:Hy0e/C1csAlPQnC0SU7hw2Wj8nPXEY5vsg/IQ3jAveFMrfdYW46K98hzfjZ3z8DtHd5wu//0CuHdYeb/7qtQ7CXm7xXAkMKEf0N6Te4+C0jJAwGw4PutnDiC8ROP6xDpZ98GPlRerNbOXhdV400ncFIqRKXCynKYB0LDcHk88t1Wsxdfu57tWASzjvGxucNjQLW908GK4zzp91gDHpR9EXhSwYWrycvfZZkdiX3/2AETKDY1cEw3uKwCKFtrJlSk;20:/kgjDgLmR4lWuyX7WVs3ofHaHT3+A7Obgb0I5Vc1IeEdk+Rr9eyyVAPdDuX+zMAdzVarOzlFVvGe4mrojGj+xZAyc+Qswz93n0HxiUrD7rW93LWD02550PNXGJ792adYiQ+0P22+qE/mVz7kiVers/MdPY7dqpEbBZZiFULeCeI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5df4c5a-1898-4aa6-4e04-08d584b12d7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888BF540EC634436B8FDACAFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(6306002)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(966005)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: j+7kAkqyxNeuoohv1X3lRjROY+oXsc7g1DdUKq+zfOSrMMHIZPeBg+OdvVLhBOucpr4/V4SywA7Q9hFir6E9BfZbBSGYaG+gN2XkLlXbYYT41QjWQXU58M2U5BrPcfwIVo7ZEecGLE35iWSFrZywK7XKjBwmhZXGRBeN/AgLlzYZEQwTZzqjjOrm1ZiWPld99uRG+OPlAO2Lx0zjHhQA3tCe2R+es5zXY2XAnSf6eawafArKBiZXNvULH9yLB6ZdHPcCXIn/tmuhESmJASiHSjVb0VJsXqsiqoGejjfvrab9gF1Q/U4EfoD1pJ0Bd52Oe1Q42UmlpzW9gMpQ/CLsVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5df4c5a-1898-4aa6-4e04-08d584b12d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:34.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

[ Upstream commit 1b0a83ac04e383e3bed21332962b90710fcf2828 ]

Some PHYs (for example the SMSC LAN8710/LAN8720) doesn't allow turning
the refclk on and off again during operation (according to their
datasheet). Nonetheless exactly this behaviour was introduced for power
saving reasons by commit e8fcfcd5684a ("net: fec: optimize the clock manage=
ment to save power").
Therefore add support for the phy_reset_after_clk_enable function from
phylib to mitigate this issue.

Generally speaking this issue is only relevant if the ref clk for the
PHY is generated by the SoC and therefore the PHY is configured to
"REF_CLK In Mode". In our specific case (PCB) this problem does occur at
about every 10th to 50th POR of an LAN8710 connected to an i.MX6SOLO
SoC. The typical symptom of this problem is a "swinging" ethernet link.
Similar issues were reported by users of the NXP forum:
	https://community.nxp.com/thread/389902
	https://community.nxp.com/message/309354
With this patch applied the issue didn't occur for at least a few
hundret PORs of our board.

Fixes: e8fcfcd5684a ("net: fec: optimize the clock management to save power=
")
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 311539c6625f..04b1fa007a17 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1872,6 +1872,8 @@ static int fec_enet_clk_enable(struct net_device *nde=
v, bool enable)
 		ret =3D clk_prepare_enable(fep->clk_ref);
 		if (ret)
 			goto failed_clk_ref;
+
+		phy_reset_after_clk_enable(ndev->phydev);
 	} else {
 		clk_disable_unprepare(fep->clk_ahb);
 		clk_disable_unprepare(fep->clk_enet_out);
@@ -2844,6 +2846,7 @@ fec_enet_open(struct net_device *ndev)
 {
 	struct fec_enet_private *fep =3D netdev_priv(ndev);
 	int ret;
+	bool reset_again;
=20
 	ret =3D pm_runtime_get_sync(&fep->pdev->dev);
 	if (ret < 0)
@@ -2854,6 +2857,17 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto clk_enable;
=20
+	/* During the first fec_enet_open call the PHY isn't probed at this
+	 * point. Therefore the phy_reset_after_clk_enable() call within
+	 * fec_enet_clk_enable() fails. As we need this reset in order to be
+	 * sure the PHY is working correctly we check if we need to reset again
+	 * later when the PHY is probed
+	 */
+	if (ndev->phydev && ndev->phydev->drv)
+		reset_again =3D false;
+	else
+		reset_again =3D true;
+
 	/* I should reset the ring buffers here, but I don't yet know
 	 * a simple way to do that.
 	 */
@@ -2870,6 +2884,12 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto err_enet_mii_probe;
=20
+	/* Call phy_reset_after_clk_enable() again if it failed during
+	 * phy_reset_after_clk_enable() before because the PHY wasn't probed.
+	 */
+	if (reset_again)
+		phy_reset_after_clk_enable(ndev->phydev);
+
 	if (fep->quirks & FEC_QUIRK_ERR006687)
 		imx6q_cpuidle_fec_irqs_used();
=20
--=20
2.14.1
