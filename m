Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494683-2-7397482863954576965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494683; b=waD+mTQ/qgmOlTNyuSIymkRRkmotY4hixqLR32id57I1343
    IQdRlYy06q6pWehuJc5qJapqjyS0FN2N8FPje7144leq1S4KeaL6yBASA1wh6tk0
    fGcgtQXqU6K+PP2kfX3p4alYzD/smlaZpJeNfSrx55SALXK2dG3jrhdaQ8HBjq7s
    Bzln0gKVG2awbcuRPCGfHq/VYuhRQ/kE4Xqh+v1eCYj0hwP0HxzhfslRWDjJGibi
    3vLy0GQNjIBLDRgR7Iwzm9OfGd/0BiecqoZS+o1UdG7xIjrhDFjeeUIEbCL3tGiC
    +jCXFBU22vvLLWUF+eHQAKd4a248QQItA/EndbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494683; bh=r6iCvZ
    fxSK3uOpKerV034Qx5rnI/MCv1IKXXyQSEKJA=; b=GqzrfwUv90pw7aDHObKAo9
    7IVBQhcTqzeHFoFEpNNhZ3JnCAsYNQwp4TO/Fa3/jvWlMGcZ4vFes7FUpGi1/b7D
    h+3Jf1uMDaPeCr1QTa5vu6ADc6VkU/Fhi9HY17hbPQK0RI6g+sX/aYsM0uyTzaj3
    WIsgYv+fyXTpxjhox74JYj9qXBfmtR/FbEXE4+jGxxBUdBQFB9ba7BgyC/wKNOgQ
    9rXfTL/mdr+nYMRjFy5tTUsYbRghwtiFTevV2vOsDBxrF0gmdhNyz/S1CnUdRrO4
    S8cotyfxa1hyOvYg0pL9ifNfAcPvs8bNaiC1cmeHNnfXmBiAuDvEjJqMleRfmscA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iCyPG+XF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedujeenucevlhhushhtvghrufhiiigvpedvke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iCyPG+XF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedujeenucevlhhushhtvghrufhiiigvpedvke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969538AbeCSVXu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:23:50 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:54448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934837AbeCSQAX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 078/281] scsi: csiostor: fix use after free in
 csio_hw_use_fwconfig()
Thread-Topic: [PATCH AUTOSEL for 4.9 078/281] scsi: csiostor: fix use after
 free in csio_hw_use_fwconfig()
Thread-Index: AQHTv5s+1W3JtCmIDUanlvUHHUB5qA==
Date: Mon, 19 Mar 2018 15:59:20 +0000
Message-ID: <20180319155742.13731-78-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:i/GYIrkRq80z67oQjMcX0vCgSFWWAEBsNOyxUiv0o0rGR7qzgWInGZ9H+6wOkESCnZCmm2ZTnqEHqriT2UeTxbgmssOL5zSqB/Crkr1wLI9wdhSo8fNPWEqlLudGEedm1mBqYjoNjOU3Py/6aRosxMhJPeNmERhNhhpW05A9QbaKsY9J8XBAwsuawuMqxhnvRzVqiS4L3tKPnw3WDbJrB2FtelNPzZLzZ9tMjHIFSNheki6VGAgGTGBGfYyyF0tI;20:e6WVf94wA1iiAhqroKlFkFjDXU77uJcikhegmlL8r/jU7gSLAQk3ubDrqwtxsEMa8TjnLUbdG5P9wj2qKWs5RnDgI1+XDHpyHtUS5BvfiCOnsuTD9rzegWk7tCVCgQgHxiwLbYYJXs4aSPhw25/2SLN6thyD2J0gYjeN1x4/T9A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2138a22-d2cf-4a30-b8a5-08d58db279f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08696C7A185326E75EB68D5DFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tj+WIUvw465rT81E+GsqaXuz/akR5SQ2lhwEuxN2DT48bmANhPk2G1I9y/0Uy9EfOVoKdEBQponrbCKbGwtUsXEdObfW3NeJJYsVb6dPs683+cVGwBLXBTePKWglcOBez0iedA6wpgJIEB1vojOUdmEh3iz1XjWbd50bOZUVfXNRjYjs0qb/jaqsvZkURC3f+8OtOcd7ZVnFSv4FeB/2rZ+II76+Sy77mf9Vit5ciYllm6c5PZI/vIfqpLAlh+bx0Du2ISzqQ4V0QjsI0gwCFyMKGNoURsNRWZGSZRz5J/2lk07SfbfrrIJZl+MbwPgl4/al10lw2kyOG5lJnRpikw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2138a22-d2cf-4a30-b8a5-08d58db279f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:20.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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
