Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683440-2-15157945789816759394
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
    t=1517683440; b=GFiF2RduNzhkjjaLnyXshmEkT/XlVqX/GGCrNOERRx5EMvA
    DfIgUPRih5elddwYD6UkvNo+E3ogEYRb1N0rU/3BK3BykZilGUXFzgt4MFle0HqZ
    /6J5oSCXGeHk4Ip58ya5SqrYKjf3zZ1M2S0DKcJib77cQa9btW4FyIa1k9RWOJHo
    haD3ekC2O4+uux7c4QmVPUhkW8zDJuDYWp8RM3DNl3YdybZ9j3trws7pslgQ/lKI
    d26rrUBRP8FF8+4rEvMbufSYxPBKIPgUN2iBWN7O6P5jELkuWR6JVBPpsyWW11p2
    b6aknVehhSkWwgr//xDtSkvJY93/lSaQtE+DHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683440; bh=Wfs5I0
    vtMvFMK6MAnOY2yQXM37+EInTVJ7z5rTrUWV0=; b=QxYkIZTFVu6dlU3kiJA2Pr
    EoO1Q8KIpSX4xmkP369Lsfn7fVybvKerL7SYwvMr6I/C4W7iwgD3gOq5RVNwR8uu
    P/ArpKoslXslTPzaBvht5pKAyY+Y0cNcSdP1arXteWWUwNngSYGKetGUFD1NYa+I
    S8cR5WND+tJCRgLvm4SQHUX164HQsBwczZGnzxDMsdheYn7iBp2w+0ZXjfn8LHBT
    HvaFGcATmECq7JFfBkUID04mH/1ShGhpxRIVexnkqzxreydRzs+ULzpTCESJ+nx4
    OxcYb04sqI7drEsR0MfB1Wat1DEGt4u6xkJF+9M6MlF5KAI/kGoV9ZT+Py5M037A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fxBYOunL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fxBYOunL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeBCSnv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:51 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:64103
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753171AbeBCSC5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 099/110] bnxt_en: Fix the 'Invalid VF' id
 check in bnxt_vf_ndo_prep routine.
Thread-Topic: [PATCH AUTOSEL for 4.14 099/110] bnxt_en: Fix the 'Invalid VF'
 id check in bnxt_vf_ndo_prep routine.
Thread-Index: AQHTnRkFcKtB6EvWFkqKwSgXh5d35g==
Date: Sat, 3 Feb 2018 18:01:30 +0000
Message-ID: <20180203180015.29073-99-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:bqZQ+KZA8UZKAtVDD2fiTfNrl4J138wu8iVxUgDc54DmzXg27MghE/bjhVq6bdh5Lupky3TcxYbX+KZgCo4cR9k9vkI+JOYh7nCHT7mqsetYzWuAL4yvLD/IMSmie+kbm5Bg8Pc5wUIYWCtZefkmu6iNOnFCivoMKXSnfNaGFQlYQNQbuJjaQjOSeJQs2LESZzegTBm6lUm6c+bBtdddUlD70YopJNLBFQYMHaWRfoU/Bp8wwhDToBvNXpvK/+SS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f02fa46e-418a-482e-6659-08d56b305707
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09939C02CD99777F21DDE763FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: jNmdYYiQPmfkjb68u1scXcX0HClE+Qg4JUlMt0SknaKa8+1MKWSFDE+CZQoQYydvx/DVyGpC0X4TqAOzu30ikQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02fa46e-418a-482e-6659-08d56b305707
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:30.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>

[ Upstream commit 78f300049335ae81a5cc6b4b232481dc5e1f9d41 ]

In bnxt_vf_ndo_prep (which is called by bnxt_get_vf_config ndo), there is a
check for "Invalid VF id". Currently, the check is done against max_vfs.
However, the user doesn't always create max_vfs. So, the check should be
against the created number of VFs. The number of bnxt_vf_info structures
that are allocated in bnxt_alloc_vf_resources routine is the "number of
requested VFs". So, if an "invalid VF id" falls between the requested
number of VFs and the max_vfs, the driver will be dereferencing an invalid
pointer.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Venkat Devvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_sriov.c
index 5ee18660bc33..c9617675f934 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -70,7 +70,7 @@ static int bnxt_vf_ndo_prep(struct bnxt *bp, int vf_id)
 		netdev_err(bp->dev, "vf ndo called though sriov is disabled\n");
 		return -EINVAL;
 	}
-	if (vf_id >=3D bp->pf.max_vfs) {
+	if (vf_id >=3D bp->pf.active_vfs) {
 		netdev_err(bp->dev, "Invalid VF id %d\n", vf_id);
 		return -EINVAL;
 	}
--=20
2.11.0
