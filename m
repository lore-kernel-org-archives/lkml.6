Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475513-2-7437281424857615694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475513; b=Rq1Rl2xaPAUY505pBxiYNEmNeBTxZPNngzwvVxCX7TBetH/
    ZqMjrAS3HZreM6scwuXcX3DMwIaDbxHZeIsWjJi9y+N2kwk3/D5ApF6f1nvICe8V
    OlvjttMzZZDhXjHIBioRozspXyEz/X04tyLmhIFiOAFT1wg9EAC6SHVP+m1AXJXY
    upDROxCQ7Z7pvuB5vXiECTxJN2k55HC27xKJv1Q2Oid9PHf2+luM5WRnapUxKj0W
    hMFf+FTXTa66CFXC1E64JSTRLvj7DFBCGqZmX91cI1zE9U8hEkvWrH+rCawn1Wj4
    Sjh8tYZJmKw/mVTbsTKTcouuIlaC4CnlE8SAbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475513; bh=5CbYAC
    kRHOftkH48N5AsOZHdZUotCm62l4to1PbKB9w=; b=B9Xs3VOOk/HOiU+K7+SSlz
    c8eN2loiuEvhjOXS++3dih+YGOijW91YD1SkvXVCWMxBrKhlqTINqr/JZJtk131F
    tVya9oVvNfR3x5/uEP8xPv07qpuz0KR0LqgGnkItW6LploN1OLg5nR5oI+oksTMc
    s9sy+e99v0frF43bdOe43X9r/yK7ImIN/ce8nR18e11dsWCv2BspEAana/Fb+kHG
    KMhQSt/Sgxp37SOK8mLkSIZDmK/9SXVpB7BDGyN59Zam5DktEihG1oRk7S1opnHS
    oi5Sf0InOHx7l/3VeNPK09LcCpBZqIfI4mECLEHIM+DeYHVetlh6MK+zgNmp9OEg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WO+Fbhek x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedukedtnecuvehluhhsthgvrhfuihiivgepuddutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WO+Fbhek x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedukedtnecuvehluhhsthgvrhfuihiivgepuddutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965767AbeCSQFI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:05:08 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965083AbeCSQFG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 233/281] X.509: Fix error code in
 x509_cert_parse()
Thread-Topic: [PATCH AUTOSEL for 4.9 233/281] X.509: Fix error code in
 x509_cert_parse()
Thread-Index: AQHTv5uvZdi/yUEjfkCalbCG/W0lWQ==
Date: Mon, 19 Mar 2018 16:02:30 +0000
Message-ID: <20180319155742.13731-233-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:o4CDZMgDfbK9N8+S9ZDVs1GyOgE5YM0AjDfEaa7+Emon7BFKzOebxRlMuGht6CEqmTfM7qbF2E9SQkuKfBa2TkdZ8Jcll+BazNb0zojqag/GsAlWav+7aCj6XfYo3gn4JTfr3aMx6+CQBEwi36y2jUT7geK2KZ96cOxErjuM2yzwcSzyWY8Po1l5002TWzzDD+4aQjMuJlRuWmt5OpT5taWbXKJ86zpKMBBmwj1CXE5oKUNGp/brx4XLHoVlKhiY;20:rHPAfQ8bnNHeEDqBzdG5IxfBDPQ6M2Jq2VjnTNblvGVwEDfVylT4xE7J1iowzpeV1rTm6yoD9LriZ4wuY3x/24WL3K8r9N/3S2zQRiXywkzxj5aKbL+Qt8bMZ5cdFVfJPqAyfDvLvLf1ZT/wS9SFqqx8eeNfm/EwBVInw/Q0VOE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0244f1e4-993a-4fcd-3cee-08d58db32663
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885F0DA820280DE357E0A02FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DzjcLysDeQANEEIAnb6fX+9RGOeklxZ0dbyZBQ0GVGJdzEh6/Gvt7WvHa78ZYmqlFKM+4h3ZiCoixSESfBJfyoZ9ZZx8eihHKlfxKaWgxC415uJzKznjOWOKlIhACuB28ov9kVSEGtrm3uMRiWGDStxR8sL+n/bf2FK2bCIp0OqhwlUuXmzDVLdY/7Dga6UwC/1FwCaWXxD3ieABO8eYFlMpD4eUQGRdM1SfSlvLYXlgPDReZEtalpxGYEmDYomQjRzUNjd+YX6Ak5OURXJdIH/+sPzycrYjRehbx7ZxS5gA+5WHk/BO6Kg56N/yAcQYsJA6qbbOv0ulIFS1vw1BGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0244f1e4-993a-4fcd-3cee-08d58db32663
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:30.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4e880168e9ffb1cdbdb72b3b48ab0324b30c2d62 ]

We forgot to set the error code on this path so it could result in
returning NULL which leads to a NULL dereference.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to t=
he akcipher api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_=
keys/x509_cert_parser.c
index 029f7051f2be..ce2df8c9c583 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -102,6 +102,7 @@ struct x509_certificate *x509_cert_parse(const void *da=
ta, size_t datalen)
 		}
 	}
=20
+	ret =3D -ENOMEM;
 	cert->pub->key =3D kmemdup(ctx->key, ctx->key_size, GFP_KERNEL);
 	if (!cert->pub->key)
 		goto error_decode;
--=20
2.14.1
