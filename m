Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480361-2-4218551255999356574
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
    t=1521480360; b=qE6CXVCWkA+a6Wiz5PBvcLSL9Qo28MIdg9bZkR5ELGfFgmW
    U2x1vO8Y3g9acubIi0Jyu6pV7xpYKnIVnn3Lx4MaTmVVqc2eYaR2fxigbgBu7kpx
    OPMy7y+2OwH750HxZ+alpGo6mbF2MI4/Kl6NTv81LmIgI1AGw4OHsFS7cfaH0NSN
    b+WKMTnFU0++I9CrOXIMXXN/AbgglByfOZ1jk4pkt/CqstpKAd43bvAfhclEuvII
    YadzKT9gm6q7ypn0tg79K2gMm72HjCAPtReY0aA8BA1caXYxX3UJHK60XAL4FTfI
    fexTg5QvcM2mXiS/BiJenJAFk3bD7QpsTAD8D/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480360; bh=r6iCvZ
    fxSK3uOpKerV034Qx5rnI/MCv1IKXXyQSEKJA=; b=NjVNVZyuBg8bv9K7QDwAOD
    cihhQYH5ICsvi2oi9rU2DAjaHlwnwebM3GV1eadyGarzlti1P72v48CaZO5AJULZ
    Hqy9uxwqxVYY992JK1NSDGQUtxfDtzH6q9KbjovxNeIpAREaDzV6Jt36mMi2vAip
    LKMrnRDXgTkbs0JZHEMD2xW3UuuBm2eL4AWv9OsHdMBNOiS6wHelhuhBEHJeTKID
    FNq8uqVVAUnp3zhqZZzz1ON6ZR+lFmE05xZD8ftL/xMHfTAlb35KTcH4Wifwkfjf
    hm3OJXwPW6t/Q6hPD6ZboGFaduz/3bebnaZH2X4bd/b80U9OjymfycFaeHIcGvVw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ENmy2hBt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheduheenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ENmy2hBt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheduheenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966367AbeCSRZw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:25:52 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:3328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964939AbeCSQIZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 051/167] scsi: csiostor: fix use after free in
 csio_hw_use_fwconfig()
Thread-Topic: [PATCH AUTOSEL for 4.4 051/167] scsi: csiostor: fix use after
 free in csio_hw_use_fwconfig()
Thread-Index: AQHTv5w6JeTCoBXTqEGB4fFFWMcx1g==
Date: Mon, 19 Mar 2018 16:06:24 +0000
Message-ID: <20180319160513.16384-51-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:pS+HQoR7N/EjGMV8ZDm47uc+meoASjcr6qILb1tATA7nfJOeGWJhn107/uNcScJraBYTN3p8WGGAPiEnoi1+hiUZ0S4GItoxQQi4Z+qqZ2xXoHnqrsEEasHjYdNfusXFRKc7LdQA01oCfITfMsWkAIma1FPh6IXF453Qro8MNG9Qb5BIAXvRTN67/WqHXckJKWnlZY/b8B09LXXp/Lh6g9XyAq+Q3zQ31kbygo9irPHMJaHwYvVqM+4CuShrbSGQ;20:nqOTZnRG2qDcSNPKJ2FDVAXjFKpzlLAkVAhip87I/qnQdsUE9G3jso+NxXKJjmbeN/uhwuVZ4hrPcRFxQTrhVR1w8h4UweGTwL/XjltyFB/djBT6UTVNo/Ktp5sp4Bl/guxzirYSjo9wbsP51VHGPiik4qWFL6ft+QL38UMqtb4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2d61844-c30a-43d1-f5d8-08d58db3a1af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109450CC3D4B2095341A1CC6FBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(106356001)(10290500003)(110136005)(22452003)(3280700002)(478600001)(6666003)(54906003)(2906002)(2900100001)(2950100002)(10090500001)(186003)(26005)(97736004)(5660300001)(72206003)(66066001)(107886003)(102836004)(53936002)(59450400001)(6506007)(6512007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8676002)(8936002)(86612001)(68736007)(3660700001)(86362001)(81166006)(81156014)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7+Q1tJMV5qRvu3ry7cBqmMhzFFvH/BJhoSnfwlN261LZihKANQFsOA3oYO0qoHWY8f8xB2BorKyaAKBDCooXRhRPzyV3y1LYTj/aGa1H+1RLhaNDIu5KJYI0psSqxqB+sobXJ9bDRyMHP2opeTNJ3MRnpIuf0nPchyGzX0a/VemTh6RT9B47pggH09amLPcnMJ6SWrOYZiGtFr3YK9976HpqyQAmvgu1+PUNklFSb8bqGA7bCGllHY0XWTGV2kBNfZBPRKCg2WPEpJw4/6eZ8LjlMumf3OFntBbZBlgWFyyTG7OIra4y6keaLjWO8YZzTnnYPFy9/mRirBZEaza85Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d61844-c30a-43d1-f5d8-08d58db3a1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:24.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit a351e40b6de550049423a26f7ded7b639e363d89 ]

mbp pointer is passed to csio_hw_validate_caps() so call mempool_free()
after calling csio_hw_validate_caps().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Fixes: 541c571fa2fd ("csiostor:Use firmware version from cxgb4/t4fw_version=
.h")
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/csiostor/csio_hw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_h=
w.c
index 622bdabc8894..dab195f04da7 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -1769,7 +1769,6 @@ csio_hw_use_fwconfig(struct csio_hw *hw, int reset, u=
32 *fw_cfg_param)
 		goto bye;
 	}
=20
-	mempool_free(mbp, hw->mb_mempool);
 	if (finicsum !=3D cfcsum) {
 		csio_warn(hw,
 		      "Config File checksum mismatch: csum=3D%#x, computed=3D%#x\n",
@@ -1780,6 +1779,10 @@ csio_hw_use_fwconfig(struct csio_hw *hw, int reset, =
u32 *fw_cfg_param)
 	rv =3D csio_hw_validate_caps(hw, mbp);
 	if (rv !=3D 0)
 		goto bye;
+
+	mempool_free(mbp, hw->mb_mempool);
+	mbp =3D NULL;
+
 	/*
 	 * Note that we're operating with parameters
 	 * not supplied by the driver, rather than from hard-wired
--=20
2.14.1
