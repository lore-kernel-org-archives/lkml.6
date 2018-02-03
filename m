Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680933-2-680107913641186857
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
    t=1517680932; b=HemyCV02u3rnDqZeUAQmvqoCwvXEgAEtqByBoLcxOCaCkRH
    L247j/BethHXfHNPMI6tLGmhfTm50R+QAH/IqWBk5XM6V3JTXJFqGdE9LXP8AX6E
    7d6DdxUy1AuQd210MbODMxQHCmsYdKiK5k/Mx107ty/4XZTW3plxSoaNEE6jeN55
    ZNnlBwUSPXbDHGcg3FUz6wGEK6MURt97pkKHjozGNwExAYi8bWWKT54yteK0hyap
    /oPokcYx2+5xekofdRFumuKyKoSrVjSK1eILKYMjFaizamLt6knqLj2vYy0JuQBJ
    LyUGFIKekIIurECy79R6kcmPjp1JW9zEtgmdRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680932; bh=+60SKa
    iPKgSJRuiD2EvphcHx10mE6W0wWc8Taf/aQ3c=; b=RRHidl2CUDwaJFuSzonjLz
    Kj3I6y4nwt8NJ+T6nZFF12nf0Sj5iQN59p0PCtXzs2iO3LC6qbXy398OEhbsdpFz
    4Qq3yf2rY+rizGa9NukO1G6w/5p3+6P+/GvlUBKurDIo0ht04Rm7yGP3yWZrVcJ3
    usMhAQt9v7d36y0ADQsF3rUO8Lbas2nV4DbjVAVum4aeArzycb/kNAkAGpCiodIC
    WDR1Z9PwQH3K/SCCxZ8ethrTGSmrrWmF1y4YObKXHU/PgZfwhRYFF6rEH5+jZLfU
    5W3s+6m/OBtAzL9M9xqxXy5bgkkfBSiFQ37N22rzevQ2R1HiF/PiaI3A2jdRdO2Q
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N78gnfVQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N78gnfVQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeBCSB5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:57 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752236AbeBCSAk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 009/110] nvme: check hw sectors before
 setting chunk sectors
Thread-Topic: [PATCH AUTOSEL for 4.14 009/110] nvme: check hw sectors before
 setting chunk sectors
Thread-Index: AQHTnRjhVrgVrD2KOk2Hd4UF6pnnSQ==
Date: Sat, 3 Feb 2018 18:00:30 +0000
Message-ID: <20180203180015.29073-9-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:5bgLBDA903h/l2gmpnP4Av85O5vNi+jq8e3dtHc3DpsxV4UZHaSagMnBR8whW0ePnOq2KY7c2OsWWiSY8de94xaSFoDKD09dWHtzBq+o0EiyADO6Qus8igQ5R1S4SJyVg50jNB1dSREDYMcKmZat4kuqHW+VJMOrZtfbW97ANf/1Qu/eYom63LWxn5joLZoJ3ld1YiNAYDJeLTHaorJya74juOlVL4I5kmLtQzr5O88DDD3pALrHcQ0Ugb4t3O59
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d2fa894-1e65-47fa-cb84-08d56b3004fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043C86291477223812CB571FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: reWFLhv1nzJeP6evGmsRFV4FnMuod7JBJUIxWTDI7AHvr/j/EBwnkNhI03Tu2VEBXMyDYrzzjB6rmCeX/Z6YgQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2fa894-1e65-47fa-cb84-08d56b3004fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:30.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
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
index 0655f45643d9..dd956311a85a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1515,7 +1515,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *c=
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
