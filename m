Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494137-2-741545846224508645
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
    t=1521494136; b=VXV8XCG/2NPP3DfATNvurJ8KSSM6u+CBU/+rcG6dextfvvF
    H9zyrnkjPG3qrp5a0mucbChJLXM9NXDqb4lN6gsOJs5X9yWjjq5Eb1OJAjSx2CS8
    TMwLfAl/P7BqQ4ZQcCjWzdUNVSezHNr2v70yx1W8GFOwsTX7tI2+X6HSMDW2AWkd
    v4hQmSeRMhcYvCBjvHahp3V3eeVggK0RNeshf/5o/imcwnQ8V0sY5Tqp30Ypo8da
    xlDvwbwWJOncV3gOoR1mvV/Yuzg/EaXgjFbp5006gI5YSCKr0So4aecvjs0E+ztK
    pyZbawmgkOZSUrS5BDNxqmQ0tu7DsZWm2DVGTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494136; bh=Lamm+y
    dvJeUgbUEEgcec/kxsbXEdGe6vdnX17Dxy+bI=; b=Z/UGqAoYlADB5MOhPgD0yY
    z9RLH83hgea0xXYDzkZ4ODU4UcZClN4AodbOfg7kudnmiv1rQtZsZtpTdDSZvqeQ
    4PWqYXxESh6fUX0o2MeHGARtxinGqb7uL3iOAEL1ay04/nDR2OiNLuOFuc2kHiSI
    Woxh3d8dphKrJAoUjAeTw/ekJYytjDmD1/g4W44VAnokzTxv+FaqhvoSULq2CQfO
    Zz52+fvbjySvv6ChvMOvMhd3/aiJHGeNQXfmqzKZAp70YnfnXqkksoPnKJ0WzKe7
    m3lnrObkR0Ka1dpEbXug5YFuruQ+quLg1T2ZHXv511imh/Nk4/jIJbKO2a4eaxMg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HDYaTExG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieejfeenucevlhhushhtvghrufhiiigvpeduke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HDYaTExG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieejfeenucevlhhushhtvghrufhiiigvpeduke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965330AbeCSQBV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:01:21 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:15552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965317AbeCSQBQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: linzhang <xiaolou4617@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 118/281] net: llc: add lock_sock in
 llc_ui_bind to avoid a race condition
Thread-Topic: [PATCH AUTOSEL for 4.9 118/281] net: llc: add lock_sock in
 llc_ui_bind to avoid a race condition
Thread-Index: AQHTv5td8ITeE9oKiEijsaKEKnO5Gg==
Date: Mon, 19 Mar 2018 16:00:14 +0000
Message-ID: <20180319155742.13731-118-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:CWKgsLPMIidXSum2bPj/mAqAwZXm5cwDQoFgeLneAotfqpS8tmgi6D92X+TKk/bclHW1vydFHcd+Muegvs3wt7PZar6lQFiJjGWAtVNr/oR8jCSdvlU9H01LldT9jEPEcv/Mie4uqNKIoUQtkEIxgXeRqlVK80zQ4R7m/KeW/WX3/jLMZydjUGrxKgdHg2khLrE4iQALr7rj00o2iDYIbPiDqRN5gqRmovhlEPHzcpHD4ptnPUprQO+GLbYp941p;20:brd5M3PYV03O250teiKK5oyyzxPi2TFOhzSgvg2Gc+KRWrH4B84hDe6Jy7Wht7l0PzljWKKHO6IyhLC2ePy20UNmZT30OhUpz4cUMYY3dSgD87EolrYdHWP0iFLyEnZwILUuZyhfH2IRus7rQtuSE8wT1u36O/HABIQkZmhdKVU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe70f7fd-35a7-4c43-40d6-08d58db29e50
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015F5477F89D84D3DF7275CFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(39060400002)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6SG3f9Otk+8TybxBvhpQjDUEbk7t4gKwM6cqcANFYpflHpleFGyNIriZsHhA1yko4JdsswNLfR/uN5HN87YXVy88gzWMOcuJ4AJEeN9XbsXgv+4PpU2d4l2VBF1aSF3b7w6gBhvKuNupsqDCCTk5o2FFrMNYjVu0xKaWL61P842cGtZ0uDIzuk5yI1Ud677R/paTcK+CjcDKe27jDGpfNIkjVoTUnPIte2XKSmHGcJq3d2Izm8s4XLpbzbKklB2nq6pBFS/2de0h7PuIeAIwuP5RBKYaifPSyjgyQV6JUdA3tM0JGFx3hB4IZjWLqHS/gLA8B43OhYyRw/foYbOYEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe70f7fd-35a7-4c43-40d6-08d58db29e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:14.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: linzhang <xiaolou4617@gmail.com>

[ Upstream commit 0908cf4dfef35fc6ac12329007052ebe93ff1081 ]

There is a race condition in llc_ui_bind if two or more processes/threads
try to bind a same socket.

If more processes/threads bind a same socket success that will lead to
two problems, one is this action is not what we expected, another is
will lead to kernel in unstable status or oops(in my simple test case,
cause llc2.ko can't unload).

The current code is test SOCK_ZAPPED bit to avoid a process to
bind a same socket twice but that is can't avoid more processes/threads
try to bind a same socket at the same time.

So, add lock_sock in llc_ui_bind like others, such as llc_ui_connect.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/llc/af_llc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index db916cf51ffe..f7caf0f5d9c8 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -309,6 +309,8 @@ static int llc_ui_bind(struct socket *sock, struct sock=
addr *uaddr, int addrlen)
 	int rc =3D -EINVAL;
=20
 	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
+
+	lock_sock(sk);
 	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen !=3D sizeof(*addr)))
 		goto out;
 	rc =3D -EAFNOSUPPORT;
@@ -380,6 +382,7 @@ static int llc_ui_bind(struct socket *sock, struct sock=
addr *uaddr, int addrlen)
 out_put:
 	llc_sap_put(sap);
 out:
+	release_sock(sk);
 	return rc;
 }
=20
--=20
2.14.1
