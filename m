Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482814-2-17429389287598186934
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
    t=1521482813; b=DnQL13lOEUtEFvV+53gi+Diy3bcfsD+8PfIyjR43piT57Q6
    pbnGQPFMqVwneeNN0H/19KdUZ1H/dIgqLJncchhiL+iAt+veM1bhZ+HpKXrl3tOR
    GTulj4Zmwh16F3vg56dOXNx5Q5PTOsk01sO1IYMFMlYykr/PM1fLO1XINDYju958
    Ky+VyGvA0d6BoytMJfmsePCff7XmXQu9thP03Lf0GtVNeOwBLaN1MXthFiIs7d5/
    +rVsm8HuRkhU677TAU9mzymSBLJc/nYxv3HBe4zxhWt83Sx4lQO0xKOTuR0iTsuP
    5WSVdI8NNErMLqmr4oN3NvTrbb1P5f1TcLwScgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482813; bh=7zlE5W
    9gItGkMZCouwsNf2IOb03X20RVdCi3+klF3r4=; b=FXeeUiyfpMXLe4QmUoflFZ
    8to5QAm1wCI+u3xfVatTna5OjBHmMNnykOQctUUePAJyQ/LSicani+gp7QfpKaMB
    eJaUO+SJ77IgBpvl8VOTZpTbMSicJ6f3r3d27cO5OZFsBpYfUAHm1cHv+YhkvUvr
    zTTkDrHtoUsFfiip9x0qq+cSRtphj9kxBL5n82LxqGAUTrYH6uRmuYXAlARVuCFF
    6rRzcpwF4ectaLgXSXH+q41qlOF2SAeyHUw0HgG4WfZXPPNzS2EFKFIb6VB9kD/A
    1mdnlHeUb/H9n2sZFTnyeSEs9rqVM1D3MhkdF8kEOmaX+TLeoyEjwPWigWo1k17Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G/IPfaZ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtjeenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G/IPfaZ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtjeenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933541AbeCSQDa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:30 -0400
Received: from mail-cys01nam02on0139.outbound.protection.outlook.com ([104.47.37.139]:43744
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932923AbeCSQDT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 175/281] mtd: nand: check ecc->total sanity in
 nand_scan_tail
Thread-Topic: [PATCH AUTOSEL for 4.9 175/281] mtd: nand: check ecc->total
 sanity in nand_scan_tail
Thread-Index: AQHTv5uF4W3uZ3mFKU2+UKkRCyd0Aw==
Date: Mon, 19 Mar 2018 16:01:20 +0000
Message-ID: <20180319155742.13731-175-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:ZwPvRxkBBEIK/UiTX4fpgwnhmzSU4opjIVx9096+07JuZJPcxZHHsLlkGS63RJ9jj9nOWcjNDdW0/6tM+HtRYUwmDyLQig9d2Ai7vVRGn99GVnrhDXKeb0+Jrhl2SrsbSBOXLrSk7qtJ36oed6yKkrhQC6p6yn4zLX7j2FiL5rsFxIMqV3pMFxC7nt2plFTsiMXLAeIf28Lkwr/nFBCHF57pr0n+CRukoC72QU5FtP1IrgKN5ei20Ulyn/nkpq38;20:lMu4b/NEXJU66VGIVh6UrvCT6z4W8G0pQJnSaYrADd5RS7mU/b381xKSQu1d7FZnUZbHTiUObu8Yu7G3BfVOlA8RlHW1ERkNNSLQyCuy0ilMqzahsAkM/FKL5Dqp5adL/iWl/VWqERWBzTAkBhI3ThUNPsxSXn79cdKCcGlKwuc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1f2bed9-d19d-41b2-1597-08d58db2eb62
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725AE09B6B3A9DA12908CB5FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5VdpbfzseeUrbtbo5pqR1ZzKmXEEFZGhdNLboK6dVmB2zqPSdfTtb5rXyoPshsp7GkTb9f2ZersOOS9g7+xkydROJ4fuhpHiSWAc0Zw/U96dml9WRGxdSF3TdiWdfu/8EP3uSYotlt50cR1u08ehYO+h/N5HK9tMgomVbx5pVbaigL0b064IVjxR2RYea0Uj6WVMVNmLj20/3lSlMCY8uEbJtPe0bbPNcgbUiypmju/EP3T0gMccJCnkoxENh3UB9nSZbu+wSduOk58phsnj+kA2xB96YQirpo0ITf2C8248vdcTXLn6XEJ59m2brWy6cf1xfFn64kNJ8ODG19yNug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f2bed9-d19d-41b2-1597-08d58db2eb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:20.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 79e0348c4e24fd1affdcf055e0269755580e0fcc ]

Drivers are supposed to set correct ecc->{size,strength,bytes} before
calling nand_scan_tail(), but it does not complain about ecc->total
bigger than oobsize.

In this case, chip->scan_bbt() crashes due to memory corruption, but
it is hard to debug.  It would be kind to fail it earlier with a clear
message.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/nand_base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 21c03086bb7f..3bfa8e0e44cf 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4780,6 +4780,11 @@ int nand_scan_tail(struct mtd_info *mtd)
 		goto err_free;
 	}
 	ecc->total =3D ecc->steps * ecc->bytes;
+	if (ecc->total > mtd->oobsize) {
+		WARN(1, "Total number of ECC bytes exceeded oobsize\n");
+		ret =3D -EINVAL;
+		goto err_free;
+	}
=20
 	/*
 	 * The number of bytes available for a client to place data into
--=20
2.14.1
