Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495593-2-8537389546233728962
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
    t=1521495592; b=bllswJfTq3VdaKP5fZxfegKReSC0mL4oKtWwQhOdHeaZ81B
    940TImoWz1drbygPa4uTX+qF8rNVD7Vh90wStboR4KjpI3QA+TTQxOIC0g2sP8tq
    GeQxN7HfVuDSJT3coNWUuNjYQ42QX1R2qaZ/Alm20IdG27Vo6EsEAPW+tdDar86m
    WHXzyE9Bk6gxM2ZxOkpnfglOoxv1Oc6YFK3i0kTAoF4uu8N5NTgO1/Ij9t4CHTct
    GpmcNrH4S4THF7oqHrcqu14IwJrA5tKRCPS2lJ2UQr3iLgu28EaA+pS5ZdHhhSbL
    ttSCLQ165lIc9b9UiPJnw1Sy0+4aCKmI9HYsz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495592; bh=tP0jqv
    1XflB09Fc/zAQxpNxkvIKxjViy53HQHXxh7PM=; b=iNmed57eguStflypRjM0ri
    QvTb/ptFBkw/XK5ReylSMBcVIcVFH9Fg5hvqoecIJS5/mqfg/dE76wB5uX0xz+8R
    12xTGUFhktAAlgVP4Jy25vwiGBIZT1kONqYncdmGpLRvBzXI3ui65lcApRYtl8Pk
    ZyXrSOKJpGIDu3sDS5xxaf+PxNwHNd2LdBQpO69/E0p+exJ0VaSva2jaFW1ApT0Q
    7w6Lh8wJi1vCG+G63BjLexuPquWipFCuFF7QQLr6/4Vrbvc28htpic9JRgDEWeRP
    YuqDBHu9IOJ1mkrAtNLSMyzRx0KNjU/MZHQJh51/C957EM18WtZXVQa5ix9/YHGg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zll/c4nl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduieefnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zll/c4nl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduieefnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965117AbeCSVjW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:39:22 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965062AbeCSP7O (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Reza Arbab <arbab@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 039/281] mm, vmstat: Remove spurious WARN()
 during zoneinfo print
Thread-Topic: [PATCH AUTOSEL for 4.9 039/281] mm, vmstat: Remove spurious
 WARN() during zoneinfo print
Thread-Index: AQHTv5skXdzuv7AF90SqGyQ+qdiOEg==
Date: Mon, 19 Mar 2018 15:58:37 +0000
Message-ID: <20180319155742.13731-39-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:+x+ByIZOpITbvDcPxlBIEAxro9YY/hzvMrZ2wwD8s2UPgEme7lB6JqOobFMYzVt5Z3dsy3HASWTrBqRpn4+cqYBQOfpvSd3A924vKWvka9nJ0m7uEYNflIm40Ao1u10fxBZQncHvVL1w9JdQWo3c7FbFlb5masag4NkGH1HdThGg9pvLOawfAibtV+vHBJoNzvG4YplPFKDUcQA5TNziaddeKXxIGfA/fAdp2i/7P661w7NTU2E04pG8+jiuyQlW;20:TRj7YmpbP4K3rooSnM7ldcCG55fXQJf2u4L+oEqTne/9HPBjMDZKqt34Dp2F7nJHeSszAjKqsntwhWEwyZntkN2lz7Ds8DNNo8VNlg1PxtvdM0HFkv7ut5PB9o5Pm+/56XVPGKrs/SPf9E1IYq7u/lNBHJJNTtIv1bXqHaCcwQk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a46dbe61-a617-4231-9bff-08d58db255b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07266314525AAA22D00E83A1FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(966005)(478600001)(7416002)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(6306002)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7JIyz7yAt5tS2TqXilWOEvE8DyuaCfhNZS487WuugbYw61Fn9Wx1jq7hav7ZzorYjbUMS6GUKCuuxbzeUKp/ZdXK0sLpSM30aouqqGQPbS4tPNVxNFs40QPOVBijtnhic2nLDGpcDZUb1OBzeqne68sTZZkNlGtoObN+6QypszFNdmdL0w8j/bUB8qftyG6TNqc7+KN9PuIGfe1XxBqn9fPeL9FeXKVxl6ui5RPzjDaO88hIoFbbwtAZ8DVqBpn/1DdjAv2B3wdxRysqvI+krHhTDwqCgXJ4T9Zp0eu955Yk1Oueo3TlCDQcas+g3bKsu8ODOLOIfoN4sHTQ3z3nPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46dbe61-a617-4231-9bff-08d58db255b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:37.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Reza Arbab <arbab@linux.vnet.ibm.com>

[ Upstream commit 8d35bb310698c69d73073b26fc581f2e3f7f621d ]

After commit e2ecc8a79ed4 ("mm, vmstat: print non-populated zones in
zoneinfo"), /proc/zoneinfo will show unpopulated zones.

A memoryless node, having no populated zones at all, was previously
ignored, but will now trigger the WARN() in is_zone_first_populated().

Remove this warning, as its only purpose was to warn of a situation that
has since been enabled.

Aside: The "per-node stats" are still printed under the first populated
zone, but that's not necessarily the first stanza any more.  I'm not
sure which criteria is more important with regard to not breaking
parsers, but it looks a little weird to the eye.

Fixes:  e2ecc8a79ed4 ("mm, vmstat: print node-based stats in zoneinfo file"=
)
Link: http://lkml.kernel.org/r/1493854905-10918-1-git-send-email-arbab@linu=
x.vnet.ibm.com
Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/vmstat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3863b5d6d598..6ad26e3a3820 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1351,8 +1351,6 @@ static bool is_zone_first_populated(pg_data_t *pgdat,=
 struct zone *zone)
 			return zone =3D=3D compare;
 	}
=20
-	/* The zone must be somewhere! */
-	WARN_ON_ONCE(1);
 	return false;
 }
=20
--=20
2.14.1
