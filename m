Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244795-2-305006603908972732
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
    1523244794; b=idzB/HQdL58sxUpyL+qRfgTNGoIMpK/A19bXt2b7yFprXUvPdO
    +ylUlu8iRhiC/jCAAJ7/WxJj3/fLK/YjGpWmbOd5MAPTJJa3gJM7x+wxlrd+WbQG
    W80NKqg9P571nWkjPQ7GLDc61XFRGYXrVwYXBt+GSgduG+jtPpO92jBu/ioZ+Qy5
    jVRUtSQIo4WdhQtfnbuXfs9OtDafjbT4NOdUMLxExfMAM957SPSr6M+Gj6vXN2HZ
    PvcKw2MuuGmJPnQH14wVF9Nw8UJnmDhLPBAc7lqHtXNJU9o6wNymQAlq0DujDSvC
    /60TU+n91NWy2TnMFJr2WPplFPwKKm5KMXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244794; bh=MEaNsmUJXJ
    dGXA+MMGMlexOKQbmfAYmK3SLC4prvcKI=; b=nKZGAKHgi2tDez+IaudBwzM00u
    z+RrnH2vA5ugnn6pmIr6P4bmPJhm1FW82p79vwm/Uo+gs3qBBcJ0v3lmcAUXmCiV
    yeNjExYv7o+qJV7PzQKbbgNdnmlUWPcpgmm0W4Gc61x5UIaQjySWGDuLR+uDrxQ7
    cBLdaQeOKn5Jke+Bhilk7a7FySlwExSotYYzNEkRAXEWfU+hBl9gedx5LDEcJL5X
    BubaRNXdF1IuuyXeKXpGMGPHnftxORvCbNDFDk9w8oyGWQy4fd9fh5SmD9MzkXdO
    x1bL3zx43n0jU1VU4SB5EgkMkz3J95p71g0AtJBSgiN/0towWCV0968Rk9Sw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WHQHvVHq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WHQHvVHq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrRpkHjHgjr41IjxxI4hSw1ne3osuaNGCqa0eA8k4p258hr827VBVOUt8CPBGxdyr7TxhOyBGz0kMdm7mAOBa+uy3HFxxsEtHmNiMErK7kye/l9WOng
    SBaGegJq6bCZdQpReqBiJd+3rwThw+TRRkMaIxbMMcWfXTGuWO8uPhRSgdTXeFZzEA7RVTfdzQ9E07o1w48tJrBT8juE6NMkvOWeekzNuCpc39WtUvJGxGXc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3-RhneuVAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=0-KiEwIEol9P2Yym3BwA:9 a=wPNLvfGTeEIA:10 a=VLVLkjT_5ZicWzSuYqSo:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeDIDdL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:33:11 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:21664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754377AbeDIAVT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 177/189] net: stmmac: discard disabled flags
 in interrupt status register
Thread-Topic: [PATCH AUTOSEL for 4.15 177/189] net: stmmac: discard disabled
 flags in interrupt status register
Thread-Index: AQHTz5hgYIt0pRETqkyMk7UjG2VWmw==
Date: Mon, 9 Apr 2018 00:19:08 +0000
Message-ID: <20180409001637.162453-177-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:qnsEOJSh/AeSIedMqW5iYMZWwWuDQWw6Pd6VoAMKCSB+EmeelOFdimzfc/84h7ZgEUCO7SY2xiYiO/6agZm4+hIJP9qQwPcpBhGDo2FKmW6XTXDSNjEkQJxKyLNZ+c1OqX2XZBhclw1NSuCqI2ICKJsjJZDrPD9GQ4fkVTV5xTqoanoFdalGrl/FZqhiTIMpb9TX5FZHpg8VgT2WQm+NOW8qro+HXb2rPtZsdpNGxAcaCWwDIcoXI/YD1Kzs7DNs;20:0lP3Cpcn7LbT64gaRxBxPgr+icYOcWp5Z4X/PBwIWQzwxIg9zuwBajJndlWpXiD0nt2twGxEMXV2GQN8azKH/is2+6xap7WbLUqvKmYIISlwV2fEOXeODdMzpT7VbaoYTIYJ8FxemJojR0KlYzgv7+d1+DShc4jooSracROxACs=
X-MS-Office365-Filtering-Correlation-Id: ac69e1c5-1932-401a-5e8d-08d59dafce11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112588E6CFFBF239B55CAC09FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KE2RoVHQRu7M8xOD9C6LAUKKnmYhwkQjhdX95855iivcnyHXcs1uGkcDPPCTPFaw6EDMUMh43PPgY/lzU8YFgBvN/EtHdGHUgWAp4KG/sSksTJT4jiFKB9F1jMAQL27Rk4+6/hfbSHIBlHqTleWu1kPymzy0kMg/8iW8cbP52hHoDSbGGzs9p8BDCigT25kAOGjjF0bOWAeZO5/xCj2KDrnGElpfIB79abvnOBu98QoGSgqOmOKecAYv5275Dr8ikhEUOej5GirUDXjDMqNRLwllt7VnE3rHqX8igAOYMNj4UFriPmXZMIePv61jml0LRc+1cKoKXuI3SkUJwpigA/tPVGArTQVBGw1J4edNWqjTJdD+Mb9HlM7LBuPXxsXDbDHrAdTEGQtyFl+ru1cxKxaSHLRZb/jEFVZdIY8lMIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac69e1c5-1932-401a-5e8d-08d59dafce11
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:08.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit 1b84ca187510f60f00f4e15255043ce19bb30410 ]

The interrupt status register in both dwmac1000 and dwmac4 ignores
interrupt enable (for dwmac4) / interrupt mask (for dwmac1000).
Therefore, if we want to check only the bits that can actually trigger
an irq, we have to filter the interrupt status register manually.

Commit 0a764db10337 ("stmmac: Discard masked flags in interrupt status
register") fixed this for dwmac1000. Fix the same issue for dwmac4.

Just like commit 0a764db10337 ("stmmac: Discard masked flags in
interrupt status register"), this makes sure that we do not get
spurious link up/link down prints.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac4_core.c
index f3ed8f7853eb..05b3e7dd9821 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -562,10 +562,12 @@ static int dwmac4_irq_status(struct mac_device_info *=
hw,
 			     struct stmmac_extra_stats *x)
 {
 	void __iomem *ioaddr =3D hw->pcsr;
-	u32 intr_status;
+	u32 intr_status =3D readl(ioaddr + GMAC_INT_STATUS);
+	u32 intr_enable =3D readl(ioaddr + GMAC_INT_EN);
 	int ret =3D 0;
=20
-	intr_status =3D readl(ioaddr + GMAC_INT_STATUS);
+	/* Discard disabled bits */
+	intr_status &=3D intr_enable;
=20
 	/* Not used events (e.g. MMC interrupts) are not handled. */
 	if ((intr_status & mmc_tx_irq))
--=20
2.15.1
