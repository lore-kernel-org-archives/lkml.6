Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475779-2-4718975823694675380
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
    t=1521475778; b=a05bj0iW2b8R1cD3cTexVz5Q6XCZA5Nrll5L5UIfZ2Lbztq
    dr8cUiAWPX1Cku00jPj52T+twm5XBHE9Lhg3R8VnNXw3CrhMfbvmKJ/xssV8llBG
    OtFp/Nag/pITfD1Bym6YB/ASSe72p2peC4MtusCoxKuX8JuKCT6TpAusAYAyiQ6r
    9YbOs/rvWRXawkzYbfBI/1qn3wIJ3L+jBscuazRAysFfzbuRfqVP4K8U19JVAMcs
    NI4XBMbPm/T/P93hlhx2vwyogWi3B8NDpPXat/pQp2lqOvyuI7j0PGLsM82e4+sp
    9TAqRc1ntKGgwEdJzqJ2BisCsWC4LTv4JTLMSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475778; bh=sz3ck4
    KZz5pd2306WJnt+0khYhLs6dZ3IIt2HYmHAx0=; b=VjTIwXNya2xr1fpgTv+srN
    L3axqDVIXbmZrLhPzGNow9TcT0MUBGCKTK1yTqaby+3EurOfLRr/l7akfb0MQOjO
    MGpPhl2Gwpe+YGOeFOlnXeC2Us1zH0wsLCw+0jxBqPEL9ZhW6p6cIn6jyfhs7N6P
    hWndGo7pqF+lEojgTbz7X+/NSBIzARitJt9noLvftsiHRtbGt6B3m1WwHPBSSVe2
    3MPu/iuXKsV+BCSOh3TNvcdrFBBO7W3yFvOdwlnXmWZKHSXi0TKIDfsUjDGZ1bLP
    GLR5bHLY1vN4vxG+AyTDEV7yJA40JRbhWcFI8sGw3avr9kWgMroI13ethRwpu2bA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WRdhv8TI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehheejnecuvehluhhsthgvrhfuihiivgepledv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WRdhv8TI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehheejnecuvehluhhsthgvrhfuihiivgepledv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966168AbeCSQJd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:33 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:49376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966304AbeCSQJL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Schmitz <schmitzmic@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 074/167] fix race in
 drivers/char/random.c:get_reg()
Thread-Topic: [PATCH AUTOSEL for 4.4 074/167] fix race in
 drivers/char/random.c:get_reg()
Thread-Index: AQHTv5xM5Yz3JEdzWECzTvJXomKJOA==
Date: Mon, 19 Mar 2018 16:06:54 +0000
Message-ID: <20180319160513.16384-74-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:FfJkYmaieRT+4AvB2I8Bs16+ysw6d8fM6zwtC8WlzC3MRVqWJlBezngiddaSTSBN+yHASHUpOKjz6X/JBCzEaBwaVyGdYN2blSHja129KOnRunSNGLchkRanzoY9pf7HF1HQbtfUxg7IhjIWaFoRufy7pCiWvxYeRt2pjWnXmhjxhB20PJGPEUtlRRklND53nx8oPVKqu5M/7BdwBoqIOquvGPcvsh7r+Q82BeuB2d/W7o9rY+UNZJJD3fvunLIQ;20:LhmoEE4N89iH/YiV1SzmH0WHH+qZK9Y1BjqTQCase8CZfz+LokBOpBDcg/25AfXY3eL04vgHATp7oIo+OCLMsFswzWwxnj9OB1XlZsR8msQvCKVuWab7TR67tgvuAW3W56o2575uOrDuNrENTmOZvHRm7FRDAK1hB1AaGFl8O08=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04cb157a-52d9-4b3c-7864-08d58db3ba5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09653795286E1A73B7D282EAFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LfRtvhw9+KPFkZK0mbD2k+ax2D1NMxEBPofyZyiq91gmdtom++B22tO4BR+hr23CddPfY0zxS8HiQR9qcmMxTJlEn6v2zyvXPZ8jwU2uxB3cqtPU1110PDxyW485GOTLya/ciyHyO5wM4NSos0fBInzr885wL8nBiQYVrdBgtOBlimmTHIE0XMqF5Pu77oWadS09aVacSFog2nS3lMVjyD7TuVVPvnKjCZlWmC8DgcmxEmTUwKiKBzoemlTH9xEFbi8zz3IkKqia4AZp1Rwn4JGAkDkWeGbIoICU+OYxcfsnz3ms18wOx9wzbkxpyGs6roIZj56aekq9kU5K57iqUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cb157a-52d9-4b3c-7864-08d58db3ba5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:54.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit 9dfa7bba35ac08a63565d58c454dccb7e1bb0a08 ]

get_reg() can be reentered on architectures with prioritized interrupts
(m68k in this case), causing f->reg_index to be incremented after the
range check. Out of bounds memory access past the pt_regs struct results.
This will go mostly undetected unless access is beyond end of memory.

Prevent the race by disabling interrupts in get_reg().

Tested on m68k (Atari Falcon, and ARAnyM emulator).

Kudos to Geert Uytterhoeven for helping to trace this race.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/random.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1822472dffab..29b4218e9b63 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -886,12 +886,16 @@ static void add_interrupt_bench(cycles_t start)
 static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	__u32 *ptr =3D (__u32 *) regs;
+	unsigned long flags;
=20
 	if (regs =3D=3D NULL)
 		return 0;
+	local_irq_save(flags);
 	if (f->reg_idx >=3D sizeof(struct pt_regs) / sizeof(__u32))
 		f->reg_idx =3D 0;
-	return *(ptr + f->reg_idx++);
+	ptr +=3D f->reg_idx++;
+	local_irq_restore(flags);
+	return *ptr;
 }
=20
 void add_interrupt_randomness(int irq, int irq_flags)
--=20
2.14.1
