Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681257-2-11387707021003080306
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
    t=1517681256; b=BVRhUPCsCzAlr3c+gNUn6I9zKMtdjKdsOpyNJjyJgmDxEzQ
    bqttiZWGtj+fhTTlVK+ysSWDIeqOnYjW4xY962r19T+tWgZQlXEK0Dz4YXs3Bym8
    DUR1TMxQG7q2WckyaImFgSy0Gg8tht47y1uguLYEFhDoqPUlk6Th7qGQ4Fle0UXJ
    +jvuuVBjhlRDTWMAezwWmXHgXp0Z1EwAarY4/aR7DcmmRg+ggbYHPNToktiivTfN
    BCIw8GaAOVckb8nwLZTub6LX/0mMLGPUf5uwEgAcIIfvflFL8X6osXczBNhB1kG4
    sA0wsiloLbptFwbO+5Hhk2QFSNCj8QWoPPXkQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681256; bh=vop2D6
    Avi7BmVM4G4Qk9ns7hVlDUMqTweUFwxCv/ZKk=; b=bRd04dmog/tp0WUEkHn0k5
    zlDEaQU0n3rck6rLAb1VQOlc7HD7efdXYD6KVAaADMVA/VSDPvgrMHPZK51WQa8c
    PDUW1aDbbmQmdAtvJgcxmkX3Lc+an7vu+8hbn03gisDVuRB3KakAfEMr7tVb4dDL
    KzFhFPWFfjqrHie5Bj2qvdbwgEsUGpdF3qEwyWsYPSnOECmhGnreOdL3XU+nzf1f
    uRn0CukNDQxgi4H8KNm3qfLTlkl7h3XGZdDiv964LoRsGgDqnAjkHEmnYRQvU/t1
    vSS8Gh/Wqp1zxnrHHokRYO2b4wnodRR6AaAGeTZ48z2CWyfA8gI4KaSMVlcQdxNg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zojct0fd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zojct0fd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeBCSHd (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:33 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753361AbeBCSFM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 02/52] nvme: check hw sectors before setting
 chunk sectors
Thread-Topic: [PATCH AUTOSEL for 4.9 02/52] nvme: check hw sectors before
 setting chunk sectors
Thread-Index: AQHTnRlO+b+Zjf+etEazIzp6zuB9qA==
Date: Sat, 3 Feb 2018 18:03:33 +0000
Message-ID: <20180203180303.8490-2-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:M5rmXMZiOhAK4+tPTJiyFOvq1xpmJoSwR6Y5Evcz7CR01lJ+YQkH0vttJREVIoOZ4Cz/d8NV5OmbtZrEBaLEzC11YsmXG9sb5m8JVQp6DN/Z2kbgAPG+WVFnVri7mtp/Cyh2Y6gDKRW/Xyfn6/qK7rn6pIsQdY6CGMtAomCh6Vm6+KvLZ8FaysMJgztM9Rd++bLAWzPnOci3tC5Vnm+B9Hjs6PGCIrLHLAFBE7P9MJx+++HFdZE3DDadv6WX+8be
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad753776-595c-4367-1ab4-08d56b30709f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993DF60CB98C1F5F4611337FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: KfqL/6vf2LAkR/nHblqM4bc3bGnUxzAyFuSWTZF6zpJxuLIYzBIwJc6EiuoppOXNs2miZy529LQMicAWy9BQ0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad753776-595c-4367-1ab4-08d56b30709f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:33.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 249159c5f15812140fa216f9997d799ac0023a1f ]

Some devices with IDs matching the "stripe" quirk don't actually have
this quirk, and don't have an MDTS value. When MDTS is not set, the
driver sets the max sectors to UINT_MAX, which is not a power of 2,
hitting a BUG_ON from blk_queue_chunk_sectors. This patch skips setting
chunk sectors for such devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 719ee5fb2626..ad9d82eb2aed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1204,7 +1204,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *c=
trl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
+	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ctrl->max_hw_sectors))
 		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
--=20
2.11.0
