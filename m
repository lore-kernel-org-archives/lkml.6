Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477686-2-2481460571159237418
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
    t=1521477686; b=ezax3eB3iRmqhwKGI3AyY8M4Hcdj57LdNKX91SZDQCVQOSb
    Gs3LpbRVhhYlN+N6qa44FX+VYg8827fv4+PjEOkXSKWGhjnZZCHzTlGPYSewOMG+
    uof6w1TsSApL5WeYwsNt8xGQd7DvyliQW0faniRlo2g35p4OOKDpgf+8CkhXWh+l
    Th5zSLpo7WLOXORJe5T5GLtgnFTkE/usx2uC6pX9wjq3CwhqrXM5m5Zbab16yBrf
    qzbizqshfH8VsQ60o9EcaFms1jXBLvDaGSDFDdvqZuVKUUysXkCuyvKV0KClExQv
    2NDN9wZhvG9ea0yBphWEhzkvVKaE2hd4xdVg2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477686; bh=ej6LWH
    KZ6iMDvYXVuQ9+RkK8ZLYQfcZCmdM6Ln8aDKc=; b=A8ndpLau1tD+frwKEsRgGa
    E7qvJ+HfwRhq2CsK83juhJTsRMfaGNrkupVtofARDEp0rD45oewYQf2b16PXN9+y
    xXj4ll8ddjM0+CKZ43+Ef51sbo3/tkCP2U7tO+b7cNaGEvZ0X72YDwA/cNSof9Yg
    UDW7kZOQxaKrpcBOHo+LSmcd+KSoOBDy9e9pReZRSHc0iG/DcktqCxH/SeskUuL/
    r4Ea9e6eBTn9MVK2XLFoJLrgjzS4n9/mEkO16KxrKJYEuV3QDzFJgiZ/NfLa+5pw
    GvomPSGwwIlKuupIaMpEjE2nrcEIdUrD9R16F3O02xAKoTj6r0yYGzL2wV0i1LeA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m3DtA22y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleelgeejnecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m3DtA22y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleelgeejnecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965090AbeCSQlW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:41:22 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:1938
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966694AbeCSQMz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 043/102] scsi: bnx2fc: fix race condition in
 bnx2fc_get_host_stats()
Thread-Topic: [PATCH AUTOSEL for 3.18 043/102] scsi: bnx2fc: fix race
 condition in bnx2fc_get_host_stats()
Thread-Index: AQHTv50S8RSqwIZeJEGGDDQcF5enUA==
Date: Mon, 19 Mar 2018 16:12:25 +0000
Message-ID: <20180319161117.17833-43-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:xraMRBMd/IZwNNMyUC7aA/N32KU40P732LCrDr0VkIZFUis7jEDgu0GI5qTX+v+pQ1iTErchg1G2j3cIo66mPPzjQwvSd4YZTkItIEtHskX/l6n9UUwupKWiE2m86NHNO2Qvlk6QVuwLnpEZCNX0CDEVuR/bHX2FdzP7boq+mnkGVyrFvTYc1qK/k/1syK/ndGlnvMNJ7sUtnxkyCmPlJ0CKK2eUtKTjvXIg7glfngPOGaHqFkiqQ0PgOEzZSj6T;20:urUrXe2Hjbq3Smtox0P+Kf2g9b7jNmIcNVjGeDA07ltS0xOCTs/O2/P3x99GZuVA+QVU6JI/nIsD5EsHmTmSRYGWrKLGxU4yJPGajL6KFObXnqSz02TYaJtIwkU2/WzHZeroPz5Ko9iOD4I8whvcPYWy8B+6rxb+qUg4L04zioI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 561113af-0420-4464-ecbc-08d58db44489
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048077D4D91AC838C908779FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(3846002)(6116002)(59450400001)(305945005)(6436002)(36756003)(54906003)(110136005)(53936002)(15760500003)(14454004)(97736004)(3660700001)(99286004)(76176011)(22452003)(7736002)(6512007)(316002)(6486002)(186003)(86362001)(2950100002)(6666003)(5250100002)(66066001)(3280700002)(102836004)(107886003)(10090500001)(106356001)(25786009)(6506007)(26005)(8936002)(2906002)(81156014)(81166006)(2900100001)(8676002)(86612001)(2501003)(478600001)(105586002)(1076002)(68736007)(4326008)(72206003)(5660300001)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: X3l4ItccP6BcYR8LRtpgeQK0Zxkn9pmKLGSF1As9E+HyUb4sQgC7BuHhTqxhk4cTg5JdCcPjnnylom6Tl09dWmCs2zvVw3aqpgNif+ydT4VbBkdi6hGB1Eh/yYGAUzFHVzh5g9EheaC4GjMmoDRvA8aVq627dREgOs+U/xI9AUYMZOTFZFsUYN2jbr4yiL19D0iegfAyfg9tiw0s/8zQpzDTL1+MN0lQ0un563HL0BAwGsVaPAFAJGXLxbMTjl9OR+Qep4pLnE8dmcuIwa2UHU9kbAmI8eTYblEuCCq5S4Y7rfpL+FMs1K7JSTTS4yFD2ihSfHwJwjW7EPg+TB+k+g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561113af-0420-4464-ecbc-08d58db44489
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:25.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
index 1346e052e03c..8009158a6639 100644
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
index 72533c58c1f3..2577f8e86be3 100644
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
@@ -1303,6 +1308,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cn=
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
