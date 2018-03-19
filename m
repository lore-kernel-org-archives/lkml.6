Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475449-2-16035703756869554209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475448; b=jni49hJcQfjysisUVg0rxVqihwUkaGxs4WrAHMyVhsLglqQ
    aQW9bvqu2q1oYsjuVpbF4eYLY0lQe6e3wUZoSV5VoilbEL9C+g/3x/8SnBzN+cum
    9Zh7emK9c6xxKbvvDN6OTPhA7KCCrqElDLr/1ZTco++VPkD4rLMK6Gxer2+BDOoJ
    jztDsVev/l3LXRjlrWY0cFwWhBbOE+l9tkdzaEBi2R2PZ4sHVnHCsrVzA7RdC8NG
    haqINVi0rdLH4+rWJc8d+j/TLURQPCFgETcq3R2Bodl3yvB+k2wp28KV1SV7T1i8
    XYJ5lD7Lr+1V+8fD/H9WBi6qMvF7Q+5pogc+WyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475448; bh=8ILqqq
    0dtG2+FXAZTykxRigSoH7ems/b2zf/xNHpoDk=; b=dYlp5jFr3qvFtsYefpyd4/
    mnLpUIxxUc66ia4BohzqdATjG88hfdlX2BbHk3CS7ksNe5Zm592tQzPgOXfVCEfE
    7t4Cdez29/KFZu5PNR+b/os4homklZ67jpc0leLveFk3b6FFJW68Fx08YgvS5VdD
    KvjDCq5Cm2+ztr0PYuonKT+QlySWRCf88/Fmj16lNpr805ftSOIk/xFS3poWc1Tw
    q0aYqfTUWV13Gr/yagHNKYg95B1PFHK+n3MQegQK8ve5XcFRiNNssG8tT9/C/NvD
    fzoEUj4xMK1O1De/N3IhirnXYY3QXtgYWMLWheExxy6oC4PhcqbMytnlhxPNDRDg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G45A9P8i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduieeinecuvehluhhsthgvrhfuihiivgepjeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G45A9P8i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduieeinecuvehluhhsthgvrhfuihiivgepjeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935049AbeCSQEE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:04 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:46928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965616AbeCSQD6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Raju Rangoju <rajur@chelsio.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 187/281] RDMA/iw_cxgb4: Avoid touch after free
 error in ARP failure handlers
Thread-Topic: [PATCH AUTOSEL for 4.9 187/281] RDMA/iw_cxgb4: Avoid touch after
 free error in ARP failure handlers
Thread-Index: AQHTv5uOvSR7ytkLEESX8jLCRFojzw==
Date: Mon, 19 Mar 2018 16:01:34 +0000
Message-ID: <20180319155742.13731-187-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:5E+remD83GgF/Nqsyg96IpSnJd5WeKmUuHk3QLQQVSza9isJynJKzoymaMXPOf26ZTzWzrol8AwZnjrSmZfLeYgq72olkq2V+mzXafu5ml7+tcXAFwq68OxxuME8Tfl5IAc7tEKsesJaApG9Fds4GBXq2lqOTBjFizCmthTB4EbBmm0IlMFQte9dCd34DU6H4qGGXgpN7YQ84vhiRVCvpDFKpo6IATFzgPnKmaOzF5AP94UtSD7zjzj3lcYk7S37;20:1jF+d05+MZgiHeUrN8BmEI/9pfLq22Vz/LLYFGObesuLXKRQUcQLC39dng2ZlXR9L9xqvS9A9XtKzS1YGS8Z7F6f1VvH95KCfmQHdZrEfLXQtPD35xwr1dhH6V//RPKw6b+ICoIwnyNWRa0y4KXaHi9/KLHZBPC1wIk5r8ESJuI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8c1f229-0ffe-4b0f-059f-08d58db301a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107766A88DD7F5C927DC2DE0FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(575784001)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kh0iboDcN2/UkASjws2VGSup85t+k/i53GLuCVLTiXWqTl8cZI7lNAjGme4ydHUbA9+j5ErAtVdtGw3ly7eoqqyo9SID3w/i0bHE1+l6sORaCuE6iXHVSGrofV5IbHudpRQmAwBd4WjzNiHHqc1a2gTFgmbCM1mr8ZkshOtL6R2Ahx9FygHMqc9zw+qVe3EA1+U02XPceXyuWJhxHxNmtzLLPNJhfXGIcjs+gmjcZxnDpbwrsdLtQy3Lh2uch1gcVBo7U5Lp7rfmQoNU8pwqv6IE/QfBFR3fw8BkdXpScxRhAaeVOmQKBBHYPslJnMIsxwM26lJ/aefYeAdynDsh+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c1f229-0ffe-4b0f-059f-08d58db301a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:34.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Raju Rangoju <rajur@chelsio.com>

[ Upstream commit 1dad0ebeea1cd890b8892523f736916e245b0aef ]

The patch 761e19a504af (RDMA/iw_cxgb4: Handle return value of
c4iw_ofld_send() in abort_arp_failure()) from May 6, 2016
leads to the following static checker warning:
	drivers/infiniband/hw/cxgb4/cm.c:575 abort_arp_failure()
	warn: passing freed memory 'skb'

Also fixes skb leak when l2t resolution fails

Fixes: 761e19a504afa55 (RDMA/iw_cxgb4: Handle return value of
c4iw_ofld_send() in abort_arp_failure())
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4=
/cm.c
index 6512a555f7f8..dd18b74cd01d 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -488,6 +488,7 @@ static int _put_ep_safe(struct c4iw_dev *dev, struct sk=
_buff *skb)
=20
 	ep =3D *((struct c4iw_ep **)(skb->cb + 2 * sizeof(void *)));
 	release_ep_resources(ep);
+	kfree_skb(skb);
 	return 0;
 }
=20
@@ -498,6 +499,7 @@ static int _put_pass_ep_safe(struct c4iw_dev *dev, stru=
ct sk_buff *skb)
 	ep =3D *((struct c4iw_ep **)(skb->cb + 2 * sizeof(void *)));
 	c4iw_put_ep(&ep->parent_ep->com);
 	release_ep_resources(ep);
+	kfree_skb(skb);
 	return 0;
 }
=20
@@ -569,11 +571,13 @@ static void abort_arp_failure(void *handle, struct sk=
_buff *skb)
=20
 	PDBG("%s rdev %p\n", __func__, rdev);
 	req->cmd =3D CPL_ABORT_NO_RST;
+	skb_get(skb);
 	ret =3D c4iw_ofld_send(rdev, skb);
 	if (ret) {
 		__state_set(&ep->com, DEAD);
 		queue_arp_failure_cpl(ep, skb, FAKE_CPL_PUT_EP_SAFE);
-	}
+	} else
+		kfree_skb(skb);
 }
=20
 static int send_flowc(struct c4iw_ep *ep)
--=20
2.14.1
