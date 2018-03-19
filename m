Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479929-2-18318381720472652673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479928; b=mAX+VmT2k9lXMvH89h03KhQmr9rzKLMdGDWQA9yugwmEROv
    iKpCfjOcQ2xMuH4BTSlsb/B2WLIJmqzEttNJLtv9VLu/VkWnQ7LtfWbRasRJ7PhB
    uTGrAcUkMoPgKoATALhu12cYOC5w4vewmylbJlBVPm6xzI49kNb5psBzZlRJux9j
    mkJ7ZUGO9knvmAZgCA/4wfzh83+AHmtmImHF5Af0fWL+JlhQz1qOYEpTWWFUpTUI
    l84FE3SBH7FM5x7jRsTHJPJEZmXUbK+sQYIgUcjcTqeGrAf2GIDsctSOI9oBK8+D
    oLrvW7Jq82LiWg9Pjv9gbEPB4yiUP1Q5hLkRnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479928; bh=+Hod+9
    e3U3wkKTsnqHhTWMe7Em3H7DttXOoufNgPiqc=; b=aIIhxKJC9QYtPIKjCdHCkq
    40/+YjtV+eIN5vd0OBBTKI8lf/5m5SvCU1DmIxwFNpVMFIDtIBsKX2/46/Hqpg6Q
    jKykQxVtmwMVmFFhuMzDTIguO2qpMxrmQTwo7oueXBeJUQ3MgYjCUar9l1G67Vgw
    gh1WZiDxohL0ynlr71mCgGggnzU71z2DDz032HJR4wDwfaLgFxlj3j5Xzm0lJIG9
    fOPwMGtDFBjILlSpDF9J9JO+oOS0Le017KV75X6YTaVIbrPpVI0RQbtnIHzsuCMw
    8hvHWxyEKA5jJOx6mPbMGXvoslOhN9HrM5ZsJjVDKn+v79OBYY/1DfdBSIhAl0OA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WyKqSeAB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelleehheenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WyKqSeAB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelleehheenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966483AbeCSQJf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:35 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:46817
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966416AbeCSQJL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 073/167] scsi: bnx2fc: fix race condition in
 bnx2fc_get_host_stats()
Thread-Topic: [PATCH AUTOSEL for 4.4 073/167] scsi: bnx2fc: fix race condition
 in bnx2fc_get_host_stats()
Thread-Index: AQHTv5xMwQ/L5Hzfc0GLBZd/nd2Syg==
Date: Mon, 19 Mar 2018 16:06:53 +0000
Message-ID: <20180319160513.16384-73-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:6rX1D+mf1QLGbrklqnF6BwMPTo8R6xMnGNyqWWhyhJn/LnX9BSBIqAx9Vb8J+M+P7fetgtI8UaG16mSUd1tRPKj8g/260zwsd55cxV4MECPsNn1kT77d6fRVHmhWxEPK/3ZsOtbevFNUD4WQbDOZl1onjmO7/Hj9f5vWNFvlKvrJKSchsam6w+JNZy/RqfgHGEbRMSdzyV+IcByfGy+ux6C74el4ZhAaih/s+i0DnffN/wbIgWlUy3rrsB+gIxON;20:mGvJZr8CBNDdY4jsxUduQwUUnExYzP/yLg8gn3Bgco9QcuBWGrt4A0hOQlZneHxp68VP224v2iTy/WdbobvhseCgXSA+6tf25P/SU+TsHdjtl8oXfXVYdKICqbwUz6tKY/3Mp/PYT+qRI+ztAK4i/tOeNFYkghEx/dC5Nn8QM5M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e434268e-634b-4f9d-179e-08d58db3ba13
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09650E264C43762BA6708593FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(15760500003)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iJCIY4Ac5IkBa2LihQ2mTHcqelgRPBmD/pYNlkkxoUgF3kfb6zEuvbSEoo6zlar89rhaXR8o+d0LXSOw/X4N0ZcJGvXN5+TGKjQO+L9yKbNWlLwFD1XTg9XZPqCPF7rIYkv5/jzP19MhSqkZzaN52dQjbO1bpKbuoCy0GBKfxCSj73ZooGVwWXPZbZs5HT8NpI9MaeVYPJBbbsJZWx8tWcxjCo0E0y+Tw9IWmOeQAJ/XyOQ4EBIKBmjHywZzYrdkh2dlOASDG5WUrqZOrnB96WzCN22J1vCNqC9/Vk5GML/9ydxRgutPBUjU6wbMw7W9b55frXRgwnniE/SM83J16Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e434268e-634b-4f9d-179e-08d58db3ba13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:53.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit c2dd893a3b0772d1c680e109b9d5715d7f73022b ]

If multiple tasks attempt to read the stats, it may happen that the
start_req_done completion is re-initialized while still being used by
another task, causing a list corruption.

This patch fixes the bug by adding a mutex to serialize the calls to
bnx2fc_get_host_stats().

WARNING: at lib/list_debug.c:48 list_del+0x6e/0xa0() (Not tainted)
Hardware name: PowerEdge R820
list_del corruption. prev->next should be ffff882035627d90, but was ffff884=
069541588

Pid: 40267, comm: perl Not tainted 2.6.32-642.3.1.el6.x86_64 #1
Call Trace:
 [<ffffffff8107c691>] ? warn_slowpath_common+0x91/0xe0
 [<ffffffff8107c796>] ? warn_slowpath_fmt+0x46/0x60
 [<ffffffff812ad16e>] ? list_del+0x6e/0xa0
 [<ffffffff81547eed>] ? wait_for_common+0x14d/0x180
 [<ffffffff8106c4a0>] ? default_wake_function+0x0/0x20
 [<ffffffff81547fd3>] ? wait_for_completion_timeout+0x13/0x20
 [<ffffffffa05410b1>] ? bnx2fc_get_host_stats+0xa1/0x280 [bnx2fc]
 [<ffffffffa04cf630>] ? fc_stat_show+0x90/0xc0 [scsi_transport_fc]
 [<ffffffffa04cf8b6>] ? show_fcstat_tx_frames+0x16/0x20 [scsi_transport_fc]
 [<ffffffff8137c647>] ? dev_attr_show+0x27/0x50
 [<ffffffff8113b9be>] ? __get_free_pages+0xe/0x50
 [<ffffffff812170e1>] ? sysfs_read_file+0x111/0x200
 [<ffffffff8119a305>] ? vfs_read+0xb5/0x1a0
 [<ffffffff8119b0b6>] ? fget_light_pos+0x16/0x50
 [<ffffffff8119a651>] ? sys_read+0x51/0xb0
 [<ffffffff810ee1fe>] ? __audit_syscall_exit+0x25e/0x290
 [<ffffffff8100b0d2>] ? system_call_fastpath+0x16/0x1b

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Acked-by: Chad Dupuis <chad.dupuis@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/bnx2fc/bnx2fc.h      |  1 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc.h b/drivers/scsi/bnx2fc/bnx2fc.h
index 499e369eabf0..8bc1625337f6 100644
--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -191,6 +191,7 @@ struct bnx2fc_hba {
 	struct bnx2fc_cmd_mgr *cmd_mgr;
 	spinlock_t hba_lock;
 	struct mutex hba_mutex;
+	struct mutex hba_stats_mutex;
 	unsigned long adapter_state;
 		#define ADAPTER_STATE_UP		0
 		#define ADAPTER_STATE_GOING_DOWN	1
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc=
_fcoe.c
index 67405c628864..d0b227ffbd5f 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -641,15 +641,17 @@ static struct fc_host_statistics *bnx2fc_get_host_sta=
ts(struct Scsi_Host *shost)
 	if (!fw_stats)
 		return NULL;
=20
+	mutex_lock(&hba->hba_stats_mutex);
+
 	bnx2fc_stats =3D fc_get_host_stats(shost);
=20
 	init_completion(&hba->stat_req_done);
 	if (bnx2fc_send_stat_req(hba))
-		return bnx2fc_stats;
+		goto unlock_stats_mutex;
 	rc =3D wait_for_completion_timeout(&hba->stat_req_done, (2 * HZ));
 	if (!rc) {
 		BNX2FC_HBA_DBG(lport, "FW stat req timed out\n");
-		return bnx2fc_stats;
+		goto unlock_stats_mutex;
 	}
 	BNX2FC_STATS(hba, rx_stat2, fc_crc_cnt);
 	bnx2fc_stats->invalid_crc_count +=3D hba->bfw_stats.fc_crc_cnt;
@@ -671,6 +673,9 @@ static struct fc_host_statistics *bnx2fc_get_host_stats=
(struct Scsi_Host *shost)
=20
 	memcpy(&hba->prev_stats, hba->stats_buffer,
 	       sizeof(struct fcoe_statistics_params));
+
+unlock_stats_mutex:
+	mutex_unlock(&hba->hba_stats_mutex);
 	return bnx2fc_stats;
 }
=20
@@ -1302,6 +1307,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cn=
ic_dev *cnic)
 	}
 	spin_lock_init(&hba->hba_lock);
 	mutex_init(&hba->hba_mutex);
+	mutex_init(&hba->hba_stats_mutex);
=20
 	hba->cnic =3D cnic;
=20
--=20
2.14.1
