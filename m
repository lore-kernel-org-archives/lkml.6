Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478065-2-2815239238754813756
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
    t=1521478064; b=m23iPgt2kePQOxqqJsGrT25aMpD9OnhclAF4qc2eLE3qO+m
    IS29TRL91new5E/qAoUVuQrEPl4eZFAPG8SvHRyPnPLJXDvJHpX9ocwZswFHPa3g
    Ssqd//vhfynhc3fTNLFCZLOupqQtGVCM9lEmVbc6P6YKmScgNgjvOvAWGTryAeyU
    UtLuM4iOAjgZ2HZgrIwyfG/KeE9JN6zQlC0S3yPoGSd1A7v9XGcGj9B5zJmR/1hd
    hsuJHHkq8cW26BBeDeFPM592IIEaARC7Wo5HCU/X6ARJ3qAzUujwDaRvaef7nBwR
    rxwyv1eaHO/9bwuzQHngbfEWcJ1wEhcVs1avF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478064; bh=1IZ7ZM
    c2kdBHwINi0aIVHkwDvVU/MNnbdP1NNKYKmXU=; b=XqP7vlwbYQPVYwewuADFfp
    8NFiaMBiiFpHqzDTf6ZqpD4Q04caKMBzhqS7MAZyBjY2AWQK3pVU+s58ZahdRjhm
    qgmWfNKU/QASDVKwPJkB4P1NiMbYhGW3eUNCYkrrLjJ2ZWaA6twbwaHk9oVi1rUM
    5U2dziIFyOBzl9kjTFrew/gnihoD2j3A636gRUtDXXQrTpPzRn2Z9KxyEr2qvH8U
    BErLXmoJAfEiTm2PniGBAKNoAQZk9ST0l65h9tKYZmAFHmd7ID/AxVMSQqO7wLLm
    VxZHHVcjpU8Kbc0KT8QrQyKLoGBfHE2cet9r4xQjo5nlyUDbNW4l7Jg3xewA4fdg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HNInE5iX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejleelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HNInE5iX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejleelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966315AbeCSQrk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:47:40 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966795AbeCSQML (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 023/102] ipv6: avoid dad-failures for
 addresses with NODAD
Thread-Topic: [PATCH AUTOSEL for 3.18 023/102] ipv6: avoid dad-failures for
 addresses with NODAD
Thread-Index: AQHTv50Asxt2Itu18kCoem1U4aA+lA==
Date: Mon, 19 Mar 2018 16:11:57 +0000
Message-ID: <20180319161117.17833-23-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:QlZXQkQpGyVt1KRrWtXzV+ooa0jHyt5QQ34SdUIKgOcfwrTlI44FOFaGtCvM8O84usFmxf7eBIdbmzO75pxzJcH/I3p5BF2JHIu70BQwaGU/3+lTsJ0SJvadNc66QQLTRaEjD460yOQbuUcS4O1xfUwef7thep1Z85oTQe4UqbEmCwR7G41KWd2uyWmsCCYvYYV26aJX1o3aC2szFG+dnlsr/vlt12yEGMp3VjxBzin3V+gXHMBqzJZs1ns58eSS;20:Lklc34YLQ5X+JNY1Rug8H6ia9K18AzM+DUeY1I0ydRaFv8Ug3icHkJgAD/JPTzFD8fIN/XfN5vdsT6Y65H42ZmRj8BdGpNC1eSe4g0RfxOx/RTdxLoqIF3z6WZD6Sqdgp7zb/5e0FdJXWqFN7EgjAz0tidw3suWKb/3GEAW+dxU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d7189ad-9a87-4a9d-e288-08d58db42380
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09205EAA57BC5C1B7C24B914FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DECSNltEjsyOot2667+SXtiffSEs8YcBFHk6Epfp+Npv5UUnh9TshLWSGW2WE9L1h690tFU+njNygMzZbmxAZFKEFS6WiNHBQqJK/kx0hHI6PC3ooiy3zcCJyX+ViMhguoVlLjt33UzyByG6+tXGltKQwcGQo5pPdMMR04X4f2ZkPh0LP/DjxE2w5RkYyxu71XZafTSgt/AH8AN9Rnw/iulb/e967bU9E/x5/xq1IwOr2YayLR5zKfecWjAr5uIEZcHpDs1iwG93glaikurw3HWnyfNuT0yi9zia9bO+DEbwyK5sR0FVcMv5BbKBNWN7VbwOxGGjDn4DqvPF4Hsnxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7189ad-9a87-4a9d-e288-08d58db42380
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:57.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 66eb9f86e50547ec2a8ff7a75997066a74ef584b ]

Every address gets added with TENTATIVE flag even for the addresses with
IFA_F_NODAD flag and dad-work is scheduled for them. During this DAD proces=
s
we realize it's an address with NODAD and complete the process without
sending any probe. However the TENTATIVE flags stays on the
address for sometime enough to cause misinterpretation when we receive a NS=
.
While processing NS, if the address has TENTATIVE flag, we mark it DADFAILE=
D
and endup with an address that was originally configured as NODAD with
DADFAILED.

We can't avoid scheduling dad_work for addresses with NODAD but we can
avoid adding TENTATIVE flag to avoid this racy situation.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/addrconf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 7a5967bc0f38..acdee14c9b03 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -863,7 +863,10 @@ ipv6_add_addr(struct inet6_dev *idev, const struct in6=
_addr *addr,
 	INIT_HLIST_NODE(&ifa->addr_lst);
 	ifa->scope =3D scope;
 	ifa->prefix_len =3D pfxlen;
-	ifa->flags =3D flags | IFA_F_TENTATIVE;
+	ifa->flags =3D flags;
+	/* No need to add the TENTATIVE flag for addresses with NODAD */
+	if (!(flags & IFA_F_NODAD))
+		ifa->flags |=3D IFA_F_TENTATIVE;
 	ifa->valid_lft =3D valid_lft;
 	ifa->prefered_lft =3D prefered_lft;
 	ifa->cstamp =3D ifa->tstamp =3D jiffies;
--=20
2.14.1
