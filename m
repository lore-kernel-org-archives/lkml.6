Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477966-2-9145326572727211094
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
    t=1521477965; b=p4YtM6FP0LsforjWBAhq7ojhrQ1HRyi+ssF5yDhXwnEVQYJ
    UNawpX8nP3tL0HdaapQJ5s6RqwCDjSaqr060kMZtoV3fr71pbyv/osAYpS77MXko
    4OODjOVUDcAMA//Y/rxjX0xfMN6zGWd4D6Cl9tGeMR/wxC92dTME9FQiV/6sGajc
    ZyPoEcFutRGg5xtoMh+yXhJWZbWh3RTiBmpBpl4wcVRUnsFrcuS7kFIb4mYi6Z3R
    3zQF4twFOnLPzeoWAlpqGhasZM1oOTaK2HizlGaf1dK9e/ykuoLHP/4hojMiee0N
    kx6s0/FXRACYNige67jwVb2arHiaoPdu11or3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477965; bh=vHc5+k
    g9T9NGLVexUZQhaLrtjeRmUvXjnlDWwkylErw=; b=KWrQu1p1gK0V5HFEH2nmTG
    MCutRkosfxpnIg006By+R1Rf6zZsBGyJi7TuLgiQLhBzn+1NoqHwgM8jNLOkcYiv
    ZXW1fY4bn5SsgepZFIk11bc/kp73kmInvfD10SCuErRoUOHbhdikBWckmtlJuqEE
    BsSSDB5LUrxkzdnQNU7jKs8xyWlB46WoZLm5EwUhwRc8yh4trAQqLIYR5X1Q6XEB
    VZCZGabcyGOt5WBWZrIO81bT/u2AXu94PiPN88N+p1QH0tLHU8xYScH0I0rVqFT6
    jRVMoyXfzfm7e8HxA31iRAti0HjPsRxSJrPhc9fA+osuX/v9ABw5MB3M65PLkUPw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eu25xdLr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefudeinecuvehluhhsthgvrhfuihiivgepieei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eu25xdLr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefudeinecuvehluhhsthgvrhfuihiivgepieei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbeCSQqC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:46:02 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:59520
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935133AbeCSQMO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 026/102] btrfs: fix incorrect error return
 ret being passed to mapping_set_error
Thread-Topic: [PATCH AUTOSEL for 3.18 026/102] btrfs: fix incorrect error
 return ret being passed to mapping_set_error
Thread-Index: AQHTv50Cm0NsaybUL0qfwXZlSqisLA==
Date: Mon, 19 Mar 2018 16:12:00 +0000
Message-ID: <20180319161117.17833-26-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:ZJ9EYbHcDzJuiv9toc9nO8w1VqGN+70dTkKCBhXFZjqZ08Gt2GWUztqQ+nuN+FDRDFZjs1vkXpXH3cpT5IWMPnG9YfMT2Er4pv1ix0vLOQ47HRp4dZJMLmAxUPsFbmTWaEgCiuzC0fTtTq/4uLhL2toY93dD8YooQULWUHg64oZLSys0cbq1UTtXjX+8KfpKPkzjoSdFCZG1CyvO1c3vTuKFC21ZDxWg7iuLXBywzkCtu+REdZzcUhDFoMziPAyA;20:qnj4bNLxF7//rWnIzYywDSi5ajAKG28eV/Mu66w83944wfghmRwgvaN4cTV8YD3HfHtcrrFbY9PQUCeTemXzvRNjcKL3UIILZGt8/czOfGCJVkfPDiLgw6hPkuVKM8fPwrNDWN/8FgVLPIXtpmbWE6+7NXqQ9NC9zAQ5Khk78Nc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f7bde31-6105-4566-8a7a-08d58db4296c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920BA3822ACD42E29362046FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9zkllXugYTstXZDPE03NwFOSd77wKWs01XPFaAFGN6R2L6nSsv0sXA4A0a0isYkJFXuUSyTeEcQrOrNT5F9Jwey2/4DqD+BcEZ5xpDc+/qWM0l6YD6aNuyrlZhfI26Ao+aHCRQD4tJ4xKcwBT38ZC3JabHmlbjv8vY/dVBHXm+VpD0K7OQaJnQJ2vrP2z4ytSvYAerMcVSPaVUzpuicg1z02XKisOWHDcF2C2w+CnejJprqtIx5fMm6Py979ANjghCKT+fO9LcZhuqy2AitF7c2YUpgOQuqjpx7rIWTi0c2S3hBFMzA7iumevNICD9X9ep9oOSRnvKraILgTxnhBFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7bde31-6105-4566-8a7a-08d58db4296c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:00.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit bff5baf8aa37a97293725a16c03f49872249c07e ]

The setting of return code ret should be based on the error code
passed into function end_extent_writepage and not on ret. Thanks
to Liu Bo for spotting this mistake in the original fix I submitted.

Detected by CoverityScan, CID#1414312 ("Logically dead code")

Fixes: 5dca6eea91653e ("Btrfs: mark mapping with error flag to report error=
s to userspace")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b1131c319897..a12d733a4bfc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2438,7 +2438,7 @@ int end_extent_writepage(struct page *page, int err, =
u64 start, u64 end)
 	if (!uptodate) {
 		ClearPageUptodate(page);
 		SetPageError(page);
-		ret =3D ret < 0 ? ret : -EIO;
+		ret =3D err < 0 ? err : -EIO;
 		mapping_set_error(page->mapping, ret);
 	}
 	return 0;
--=20
2.14.1
