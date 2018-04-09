Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233171-1-4040409283282267271
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
    1523233170; b=OLoTZXlm2+MNJCBrgR9ZmpPYw2ERTut6q2WcajqRvDnyvW/4yM
    /4rhlPUv8+BpUfcIBzgv+mROeuRtfwYS1ox7gGM8R8J1CqlGdzId1Idm7PASM5HV
    8OUkiJ/PtQEzo2C8kp+0JlcKcqnmn5RqI3FL1svBwuQBjO966I7fel7RhlGGjSqG
    04c8Mcg7eZj7KyJKp5QxxC86ZAizcZzfXrLoKE4o04i5cO0AICx2/f8j4i4/93UA
    RElcENc9FLD5bpmne3gpBPVe6HN+y+B8iOc8tPLGTsytpGR+YsJzWXEhhrJtFQrV
    TOzzu2lyv6n+7I/8hBeijEfW8FZ6wtlliiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233170; bh=xCGZ7hWhf9
    xgTHEFdUEOsOTLixWFnr5IFoZ6A0B7acg=; b=B/ovmOs0rYr30l+Axpuv3Icqwv
    mmV1JI9FBzu3M8BMC4/ApQY38O7o10tIrV3Htx0TqvKosU+81O1oUgYqMdvAD+43
    lCyKDCThdeTCWJw7b0IURbZVC6X5Bd78mVHFPFffbWlamar6krG3xpNxRade9/K6
    b25pgstuFPZUXxlkiV/Jx7oIwIqqQqyVjkq2qlDk0Iv8Ts+cGJQmb+mSO2ad/I8+
    Fu9EFlvuqjZTB47jt0xk8tZ6R8ab9MuyD8pdONlgLW903AGxnNs4Sa8KdxoLnjpl
    /Wco8ahDIZdZlPir/DtyvlqSvQmK4MQu+1H4Dk4FOQKF75i7DbjcuvAvvZ1A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b2hZhJof x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b2hZhJof x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOuJjmbxGepmgPGN0uuXCYs2E0oOD5Z2+6koyy+otI9YTUIPkUzy8FXdtnHjDLkKfaZi/kk36uzTDE2qxgKHE1rUqNhPqxyLrjSALJSDQ2CPoRbcjZm/
    JjGhglyzsKil8oGGjSShrFvYi0qnh/tVAvjVGS3wUbbV6hMTOv1UYQjJxWKkkiPv2l9ZDridnIZKjjni+UrDjr0g+goDNfaYTKbZVJiiXaiCuvCE046lmT9a
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ey0kYsS5pBSIQNGXVkwA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbeDIAT0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:26 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753783AbeDIATV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 095/189] RDMA/uverbs: Use an unambiguous
 errno for method not supported
Thread-Topic: [PATCH AUTOSEL for 4.15 095/189] RDMA/uverbs: Use an unambiguous
 errno for method not supported
Thread-Index: AQHTz5g4M5EosI0cfEGDN4dxz7zPLg==
Date: Mon, 9 Apr 2018 00:18:00 +0000
Message-ID: <20180409001637.162453-95-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:ojMJr3iRTZ/PJU3jFMvka+sK59mswSI/851JTKDPoHQb/APc8Cyy5njC2M7jEp0jG4H3t4/T6yGiR46llHcxC7ZTPmI1oBWuBF8/yJ8pbkgAzuQpdNfB7io/mkI40uCxsiz8O5Bcs7JH7lxk5GHp8mlNvLmH78hdIftlaC3KweLfIpEXp1aLCU41O2bR18wvc+aBS4El+WDgrSRcZ8ce57FFscvZ4d8pdyvv5HMzAyLY85VaGm40XgH8M/PI0OPS;20:KxJs5jigyolleyf4pur/SfLK4ARlXI7yqDKzMivDvDstlKn9qdCkbscJP2E3NuIqWwuEwUqi6hgv03eRKfYuRI5kNlWdedLy7cNpcNigmeGbqG80yv6hePPrdKvRxkVOLDF3a2K7MK2v3PJnYqS1dgfUWlkNow4a3tMskAZ/FIE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ec7b493-af18-457b-1167-08d59daf8827
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10634DD52D49D68D87BDD64FFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: OvK5rzBwfTUbyoGQvHULqgPri54gu+bEpxltnU9bisS7M7TAxZYstH2DoVgv+G70/dYzA+A/9sTHmUvRjK2vVR+5cB4XwY8lNjxoM1BG7v8IEr8bvwuKngF/gj9wF0BjSPnYXH/L/5XPwEDbAp/oHLP3nUIzAxL1xm264QCBCs5Q00KMsAhxs6rDDZBkrqBB6gW2oMsI3WUyhySSQzUQJTVH5pxIyFmMdQHfFp8hpCcBwZQ6h0yQi3DPfo/akYMpeEsoRycSQjDAij2d4BjW7/FXFfzGdik01uY8ELfTlB6gCfwcgHOWnQBM/hJDxEt71VA/1HIdwJsRNr+4Ty791wR6xlsY1tzM2qPdidwzBZdeO4dZPxlmZqxLbWuL+M/szDFtZUKHdh0FJSY9wc8nhQeDgc8hLPmnJ92JaWa+sZg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7b493-af18-457b-1167-08d59daf8827
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:00.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 71ff2644e053..d96dc1d17be1 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -243,16 +243,13 @@ static long ib_uverbs_cmd_verbs(struct ib_device *ib_=
dev,
 	size_t ctx_size;
 	uintptr_t data[UVERBS_OPTIMIZE_USING_STACK_SZ / sizeof(uintptr_t)];
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
@@ -305,6 +302,16 @@ static long ib_uverbs_cmd_verbs(struct ib_device *ib_d=
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
 	if (ctx !=3D (void *)data)
 		kfree(ctx);
@@ -341,7 +348,7 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int cm=
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
