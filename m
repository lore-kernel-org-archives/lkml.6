Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477686-2-16159107914070658039
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
    t=1521477685; b=H10IEPkT9CGZQluzLqdJvFL0bg/5zMv1ai4nF4YWCHg2uha
    OqvwncSnsQOKujqC0gjN+S4fcM5Ekv5GbNvBiPRJgFegF0gG/5DRS1X+d8ywwhPk
    OR+KscSJaK9nZXw+4ohvsnjGbuHoOXOWOQ01txVLNW4DCFQ57+KuDOYg2zBbB79q
    CFdUrKPuQtQFDSKIIV98VZtmThfceK18W8tO+LtTmutCufAE5Z9geaZq1MGkv4rn
    L8GUH8ae032Toy1tc9c04gaYERiB0fa3h6goZkfN1UIReduqisMMFnrz3G3zkMj+
    w8uh2KctE2a2WqIUNaXykss/bj5DDK1mkcAQ+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477685; bh=Ag8D/h
    BlyyMPYt0P557720T/MxOZJHiaAmvXaGPN4Qk=; b=PIgZgah93MB664DdRaAloH
    w/Q1gqIBeW4V6B2xiWO6jM670+zn9k8uT3U/TjtETlgfrYaccHUoXhO4cPIEDsoS
    K3tlZs/1SmfzekrVKWVXUlcGHZ/IpuGckh+4Y9WEStHLzx+99gHo255y4SPvBFOP
    gD3OTukWUBzVWQS5om9NuqnTUXuIcTsB7TXUXvRyKyXJ6TweR0Yib+32wi7XIwcS
    +Ml3Ujmnz5kKpZMOa2FdDlWFheZisooK20KdONNuKOrytJkM1WgsXW1Gy0n5V4CR
    bfY2eMiyPDjUuzbnihzVrFrvlRdzlaaXuwd9C5LVcR4mY8TzngB9U8EXdxQypnRQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jMjDu5sE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehheeknecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jMjDu5sE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehheeknecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbeCSQlD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:41:03 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:1938
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966839AbeCSQM6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Schmitz <schmitzmic@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 044/102] fix race in
 drivers/char/random.c:get_reg()
Thread-Topic: [PATCH AUTOSEL for 3.18 044/102] fix race in
 drivers/char/random.c:get_reg()
Thread-Index: AQHTv50SKnpWhYnAQUCZrzeeMQkI+w==
Date: Mon, 19 Mar 2018 16:12:26 +0000
Message-ID: <20180319161117.17833-44-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:Tfz+90bT27s+er3xSmagkCPL4EL+FcYy68c1mKLpC2VSoykcWvIk6q4zWVsWZL7A1IqxkNv/cHdA2N25t3VebpLcyzIcj0/27E4615M/FdeiDNRB5X8WnITVVvRuemXbTGexHSn//gNHLtes71xiGAGK3H1byQV0uDEMbxzdMIj1yFQD4HT2o6dQ0+Y+t5HjEv6zy/xbyLEUAc4de+bgTttPxZnlIkMpCEa+st6EAFythRQjPZbpYNV0wHy/Ekhh;20:ZEc7MXjTUvII80hjfYuX8wJg7CZGxWLNGfDuzFO1C/bIbT8JDfwDqgacfpQ7rRfrH3MYcYusySpQJe2I0Q/xzgFYw1/mFcqsvQ/pZl4QlCVTC0wmEUbP2ESb2Ncdnm7nBEnFBl2fa2djvke++NmkGmJG9jJ7KE+Bz/Fr78T2yKo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50e4b348-d2dc-46b0-9ded-08d58db444db
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104854268D4637F029DC044EFBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(3846002)(6116002)(59450400001)(305945005)(6436002)(36756003)(54906003)(110136005)(53936002)(14454004)(97736004)(3660700001)(99286004)(76176011)(22452003)(7736002)(6512007)(316002)(6486002)(186003)(86362001)(2950100002)(575784001)(6666003)(5250100002)(66066001)(3280700002)(102836004)(107886003)(10090500001)(106356001)(25786009)(6506007)(26005)(8936002)(2906002)(81156014)(81166006)(2900100001)(8676002)(86612001)(2501003)(478600001)(105586002)(39060400002)(1076002)(68736007)(4326008)(72206003)(5660300001)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ls4muSuuenhzNAyjgwWux7k/Hcs2tdG1My0ZhAuRJnu3FSM1TYiZQt5ycdLzYAwKicxCJ5XhkilneiWtUTxF2C/2+w5G0PQy3urkpSMRQO0x8sHE+A6mKfxfbcYblmxmPLPVWB8NiXQJgY6uuqFoS19mFAjNhrbBeoEc5rmI2A+vEzuEGzzSRVPUIHVG/YimEpgUFxNvwLbq03CuF7WnFyvQ72LFnC7cUPSo9pLvXmZojNVa28QaRKEffqeUvUIAXmIGrC7AQqNzqqA4egiYCVUo1VYC/Ty3d5rJuAN+Ur4f0eRfRL7f8IEbZQNPZOV3jKwX7nk0WZBmDVEkwLJhPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e4b348-d2dc-46b0-9ded-08d58db444db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:26.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
index d55156fc064d..73049abf4898 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -863,12 +863,16 @@ static void add_interrupt_bench(cycles_t start)
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
