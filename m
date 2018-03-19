Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498525-2-1915872443335997128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498524; b=ShBHPBWG+MOsCy50jlcu1s/04JY71InN/PG9zIwIdEpTuVZ
    9gaf90ff4b9sxPGD3jQcXsULOgYlWxCmtlSEL6ZcTyo7qaJ6RrxBkFOMmAdlMgA1
    T/5bvgFXZnGgwmI2IxDmxxEzeQRbiln7WKN6V5g1N1rpsspsxdvf50kloSTt3+1D
    DJ/R7YX/Qccs22rfjsxzfoIIxyl27VwR7tQoMZDBSzGBH6ctT4zPwcuGOqbRj+k3
    11IxzFjRe3YRVCPCJVSuS3FXuCaUChxuP0AradYidOamRrhbmmHMNw9FkMw/yC6P
    9rT10BXv928VCcqzamq+9//+EFVPw8l6e1XwDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498524; bh=Z3szX5
    84mF1VZpcfqNgs6AmuQPDbq8jNLY7rcf8mQrE=; b=oqDWxpCTIwaSWotvwtQFjh
    Utcjon1tDmxaCO2vj+JknqEMm7NRcI/+n/P5rcthO33U4Jxl44GVlUL1JSvnLnYh
    592AtRpTurDSS4LC9g/OgwQVRpB61d29bUEIMhsNFVaVOHSmVR5VhkZNBcFuRoXE
    k+ZaKWCShrJL4g8upMJKhI4Z8PIjJPwVcOweOU/QRygAKD1xpQ31nVM/E7JqTzVj
    ZpjD57LvT3PSQ2GV9hLKDxiC2eDO6XxzwtaJ4Q08e3Lz4CBD8lkQs97+HVLMttfZ
    KsWq65QXRc9Zg8KPT66RhPLwCKNDwtwUWT7pC/2II2wnsub9uC+l/D+Q//nCozcQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UtOtrCn+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudduleefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UtOtrCn+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudduleefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933846AbeCSW1v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:27:51 -0400
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:31072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933831AbeCSPsv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roy Shterman <roys@lightbitslabs.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 060/124] nvme-fabrics: protect against module
 unload during create_ctrl
Thread-Topic: [PATCH AUTOSEL for 4.15 060/124] nvme-fabrics: protect against
 module unload during create_ctrl
Thread-Index: AQHTv5mqPHPJljbAdk6oTIOCLRHJoQ==
Date: Mon, 19 Mar 2018 15:48:04 +0000
Message-ID: <20180319154645.11350-60-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:cbNzlaLhTfAzQoZV1bOSApC3HjuKYZL3WXmIY5Z9cxOHgg3JbNX258GwcScB+qn705lQLi+mizCOOaG85bN8ujgqgWwGpikkT5ArOH8bbp/25eJobWkdpqf0U4ZQDL5ZBy8rojVNfKa3J2I3e9P6Fth68jpwE5UhngSKuxtiBbNzlr6n80ly7RFOSuAdp19DEreS604p8tQ5BnyPgQubFyVSJCcZd8QcYOxV85zx+HBFw06YTkR2d5QrT4NK7F2D;20:N+JoaLttOGr10+0aedR9dpBYRgXh6eTi+xuxDlbcSH2Fznxa7GccxDz4TuEU/4b8mBFhOUbTYJxmhTt+uZoP544ge3OiJRHjJHyuuOQchUopubpgvbdWzW3LhOd2pGsCYEAcCRdmdj8D1rrpzSn7nrOU40aHJvIs92De4sDpEYE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 273f4a68-6ca0-4950-f2f0-08d58db0d5e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031D753CD638601B56EE4C1FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(575784001)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: CBpFQheDuqQbWHCWcYc8wNfxsaSdrXC6HX/9v6YdHfpJ9ftv7QZ4k/32FYaw151A05T0mCPfNTfskYc0NPhc/6k/sBtdG+8N794UEU/uO8t8KXXB9AlZVr7gTp7w67yfr8eKS2v1nk58hpzdb9G4waHObfz1cZV4jkkBxRhHBueXRacrc1dnVl4kJqWpBUBa1Og+Nta2/kTyGQ/pjVCENDmKa4F8csEuVJFNm4Zg7obTe/954YMp6nMR6fyG0NkxzvTCLLlBxlbILgm+LlJZvI+9rp4Aq2yiWchphKXPA2H9Yk8rJjFgIH45rEXuUo/geSHktY4fE+LhEKCNT3TW+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f4a68-6ca0-4950-f2f0-08d58db0d5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:04.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roy Shterman <roys@lightbitslabs.com>

[ Upstream commit 0de5cd367c6aa2a31a1c931628f778f79f8ef22e ]

NVMe transport driver module unload may (and usually does) trigger
iteration over the active controllers and delete them all (sometimes
under a mutex).  However, a controller can be created concurrently with
module unload which can lead to leakage of resources (most important char
device node leakage) in case the controller creation occured after the
unload delete and drain sequence.  To protect against this, we take a
module reference to guarantee that the nvme transport driver is not
unloaded while creating a controller.

Signed-off-by: Roy Shterman <roys@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/fabrics.c | 17 +++++++++++++----
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/target/loop.c  |  1 +
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 894c2ccb3891..4037fbf6457c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
  */
 int nvmf_register_transport(struct nvmf_transport_ops *ops)
 {
-	if (!ops->create_ctrl)
+	if (!ops->create_ctrl || !ops->module)
 		return -EINVAL;
=20
 	down_write(&nvmf_transports_rwsem);
@@ -869,32 +869,41 @@ nvmf_create_ctrl(struct device *dev, const char *buf,=
 size_t count)
 		goto out_unlock;
 	}
=20
+	if (!try_module_get(ops->module)) {
+		ret =3D -EBUSY;
+		goto out_unlock;
+	}
+
 	ret =3D nvmf_check_required_opts(opts, ops->required_opts);
 	if (ret)
-		goto out_unlock;
+		goto out_module_put;
 	ret =3D nvmf_check_allowed_opts(opts, NVMF_ALLOWED_OPTS |
 				ops->allowed_opts | ops->required_opts);
 	if (ret)
-		goto out_unlock;
+		goto out_module_put;
=20
 	ctrl =3D ops->create_ctrl(dev, opts);
 	if (IS_ERR(ctrl)) {
 		ret =3D PTR_ERR(ctrl);
-		goto out_unlock;
+		goto out_module_put;
 	}
=20
 	if (strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
 		dev_warn(ctrl->device,
 			"controller returned incorrect NQN: \"%s\".\n",
 			ctrl->subsys->subnqn);
+		module_put(ops->module);
 		up_read(&nvmf_transports_rwsem);
 		nvme_delete_ctrl_sync(ctrl);
 		return ERR_PTR(-EINVAL);
 	}
=20
+	module_put(ops->module);
 	up_read(&nvmf_transports_rwsem);
 	return ctrl;
=20
+out_module_put:
+	module_put(ops->module);
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 9ba614953607..25b19f722f5b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -108,6 +108,7 @@ struct nvmf_ctrl_options {
  *			       fabric implementation of NVMe fabrics.
  * @entry:		Used by the fabrics library to add the new
  *			registration entry to its linked-list internal tree.
+ * @module:             Transport module reference
  * @name:		Name of the NVMe fabric driver implementation.
  * @required_opts:	sysfs command-line options that must be specified
  *			when adding a new NVMe controller.
@@ -126,6 +127,7 @@ struct nvmf_ctrl_options {
  */
 struct nvmf_transport_ops {
 	struct list_head	entry;
+	struct module		*module;
 	const char		*name;
 	int			required_opts;
 	int			allowed_opts;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 794e66e4aa20..306aee47c8ce 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3380,6 +3380,7 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_c=
trl_options *opts)
=20
 static struct nvmf_transport_ops nvme_fc_transport =3D {
 	.name		=3D "fc",
+	.module		=3D THIS_MODULE,
 	.required_opts	=3D NVMF_OPT_TRADDR | NVMF_OPT_HOST_TRADDR,
 	.allowed_opts	=3D NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO,
 	.create_ctrl	=3D nvme_fc_create_ctrl,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a0bba7f50cf..d49b1e74f304 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2018,6 +2018,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct=
 device *dev,
=20
 static struct nvmf_transport_ops nvme_rdma_transport =3D {
 	.name		=3D "rdma",
+	.module		=3D THIS_MODULE,
 	.required_opts	=3D NVMF_OPT_TRADDR,
 	.allowed_opts	=3D NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1e21b286f299..fdfcc961029f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -686,6 +686,7 @@ static struct nvmet_fabrics_ops nvme_loop_ops =3D {
=20
 static struct nvmf_transport_ops nvme_loop_transport =3D {
 	.name		=3D "loop",
+	.module		=3D THIS_MODULE,
 	.create_ctrl	=3D nvme_loop_create_ctrl,
 };
=20
--=20
2.14.1
