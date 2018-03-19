Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482108-2-13167189574385958153
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
    t=1521482107; b=q/OI41zJrquHP0y+f83eNKZgho1d4QjxvU9ChLSUb21dCzP
    tFRLjylMQYKqzcO+TlpBDFMu0QrTfxtsTpiQA+zTZ5MtRkOdVONYZzOljk6K6kwW
    xRbD4YihgOBzQJ70W0Jm7W9vR8Kz651C2UvkGtys7H0WSYLsVFwpS2570xmewFtg
    fv3OcP6m5SHm5ihEAIaCI32v7fcGhcOHNmowKy2Wu89VeUz0CILMuRF5km8lbU6M
    EaazYjXVsi8QVrc+B+I5Izq0OTQH34d5wgHMCIVcgvs200oT1n09n4QXt3tmHseu
    oACiyRQAM3N1n/MF+2kw/kJkucDUmQlH5/93kIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482107; bh=E42wZY
    bZpQfLl2A1uUD1NSpjJo5vf7FdV2JkTMsQsZ8=; b=e+LmUlhY+40aLycw9JwGkY
    XLALhhk8Fi0XW/ZBx6OrUHns0Odc+vNYQmfV3zv9dcOGxNswdD3NB5R61Yy07uv6
    Y07p/RYaqUopsZIf2tADygyrAa5+6G1G90TbptQt5WkBIaXi1b4fiIExJU40Bs7D
    5pARpmHcNLAKoaqEP053HSB/KRsW76WGXlntnLtuC4Gi3Xk2rqw9Xd7pGXazF6j7
    5eLe+4T7h3aF/eD+szttFgh0sckpudeLiPvWrwmMX5+6AOesk8AIjy0VqE4dqaMl
    ZLT90xCIYGtKAPENMzuysdmLgnMQGjaJGMTjJv+KO439dWDHNOOyaFTNt8tK/c3A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CAcOtTiV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedtieenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CAcOtTiV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedtieenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965696AbeCSRzF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:55:05 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4621
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965695AbeCSQEr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 218/281] nvme: fix hang in remove path
Thread-Topic: [PATCH AUTOSEL for 4.9 218/281] nvme: fix hang in remove path
Thread-Index: AQHTv5ujb50ULWiuFkS+Qf75sd4V+A==
Date: Mon, 19 Mar 2018 16:02:11 +0000
Message-ID: <20180319155742.13731-218-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:SR1ifnutiUwmU4Um5CgOso3rki/YLLJShCXcI1GdZMypCa4v7pphMCd6YqeHPhrXajUZ2g/o8mIhnfoLfbtclZ+VeFalEvJxuLZS9VmwKGKOvEMsKKi4Gh7PMpx4a2ppSb12/J3VhbCUGOQkdJlg4YRSX5bshqllbNlgiqbga9LwyiewtVz0Q8ls890NEYOGFPWnM4oxS6WdAV9hYi4kvdHhKYtExlZfN6knaLq2xxZ1jnRH3207f0LI1u2j0SDX;20:J0rxkcp+OiBF2VACjhZJ+YTKUnPUarM1JFc9ROGgcrsehbKoWcRPN2MjFHfO6LlFOtY63yywJ65OaRIfrcLcbF3E+GL/Uvf/SAkTyCOs6Jr1f8RysebGIT0VyVGZP1j9Q8emEDOe4aTFkm0k4iXCZtaYABljOec7fB6ilfUmgOI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15a162a4-9d54-4125-2f2d-08d58db31dc2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805BFDCFC62C73C7503D189FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(66066001)(22452003)(10290500003)(4326008)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vSUacz2tKbGaYjurRAZyca2TMAvPzZuPuCoWhhzbB1BHL1sHan8YE8gkhnnbR+UCLa5l0feoAM4+k10eUx+wdslPosyzvhxE09o4KSnUFwN4hDNn9pdXR5R4ca7cIJu5s6cygLp97jrSD1XHDuzyIFRKcC3VZ8I1tH9rYCzp1iHdicBGGoPRB5rp68wgHjLKv5OucMlEas2muqIEH89F3WShoHjfE/zowXUKHilsZi8nXO6wMlVwed1M86lbZetE+gNiSgyrv4PBzLg6A5qUMps+86uXqHLOeKCad57ZJ2HgefustCgcB8CcDaWzlLm5pEBBHnV3pq3I3EJevK2BbQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a162a4-9d54-4125-2f2d-08d58db31dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:11.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 82654b6b8ef8b93ee87a97fc562f87f081fc2f91 ]

We need to start admin queues too in nvme_kill_queues()
for avoiding hang in remove path[1].

This patch is very similar with 806f026f9b901eaf(nvme: use
blk_mq_start_hw_queues() in nvme_kill_queues()).

[1] hang stack trace
[<ffffffff813c9716>] blk_execute_rq+0x56/0x80
[<ffffffff815cb6e9>] __nvme_submit_sync_cmd+0x89/0xf0
[<ffffffff815ce7be>] nvme_set_features+0x5e/0x90
[<ffffffff815ce9f6>] nvme_configure_apst+0x166/0x200
[<ffffffff815cef45>] nvme_set_latency_tolerance+0x35/0x50
[<ffffffff8157bd11>] apply_constraint+0xb1/0xc0
[<ffffffff8157cbb4>] dev_pm_qos_constraints_destroy+0xf4/0x1f0
[<ffffffff8157b44a>] dpm_sysfs_remove+0x2a/0x60
[<ffffffff8156d951>] device_del+0x101/0x320
[<ffffffff8156db8a>] device_unregister+0x1a/0x60
[<ffffffff8156dc4c>] device_destroy+0x3c/0x50
[<ffffffff815cd295>] nvme_uninit_ctrl+0x45/0xa0
[<ffffffff815d4858>] nvme_remove+0x78/0x110
[<ffffffff81452b69>] pci_device_remove+0x39/0xb0
[<ffffffff81572935>] device_release_driver_internal+0x155/0x210
[<ffffffff81572a02>] device_release_driver+0x12/0x20
[<ffffffff815d36fb>] nvme_remove_dead_ctrl_work+0x6b/0x70
[<ffffffff810bf3bc>] process_one_work+0x18c/0x3a0
[<ffffffff810bf61e>] worker_thread+0x4e/0x3b0
[<ffffffff810c5ac9>] kthread+0x109/0x140
[<ffffffff8185800c>] ret_from_fork+0x2c/0x40
[<ffffffffffffffff>] 0xffffffffffffffff

Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")
Reported-by: Rakesh Pandit <rakesh@tuxera.com>
Tested-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ad9d82eb2aed..c823e9346389 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2040,6 +2040,10 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
=20
 	mutex_lock(&ctrl->namespaces_mutex);
+
+	/* Forcibly start all queues to avoid having stuck requests */
+	blk_mq_start_hw_queues(ctrl->admin_q);
+
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
--=20
2.14.1
