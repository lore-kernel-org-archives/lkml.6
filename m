Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480504-2-9048797546902578267
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
    t=1521480502; b=vr0PlLsLt5xsawUPglsXg8sxKxgW0kpHY1aAHbYI2EiSp6+
    t1ksCm9AVACI3XFrdbI0vZ775Urb6hHtXnktMBDknT6N74bxaH7sQv9uWP692/sj
    VuRuEGjXPCecFko2mv4nyWTC4+PuMIWQTkwkPSMLQmWimjjBBRmVI2ATpyzl4lD9
    XFpOStW8DU7apNLXU3kyS899Cj6TcDDaX8vriIv1fzJuQP4ck9xBMD/8UiliRS5/
    HBXbRVTK2dYTrDXKmNpsu6E+8yHwTtMCoDwgPqhh0qyorC+hCb0Q+WBfEmwEOhIo
    7kVmqVaK7FujtXqgcRQw16v15REi9VNSXFBkCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480502; bh=4pqXNz
    RPsUyeO25g4Q7VpRF4vHtKixFKK60lYFnAmBs=; b=cLd7ug9Dr2RwlKjXhPUVM4
    6PpJahLW2ZY+4xIElujpeJ/ITJuq9k6BrOjg4f28K8mNAIiDtqOWchuEwnbDCB0j
    O1n2TW2fbvFBLKHvMI213VkqYRvHtdxEqLRP8bKJ9zQLPfSy+s8kxYHUE7enH3yN
    ebLdUuUqvv/eiI4Rx5YXyCgHjEZGT3lYzWY7xw3oEWNOEyBBJ360kruZV4NOAjNW
    SdGDRWVzggE9ERgGEAUFgSgwwz6tx8I4YKtsVAbrSaVcfPWN5r0BiJZYD6Enj2b2
    nKxS+mRHHgc/WSA6x85h1521rl9XoGtLhg0vLkk6JQHNkQjRak0513mlcQwO9ftw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXRrEivt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedugeenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXRrEivt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedugeenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965803AbeCSR2T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:28:19 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:27616
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966190AbeCSQHk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 040/167] btrfs: fix incorrect error return ret
 being passed to mapping_set_error
Thread-Topic: [PATCH AUTOSEL for 4.4 040/167] btrfs: fix incorrect error
 return ret being passed to mapping_set_error
Thread-Index: AQHTv5wy0GW4My4ciESWTSizaiRF+g==
Date: Mon, 19 Mar 2018 16:06:11 +0000
Message-ID: <20180319160513.16384-40-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:hkhR5iDPvZxQ5N4ux4Rm/h3pcXMgXv0VN1IO7iY2rIrBKO7MS6rHqobIOsVmZZN7bMguZkvF8NWTWy5PWyRJCEtqnkLNQMV3hsa7OZCS799V3n3b8wxHV8KoA2aDj8vgaR30hp9ctSMnujIaGC9VHR7JM7dRjF+oKthuQUh91PJl9jxMi2fB+9T598eXEsOub4bzTdNowRdezfUXgmiVPlZ0FWliyBJD//DiRqbTiBXxjcDQqD9wNyBcVJn1x09k;20:Gybg8SfddQvnOKB+3alvLbm4dzT46i4Z5cKPKB3FqjjCnrO7Qq5jazRxOemTByWBXsjBduZdcfwkZHhA4twV+G7CvDNMoW4aQwnIeemCUHDb5qid83euJAifnEJ9x5WJXFrf7+zBzRw5Olin0NqezTW+r8fhgIGuR+dX72b2IOc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd878cc4-8e1e-45e1-c672-08d58db3897c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080516CB2445994BDEC564E8FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vcvOfrOxsb2CNSSHT+Kq0oI+j6CWl0fNaom+mhGrxdNWzgFUeJ2SrEA0C7p92DdgB8j7eEOCNQ/PuQykuUbnLQC1szMcHcbAsBkg51f1MiVPtUDHBwZ2Vrlpl65dU4Gegdl/hTHtkclyNX2WpPAkwS8/mZLXfsmG7nloV+htshlQv2HqNxTrEyr6tsiIyLbYJD/mMugGpZp0sn2ijEnaQdF3sbliV0F8lzljW3la33DLD3frt+ZvRCHAxJN+sBmzDyJSPUcHNu0kC9PJCl7FGhZfk/3w08UpTvqoONBr2ncmw9XCDonYY3XZs+wxErZ7vAL21XFZqKmHp2nO5xYNQg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd878cc4-8e1e-45e1-c672-08d58db3897c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:11.3191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index e767f347f2b1..88bee6703cc0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2534,7 +2534,7 @@ int end_extent_writepage(struct page *page, int err, =
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
