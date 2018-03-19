Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494574-2-6155492300318147268
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
    t=1521494573; b=ITCA958Ups8yxphvBOZ1uGhuvrpFUmCjg8bW4d/6eEFDJsk
    PMSXGxa/wGSljuNrEwjRmNuK0AsTsWaNTf44dq0fVYeqExsJ33vgxMr3YhXr87vh
    ZSwujnVfK5YIz8pHK34y9AIRVEB7VYc4e+m+C+HVyGrEqD9dAbqrZ3/Ld/z5MNar
    0f293P/u1KccuYdazqcR8WmIX6pP6+b7c5KedQLTTB8rlhN90VRkMsBUnaJ8cbTH
    FrQ/O+U+/Os3WzslwhXtgoltSlMlYMOyfVnLREYMn7QdsJEyjZ73OGk1GkXQ22ch
    yzik5r2JzTYxSytEVwdyNr9nQsrJFHz9C6HXAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494573; bh=65/MsV
    x2gW4jP6CUH25JxULJyHtCzkcemrgIgkA1K+Y=; b=TRY9Jj4Ke2MgomKBJJAMtL
    06Dz+dVU4ddOl4RYtpXwGGmyAcc3QZkZxb34N5qJQhbBmrPPY+WuUb+vlUqi1K9U
    TO84TiW5dmh9gLg6SOFQsNo2GEB+xV5+UhQu0C1Wbjej36iCPtfx4UbdfE0/rBD8
    1XLWCmicmz/7WtU5xGkC9pwtucGXiGCRFETiQsvUlNXLMIBaSWnyUWZ6Qlyi/UpC
    D+R72HTzRaD9wJDB93uxWG0T0S7HqSIToo56lfY0AW7Zdd8rsh9zXGpdzMU8/cW4
    CNHt3ZjRMebBqb/jLNWfbWKx7giXOzPAc1+zj8pQyBuhHhdHFvCO+BquHMBTXHWg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/CAFREX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudegjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/CAFREX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudegjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934899AbeCSVV4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:21:56 -0400
Received: from mail-by2nam03on0105.outbound.protection.outlook.com ([104.47.42.105]:9497
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965052AbeCSQAs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 101/281] libceph: NULL deref on crush_decode()
 error path
Thread-Topic: [PATCH AUTOSEL for 4.9 101/281] libceph: NULL deref on
 crush_decode() error path
Thread-Index: AQHTv5tQhlhp5yJorE6OlZe8lLsLmg==
Date: Mon, 19 Mar 2018 15:59:52 +0000
Message-ID: <20180319155742.13731-101-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:YRGpj0VEnhjC+bimMAXQBa1vKD0UDoIHVFx/Se6I/MeHyZGK/VjWKNJX5pc5Atoz0m1IjAw4duALs+N0ciyXmA18/rnTzOY+m8/rm4oeqoNEWePZQ6nYeWymDrJGjTkm+QD8oKhW84hZrbEzvbEm8jGRs+aRBFf48xcCZ66f/M5Ki38DPGWrFCZJClsP/rXfk43EtJ8ES0fg2LpVnKSOo1JtL/d8EM87QtTNFGTTNwdEk5aZ2+BuXhsGtvB7eGum;20:mjyJ0VB8OHrSPbm4RsMS2Wgo5wf4SdNBXmw8M+OJTBp5Q70SJBBMER3nr7bQJ9ULvU+NceFgRnrd17M13Ja9EBXQbpcJtFtpCggP+P0r4XSHbdjEbvG9YikEC5i4lvU/guZy/94Fx/151xLaiXDCdr/O55wEfQVSpi0n7OSONPs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1971cbab-f1b3-4232-14af-08d58db292e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031AC14DE5AC1AE9C5EF9FBFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xIXIRnZiOdk2T1+WRjbJd2h58+xoztnP5Ia7IW7GZ0YzhTX4yKK7nP3LnkLMs48ZZ7aKN1fOn2fO5KIa7hVE7rGlbkEkt8G157zjcEMqb7v3cPz84X/9V58E+9A5+5CBxks3KJQ1E0W514MZOCmpjqI2+CMLtKFTGUjCOZpG0tecrps0yphhm0C1lNV4REJFV0/54S+uyrTQriFAxr3ICehrBrJ9aX1GaRjjB0jhLei6CXKfrFQu7kQrYedlSeldd904cG6FUoeBmxtmRYxoGWrWpmjjouZeWfOycYoLiMk9KvBDua5wF2Nu92qTKYvVmoRv4lukXsMX/LnCsOeemQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1971cbab-f1b3-4232-14af-08d58db292e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:52.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index d3f6c26425b3..255c0a075e49 100644
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
