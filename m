Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494577-2-14050410998399408959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494577; b=aqT1k5Hgfbs1XCSYbtnxz3DJfHNxeLi1d2/7p546b8ejUoM
    iEADPO+TsdIYc8VR6SoOGMZ9Z30eQ2SLew/rpZ345BOUunceLsEfH7TDQD/NpWVl
    D4CBkXwdmjluBKKxpB3qwjVU/tQIc5gzAx3bKC8LUXfShCCN8oeTT/2C876cCCAV
    ODkP6DyCJ2JDeekOAbm/xmagYxK9500N6kC7m3vu03bQIaVE9PFHljvD+wFb6R4N
    056B6Ddl900ArKRJLAGM2ZtLHHgvd5qfAy4oen4zvCmKHoQJsLIKhB4NDWqloe96
    1ZaZT3pfE060zM+w/c8xPcSQTZovETlS1EaUzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494577; bh=FBhISl
    7PjG9tLStaDGN/XX2dFUhNRTkUZVsK6fDHZ5E=; b=p5vv4/WzXWUzlq5faaO/Cn
    5bKOyN4/gBld294lRIMprXRbiUhggMw/sK21yeWqsIdB8Owo+TGuzW+qJ3PbJ7Pq
    sNKA/c8dMX7A3MuSktDvWLVHkZ3TnUMjFa08Mm7FvQeLN+McnUCGKTqqj1u6V+BT
    abGLdq+lhyzcfUBEwzG3pW4KgMvIAJa/ukHPaO9GXq5v/WqAArW6MSTZEthUl47P
    WIuET82GZ+AXaBrOffU75R3UE0PR4uG++RMbVq2ATENifEWuyq3SbUmVkgoiTcE7
    r+nZkHmFNRCv8GQCa1aY0qAYzKWcLL6fb6vJhiJgyQdl9FRvymzzEBQbcD/fU/RA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JfDoM97b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudehjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JfDoM97b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudehjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934894AbeCSVWl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:22:41 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:3840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964910AbeCSQAl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Holger Brunck <holger.brunck@keymile.com>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 091/281] net/wan/fsl_ucc_hdlc: fix muram
 allocation error
Thread-Topic: [PATCH AUTOSEL for 4.9 091/281] net/wan/fsl_ucc_hdlc: fix muram
 allocation error
Thread-Index: AQHTv5tJI1vd4Rte10yhajAm8E+OEA==
Date: Mon, 19 Mar 2018 15:59:39 +0000
Message-ID: <20180319155742.13731-91-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:1qhjuKLMUbVg9KT2HO8CaowL9GwwWyx4LgiHZEIGjbdtJogi8xXrC3V4/c2HqCdLkfzw/ndTXGK5B9hjKqzIxqyv3hD6vL8KNLWy8Fhu7i114HCEpark+hfskQfCDQErjUdXi/43hiOLVSBa4DbPEw+DQRUz0CjOrxyuTZ+IrjRKauv52I93pWEz6SpbZyq1kV8/TlblLBAWTjmKyE1oyh2uxttYYVFgIh5zGqOsZLBOt1m1DB2/F303OZ7ieOm8;20:iz3u5mN5VDn2ur2PLEsRuC1mvoneh8C0zLD/mKA5gvebSoWUMSek1dSWubHJEALoJq2ZDksnFgzjLtdJjWWgUPv5EK7S1oBeyrqDma8477pkuVmgOn4Xy5Q1f78dX0XOc7aYChdZm0stHNZxPv77gL25hnVIpbzWMSxIeJN0e+k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 583e89cb-de79-4b07-d720-08d58db28fa0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933FFD125083148727A6071FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(8656006)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 8nMPIDjVVQYKRJYofCykPQysz62kel7RJnbTNVOq0eyelwALkXpqQnd7ixOTJPlKS+Au1D++lUt7/cKUBX5WKEdbbdqNL6NpsYDCMTTQRxRVSI2Nyo5kLGOcJFrEnqrvC+LP5Pv2uJqdFNFqeyb1tjA1wyrovmpMkj62fcJmEsiz8Q3npc5tEKgWvxP0GyF2/B+FVjKj3+PJjysAR9CK2+0Kn4IsfTmQT6euTV7iTAoPlyr/j2Tulw/mAMAsjM0SZYXst/rDQU4qIolzU4Qochnk6b5u7cS+92N5vT8lXq2Vh5+033hQcyGcFoQZXOpWgWIKp4kkcdVrw7c8iINLdg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583e89cb-de79-4b07-d720-08d58db28fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:39.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Holger Brunck <holger.brunck@keymile.com>

[ Upstream commit 85deed56032b6c98b541895bfda9bdd74f6ed987 ]

sizeof(priv->ucc_pram) is 4 as it is the size of a pointer, but we want
to reserve space for the struct ucc_hdlc_param.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.=
c
index dcd5ff43a946..a8bd68f252e9 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -158,7 +158,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	}
=20
 	/* Alloc parameter ram for ucc hdlc */
-	priv->ucc_pram_offset =3D qe_muram_alloc(sizeof(priv->ucc_pram),
+	priv->ucc_pram_offset =3D qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
=20
 	if (priv->ucc_pram_offset < 0) {
--=20
2.14.1
