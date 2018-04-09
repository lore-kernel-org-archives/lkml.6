Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242121-2-3008640942248890304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242120; b=GowQhFRCaKzgXKqs2b6XWH0HGWhO14BfRnIsTVGda3eUNGG1A2
    SEinoj2SB2GD8C1/hqXygIIAATx6P0DdUzV0TxedyZCMAEDo3JymlFbDCzzfmaFu
    D9WSEFZ01vUwkEJvz2zXEvl+c3CbKlqfieFf1DHhEZ/BG1vObCIqryw7WVHJa/o1
    cfrqT+dWEVZUxhm85Kii+iyBBGLOXbWKEnTrm/Sa4yKVzl62TBB8+fesUNwXZHtL
    VUirrzLjR2tFW1gAoHxWG3QfV9ClZyYRMAnDQwEhrvXvKaynXrGE/8P1y5le5hjA
    tIzTk1MMNmhe2OeKoMmG1eiJbnKUmH0XxB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242120; bh=5o0Gp6KZ9T
    f4Xv71SgvCYFonaw8IFtVXXltacFtbIO8=; b=u+asyDzAal38gv8xEmhoLsMGsT
    XH2REC9rsf5xYCVwWNmDGpg/rYXl2lfxGLYFIyvFqZC3XwhJhd28AIAikSYMy9WU
    zxTszXFy0QM1HgaRRPgiu2lfQHreTddAljIjFVcFtUkAgKOh4dS72nKihqjCVpGk
    LNSvwTfIWMgQRp9OIsXmUEWMTNeukPdusltYW6rJwphdxqXi+QqrpLuuD8UFMyQV
    XCq1bnYAQa/NcICMta/AUGeXhDqIjbFBEEV739uglIXqGaKnW4+kfauHPwI/mgVH
    U5lCK6ujCfQenljm2MowzVV5mCsuXS7wSII7pr2d2O4ELZ6Zh6ElntphNrgA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XXU7XjST x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XXU7XjST x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB3T6sysjK4cBgm+zztZWx3001Agc7fB0Jw11JkJjuzzwIWmgNANfBxQay0uuURI9osdwJHY8MRYJyASqty/M7EHH1lAkJmo0JOzB1B0ufPxB9FVK38Y
    qA6BI/ccH0PtQIRTZv8yQXqZ5D1/4BQuW7WBK4V4o3NLNCcAeyuBD/iGzMDKjt3Hv6no4rY/sTbwWrkrX8t6RqKC5mFTY4Gi4RDvJqzlTHLv5Gd3CMdyedSS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=3DfWnJiXAAAA:8 a=yMhMjlubAAAA:8
    a=c5t9UXjes9Jb_MSDGH8A:9 a=wPNLvfGTeEIA:10 a=fbZbCd7XTi_oNd1tYRxB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeDICsg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:48:36 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755379AbeDIA0h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 003/293] nvme: fix hang in remove path
Thread-Topic: [PATCH AUTOSEL for 4.9 003/293] nvme: fix hang in remove path
Thread-Index: AQHTz5jjezob4o4mckaPt/N5DpmfrA==
Date: Mon, 9 Apr 2018 00:22:48 +0000
Message-ID: <20180409002239.163177-3-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:XqTYrOV60+xVy9+SnWwL2b4uejmPuozti93+uXBC2hhC3afX5VrDXhB1431gPSrR+8WMDFkrgDwtB5a+Qq735vixOFxGatjHPjxFIun1UR64SJWSgdUAn4Bd03GHzoavuE8CdSFloINpn4vjEfeY7V//CntHclq07QHSkVvqf02moDSZt3OYqHqpk2UXhCmGkVZDExolSq5sDSjCrvAs9IjIVmEIq2Q/LCqD+hz649m2ROGHu7P2McLH5vw80a5n;20:Jxg7tt9heu7PjiDF7r8v8GC+W2TYzr34ItrG0KCCi8tbnGBTOiBm+5IbfuneiKirjFbYj5rUKIbrgISVk6981vIQyje0wBga4sYpt7zW5Yd9iXjn4f4rgWMv37FWNazkwQaCYVw66OK+s1mhN9tKWHtlp5nCVi+6uqQwZPV4r2k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ddef4b9-918f-47a2-54ad-08d59db08a9d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015EFE63E532FF89A5CB581FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: smxqBU1s3ce8BIulyWnsOLeA/f3BG/A4JSQLs7Sgnw44Aur+FX9x23t4GqeEpxgCW/+/4AMlq8ZD5mpzAEoQTuzp0KHioDIN+30K45RDXH6od+VSjAI9cq+X0VGTG1h8lGwBoGDeyMwLuNrDj7Iwg2CCrj39odaSlH4+oFhnkIyYlnEo+tj6DYISEMVUc9JRTZlAS5UJwFz5I+shbkPRZ98U/lgJnO6TZdIJYM6c/+K3xdCmPDk7yLOBeOB50vaBvaYQJb25AeNNNgCU7bzofkcmGAgkxF5wRzRwjSwrdU+EPyPrtkNOE77jEBGq/r17oR0Uu46JcwdKRLeB6iEgsaxU9UqURBFY5GRaUo9AE5+FAjW94JBeK55UqZDC/tPTNH96n2uipBbtDdc1yfh355czHMa/Iaza/0T56Gyckdk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddef4b9-918f-47a2-54ad-08d59db08a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:48.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
2.15.1
