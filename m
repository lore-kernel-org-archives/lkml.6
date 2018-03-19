Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478123-2-9631018948866263988
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521478123; b=DBUL5qJIwYo0wVt5bZXGkCexBFQFpBx4xm/7OSM9f5V/4hT
    3WaoLdpli/p/GoPyQaxlo4Bs45yszjo1h+gS8mu0RBswkr0AoRMSHUSsXxMbGJ0L
    EZY+/u4slMtk1oxJweQpOKrL+qZ672oeBgoRc/k9Kgsr3qR52vCOxaw6Ad/e8EG/
    oCAnWHHzIvMnNG3G4AkK9AaAScZ75aTf5QY0eF6rdihad/OF1rEFxXsUVbE7EDHP
    iJgAefCEvPlRuDp+z9+UKI6UVjB7XLyYes/oYWSzRA6NPU3EiWFrlAcp8P7EIPSM
    gvAqTwmq43K1SkXGwL3UEhky8Ucuhm5zKuwHqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478123; bh=z6PmXY
    MUjm3hDu4m6ceWmJf1yO3MggF5HNcoBwfQN2k=; b=shbyKw9N0KS0C3fDs4s8ZJ
    SKAGTMzR6IhmGGo5TTRBxWlXm2+rBNL/xkCMEV1x/vkZ+3ZhE84UruturJxm37mp
    3AiZe1J+hfyYfA27fjlWmo8Gh4D5zcRl+SOump4le8Y28g7qb5FPhGstyhlh9587
    Fc4h8LAWU9C+qEk3qL9h5Xe4Z0BdirDpP+ou5F+MkKCTHlrItvO6CVVxCQOJPdtt
    IbstjhnIfosjkO+7Gmg11ie1wxkOQrICnZJ3SND07zePh+nTB6dL9YYbIKiVhGih
    R6phkSEXmGgouOML0sn4o6cThNZ9CQxfwPXVUfcgWjjHLrGe/gsZ71iS0n/OLj/g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YeYQazMc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YeYQazMc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934847AbeCSQsf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:48:35 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966777AbeCSQMC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 019/102] PowerCap: Fix an error code in
 powercap_register_zone()
Thread-Topic: [PATCH AUTOSEL for 3.18 019/102] PowerCap: Fix an error code in
 powercap_register_zone()
Thread-Index: AQHTv5z9KueEPuhlXk2S3yk879eKfQ==
Date: Mon, 19 Mar 2018 16:11:51 +0000
Message-ID: <20180319161117.17833-19-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:Ix6hWj9QI75yT8aeu6tM9zff2nEHyZbfO1Bc8HckHRqElStlqOBV9D1Zy+d4FOUnv81Pl++ZgPeLcd3OKOwXWFXp7m0zW3vx1dHiIbgIYpY8w476sho3edTBqgbB7AEMlT5mOd0V+myNgy2iQyASYFK1H4+Qwl0V5yEHtHg3sInUmVqVSwO/ntvDN1p5OiohzQ0VN+05ZDPr5A8MkJmTl+3FdH7b2NHULimotr/cEgKPOFia9sESn1gKDZvMFx9h;20:ZvdY0vyUNOa1JN5IBj1u82w6qpRMh7iXYDGGuRwehAEZN4XnY9BmnTIiLBTaV/s9oZfCVkqTqJoSltvI+i1j5augF3HIYb+y/7Xp5uv5pNW2WQOQHGxjXaSIps9oP7Glw0P7+eyfo/k5okR25AVK6uwjpg8SB4xFXPpLic03p/E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8264fa9-4efd-4635-279e-08d58db42022
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920A875FD5911EAA5956F2AFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: R5kJ/CVfWVjRRldAZ1U68DhyIw9t6aqqKE9YRLP66JBX9owq2VbhzBC3LzVNPHWQSosxg8bL3BDXFIBI96rIOv2ePzRcvYUYbBDwT0rkZ/iTYBAtfvQsiWaWy1FI1LnvuEuKDwNu1NYLjpO5zRoWeCnHjiBLCUurRF2XijPHq6tBlVMAToCruDjGRnA4ZmQAN0PEYXA54oKhcfCFkr6hvuBljQQ2iVdS09qLcY7fqa4IhO8E8XJMNP1JUXT9oKjIZKFrCsoLkZxS8PdnKSVn0vtlN5OeumetmXvzfhIG59Oe4+ukNKgdZ4I1Gtg9YW2RJVO8jY+dt7zy24PDgToY0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8264fa9-4efd-4635-279e-08d58db42022
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:51.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 216c4e9db4c9d1d2a382b42880442dc632cd47d9 ]

In the current code we accidentally return the successful result from
idr_alloc() instead of a negative error pointer.  The caller is looking
for an error pointer and so it treats the returned value as a valid
pointer.

This one might be a bit serious because if it lets people get around the
kernel's protection for remapping NULL.  I'm not sure.

Fixes: 75d2364ea0ca (PowerCap: Add class driver)
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/powercap/powercap_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sy=
s.c
index 84419af16f77..fd12ccc11e26 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -538,6 +538,7 @@ struct powercap_zone *powercap_register_zone(
=20
 	power_zone->id =3D result;
 	idr_init(&power_zone->idr);
+	result =3D -ENOMEM;
 	power_zone->name =3D kstrdup(name, GFP_KERNEL);
 	if (!power_zone->name)
 		goto err_name_alloc;
--=20
2.14.1
