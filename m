Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245560-2-8099703473818576588
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
    1523245559; b=CFGmnhLkeg3ZUpZC3dyXDYVfvnJk+emHxX99p+CdnHcyksZRLc
    LO3EiuHQpCfCL1bvp2tJ8MaTV5VyjA9ZL1cME5qr4V7krA0yWe1P+TtyJuLadczA
    K0f1DqtSTRH3ZdhuemCMV7m+LJRhsqy17Oc+vun9ZKKMpvbaGtqNZICCiw56n+lH
    YAYTqSPv/ijIkG4lP8h14vRe/oxGNWVKItja+929zO7Yf0vDqzk16Z34wgMJXc/t
    hfC/IK1h+7o0GJwSAXd/U8nh8n4mP+dUh/yuOXn1m0xfOzRleBiJlpGuNz0AyFCF
    YdKR6pKuETgA1bomBqjgOYtmkOLAi7/A1f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245559; bh=C3OkkdqEBP
    BYWs5SlbQmpy0LZuNM6owdElrP9QfhcLY=; b=GxT3UljhmkbQtC5XRTgvEeuF1Z
    izMLS6JfO4kIxcpNUDUcShcXlavcwEOSEgGgZawOhsIxWV7GXTs2WavzYAxskWIb
    EGD1kYPbOLj/j+eKCPSpkL4Vov2jFayr0P2teCqnSHv112EZuSyvXbq58Y8OLVAO
    he7HgRfgv+mH9CYFBYSwF6qD9L/CfGfxyHkScFIymqaAaJ3V9BybPq9MbZaNPf9k
    mhamiuAtw4dHE7zUdZrkC5zIXTKtinw97rzGKQ9pmi4X8zw1poWH9zdLSn4t01w+
    DKppNPnyMhcGF4IZy2W4Y/j2RtHsSxHTqCkXhrMgdv3aDK2/FIzZjcVdboaQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QvTStqEj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QvTStqEj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC1GZoEnB4F093uWUQ2kf2XwDfc4qem2riE0c/KHoyYzZniIOkyulbvKfu0HDe1IXyQ5PnGQlT7LtOoWYavxQWnbpL91znUxeZFoahftk3518r45tXTi
    HBMBh9L9O7Bne2h2LktkQTac1m5riCCpV4yibL2DKMDSoBG+zaj2czTJQZWPsIXFvMlNRjZRsR5zJoAnVveaufvDVysosW//Ixu1Q1W3OuAgGAt5ipwhjG/d
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=gbqrTnXV7oMqAk23AL8A:9 a=A9A517snNMK5BYwJ:21 a=yyLeFuLSMhqlnD7C:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDIDpr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:45:47 -0400
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:44776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754192AbeDIAUQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mitko Haralanov <mitko.haralanov@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 132/189] IB/hfi1: Show fault stats in both TX
 and RX directions
Thread-Topic: [PATCH AUTOSEL for 4.15 132/189] IB/hfi1: Show fault stats in
 both TX and RX directions
Thread-Index: AQHTz5hKSHzMkxi1NEC9czRfjZ6ysQ==
Date: Mon, 9 Apr 2018 00:18:32 +0000
Message-ID: <20180409001637.162453-132-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:ZaRO/ZQVPlvmnEbLwF8GeoHl6usaHBVcBPjlvekq+ZlcjalMMc+YGB2EUpyrHGUbumPlwxdzQtPHn8olwYcm5SUMv9iySpBvbtyUNfROWX5LlxYooQj+7bUZZQQZB1NviV2l4KzOsAaVVf2hptYZ/+wtvaHAoGZX3KmWZr97LT5d7+4f1nhI0shOIuaTJyTvNz8AoU2CqWI++X6zAFHWN45PUI57bkn71ovb/k8QiytkWLOscIRpS/hw60d2dv7R;20:EXKhs/mkBmBvnh6jszXh52l6SO5tbdWHxV09BvBtn5oafbLoFXHQDuQ5sYkVvT3Hk6aatu08JDgkwYXSSZ7qmYxk81/uUuPzEiQ6jb2Q7DvEPijLbmYoqwfTfsvGF6jVK+qveDifSeOT8mQjjay77XNKA/U4qcJ6NpXR8KGoo3o=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 453371bc-dbb8-4a06-88bd-08d59dafa897
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11101BAF6C9435FE612096B0FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(551984002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4nDoExNhK7LAqZs7f1Yskucbr7yYIzHXOhf5CjQdbbQL0GDWuCEnaPvVVwbggM1VLmLpmhMcdUL2vyQ6cFfCJWuYILupfG7bmUsxrZKs+gAaTGlfvpqkcXhk7nBi47TSsDPGMG8tJrpPDhrvUtmIlyQ/SniTstlYBdOs6lXJf+Mri9sZ9ocegOUcxN9LajCYzoDEFWCDWl+xs4i9BZBceeqKvS0rsH49nYjfSVdUILADEctycEx2ZecujJ7u/mAtk++WpYgvoRPN9NJNOm7/mcDcvXg4tNmM7qNrzQEbndFT04OSDlC3ESuMN/ZuEFLinaHxN4XypTbro0St8XcWXg7K8lxEm0E5R3QyT6PsrfNZoepesy5SUA21ohBuWwO4tTPnwhFOX9PiwNGNaZM7zwhWm1CKyS3DWye9EIdt9X4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453371bc-dbb8-4a06-88bd-08d59dafa897
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:32.5818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mitko Haralanov <mitko.haralanov@intel.com>

[ Upstream commit b5de809ef6f6c32cfbbf0da14ed11b0fdc0888f8 ]

The routine which shows the fault stats checks the counters
to determine whether to show any stats based on the number of
transmitted pkts/bytes for a particular opcode.

Unfortunately, it only checked the receive counters. As a result,
if any packet faults have happened for packets egressing the HFI,
those stats would not be shown.

In order to fix this, the routine is amended to also check the
TX counters. With this change the pkt/byte counts are the sum of
both TX and RX counts for the opcode.

Fixes: 1b311f8931cf ("IB/hfi1: Add tx_opcode_stats like the opcode_stats")
Reviewed-by: Don Hiatt <don.hiatt@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mitko Haralanov <mitko.haralanov@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/debugfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/h=
fi1/debugfs.c
index 2e6e0c516041..852173bf05d0 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015-2017 Intel Corporation.
+ * Copyright(c) 2015-2018 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -1201,6 +1201,13 @@ static int _fault_stats_seq_show(struct seq_file *s,=
 void *v)
 		}
 		hfi1_rcd_put(rcd);
 	}
+	for_each_possible_cpu(j) {
+		struct hfi1_opcode_stats_perctx *sp =3D
+			per_cpu_ptr(dd->tx_opstats, j);
+
+		n_packets +=3D sp->stats[i].n_packets;
+		n_bytes +=3D sp->stats[i].n_bytes;
+	}
 	if (!n_packets && !n_bytes)
 		return SEQ_SKIP;
 	if (!ibd->fault_opcode->n_rxfaults[i] &&
--=20
2.15.1
