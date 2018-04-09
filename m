Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233616-2-3434972387329572424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233615; b=S4KqTnCzxlskCdtGw3XFy0olpvc5HMzWQG25CAcBIkqscq3hpo
    q4tkUFf9xfAdXqiF7XrMxtbZZfO84xLNSgGQmf3nwCCY1TlOOkoZ89sglhjbQRQa
    /Wwj1utfzkwWsXYKO7XCZxzGycjEMcyY8m7OCIRpvQq0X7hGyUQPg0FVu+gDbIVS
    x7WgzcAV7NgQDypLomneqousoT4E1MSpHi8Z06xSnHbrQgzdp8QwvGWuvPjOdZKe
    /9qy+bnY7++fcgD5uqYrW0Z+o0deyS2jO02i455mJg3ZnRP/tIr245uNmmjUelix
    qGvw8KH53G0vqxLxaygGz9fv9pHhf+ZbguYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233615; bh=tS+lR4ksBS
    bussWLk9meDr4Umj87AHjJDZQoXh6y8Xg=; b=RhvmBDOGB9BViHftyL961hBgwh
    Bv58tJ/EPhPbDI37/4nB+acNAdnrz1QYKjUAv/O0zuZKnq+ZRx/GF7VVRFbNH+nJ
    DXrmrpcTGN293X3mnMBxslhl8osJ7Q1NBhi5aOx4IpfgnER6WEdLgty4IvpcNXlP
    ed1D2xVugOY3FntnK6umtgFhbKJPvcZWJWkSxF7PJDfh+ac2qwW4dh5cupQh+xFW
    3726lV94dyKUA5ToGBLd1pBVd4GwYKdjmcIT2vsVmFPVfCZIwbVHykVO+5fLtugc
    9Kb6IGiT+aL2MNy4zcxxCev/5J5ezw+gxbyHue32ReNkxRxi5N7EHTn0MdAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rgq33/b7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rgq33/b7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJG39B8LCshRujK3Xhl8Cf1v7n9b8riGc8o94uIzNY7lfbUQMlzQTf/8TOLVHVzryWh8f2fKgY6tw6nTqbtNh0YE8LnFaDKXOzTuQUfDl3hI12MTRh3+
    CQM2a+/L9OP7sdzczpBwVX8OWvTzAD5GYlzGezlOGAHyEjWuRK9flQw1/u/2jQwRfpORaZicR71m8m0TxHQmFlUx3j+IRL6UbKCdXfgWrR0xVc+9BC4XLmFP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mK_AVkanAAAA:8 a=KyFl3zXNAAAA:8 a=pGLkceISAAAA:8
    a=wN8y-Yx_AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=L6mrDz4BGHFqb7Z-ehIA:9
    a=nWszNjwElBV_vZeR:21 a=PUMi5XH-WNhQB0pU:21 a=wPNLvfGTeEIA:10
    a=hE-CQoAEJnYA:10 a=3gWm3jAn84ENXaBijsEo:22 a=BhUsNs7XMpJvgoQe9RqM:22
    a=157CbnpJa6P2q4pOZ5fC:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755460AbeDIA0w (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:52 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754312AbeDIA0o (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christian Lamparter <chunkeey@googlemail.com>,
        Chris Blake <chrisrblake93@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 012/293] net: emac: fix reset timeout with
 AR8035 phy
Thread-Topic: [PATCH AUTOSEL for 4.9 012/293] net: emac: fix reset timeout
 with AR8035 phy
Thread-Index: AQHTz5jo5JvCXR18aEyf4sACKzqHgA==
Date: Mon, 9 Apr 2018 00:22:57 +0000
Message-ID: <20180409002239.163177-12-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:x7BVchSYQAJZpMy0eN2Siztyo5yCfl6bMwO3qhTPss2o4dftcZXYGKSfN2Mcqb7LFo+dNC8VmnhggaBfG4lUXyxvi+bP99t4M1feGbF7pLVNKTC4k3HXrvw+ol2XajWX7TO+mGEIE2Y9YCyMZD0lWdfs4GJtZHhqKR+gQgX8IHVLc9FxPlCEL5Sg93zEiIOn7IuMBMLAspzS+6vIRsUZiF5FgUSRFVwVCof1L66ZUcHSNd1ftAMBLUlCfVqM0+H+;20:rbocMO1P0fZcth7IeJ1p9qCT/8rvVSbfuuiXOQ7r8P5fbbmNyFTALr/5GAvnqSZv8noox+idgIBU7+Ft51CaY+1DPJtdKXowgxFNZ/Hs7krQLcxGyjFHWFTFBRbJptJRRb2Omm04XB2Z6t1yC2y35WRXU6qsI9gpQcmIOhfM8Ec=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14f7efef-db8f-4c16-676e-08d59db08e3a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015C0D2C1E1031BC9E3F1CDFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(5890100001)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(347745004)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(16799955002)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: R4E8gG7Ey8ykOtAQWAOnaimM652bVHp6io+23S5lvjs6H6Mvb7coqD6XmDr5wPUz3KrzW/bVAE70Fe5XFZovzp82YNVxD+C4E/tcH80NSCepWGWQbUoJvLTrwbpTq+qv/4gMKiHwKA77MD9Ui5HP1I0ZgmnzS952eCwIb1iiIMQnWxtbmf4CQlPrECk/RDCV8yx4eQtdpCN3vyOcUo/3+FT6EJlsTTnfBjbyJYq+iYONWNs2jhLpxSCqjnB0qa9/oiTusBhMGETHsIDKLgZSFevLYOmDANOMyKaaLjLiOnbciAjjJnBBmXUR1aMR9pSUeWjcSbNbT8SphJXrbCOh4GMmQPh7hEOBCI+IscuSCmGXH2/FS/LMA7XICi8GbRc+MFH/gpdPEG+peXtisSjRekdcFnCNueXe5STw0UpA7IM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f7efef-db8f-4c16-676e-08d59db08e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:57.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 8f139197f1aa..5977b695d0fa 100644
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
2.15.1
