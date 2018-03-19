Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495328-2-6691429526321244814
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
    t=1521495327; b=omRiAVuRaItBcNNhZUHvJRdTsv8b5TDW7lCuIf+HtA5FoBq
    H+EnU8ek+FW5uNdIRfYm632AwGjMA60FJQGxiimGW3wjL9EYCqRJLAAwbcar/Eee
    Z6jlKBDP8NvF4T7uK3l4Wlu9cd64hZr3CCnsEHGQd7U0Gb03wzoWC424fk7Lsh5b
    V/NQ2hBTrzuW3gFQeaMrcS8x+qz1s9nGdOBATe52sGVA2XwY1/1yo7OxWhKwxgCQ
    xT3GFdwNKFSlaAqTk0srT8abbgoDjjMRkmT4BuYeA8O534Zili+fDqrOxjoac1BH
    P1coFFY2z4gYkNzb+SYAJJqdndheNxPCzx899sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495327; bh=bYfX3l
    AWHM4UIPCZzOhtl2z034kB9QVpDCoo+wGg/Tg=; b=VGrjRViCfN2nZXR8zUmc08
    UIXwvQFXwojvcCQ45ARWVsQprt+GYVucIvqS4a/NNaM4CIZ341jmiLh91IOVYy5q
    GJcbEn5i9XgldbJ6KQaeylm8h/NxLfzXKR2FyNPVWw5tTa7jnY+9DuZCbrdSnvZL
    XnvYW/j1pcs8rlsbBT7Fw2ehegnv7msLAIMuuMckDgWTp6t/zMHVs9EXXbIWF54B
    gUYAYVtFjyhRO8aZNl4ftTW0GSR52nOan3aeupgMIb3xShjZl31ZSvtC2tM0Y2pI
    Kvpr85hBdSp5vWoU1mvd+9+0t366q3Ff3zRap5CB2GraqFct+/p4cxmbSjt4sTiw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IjcklUu/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IjcklUu/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965043AbeCSVe1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:34:27 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:39744
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965125AbeCSP7h (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 059/281] btrfs: fix incorrect error return ret
 being passed to mapping_set_error
Thread-Topic: [PATCH AUTOSEL for 4.9 059/281] btrfs: fix incorrect error
 return ret being passed to mapping_set_error
Thread-Index: AQHTv5sxh/xTIjeaCUOuUhY+B+wfRg==
Date: Mon, 19 Mar 2018 15:58:59 +0000
Message-ID: <20180319155742.13731-59-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:Fuo5EMlTs/4lCndeCY5zY31xuFbaWww7KXX7SOaP+E96MYJZ/7FGRulKgkhf1CKKf9njO3mSzZ7NO8/9atFDjrQ1Y1op2mXQ/1EXnrJ/OXe3XRfppWCNK7CUycte50ItlK+AC/Z4c21HX288B5aH6+UVBPtOg8bH80Ink4ebljw4qnVxydyZI5VZPoj2uwVTUeMp4r+R+PnDuP9vdXrSk70X+RDKloLmTghw8r11aYLgM7mKmrEtQLcXqxDNijQp;20:8em+GnjyoNPTXkf0/xlfRjW87l44HxHq33jOu03sKktNP9JXTc7IVn5HoKy5mnx9YiV/6FvuQgZUb9MJgFt+tiRsBJBRnttmJS+gdn7H7aMhBCPXXQBGOYfHe+XyoBLVKF/+xaZDBQJcUuyjVOR0jC4gvSihuAoENJyd3da29qY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1479c9d9-6a5a-4ce8-45c5-08d58db261f6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11096B9CF68AF791CF308065FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Ag7ohlatyTvbmLs06zqeqNOzY3wyidLD+KwMenf4p1G91iAWMH8nEZSC+3076guhFk4MiCnuN/oPucQzEaxG0cu32UfFa1bjju2p0geCrhlRgirJ3P8W1IrqS0nVd4fZvOnoxinxM7lt7vmUChpUdPLGkssLR2HL0om8U3v9Ag5z/wLjwo7M3hwHtJ2ds8MZR0hwN6M68EYPCUnm1jAA2X4pErK+h76X4JknfU1+kseHx5Jh0a/3he8I7/eJDXis+lm+e0WnIyShVKk7wuNyWJoJyLojkDeh9ovBGV6I/APGUu605M6zd8tNpytzRKVCV0wAtpu7mCU6Qpg46vx8QA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1479c9d9-6a5a-4ce8-45c5-08d58db261f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:59.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index 8ed05d95584a..03ac3ab4b3b4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2453,7 +2453,7 @@ void end_extent_writepage(struct page *page, int err,=
 u64 start, u64 end)
 	if (!uptodate) {
 		ClearPageUptodate(page);
 		SetPageError(page);
-		ret =3D ret < 0 ? ret : -EIO;
+		ret =3D err < 0 ? err : -EIO;
 		mapping_set_error(page->mapping, ret);
 	}
 }
--=20
2.14.1
