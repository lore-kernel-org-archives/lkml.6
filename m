Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233471-2-16936586965614052896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233470; b=sT2/uIVA7gPtpNHGl90i4ymSFN3nUcLTa9cqz0YpwQDo615+Bu
    LxlxrZEXp7uI9tYx1VoriREQn1w9Xi7OHe1yPTe7Ai1Heqa24OqE2pekA5cRb9gK
    7DJxyw32cbpRowrqWJYen7mWRgXbs6qHnhytSgQJ3yR8zLGfAKx9vRwxDQLpgkbD
    hC1vvwL7cnB7Fkg/+OTmmE9g9CCjEVVLuDmWbHyHDtfX4T4Oqs+iicWocFLc6s5s
    y4vQ0ZrkRq+aBgN7BWmM+gfP6K3SP0xa+b3v0sPIv+X80MCadmkfkWLyrtlFCdAJ
    w2kkD8y2Pz9aoDMrVuhGx33p/w0L8p6lTb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233470; bh=wdi6JISMER
    2Rn9T8bFBnB22DCorCFODGSDbVO66t6No=; b=nVE/Tts6OLZTQY9REOFADPwOaf
    PvA39EfMgjMintNcFNDcxOSiMo2qLlIQkwDOcNR0zrDf+qlFXifVzOEbV6q2HX9w
    9Slq43beM3oduShabRGMR5UTPqlhWot2aWQmgaTSQRWa0ROg7U53cG3i2+waWC9a
    ZiVht1lFn+MyT24mmZG+WbEQsLjo55sXQYc/wbQXmdWcuvyt3kvfSqTfhvBD9t1e
    GgI6rWMhAjoPwgYQqzc1fYr71d4jar2OGQwKu8LsUWbnhljy+lxe4sxp2UjsOjCF
    pZ6VvMn9moU5ZPnZNcdQ1bwhxKP3k6UCOa6O11E9Yj9XG9do079uIhOqXJxQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PAVjShD8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PAVjShD8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF21cVF8pGH9ZOfdX1O42L3IQvoBRC5Q7tyiRVCKiKiLxRWXM5Y3l+7f9eU6eJqNik9vo3dLRJJQmbV2LveVS+SVPdhzNafYp0MVrf3ivAw9VzEe0VhK
    UHlY5iwUZRQvLwq0K/DK+U4Yr2kcJmjw4hCSbVFW4cpFK1dgU963PVyi3Oh83gwYLv7l9OsXuPQQKwGsfUEvgV87cyw49noyVB9TMrcIVJdgpB88To2GtYU4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ey0kYsS5pBSIQNGXVkwA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeDIAX7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:59 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:13920
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754978AbeDIAX4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 079/161] RDMA/uverbs: Use an unambiguous
 errno for method not supported
Thread-Topic: [PATCH AUTOSEL for 4.14 079/161] RDMA/uverbs: Use an unambiguous
 errno for method not supported
Thread-Index: AQHTz5idUWZSG5sKN0C9+MWKE+c7dQ==
Date: Mon, 9 Apr 2018 00:20:51 +0000
Message-ID: <20180409001936.162706-79-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:qciBhHyhmkI5VqG7FXxkFV6mhzUAOP6YNtLAHYZptwxzPkZWQ3wRscBHxxmN4RnlobSgwEWWxJFjeoHTPIK/+d4R2Rh4gZHUhrUA+yjajp/yAKWdvrS+D0KbaJ4NmKxa2WMEA5LIeg3Fg9+dsz7oPS7cAkyJEVFGRbHr9XpxFp0b7RIWo+CEmYktGGgJtson1tXM7o3x9EPWm81HNY4OnEGgR0Uyg80rRmtAeT5AcaAHGskq3x8HFXkGLvc2WBew;20:ceuLXnrI6D0f86NlcSB3LOYuO2uiy50rMsMn1/HkUcI/WNYKzdpiH0UOgr7eu57XBly7le6OHR50wXQlTwX1OMeJ7WtzanCjCW9rixy6cRARJZ9e+t3WC51yA5wXgjVOKqtvWKRCulywgxfn+yipRvA8A0JdL1pEZr7N3ARBisk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7274ba0b-26d7-430d-e441-08d59db02d27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09841AB7B10D7CEC363ABF3BFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Gs9dQ5UvTIZsgqekDrJbZQU/wudH0f5IN0sdxv5PXSCd9uDcjAO68BEbsYxoSMNn2JcGDrOTWESAxjwBAECm37xo2HNEZXVMrUBdPfw5uF1WjQiDAavtiiUU1IEWL5yRkJ9rUYn41jy/snbc3/He8V1pX+PYJy6/+q5YTHGVTp2B9tJBjjCZb/ZdSCL1XdO/Pny5tbD8FOQ/MFZVNnzf1/ufMnToY5sWJxaKmO4FBtDIJE8gvVGWx9rOj/Ha76LWvNOBj6SgTbu3PLGoTJMmXyG03ijCua/ZHqGa4x90BVTIftrpLiEa9ZyoKllgmkqj1rOYNBXrVI7//52NOKqmGoevk8Vht9Yj7LeIlprzttOtPiFWfN+SMPXfUsTvczcA3ae6g0kUz2gch9W2SALXW1FRbkdo2KTgefUCLPhtZqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7274ba0b-26d7-430d-e441-08d59db02d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:51.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit 3624a8f02568f08aef299d3b117f2226f621177d ]

Returning EOPNOTSUPP is problematic because it can also be
returned by the method function, and we use it in quite a few
places in drivers these days.

Instead, dedicate EPROTONOSUPPORT to indicate that the ioctl framework
is enabled but the requested object and method are not supported by
the kernel. No other case will return this code, and it lets userspace
know to fall back to write().

grep says we do not use it today in drivers/infiniband subsystem.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Matan Barak <matanb@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/co=
re/uverbs_ioctl.c
index 5286ad57d903..8f2dc79ad4ec 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -245,16 +245,13 @@ static long ib_uverbs_cmd_verbs(struct ib_device *ib_=
dev,
 	uintptr_t data[UVERBS_OPTIMIZE_USING_STACK_SZ / sizeof(uintptr_t)];
 #endif
=20
-	if (hdr->reserved)
-		return -EINVAL;
-
 	object_spec =3D uverbs_get_object(ib_dev, hdr->object_id);
 	if (!object_spec)
-		return -EOPNOTSUPP;
+		return -EPROTONOSUPPORT;
=20
 	method_spec =3D uverbs_get_method(object_spec, hdr->method_id);
 	if (!method_spec)
-		return -EOPNOTSUPP;
+		return -EPROTONOSUPPORT;
=20
 	if ((method_spec->flags & UVERBS_ACTION_FLAG_CREATE_ROOT) ^ !file->uconte=
xt)
 		return -EINVAL;
@@ -310,6 +307,16 @@ static long ib_uverbs_cmd_verbs(struct ib_device *ib_d=
ev,
=20
 	err =3D uverbs_handle_method(buf, ctx->uattrs, hdr->num_attrs, ib_dev,
 				   file, method_spec, ctx->uverbs_attr_bundle);
+
+	/*
+	 * EPROTONOSUPPORT is ONLY to be returned if the ioctl framework can
+	 * not invoke the method because the request is not supported.  No
+	 * other cases should return this code.
+	*/
+	if (unlikely(err =3D=3D -EPROTONOSUPPORT)) {
+		WARN_ON_ONCE(err =3D=3D -EPROTONOSUPPORT);
+		err =3D -EINVAL;
+	}
 out:
 #ifdef UVERBS_OPTIMIZE_USING_STACK_SZ
 	if (ctx_size > UVERBS_OPTIMIZE_USING_STACK_SZ)
@@ -348,7 +355,7 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int cm=
d, unsigned long arg)
 		}
=20
 		if (hdr.reserved) {
-			err =3D -EOPNOTSUPP;
+			err =3D -EPROTONOSUPPORT;
 			goto out;
 		}
=20
--=20
2.15.1
