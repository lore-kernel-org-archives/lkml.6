Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242453-2-1880283041512750798
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
    1523242452; b=O6BTMwX1wiAaLCUU+NZI3syDBMx0LZK75fqtaM+BI0v/lisqTU
    HJlh9AVJ9Q+Id1w2LgSzO+Lvg+2nQUg9wTD7zIpF07ll6tUURSRbs0KM73C11QoS
    VfhQ0xR1IY+1jmVfvRU8wjXmf0EGCItob65jc1fQkjCKfbgEZa8Kn6bpSZ71DbYT
    0zMBxXbFFhzS2F8svA31wyhaBXwW8IYYFQrbbX1W4QFp1fElryR6nns3C2zUaQbl
    DA4WlNWo1SvnXDwtjf5P45dZGaLeish6pgq3Fp35p265/E1I7oZaU5s4Aow9PHyx
    I3NP4d7vacxJElC61WgT6nFTLk05sAAzMYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242452; bh=XoePjPDhqz
    HtyjtMtacTGY9I637ZJqp5istBB2Ev0hE=; b=bGci1HFlVJXc6LjemcDbDX6pMq
    2+bC+uVH+G/XisbpaF6eiKmR7qdMm0VE9hlLT0PZd2Q8KNx7Gv5P4QmKvoUTWGSX
    Pl0Iow/4lKJRX9bIVMV13EDMTOs+lKaMEvH+IG8SekqWZt2Qu4NN5fHhNkJQ1twy
    zVyTaZ3Cs9rslhdSNCccb+1oE0N1qiGnk9uKr2jHRBHKt34RDWaiqycQ8nA9NBTX
    w2BkTMhj0ioS4h1RfZ+TlQu/1yC7au+kbkuTBOtaW3syZGRqQ/C8lBa5v1iaMO5b
    ZtlkSYlXB0OHMCi6JE/j5zC94tg27A1sXPwd+shTgM2flppTiOCddOiVejQw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LAa426wL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LAa426wL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEMsDTBhkg27yxkIaf4kOULxSs0hwtuiSOS4UplEFU4mVTWbTPzqbPHeps3b31yhLZYpSzgxTEQvr0DRUuuzdJwCn76U8mDkRiRvp366By7+z4zibtav
    lmGOrD6PCU0RX33+4v63Wjs7t1yCMB2YYsVemY9PdHV3cvAhFQjv41RntBTjVYkLcpjpK6NYW4jgMxHcNGfDME5vevJQeeKdOZZ/eDCUd4q7UGETnJku4SeQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3-RhneuVAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=0-KiEwIEol9P2Yym3BwA:9 a=wPNLvfGTeEIA:10 a=VLVLkjT_5ZicWzSuYqSo:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeDICyJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:54:09 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:42256
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754499AbeDIA0Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 149/161] net: stmmac: discard disabled flags
 in interrupt status register
Thread-Topic: [PATCH AUTOSEL for 4.14 149/161] net: stmmac: discard disabled
 flags in interrupt status register
Thread-Index: AQHTz5jDrkuGghikdkCQwvrqhgXvXQ==
Date: Mon, 9 Apr 2018 00:21:55 +0000
Message-ID: <20180409001936.162706-149-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:lyxTIwazGqkn4x2YxjKh91WaiH2Cn3dRpEYr6eeibSw6elFE7o7IC3E/rMcOUAzoX7AYqKoBMuxNZIWmI2oFwE28Kq/efUZUJQ/mrcFiwk/BPXsavKhyF/X2Swnaxc4hWKKvOltG5j0XuBFh8uAdfICHBk6NDopcpnSnSPC4azNXmUdW4iQBKGGB5eDhWDqItVv09R3cnu1Ocncfv+RGk3JG9VDd/7+Q3xtFfVufYLNX8Esil6mGPwXfzkoZa7FY;20:fDPMAedF8+oyhitMIzGbsMHM3bDeWgZAFMDodsZ3Fke2F01pcEFz77HdS2VzOWDe9MAyRr5HzYji0pxiqQffLbtuOR1UjUW7/w50Nn1HGBjL9ms/FobtzP5Ru02Mo/iowJs0H7ZpvtAf4Bk0Blo91xXRLh9dPFnJSc3TMHDkBMM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b102e3bb-5764-4c0b-8da8-08d59db083c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07251FD0E1B92142B92E3680FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Gph49BkIM+e3D8eWteVDI1zIVFf6iOvWiQmWmK4LaM5bImVnFw7zeoo9PrLueEd6Z3weASMrIpXedMHu+5jT+cOzAg6OH6n+OXef0cgfYUhKr6AxVq5syQcZMDPyLHuHTloAPgc4OyMnP0ZgRohrUhxvoux1/spMuz84mgCgQw9DdX06G7WL+w5LfXuNT62ZEY/eoHIdZFXWk6+btOK27WZdU87aQxQBkvPdSnkD/5P0mPk5AKVMhXrTsUXWVqhWcaXlXCe4FTieO0t1YN1wRUHtYoaZ/SQYi1YRcd0aalNJK0YW+dSl/OlOG88c9ZXWVeXSFZ+Uzwf7cPpGn0SUjM4sQoChGNZr4fr1+KStt7votQx+Kz+OtC9HK1QFdvCvBomWMi44kK6irIMchGH34Gz2OyaC8FPXxhR1Qs0xZTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b102e3bb-5764-4c0b-8da8-08d59db083c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:55.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 2f7d7ec59962..e1d03489ae63 100644
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
