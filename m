Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475274-2-16206459129380189424
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
    t=1521475273; b=fmw+0FtR3wWI+IbYsGWeQaHnCixvVvJStfKiF4AxFdWQo4a
    D7KHRKDlbQy9gPUxeQn/PCfu3sWNm2dWGABIxs06pvlvIMc5sNBRcBSVbAssUFhx
    TqkJC0pTdg+vahDQL3dI3eojMrc2gTBdwdiXnFuEMWMA+XjLhJPbdkHyDzJc8JMg
    LYbM86OHE/DxCXQMDdGNEzCioeuRK2Pa9fU5lcab9IVja9DWUZexAe54dcRRIPjI
    OR3+Fz8+A5yDpy/kAtYQkkdEYunNWJ+Bfzi4A7N3gOuXuRTXGR5gF0vf8vdo9TGl
    dQ+UtmlJno6KYEqf4smnByellnPNg10DBg10ZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475273; bh=JI5Wvj
    lbYX+rMG+8cOd3qhx8sMmlfegDZpf/B7eJ2n4=; b=nAGiVdHugQuJZYKpL39WYQ
    Q+Lp1F85PeLBRkz19rqUid6iEVw1puQJ0sNrin+dxB9e6hX4urZDl8dlXDZJyZht
    oGSFNsaBOjr86CUcddNxXc6rK8kws/chk1hiYyZNBSVgCASVDD8+4q5jOmdBqimV
    e6bPm1zVZbCfKTSgq3x6KeFRIo8FqcnA6Vky+UBkAAaUDFIkvg/xnEnpWBeHflBn
    yAz02NkEZn6I61MI594KGyVjA0IsvDHabbokLNG1wzIf8eyC1bQZMbKoFB5ugTM5
    7TQbZHldcRPExwSysepbWHO8c+rAd8sHNk4A+oyiM5LMDBXIHVBB4D1h5+LFG3Kg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZMgreBbg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegjeeknecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZMgreBbg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegjeeknecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965252AbeCSQBE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:01:04 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:4912
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965264AbeCSQA6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 099/281] mlx5: fix bug reading rss_hash_type
 from CQE
Thread-Topic: [PATCH AUTOSEL for 4.9 099/281] mlx5: fix bug reading
 rss_hash_type from CQE
Thread-Index: AQHTv5tPi4aTP2JI5UewINsSY3vxqg==
Date: Mon, 19 Mar 2018 15:59:49 +0000
Message-ID: <20180319155742.13731-99-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:XB/8whVIyW4l23L5HekD/rzupr0JcIyPbY7PeNb6RRwrwIkD2XPK8lzMouvORKvye0W74ClGCLv2IqhQluUrz8jTk3laKSBP89cqEu2KvmBxXGHux9RHhrScSytlk8eLmMjUSathQ0AFlk1HWsm7EyihoVWzuw6vgVn++Azp4n3vSgHKs6i8curAC9igyg7JkLVMq/ctpDDmZxlmv0YJKni/vxZvkklDu/FP/M/xBj8zdcmqzJ5g4s3hEojgRcz1;20:Sw25KORhHwxJZPqjoY90YH1AKy+RSa++B86q7iSIozbL7eFmMul3OvQPTordPOTrc+0UZ75X6kOpeiOuohFny0cA+RqZkO5ZHTnVs2QE578ao6urYJ0UKv7EZDw/Jx4L6yEn2+m03KGDwVR9AYGtoNMz5W4NnB3M9+Xdb5yZ6vg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d782991-95c2-44ce-9d32-08d58db29257
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB09331326353D7C7CE560EA21FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: LUN5GmNJImW/fNMwprOECxe9HF0kGTKh6BF9zo8nNwJdZxPsgEm5WuDHTyyeFp/Z2QDKbGELjRaXiAFoUsVEEjvk4zEFQHPjICH/Gakt8IQx7SrWd/fiPWs2tf9jB0c5E6PtVzS2aGGJgXSFA/kQ7XyRelQE1+wSSTWjVK5+HXWZ1HsEg2bPPF5pXobMHDxSZTxHrmfdo0sun/tBAbcAOd0f8tonmKAtysPg9RCUB0ZVwpc9eTZY2Ff5uqsAL1gQ02gh53bq2s0FqoN2qnxzlyL0BTF8mPCNojs0oDiT2hC3n1NFVE9q9CG8Wkq9AOtYermJdUn1gXPRkK92+8ioeg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d782991-95c2-44ce-9d32-08d58db29257
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:49.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 12e8b570e732eaa5eae3a2895ba3fbcf91bde2b4 ]

Masks for extracting part of the Completion Queue Entry (CQE)
field rss_hash_type was swapped, namely CQE_RSS_HTYPE_IP and
CQE_RSS_HTYPE_L4.

The bug resulted in setting skb->l4_hash, even-though the
rss_hash_type indicated that hash was NOT computed over the
L4 (UDP or TCP) part of the packet.

Added comments from the datasheet, to make it more clear what
these masks are selecting.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/mlx5/device.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 58276144ba81..5f3e62253e2f 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -750,8 +750,14 @@ enum {
 };
=20
 enum {
-	CQE_RSS_HTYPE_IP	=3D 0x3 << 6,
-	CQE_RSS_HTYPE_L4	=3D 0x3 << 2,
+	CQE_RSS_HTYPE_IP	=3D 0x3 << 2,
+	/* cqe->rss_hash_type[3:2] - IP destination selected for hash
+	 * (00 =3D none,  01 =3D IPv4, 10 =3D IPv6, 11 =3D Reserved)
+	 */
+	CQE_RSS_HTYPE_L4	=3D 0x3 << 6,
+	/* cqe->rss_hash_type[7:6] - L4 destination selected for hash
+	 * (00 =3D none, 01 =3D TCP. 10 =3D UDP, 11 =3D IPSEC.SPI
+	 */
 };
=20
 enum {
--=20
2.14.1
