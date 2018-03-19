Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480186-2-2401965138345501478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480186; b=K0pumwlLHthlBRboxM8QTJPPstBNCe0WiUcyY2+G3siKYT8
    nR/Iq2FsayaF3FgKcy63NXq7TYesC67LRfEOhA01RWD+YRe8Xs8px0yEZ+NjU0HT
    M89nwrqsjchCeMObTtl1KynezDlNqE6rX1rMGdgdhFTRCS2jrxbKQoFRI0A3hs3S
    E8yzjNwxGGithUCTJ7KHCVJEEmdTAOi1tWu0dAxmQiofi8p+jyakd/cx0IExUr8T
    lNoidg8sUC1nebGdtEJZzY41hE4GaZ9srIj5FaOIb7s5HoNJkKR0HqsU97uvjJLk
    XpxMwh9ffEnAfrxp/dAVOo4pycuxt+PJi7cu7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480186; bh=IB6znR
    B7YgDK+L51FpbpRNOIdv7cJ+ftVNesD+4+lg8=; b=NZOKdTRu03dz9aVpnpi6kr
    p3ubQB7sygCcgvg38TZg07DaBiA6xzy/4+oYBSEKwue/BmAsdPhFM4jW6SUGe3f5
    XX+eyz11fnl1559+ld2qyadKcQLPUC9rEJwbF2oAQteNlnqZ/PgclyY/O7pyplTx
    rZKWDSkci4s81fJtjOvRWE0V+OTMuINqBYXtDM+XuFtfxPvsCFYskfFW9C8CSUQZ
    mThrwIKZLkBuAAIhIo8Uflzit3SFy81aQMCCf9+0OZog/RwFQ3L6tC1pMTVxo7vr
    frhdUCvqvC2TeG9+CycRO0p4OxNt5HErBl8EgNmu6mc0dWY/mpdwqR4q+sMNGsFg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oVziICUS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudefjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oVziICUS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudefjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966393AbeCSRVo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:21:44 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:59524
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966389AbeCSQJH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 069/167] libceph: NULL deref on crush_decode()
 error path
Thread-Topic: [PATCH AUTOSEL for 4.4 069/167] libceph: NULL deref on
 crush_decode() error path
Thread-Index: AQHTv5xIZXBF46RvYkeSNdL9KmSDIQ==
Date: Mon, 19 Mar 2018 16:06:48 +0000
Message-ID: <20180319160513.16384-69-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:9AyNhxVL0ike2oyRLNSCRKvNv1thVhzHXoQRu1oKUTJhexTpu/LWkBjoyngJ0wwtV0ZN4REny28Lm+BYWAENYzQ/sdQEvFg5DzFYsFAYMaSweovNAm6MWA0N8XozB/pSVIzSRvxGCvbfJQlMBahwttEsie1ocdQFh0momKzX4PpmBGOB9AVUgDWQEh+7QPTZouAcINjhyN5oqHS7p/4Cjb/M83/u+RRj5crNzalr0mqfcQoaXco8jSHN28FyOthk;20:qDIbpOyApO7yXJqnvQKKeosrzwMgXbbxpSDH+8YEnw4irSWNZVlVqR2RBJyXHGH2EjF8QVViwlxH1hgLub/2mgC9/G6DhZkGjev9xtR1vFy0MQ+Ug3Ht7pOnEK12/llIcPKipOC6uwWJXj466VfyyvuXPOGrG42kKn5DeeQyEM8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66487386-ec02-4514-2ad7-08d58db3b8eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096539D74D43EC4B7D88EF2BFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: euPTaTl4bVxK+POC4vuyL5nQXPF6elrrRVJIkeq9slP3VHc/0z93G5BMh+tCx/AkbAWGXmzIXbfq+Io3ji0b6UMpkGV/KAUoOo25RKVuywXHxaBk+wPSfL13bQlMJAseadPhAPc9MgT34X0xy8NiqnHfIhJlRJjuslRKYSmnKxArpZugra5M19jhguHiiRTwrn5cl7MsSsuL/iokfLEejpRciO0+y0D2Qo9GW6ne96y7WIeSuhxQq35G/dxI0KUG/9gJ2FbWEfqeYz1cSLfRrrGdVi5xslcy9CcoLsIZMuu9HeAOcIWQq95e2KGg+LFRefyA0/CJrPLl1JHteu4lXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66487386-ec02-4514-2ad7-08d58db3b8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:48.4014
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

[ Upstream commit 293dffaad8d500e1a5336eeb90d544cf40d4fbd8 ]

If there is not enough space then ceph_decode_32_safe() does a goto bad.
We need to return an error code in that situation.  The current code
returns ERR_PTR(0) which is NULL.  The callers are not expecting that
and it results in a NULL dereference.

Fixes: f24e9980eb86 ("ceph: OSD client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ceph/osdmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index bc95e48d5cfb..378c9ed00d40 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -295,6 +295,7 @@ static struct crush_map *crush_decode(void *pbyval, voi=
d *end)
 		u32 yes;
 		struct crush_rule *r;
=20
+		err =3D -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
--=20
2.14.1
