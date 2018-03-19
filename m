Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494988-2-448045535606119924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494987; b=VI1LmZhYUNf5DEWPMlqIZUvbJT7Sii5qhF6nzv6T2KbXqG6
    Rj4sb/V584+T5eIYUkLfv5RG3PnGWqyDFDlNkY34PAGTZFcbd18HAqrqs6H1EUws
    gmSHI3CJ2BMjQ1zxhgJYqY9r1x5i1cgIWUr248L1KdgNLKmE+AjVfk1sIAL0ScGW
    V4/3q+s6FeeZmMUf9NX6tGixsUHPvWlBHyFY+HbeEEJa9TA0uJO5ndslrHNYz1rZ
    Rzk5hijnVD+YWj3Pb3issfAshshiCzbVkNbypc7iIlQp/64xWfbhpZZ3n3f1U5Cc
    z0j5GbsXDqi4fSgWOGc6grZPK30Nh6pBgGy5D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494987; bh=nRF76v
    2xAncFvUqPz0dNMr7cA4dpKQhkpwo2kT5mpm0=; b=Qtm4ca8pZlmAYqNSj1Wc/r
    4CcDVkSXL1Mm6VbsAhlB+T4i6oTV7qVqVAfw3l9/VYkgi4Ehy8CORt9M2kGoUnH4
    9jzg8RyyNoR8yEZBX9joPp9WPl62/Zik5Rl/YemQaLfWIltDE7eg91gu89Zjlrxd
    qAGV+ZP8ZDotrjNNaDeBsnPou86skJksNwU8EY8nCOf4eUC7RjjG0IBoqw7/yLSN
    UwWwVleADv9i0DSd/M26POPJlsJJe2yVnCD1JaEF8wAknxLszqcaE2rA8NVwcbbI
    nZXSggPX0n0CdPXuhqd3bNah0sTHag29hrQ+abH1xj/ISvWJdGbwJRTOBWoNjHNQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ceorCE68 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeegudenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ceorCE68 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeegudenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970474AbeCSV3o (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:29:44 -0400
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965234AbeCSQAJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Holger Brunck <holger.brunck@keymile.com>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 073/281] net/wan/fsl_ucc_hdlc: fix unitialized
 variable warnings
Thread-Topic: [PATCH AUTOSEL for 4.9 073/281] net/wan/fsl_ucc_hdlc: fix
 unitialized variable warnings
Thread-Index: AQHTv5s6Xg9OH4QJB0SxE8vVmDI7vA==
Date: Mon, 19 Mar 2018 15:59:15 +0000
Message-ID: <20180319155742.13731-73-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:govA0z6+WLjJitEi/XvIVaW1Aclm7GCAuP2on7j4MGlEbNxJmXNjYLxjvtwfMZ1loFWuS8MJIBxf+Lc+nNDE9o7j/Xkzt6q0suVVIJ1rws3SS6TQbxe0V67Y6SzcHjZKDqVjCC4soRqM4JItxx5wcMxeqp0GWYgMGCIPna94whwOyFYrzgIG/40QWJNUA87SLlQW8OIIvnMVYy1KjahlHpS8XMM3zBJ4eiTe4oc5LXroz041w1ikjiGrpk08kQ6u;20:CF2MR7M1fYgpZWnkrq9wJECwxo/jOe9WAvbN8lXofGp5TasOXkVkr7NlI1VdIsEjR2kTHj93NCU3EkG5Gd34uydyqHRvECIuce481HHS/ZbfZfFGs0RLTVNUzpKwD/pFsv2vGfnW4dH9QReOZk9+O7oFjzPzQWSmQDu1JUylVN4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6672deea-e611-4d58-d8b3-08d58db2787d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08693E8B03F950F1D72A20D7FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(8656006)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gR+lSYggIsPt0OPncQa9HVtVEbpqJrDS0XcQ7CmmTl1WRTdSWYO0Zv4GxlnnJN/iuVmxo1qq8+/sRzWR8REnkt5oHQjddlqwgMHX5TejNLdxzQDM/9WWj/SODGIvUYq91imQe1B4muI2cdLT7KCpvep2/cCqcvNSbVCS6Nk/TleLPZh/gE3sa+jTKx5rcEvRQLzH0Jt3mc0XxNBjILQZcyGHSCb/cAFCHSmF+mBmWIeGHDP8D5yDv94+ZTbdGu5gm6+yepZVoEzL9M6UxLJT1OxQO8Czv9gGEs3nsNQ2UD16OHNePQly23RowtDg66s26kOwiQWxR1l9F0HqKq2aRA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672deea-e611-4d58-d8b3-08d58db2787d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:15.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Holger Brunck <holger.brunck@keymile.com>

[ Upstream commit 66bb144bd9096dd5268ef736ba769b8b6f4ef100 ]

This fixes the following compiler warnings:
drivers/net/wan/fsl_ucc_hdlc.c: In function 'ucc_hdlc_poll':
warning: 'skb' may be used uninitialized in this function
[-Wmaybe-uninitialized]
  skb->mac_header =3D skb->data - skb->head;

and

drivers/net/wan/fsl_ucc_hdlc.c: In function 'ucc_hdlc_probe':
drivers/net/wan/fsl_ucc_hdlc.c:1127:3: warning: 'utdm' may be used
uninitialized in this function [-Wmaybe-uninitialized]
   kfree(utdm);

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.=
c
index 65647533b401..4c49410c3a1b 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -454,7 +454,7 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 {
 	struct net_device *dev =3D priv->ndev;
-	struct sk_buff *skb;
+	struct sk_buff *skb =3D NULL;
 	hdlc_device *hdlc =3D dev_to_hdlc(dev);
 	struct qe_bd *bd;
 	u32 bd_status;
@@ -1002,7 +1002,7 @@ static int ucc_hdlc_probe(struct platform_device *pde=
v)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct ucc_hdlc_private *uhdlc_priv =3D NULL;
 	struct ucc_tdm_info *ut_info;
-	struct ucc_tdm *utdm;
+	struct ucc_tdm *utdm =3D NULL;
 	struct resource res;
 	struct net_device *dev;
 	hdlc_device *hdlc;
--=20
2.14.1
