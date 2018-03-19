Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498382-2-15931639427141655718
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
    t=1521498381; b=CK1czuelRvXzxjNg1TfrK1pYU0DQlCHeU2DvX6V1Y3X6vN8
    9kBy+E93xZWSNb5ORbIn6cBo89jCQxHgrBq+3ObxxTOZiiUaoPfX1NGFzKo9kjHO
    YtYJ46RmGRBGTYtX8op6eJNekd11AbG4+3OFlwL8qK5QL/mrTa5927Y6zsnZKR5d
    Q8H/DoQ6956vBYWEWCowPd7TTmDqvoFpV415z+m3ZpRBRqtZNDbtZnrkil5alKzS
    0+bWdSrPpxMCIE4vu7OwMUpDKZ7mI4QS0+o460rkQBcba6QE9GBRXmjrcyWLQeiw
    aieqMZr9qEWfopKNWlBANA37fYB1FroWWfPQXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498381; bh=oGDDqD
    0frAx5ljHvI0dgTrR5/iwBWns/Bxf52Nmz+Ao=; b=DMxZcsE10PLCqIKeJVN36q
    mKWAEvRjpigOqEM9ICXn+wbMP2MI9V8G7xML/4xRh8jXhjP/eOEoizxHDfd10XvZ
    xph2ZnH3UCr3G12ofGNJM4XOGIofAU2JV+lbdOZ+QXaugZ7VXIBubPDUbSE8WH8I
    I+RgSqfuHUn/OokAgvDoZqxEQHdijA3D/VbaGc/LgHr42qeEKmROqLpMK4DfhklQ
    ku+bgeAyS7e86wRDyJU3TU7b1vmM/TmrMR3ZMGsnJAqi+ZlEBLb11yhJpwu+2NL2
    zNpkCDaiv/rdONdDQYRoHRLpcyq7QqIsnhnbKDZJwJZk5sm+OeaqJQlu/mWL3VBA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B6U4RR4q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddvtdegnecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B6U4RR4q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddvtdegnecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeCSPtC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:49:02 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:38940
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933841AbeCSPsx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 062/124] nvme_fcloop: disassocate local port
 structs
Thread-Topic: [PATCH AUTOSEL for 4.15 062/124] nvme_fcloop: disassocate local
 port structs
Thread-Index: AQHTv5msh2l3On71iE6FWf7DlbD/vw==
Date: Mon, 19 Mar 2018 15:48:06 +0000
Message-ID: <20180319154645.11350-62-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:3rWlzMu6TRRDWvlXiTgH7Jx6k/LL5zkCKtdOTjLVLUJ7jj32eXoXfai9aZ0vt3naZ6vxhOr58dPcG32wOT9JrBF9GXUqa5iIKN7QEbMJCGz3meATP/k/6Rx8jYfDymFeV9uWDtE8KboGbNsjafnWgSnX3ui6okfKd4IfrkPWXiYJz72Ngvvxvy28qCpJpLdkz75SIVOmbUI4vRUm8ByRr0foc/tsPefK66SP1i7024ZeDxiuGxjjQtfEJgbd91qw;20:nPSwjS87ldPiYK/08uUeyxhVFpB3wH+NSJE004dixvoSRMbaEgvchgwcoojLftTtASACsdCntAKyKyi8PB1GIyLHhwDE5Dgqr00+wx/ITm6213ORF3YrMNroF8d/Vqj35dNrfsRLQFxmdspmm1EFSVw/YRK6/S+wNtD6nGZLveQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d42994a-f1c6-4f40-eca3-08d58db0e868
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB0936C7492D3207D9E8C78DC3FBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(39060400002)(59450400001)(99286004)(68736007)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: DyrVJpfKEyqI+77x2M0qhneKL8csL5/JtwpOBWO3CGOJvIPwD13BgpJhOV/RRKS9yYE6FTGs+k40ckbLAZ2uCti0+RmU5g9B0RO5YIGAiHhwUOuyZO1YiC/YDvnQQ2pJQpFsLn+je+MIcAXg2bvcrauHZ1cCtb4IQe8RpieofB8q35Nh859xwF9jabtQS7iNpeE2X6B76840TI1E01a8EJMrl4NPx0/n6UBY/wvCM+v930rB6ISaAjSns4FQLyadk77n3eBmeg0zgXF1C549tbFRPIVg449MxmYn1Jj9fyi5UkLw+lLcBhcaUBCIQUv1Llpwli26wMuAshbp66ToVA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d42994a-f1c6-4f40-eca3-08d58db0e868
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:06.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 6a018a0bd6ce..bedb66521a4a 100644
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
