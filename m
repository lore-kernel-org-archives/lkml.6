Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238096-2-2955848964883340032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238095; b=BYJQQlsyTimHvJ1YB/rxNVsBoKq4UEzHnUjMUsK+MsTxx7ua7H
    22/IOUIGHOS3GBsuniGexm+wMA9n3yuNpZa5GzcV3geNs6Bto9D9P4KwTU+SA3nx
    0UdJscnmINjC0VBssAutZq8mzmjqF42zbuaUc6hxEKHGROThx/+Za946lC7WkIui
    BO25SWVkp4xPNjAHMjS9v8dt/bullgUb0TbX+nvEm3RWdqKLjLzXDJvmhod5L4sn
    ew7obHyU4BS0Wgx6uT38AyMd6jJvdIalVOc4cB4IhGc14uufEaopqpLA6FiWacr+
    bkCO+oor19S3oSb2+DpDzZVBXnHDT33XE6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238095; bh=eLpHe1fkY1
    ROH0t+lYMTk1UlSjvHEkrWFF+Dy1KUUBs=; b=jVNsT6JxTUBoZbKMh0YNqYyxHz
    mwc8zQTT6zwGyA8lNV2EWa7iAIgnOLZQ6id/7qec5fRs+dh7YhsFTLlbWwFi7e1t
    wHQNXJX9AkSOG/et7Qs71gkQisGKLJThwgFzPuKME+78UUw4vMQIslAzyEjjLERy
    JECjM6T3ua9k3vJimxmNMcVM76a1iG8u/AaLQawl1/VfAbYolhAXYIelsoXItdlK
    +a8CtgQZF56gof62mMapkIR0UU9p1z/nhr5ZiO+kWF9iPOXVBB71bfq7A+8iZn3t
    rU7dTbDW78qvwm69klYkoN0palliX10dMMY9zXIWt0qdb81YKzJdpx6NfKdg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M5Ds8238 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M5Ds8238 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHb4DyR6tOgoGPw8x859dWVdqem9taN1OQbqbTSG6Q1OYZUYNWzxPlcUv6sjmwQOhHViZRUPXOJyHhk8kfbffRkYlRqy3jsaKxudHm+qS8JpBOG0Zpab
    C2tk7fQGJjMclfiUIHvK/Xgm7XkLC0R8WpGXuEwtcZo8/qa3yiujq7g76E3oryBwGRVOQQeGi09s5k6QfzNPOA4QNOT4c8b6GS4ksUypayY01vtksA3N9LTl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S932854AbeDIBlO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:41:14 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755773AbeDIAe4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christian Lamparter <chunkeey@googlemail.com>,
        Chris Blake <chrisrblake93@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 007/162] net: emac: fix reset timeout with
 AR8035 phy
Thread-Topic: [PATCH AUTOSEL for 4.4 007/162] net: emac: fix reset timeout
 with AR8035 phy
Thread-Index: AQHTz5mWy/F6Qqz5skKERIJYPGwajw==
Date: Mon, 9 Apr 2018 00:27:48 +0000
Message-ID: <20180409002738.163941-7-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:QJ9YgztK5cY8+Vc5mJxOGYitIPCiVATbuSs6dXgonT5QZ/8ZMUDkobi2WQ7MQfrFcJxXI2z3EfpU79vARAn1n6igxNhP8eSRaOJFP7pyovccxKiAiz5ceiOtbA+FmpIR66iCYwBybflS02AjroOpRO9LICBpFVDiCtOa7YwcDfRjipOefbwifOxlzzYfom/7cfqcPqrHpUjPNV0xAX99MY88tD6WRQW5Z0LG31p4Q37iiJCoQA662KqZ6PW+qUf4;20:dHZZi7sbnxv04WraYwYwa4mMSDnYV5YehNiFHDsLECXdRBz1T7D8lz80bqoC6WHOep68jFAlMcoicrnnnHaZQzC5gB22f5jkQw71d+7P/A5nyj89G1meHtR10mnng7c4UTTs9LgjsWPPxZdxxqQdN1lTIBDczF5uMIlgRg4DiTM=
X-MS-Office365-Filtering-Correlation-Id: 63d8b8da-63fb-4de5-2dbf-08d59db1b663
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013E86D39EC8AF8C45BF348FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(5890100001)(347745004)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(39060400002)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(16799955002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6306002)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /cUt90I3OFZZw9ywvIDVhvW5t3f9DKcwKQUsaERYHvps8U3iGFRxXQzM/5XYIhvy/jZzuzHsjQdhLnW6nUySxKAcD8ygWx+6x9M7S6eI7pAcjwdZ39Mx4lgAptTuBiJwOjZaahg29Jjv+U3QgikOcIR3QTarZ+6fTUaE6l8jYvSuFg80GoTz4r9M9YA4nIPf8ZivNcukUS7xK7kPAiujih2uofwCb8lrlbVjCqlH/tnVJxLLAkTeL+nrVnWGVf37smdv+l+77EZRVvSXgAAS/IRXwUpl8/qzmmhg0zU7hRt4VA/P/vVBHVGLg9RHZIYHAau/EabPv7PKN3YiwcYVvWzIG8RSG65V+ousgBPdYwOGrMm3gAH3BXrKxICZgALU6dqY2/sow1gG3cUYJz8+vSHcf1eP7yF2Q4+mP8Z2AAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d8b8da-63fb-4de5-2dbf-08d59db1b663
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:48.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
2.15.1
