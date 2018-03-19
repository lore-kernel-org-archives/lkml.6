Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482862-2-13154129349230527739
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
    t=1521482862; b=mzsd1mKOQIbaSn8WURWBLy/DcoWQ6wPYVuvxpMQEcKJjoi5
    pVBBWS/+8+R+z6yywQpMmCBGoEG+fG/fBO8Xa1hFBudxlawZSVse3Jl+IlBrGOXL
    pmk7s1gCU2NZhSash4/EwLyuwJ1cj2br3KjJaZi32oraW+/YG+knlnyYkR46/7rk
    Rgywm8l41QNSPjyqB4KEtKm+6meQ/b1G+stNGtRfBuYtaFwP0Bk7IvmIy+YGSr0f
    2qWxyYPsivA2ZUejLrne2sXHwGQeYjugVLbwfAsMYinuGdP8/TFOsq0cJ7GXzCfT
    0cLCASxI5axrb7EEiPGl11zaZo2HjuMsHPYtzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482862; bh=syO2Nd
    W9qll3CgifSn5bz0qCsfb8Jr/s1yLOO19Y5/U=; b=g0ou4G9Ewtzl93zLR2yb4t
    tdjr0wEMKAFuBU47ofAloEtZFWWbhRfv4CSX3afKsEHvET3DM+SF7Fofu4pcdl/D
    9gstPY8i6nKd64ReumwvnY+4e6KskGK/NnDk/i2qZyL67eu7fUMZMkzBPvVhwa4n
    q8HQtZ2TeKRbFem01kWJQyPJpmxNEsiLRnRm690bZfKvXmLFdm/XdSKtMIlh+Mf9
    WSFVJ7Uq4CheR5ITtrclDA4QQ0jx9d4pzXeSFg/SWqfBIf6jzIAzD5IPOobBlB5U
    wkg9CbpztjEdA8mGHhu/kjteA7W85nWEPxEVsnw28jWn6QfIWtNTnXMCO66pCRZg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KOxKYysl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehvdejnecuvehluhhsthgvrhfuihiivgepudej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KOxKYysl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehvdejnecuvehluhhsthgvrhfuihiivgepudej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968409AbeCSSHi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:07:38 -0400
Received: from mail-by2nam03on0139.outbound.protection.outlook.com ([104.47.42.139]:32544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933569AbeCSQDU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 179/281] powerpc/spufs: Fix coredump of SPU
 contexts
Thread-Topic: [PATCH AUTOSEL for 4.9 179/281] powerpc/spufs: Fix coredump of
 SPU contexts
Thread-Index: AQHTv5uIif0ffBn13EyYDPxic6NNuA==
Date: Mon, 19 Mar 2018 16:01:24 +0000
Message-ID: <20180319155742.13731-179-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:5xh6qiQCEm4BGrGBJ04intxIQXl+Pkgb/6Fekg/qyS2acGeloMUAHYiSmTDlI403WAaDfPQHG/OVTjz/b0bANX+bs9ZEx0e5h1Dtn7QcgRXGnOnT2KHJs9B9QuM2ZiOfV0ScVXMhM9I/VQNecuSl6drjD8Zwv51rwjUVUr2a0E2Eo59ljE0CFzAvCrqqo3XkYuR+xkrz2ylzOpCGZw+M0FMjiLm9u6XWL0Xj+B5b5LSA8SXOASEwU5jyR6KLD3Cf;20:vWCqYV8fySQ3CFvPHKTepZya32vOlBToPch3/Wi0HrDwsC94x4dHVFjO6XMOhYd6CuZcmM457uVeOxFoNGW0trpwV3lyQ9AiBj/wr+BJe+OwY681imyTPhsdsdylQvmDsNIIC+NBoaQxBIDFw+LmIs9W4hHfnqQsiQADDAgi5Ao=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 925d51b3-7df7-47b7-cc21-08d58db2ecc4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09198337D7DDCC4CB3F0AB92FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: g/qgWSpwG7P2vugGrwXlJEnSfHRyyW+HDJHQKEldnw2Lj1oHyRtK8kVRsQtLAB9NQrnv0gqDgCc5INAqcH/q/jXHnBGRTLtA0hZKF42vQR0eeWYF5tz72nUX92tzImD4AerknhpGuBSvCniemMVfzN34zYaYiaePDNJxraizUCoqRq+nB7zj/7aFftISObGchhlnAUCCykLC4Y0mNKe4CeF9plcDliN0YHRJX1P5DinrrkmlPNKCbsE2Crc0LLvwg9CDsrJsdJpgsl47XH0MbOA5Wye/Z+pLIaavt+SFDKyqUskC5aPmWyDW6+uqJAX/ysxVFssd0J+2ygl7M5TLjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925d51b3-7df7-47b7-cc21-08d58db2ecc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:24.9366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 99acc9bede06bbb2662aafff51f5b9e529fa845e ]

If a process dumps core while it has SPU contexts active then we have
code to also dump information about the SPU contexts.

Unfortunately it's been broken for 3 1/2 years, and we didn't notice. In
commit 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers") the nread
variable was removed and rc used instead. That means when the loop exits
successfully, rc has the number of bytes read, but it's then used as the
return value for the function, which should return 0 on success.

So fix it by setting rc =3D 0 before returning in the success case.

Fixes: 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/cell/spufs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/pl=
atforms/cell/spufs/coredump.c
index 85c85eb3e245..b4abf9d5d9e1 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -175,6 +175,8 @@ static int spufs_arch_write_note(struct spu_context *ct=
x, int i,
 	skip =3D roundup(cprm->pos - total + sz, 4) - cprm->pos;
 	if (!dump_skip(cprm, skip))
 		goto Eio;
+
+	rc =3D 0;
 out:
 	free_page((unsigned long)buf);
 	return rc;
--=20
2.14.1
