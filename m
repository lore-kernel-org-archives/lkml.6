Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479889-2-16273765629367058257
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
    t=1521479888; b=HaGMmU0ExjwGp7wQlYtD2WwINZyJ7rD+qVtuKUtanMmZBN9
    Jiq+UmjfKQ3JU5B9UXgW4A6nY1JWnNQzQCSFbppn680Iq7pPBDY1x7T34VdWcAyj
    b7oDKl6GDEcNxJRpuiW/bX/I1OU9Lr30TLmjzSPyo4xu3eGPYtePK7kNppNQJa1k
    j308hX1y5hjfqV3/+a5ni7LSh2EHkleRDCg4W1gY9FRNtO7gARArH05fQk3Tviq4
    8YK4XYGHQOXIEeTTVqyPUIbYKrfd7zAd3SIbZ8h9iaXg0pDCxxKMhLSyZ1dPiSnh
    GtlEs5mc3ClwnoiYwJ4CG87jW7ufBR9jiD1wGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479888; bh=MOphus
    yntTKvN9+BvoD5ByLyueoO5y74HQck2r3HtsY=; b=qlbdif3jDYHSkFC1HlCyZF
    xdZVjIyXOMuewqK0Y6Jqo0i9xwGDcZyK3tPRO/uXceQoRmXRBYGKjms8eEpoxdtL
    5AlYmIMcdXih6kfhazc6W6DNNgEFL42cE+n0mbgPRZ3pK/KRwZYRa9y1GBoBJyCP
    dSaxGYoWq1GachMbkv36pTx5EYQlXzv5gEdN2ozfvrKV3v0SATMIrVSWlKs/bYes
    TkW0ZA9n79pznEym2dgCACZ3QL+s+gHkD0IKMZ+/o+FCroAz9lHTyC8L7Om7GRwm
    yviiZg92pPionUkY2OVhmtFp/aZ3WfogqvgeciikbIXaamjG8KTkMmrFIGcp5J+A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NnBKNAwH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduleeinecuvehluhhsthgvrhfuihiivgepfeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NnBKNAwH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduleeinecuvehluhhsthgvrhfuihiivgepfeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966524AbeCSRR5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:17:57 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:60672
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966508AbeCSQJs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Firo Yang <firogm@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 097/167] hdlcdrv: Fix divide by zero in
 hdlcdrv_ioctl
Thread-Topic: [PATCH AUTOSEL for 4.4 097/167] hdlcdrv: Fix divide by zero in
 hdlcdrv_ioctl
Thread-Index: AQHTv5xeO+P7v4vBnUmL2iyVaDfuFg==
Date: Mon, 19 Mar 2018 16:07:23 +0000
Message-ID: <20180319160513.16384-97-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:mC5ARxg0OcdNKm0os64Qx3mHuc0n30HFKDnZlUI8mmCobB3yEAGVScI/BTRvyFwunogAP+ltYxDbcP3n7WoBRL62RrwNgPv3sS9CeX9GugDoOShWyEnT0sFtgWzTussSv5nMaxKmRVwHO6IG0rqzy/FPwIRxBgRn1+1ektX0Zs3m2s1IE6e5KLh6rf+E8sVDB8l3vP9oZPXd1k4BnTy7Pj/6LsuiimHlGJpa81pHQF4HnT8hFYT1fYqvvX/GAjDB;20:6Mp79fXZooM4MSerDovlNdM38dvdWVeGeIkbHEjBnIMR8+RnWcyrQSk8fDk/HbZE0Su/nc+QpNBHi0uZXNa/p0gu/+bCKjSpQOX65HcL1oLitd2iFOU6rKlWPXbYqHbVh+OuwJOOsOAUxJz+dxQBc+OGsaOVd+k6AmgBYCRLC5s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab1a60bd-aab6-4f28-aa5f-08d58db3d56c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109572B68ED30070895C604AFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(39060400002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yY6PqT7OyrvaU+j8Fuqdpg0SDEk4dDktRBPNAwh6wYWpqHCNNW2yZ5443yP2I0+IhkwyrxIzaL6VnOMF1fueBwp9XaO26zIuOk1rM9z/ess7rGHU/A90PRh88LMLuK9Wvu1mJvzfA2cQSFw04aX1MndrwBwmzoH75yalsWLr7aAh4NXqeXT/27+tbCNuPP9VlbIwQ4BNP1uFWVECQ63R6M35SW1clJYXk0J3e/EW+Hy5m47v1URmXo5Qbmw9X+THYDynOcaRKzPID4sgrFUmGO4vZtK53pQ51wS4A0ZfpG1+PTHv6L6kIAbDhAgSRibHHhrvHWDexS5CwBGnu4zakw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1a60bd-aab6-4f28-aa5f-08d58db3d56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:23.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Firo Yang <firogm@gmail.com>

[ Upstream commit fb3ce90b7d7761b6f7f28f0ff5c456ef6b5229a1 ]

syszkaller fuzzer triggered a divide by zero, when set calibration
through ioctl().

To fix it, test 'bitrate' if it is negative or 0, just return -EINVAL.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Firo Yang <firogm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hamradio/hdlcdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.=
c
index 49fe59b180a8..a75ce9051a7f 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -574,6 +574,8 @@ static int hdlcdrv_ioctl(struct net_device *dev, struct=
 ifreq *ifr, int cmd)
 	case HDLCDRVCTL_CALIBRATE:
 		if(!capable(CAP_SYS_RAWIO))
 			return -EPERM;
+		if (s->par.bitrate <=3D 0)
+			return -EINVAL;
 		if (bi.data.calibrate > INT_MAX / s->par.bitrate)
 			return -EINVAL;
 		s->hdlctx.calibrate =3D bi.data.calibrate * s->par.bitrate / 16;
--=20
2.14.1
