Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682565-2-11748892071290409476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682564; b=ZdcA0RhVDnResxY66j6riKl2dg+pbEtRgPyBAOtfFfZQDGr
    fswuxl5bNUr828Oi7nIYRwIZ2UCfycHzZT6Q7280tluPHnQqOR8x1OdP9mOnt61e
    YBbcCE/cB/s1Q123bFOeu9jIemQsT3nqsOyANtgEP/9loB/fDyrSYiOia1m6IpdF
    4UenW1tbOecsmhjK9/H8J0I+pS1CWErQmRD07VTRx4ZkGBDJE2iJCv0sHM1bXQWs
    vlgZgwpcsztG9QUECJ3DImA9txi5J+xnIaTgGZMGUiGJWcaEkyOhwwaycoT2/T9s
    avKm+XWZfc5cqwDZbJ/nfptfhNQ9TluN+viSmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682564; bh=FUitby
    jo5ZuEegNwrbZ/5RmNu9Y7vqU+MdlEPdTdvVo=; b=u8TGIkjOVkaGqdhz5vm7pt
    gexQ0qsfYdSqKRxxTXAjhPQV3KmfYdk/V0kWgg/Unh774L0gLhw1rvL9p7VLt3Uw
    Cxt4wCBrqLNbPZIi00fOEOcx620iBnrK8IDDiTDUj5gI4yk+G73mU4w/5L6p7SGA
    N0ORNZDU6094s/TIrR5i/ngDpZMbWDecgUtdNKgsk1QowIAZSYoOJk4nSoLj2K1z
    7zrjMNBJ2McVh2h0j0gBqJ8WTCdG55HZzpC1kS0cbST2fvjxYvxJG8jarP+pyYgS
    dpouh9sI2cP18aoSHD8zlfjmlLV1cJOBpn+GjFKaO9XjRUbqWI8vCvM1IdimtVSQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FW/ve3XO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FW/ve3XO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeBCS3U (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:20 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53867
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753099AbeBCSEa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 091/110] block: drain queue before waiting
 for q_usage_counter becoming zero
Thread-Topic: [PATCH AUTOSEL for 4.14 091/110] block: drain queue before
 waiting for q_usage_counter becoming zero
Thread-Index: AQHTnRkChhBSTWEwt0uC3xE8XzV+4g==
Date: Sat, 3 Feb 2018 18:01:26 +0000
Message-ID: <20180203180015.29073-91-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:fEKefq0ZkgvDXep6Mh0ANFWK/BunUX2AsgPu9Y4d9nhi0p8ZwEA85HkB13ngSMkRoHAAwWqzuA/fHLDltJ0Vb61L7gQLvX0GQFF8l25ex9kghRQ+NW9uOJtHb+diQfuMoIQGWPOMKLdPprjkkY06vOVwUJXAtGSW76t+U9fFYkgBsolLnMeMCr4hgfiA4Trjlqj1mLwVbzIK1Ks8s/6d3RDqhSG75L9Veiw+YNtO1Itx48e2C3uOWz6CSXQkkZVw6KEgMhF6DpppZ4STXTdHtKTSEcoeXYV+P/l75arFAEenpjqPbdDI8rCT6r31lUC9+PtXWT8EYBmwvEo9GWR8gw0PTEQvvtKBWwqd9q5OF9mcm1UbiuFEaz4rr+GsHrEJ;5:GZCeHqFGasXARmfeg6LdyrBmajYVROyxPvqhs+9S/Jw5vfRxCMZbg3YcBShgSvGNBJnv1Z0vEPWEpFDpcLApjOHrs/vz3Tk70bMYSJs3E9Kq6M3LLhg12Yt5WRq62LesYlsMSTF2HDwTM5cAkeQ5k6bNHavcIhZKq94HFnIP+9Y=;24:VgSpCn4pdh9mWoc3Wycao2SJtkt/9HXrPwI1sikDpQbxnE13tqW29RAhHz55GJha3bOr/A63q43XeWw9qLIyQVqw1NhoM6qAe+caACs76n8=;7:nDVgv6FyBP6aY/9hqYjtY7wMo0QZ/QpJ2y57jLGonKEWcELSqWpePmBcdVOGn8awGD0p6P84s5aMR69WEjqo/QUtnZMuTdTfG9hHKgoJMRkae+UQ/r/x+iYCITRu02VZHZyiawawJ3UD0L6SRh42jszW2kudndpVnAwCizuoaSw9eF0wxV2HfrOPWhqn9Gw9Jx4zpmTYxBGbEV4xIsUlzuHHPBmJqj5eEPxtSDEitdfb0IzZ4gicLys6Bw31JKPt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35e06311-0aa6-4d4e-d1f2-08d56b3054a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041D8B433AFDD717272CA83FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(274839183919467)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(8656006)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(966005)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(6306002)(86362001)(6436002)(6486002)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: KW+MrwB/pwajVLL9OPwHoAR4zbHg/jTe0EXNuz+fITMBrmsS+xQ8LIuaNs3jOqxH+L8ak9nzgZ3Ubyl/wxgVPg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e06311-0aa6-4d4e-d1f2-08d56b3054a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:26.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 454be724f6f99cc7e7bbf15067128be9868186c6 ]

Now we track legacy requests with .q_usage_counter in commit 055f6e18e08f
("block: Make q_usage_counter also track legacy requests"), but that
commit never runs and drains legacy queue before waiting for this counter
becoming zero, then IO hang is caused in the test of pulling disk during IO=
.

This patch fixes the issue by draining requests before waiting for
q_usage_counter becoming zero, both Mauricio and chenxiang reported this
issue, and observed that it can be fixed by this patch.

Link: https://marc.info/?l=3Dlinux-block&m=3D151192424731797&w=3D2
Fixes: 055f6e18e08f("block: Make q_usage_counter also track legacy requests=
")
Cc: Wen Xiong <wenxiong@us.ibm.com>
Tested-by: "chenxiang (M)" <chenxiang66@hisilicon.com>
Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-core.c | 9 +++++++--
 block/blk-mq.c   | 2 ++
 block/blk.h      | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7b30bf10b1d4..1aec210405ff 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -531,6 +531,13 @@ static void __blk_drain_queue(struct request_queue *q,=
 bool drain_all)
 	}
 }
=20
+void blk_drain_queue(struct request_queue *q)
+{
+	spin_lock_irq(q->queue_lock);
+	__blk_drain_queue(q, true);
+	spin_unlock_irq(q->queue_lock);
+}
+
 /**
  * blk_queue_bypass_start - enter queue bypass mode
  * @q: queue of interest
@@ -655,8 +662,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 	spin_lock_irq(lock);
-	if (!q->mq_ops)
-		__blk_drain_queue(q, true);
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a18609755e..b60798a30ea2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -159,6 +159,8 @@ void blk_freeze_queue(struct request_queue *q)
 	 * exported to drivers as the only user for unfreeze is blk_mq.
 	 */
 	blk_freeze_queue_start(q);
+	if (!q->mq_ops)
+		blk_drain_queue(q);
 	blk_mq_freeze_queue_wait(q);
 }
=20
diff --git a/block/blk.h b/block/blk.h
index 85be8b232b37..b2c287c2c6a3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -362,4 +362,6 @@ static inline void blk_queue_bounce(struct request_queu=
e *q, struct bio **bio)
 }
 #endif /* CONFIG_BOUNCE */
=20
+extern void blk_drain_queue(struct request_queue *q);
+
 #endif /* BLK_INTERNAL_H */
--=20
2.11.0
