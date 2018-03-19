Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480079-2-4986700614513063929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480079; b=QTHQa9gqKuGDgksZUGzDjtQ8xg4LA6On2G0AHsTpu4LhjUk
    t5jjxvxuL6yVgous4OTCms/FwSCeFCoPwgLbDtaZhxG93jccB8ILU3yQZ7Pk5ZeF
    c88smgmK8zZg33HqG8XCQHOUTwTeCrez7jrmY/kCFl6exB2dMbwM8flcDwcobudJ
    yY+WVwys8VxHEco4Ngppov2K/la3YNMFoUXb8IGEGb5AR5zZQT+eaV7x5usmboC+
    l5zR6DXeuKU1AifIFQbRcsuAYibm0cd0fXmteYzWsajlnsfX22yC6znBDW0Wxp+L
    DRO6GVtOrfOr7uSGYbz1Ip4J1rbiLQTDrE6sgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480079; bh=siR6tI
    i9695wzxY7LIivTtENf5r2KwVnjeOGz+9jwbE=; b=bXQAwaYvnqS+c0D2BH/lys
    9Vpx3hlcY49/5898Rl1AuScPH45mPjAUwK+mxjbbQbjAe3Z2lYNMPcustjKCgMg6
    DdJYPVXouWhNOtQmp1zTBdz/Ktk0AfCHa5pDSBU/JzAkpTSAwlZF0aNYRw0fKuXz
    yG7q6Oy+3HJnj2xGl5FN70F1ZxkViQIvSfGKozZlUVWDgkSVbxilnLwvOUwKprU1
    xDS0As1DJtEj1tliD5u+7zX5HOwh5BPoS+h7GSKmSQ44CUpOA8nhIkrUgX893KG8
    4TkvZfjRJiBUAiAqVwuG+65MhucCvGG+P6ywvL7/mVMbtkIAfyP6qM3Vb+q1qWig
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NIbnKcri x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedugedtnecuvehluhhsthgvrhfuihiivgepuddvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NIbnKcri x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedugedtnecuvehluhhsthgvrhfuihiivgepuddvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966396AbeCSRVB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:21:01 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:46817
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966399AbeCSQJI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 071/167] pNFS/flexfiles: missing error code in
 ff_layout_alloc_lseg()
Thread-Topic: [PATCH AUTOSEL for 4.4 071/167] pNFS/flexfiles: missing error
 code in ff_layout_alloc_lseg()
Thread-Index: AQHTv5xKs3E57bCi0kiCqz1Yx2fefA==
Date: Mon, 19 Mar 2018 16:06:51 +0000
Message-ID: <20180319160513.16384-71-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:Df4S+GYSahuvIR/ggLHp9SUDUNqEUz/yWUBqPmWuPJVW/7qH53Wqhe+mQTztnFcLz/JWXREkcSmB5FSlHc/FuT+xxmgf6W/HTMrg4IHXw2KAkmrr25F+320U5QrUoZ6GFyOcRgZ9h4iSTcpdlqKV2cFc3NxFbPky5rBr5n5GU8u4WsoUGHOYrGgrFZ12izF3FrxBHt0rSHUQjoq70m17sFQx+J8YNS+4XiS5WR376fKszJgtLrZKbZt0JAbSQRxY;20:5VhVcJ2R2GC4a6gqgD8m4dupO+rW1jxI8QVNsQGwcZGrLKKtkuuO42vVCZiHLQGu5melEnghLGoe1f8kkuNdV739hVVfz46zAUKquQ30wXV2WrO8Nqq3YqSAYr7DL53Rp7N9BWanD1EfNJu6eyghA78ep5GvyJaOw0/8SBbiVc4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a2d89ca-5840-45b9-829f-08d58db3b975
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965ECA6E904BC95D76C43F9FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AoXKksaflNNiDrgJWMVHqERyQbZQjx436BQ6o9G+k3KrTmc+RFFdZvVBIX4ImQFfnkL71w3tVBIVAfKL9Yqod7nWZM+LzNqMCtE28s+7MjCDJfPzwiNseOSM2322l+WlZJuJdsgOAc8e9Ja/8U5hmCcmzt6u2QjLZggN3owO4a13CEMX4wQe2pyG/56vFmqMeiBLS4h9WxWWS6CaOkPlVCa6vPMndg4GUJeFXSWhO3bSRQ3agwapACSJc/MWwNf/gUO//26h4w9Z52vp/CTbLa7ixWtqdX0o7EfZkX+6Mbj8eF573i7eKWoxIlrzDXMCkr7fDkMBp9LtSmL97HxuSw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2d89ca-5840-45b9-829f-08d58db3b975
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:51.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 662f9a105b4322b8559d448f86110e6ec24b8738 ]

If xdr_inline_decode() fails then we end up returning ERR_PTR(0).  The
caller treats NULL returns as -ENOMEM so it doesn't really hurt runtime,
but obviously we intended to set an error code here.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout=
/flexfilelayout.c
index 54313322ee5b..c8e90152b61b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -461,6 +461,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			goto out_err_free;
=20
 		/* fh */
+		rc =3D -EIO;
 		p =3D xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
--=20
2.14.1
