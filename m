Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497044-2-7455697346085770992
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
    t=1521497043; b=JYhgOtmAZi9N/s6IG6hQsUsJ7eCI83FIl4rbRWffOIEDuy9
    08AfTFoO7QgNX5mib3AWQatE7ulwDc9B/RsCkMbZ+35B9brF1gno49oGiF8lnI2b
    3FYMxB39gpcTEBBDOn7vz+axIp354USIVf1tQqB9ymGFhvn/0IgzC7G66GV4xaun
    2ulrERpm+QUvt/xKWMRdLQU0Li6jrxSyWcYx81DOogaodkceM8Oi5Biv4waht/t9
    nltvAIkjF6o2ALpiqChd/3iiCiXyWOs44o0zMnKiYjv/x3LQ3/P5X0xjwowpFjB7
    wRBtPI2+TCJj2O+sAMi/RjToxBpqTi0+y0J7diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497043; bh=tK1KwV
    KIW0+ZbLxGky99+6QS/T5UcGBXvbhhv0eiCys=; b=KHbsNZqOKWGbtz1pUDXFJL
    jXbOA/IJ5zT+/yixd4ub3tFlRuJq939N6uRGfw7JnJGe1poIzxOsV2MigQSEnf+K
    rZ1lWlJKknc8g2eb0sxX57WLi0m6y3pUbimEfbCHj/1l2a1XW6blIuXzqUqWYsXM
    c/YAu1FUfojSp46i9uEF6U0r0TB4T4QCi4yX2IlDkhOcbvWuqJACfKIYnsWZOGLd
    AhTYzBh3rW9aF2yHKEo1gArMJXuVWlKQ9KjtLIL0ZL/x0KG36C4MJWGxB9E6Ly7S
    vpwktZRks0kdMy1yhDxC32AH99HXx5+w8qtPAJ8OZsE9pWs99fesBhw7zyNPw9jA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OdWh5MWp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddujeejnecuvehluhhsthgvrhfuihiivgepjeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OdWh5MWp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddujeejnecuvehluhhsthgvrhfuihiivgepjeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbeCSWC7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:02:59 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:42976
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934424AbeCSPz4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 47/97] nvme_fcloop: disassocate local port
 structs
Thread-Topic: [PATCH AUTOSEL for 4.14 47/97] nvme_fcloop: disassocate local
 port structs
Thread-Index: AQHTv5qy0OC0Dy3JeU6PD6aGa8xvLA==
Date: Mon, 19 Mar 2018 15:55:26 +0000
Message-ID: <20180319155411.12348-47-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:ETzEvp77de9ff+aPDGgpAxGLPiHdgZON27BIwmop2uG0TzdVKdDLLJPa3UvtQBnhrcz65P6jXW8/YJpLmtitskeBM8X5qhWsNOLhc6NG0+MydfusyeT5YIJvxn5M2VIC7HTba6/swK7meLYdQPpUTeldYSyarmAv+t9NYyZDkDbcjDizS0awpNSHUEWEKUXbFkPb+KkUSUo88khiYgdwGtWYQ1DdLW8R+LvY7DcgvGlbRgoVoynxP0BTSj0QHUR5;20:FOUWD9xZbpLeyrf+RN0BJ064YgqLwQH/ReBcdki56pHMguxlKOAEOJWIZW4OGDYvKFIwIX7TbF6xxAdubWc1EacvzFjZPk+c/IFPbfho0EtpMC+DBtYlQpOrWYzZOCbjdbpdgeByrvPzu6MepLu5/PZwL0U3GCaNHDmVc/lmNp0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5551fd0a-a809-489b-8f72-08d58db1e1e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09671190EEC794BADB7BF7B5FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(39060400002)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DHm5R0gaqOmkqWtM5VR3xSDKnQ/AeVCg70qTbhI3VFw6NUChmZMk374hfVaLNrxsp3oJ6ZxrIJdZ4xxAbhme566GOyWVgfk3H854TXZJhBTOgwLfgJcbBowwQsrMHEJZb+3QCIf5yq81PsAEf0aBGqaK8KMMdMeZFldyBlqSYLBdSfk44BC3yJxC1yQeXyYuRePFK1TmsNG2/QMJERIGd6Sfp5p0ASpMXEVVLRLB2PYFlozWLkIoi6Mzg1+/4981N0e7KPoR9H3gbt6xk9QEBCLnnK6xkLdYYll4AMIYsEdsRIxmnNHVeTUhJVsqrjdSWju6JWX3vMbAqLL+20N/kg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5551fd0a-a809-489b-8f72-08d58db1e1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:26.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 6fda20283e55b9d288cd56822ce39fc8e64f2208 ]

The current fcloop driver gets its lport structure from the private
area co-allocated with the fc_localport. All is fine except the
teardown path, which wants to wait on the completion, which is marked
complete by the delete_localport callback performed after
unregister_localport.  The issue is, the nvme_fc transport frees the
localport structure immediately after delete_localport is called,
meaning the original routine is trying to wait on a complete that
was just freed.

Change such that a lport struct is allocated coincident with the
addition and registration of a localport. The private area of the
localport now contains just a backpointer to the real lport struct.
Now, the completion can be waited for, and after completing, the
new structure can be kfree'd.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/target/fcloop.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 7b75d9de55ab..5b51653ba9fe 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -204,6 +204,10 @@ struct fcloop_lport {
 	struct completion unreg_done;
 };
=20
+struct fcloop_lport_priv {
+	struct fcloop_lport *lport;
+};
+
 struct fcloop_rport {
 	struct nvme_fc_remote_port *remoteport;
 	struct nvmet_fc_target_port *targetport;
@@ -657,7 +661,8 @@ fcloop_nport_get(struct fcloop_nport *nport)
 static void
 fcloop_localport_delete(struct nvme_fc_local_port *localport)
 {
-	struct fcloop_lport *lport =3D localport->private;
+	struct fcloop_lport_priv *lport_priv =3D localport->private;
+	struct fcloop_lport *lport =3D lport_priv->lport;
=20
 	/* release any threads waiting for the unreg to complete */
 	complete(&lport->unreg_done);
@@ -697,7 +702,7 @@ static struct nvme_fc_port_template fctemplate =3D {
 	.max_dif_sgl_segments	=3D FCLOOP_SGL_SEGS,
 	.dma_boundary		=3D FCLOOP_DMABOUND_4G,
 	/* sizes of additional private data for data structures */
-	.local_priv_sz		=3D sizeof(struct fcloop_lport),
+	.local_priv_sz		=3D sizeof(struct fcloop_lport_priv),
 	.remote_priv_sz		=3D sizeof(struct fcloop_rport),
 	.lsrqst_priv_sz		=3D sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	=3D sizeof(struct fcloop_ini_fcpreq),
@@ -728,11 +733,17 @@ fcloop_create_local_port(struct device *dev, struct d=
evice_attribute *attr,
 	struct fcloop_ctrl_options *opts;
 	struct nvme_fc_local_port *localport;
 	struct fcloop_lport *lport;
-	int ret;
+	struct fcloop_lport_priv *lport_priv;
+	unsigned long flags;
+	int ret =3D -ENOMEM;
+
+	lport =3D kzalloc(sizeof(*lport), GFP_KERNEL);
+	if (!lport)
+		return -ENOMEM;
=20
 	opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
-		return -ENOMEM;
+		goto out_free_lport;
=20
 	ret =3D fcloop_parse_options(opts, buf);
 	if (ret)
@@ -752,23 +763,25 @@ fcloop_create_local_port(struct device *dev, struct d=
evice_attribute *attr,
=20
 	ret =3D nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport)=
;
 	if (!ret) {
-		unsigned long flags;
-
 		/* success */
-		lport =3D localport->private;
+		lport_priv =3D localport->private;
+		lport_priv->lport =3D lport;
+
 		lport->localport =3D localport;
 		INIT_LIST_HEAD(&lport->lport_list);
=20
 		spin_lock_irqsave(&fcloop_lock, flags);
 		list_add_tail(&lport->lport_list, &fcloop_lports);
 		spin_unlock_irqrestore(&fcloop_lock, flags);
-
-		/* mark all of the input buffer consumed */
-		ret =3D count;
 	}
=20
 out_free_opts:
 	kfree(opts);
+out_free_lport:
+	/* free only if we're going to fail */
+	if (ret)
+		kfree(lport);
+
 	return ret ? ret : count;
 }
=20
@@ -790,6 +803,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
=20
 	wait_for_completion(&lport->unreg_done);
=20
+	kfree(lport);
+
 	return ret;
 }
=20
--=20
2.14.1
