Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235518-2-16008292014470055184
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235518; b=A3aJXmbwriWfl1iQ8UqYpBHJw+51zBFajP/TsskwlCKrWIIMwy
    Jol96TvogPmc83A//i21jTzVzArZR5Z8eGg/J/0Q7al6+JwkJDIU7B4ZeClufXP5
    Zdf9ypEfDuC6YJMEOHyfFIGIuviiSt5Ax5XdUW1qhXDbRyAIjLO89LcNgkSMWmTq
    oI6RosYAX3uQce/iDX8ExQ7214QiIMLTW725omB/vU9LAXhJcAz5kZ1rcNTIrX+X
    ziJ6ygML4b7lepK8tmtccsSLwu25gr8Ia/UmzxyB+TDcGad729DBAPHoRHjkmoTH
    eQdiKmtx2ERj6sKeRn4pP8ubvMn/B3Yw2KVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235518; bh=0sC/odL2A3
    +6r9AlWl4xbP2NMwFGyAzb+oVNHg4WEX4=; b=pyJI8bMn1+zWu4evIubpCo89dK
    6WB3YZSXG6NGUdzrOlWbuqIcjxdNbgmic4alMCrtnEMPVMXtrzGBOdAiBeYw20ec
    3jiPIMAyN/0wxTqhs9h8upbjQGbD2ol5+gBSI80oc4ZeHgtmggDpRAEMoCrsbK9I
    ZuAT8+4T6K8HBfiOXql9v1QE+z4TN8c/1M8zkM3Ow/aODXDY79S/CkgpMx6MfHEj
    XV+kClcrUT6GAQmfg5plHJ06a89u+IRlIbiyjLYXBCYvk6qM+dX1ZB0hGpqkX61r
    +SlokOWMDimXg2Bzm4daA7h+6CvnG+xpSrzXwLbhCJtt0lV+W1bc6mXThfsA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cHvq5FMd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cHvq5FMd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMYJfxMA1yUSacT+UaFeKSPLkd7thJW4yMlL9C+Z/f41ReFK94vbo3Cvxl1KMv4jN+LRDvgfB1ir157tsInhUHZzbgRxcjwSWUnMClQTrB3LTBlaKzOC
    OliPJkIghtRL7XJbqusgzbKIHNvS6i/Y9sziReBIzDbaZ+Dz0mxY0Ru2OQIgs4IrwNQc1KxIJkLHG1t/xRZgzE1dg9o5xuxpMrxng8Q3L1PPFb+WDWqb/xiD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=dq2cNPrMAAAA:8 a=yMhMjlubAAAA:8
    a=zz7Vc1meF-ew3THYyscA:9 a=wPNLvfGTeEIA:10 a=UrzWRhJOTTn3oDX10iyi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeDIAjr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:47 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933203AbeDIAjp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 029/101] ixgbe: avoid permanent lock of
 *_PTP_TX_IN_PROGRESS
Thread-Topic: [PATCH AUTOSEL for 3.18 029/101] ixgbe: avoid permanent lock of
 *_PTP_TX_IN_PROGRESS
Thread-Index: AQHTz5quCu44Nvf2ikuZD9ND8YyVtA==
Date: Mon, 9 Apr 2018 00:35:38 +0000
Message-ID: <20180409003505.164715-29-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:DYTL6QnXth++BVfXKX2uFo8JCzVAdso/sADGbkD8fskcqpDMUvgEmIVBQ9RuFdWQNMeIS6cXMYFDCBABeCtSTwhTCkg4YVGG66NEI19zdE9qpLevQdwArx7P7CAfaUyTLkcGraZJ0FsmjcQqAMRkx4JSjyx34bmZy7x6+s+7ObdKC9DVblJGRvqYBQppE5BHn1/lgUyekgDUCiOXp5elNx9pgvw2JG5FcT02kolf2tMBnifzC2cwTV173Lf0A7di;20:ZxKB+GlvXOPTyigkB0AHG9s1d+nf6zwpfQG/ZBBFkqp3DfM6vXEujdoN6xk7SYA+4FlFBEnhr/LxpPXuWWxIhHzaG2al8+FPcrgKv1DZ0E2ZVtDobYkrFn3J3l4VBBcqEedXaNDTI++lFZ5wQX06C0zGx5EqQM4iTo/FBfUt8WM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2323ea7d-4bce-4c57-9b2e-08d59db2630b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966A326768EA24ACF400CFCFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: O71vsFuBYxLTXG6tytedbJYZzSE7MK4nt0wcHs4ikofGX4qsGVkIVrRQxTIXTgyz8CzBK6NVk/WiFrEa6SXvPUXWLANnmVHzDAsCE9IBlTIFvYFkngLJ2+1E05tW2QrE90STMJMkrml4NXyO97EQS8REbZp7dI0KAMgZSnIAKsoB/yg7dvVpe7kYII8TFAmQQqR5UlLwar/7dSx1IbjsL5lC6dS6hyulMJSm5Qrz5//JNj23osaappBzfgYaW6hnKe5p5j5rpBXX5tnfMoY1ry0gScEwmXXFd0Pm6tSCECAvvU3Ln18U6OioKRdx+K8NYnk8G0ZomlonxVq4MBWhM6fgS/k2azp4O/1MMsrAezdLuCoOWgeam8oqw/B6OzbRJDc7xtrmX/TdlfrP14ozhKYOr+xOeC6PUAKA4AbFD3Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323ea7d-4bce-4c57-9b2e-08d59db2630b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:38.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 5fef124d9c75942dc5c2445a3faa8ad37cbf4c82 ]

The ixgbe driver uses a state bit lock to avoid handling more than one Tx
timestamp request at once. This is required because hardware is limited
to a single set of registers for Tx timestamps.

The state bit lock is not properly cleaned up during
ixgbe_xmit_frame_ring() if the transmit fails such as due to DMA or TSO
failure. In some hardware this results in blocking timestamps until the
service task times out. In other hardware this results in a permanent
lock of the timestamp bit because we never receive an interrupt
indicating the timestamp occurred, since indeed the packet was never
transmitted.

Fix this by checking for DMA and TSO errors in ixgbe_xmit_frame_ring() and
properly cleaning up after ourselves when these occur.

Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index b250aa806d07..95fab2867b31 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6776,9 +6776,9 @@ static inline int ixgbe_maybe_stop_tx(struct ixgbe_ri=
ng *tx_ring, u16 size)
 #define IXGBE_TXD_CMD (IXGBE_TXD_CMD_EOP | \
 		       IXGBE_TXD_CMD_RS)
=20
-static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
-			 struct ixgbe_tx_buffer *first,
-			 const u8 hdr_len)
+static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
+			struct ixgbe_tx_buffer *first,
+			const u8 hdr_len)
 {
 	struct sk_buff *skb =3D first->skb;
 	struct ixgbe_tx_buffer *tx_buffer;
@@ -6901,7 +6901,7 @@ static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 		ixgbe_write_tail(tx_ring, i);
 	}
=20
-	return;
+	return 0;
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
=20
@@ -6917,6 +6917,8 @@ dma_error:
 	}
=20
 	tx_ring->next_to_use =3D i;
+
+	return -1;
 }
=20
 static void ixgbe_atr(struct ixgbe_ring *ring,
@@ -7174,13 +7176,21 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *s=
kb,
 #ifdef IXGBE_FCOE
 xmit_fcoe:
 #endif /* IXGBE_FCOE */
-	ixgbe_tx_map(tx_ring, first, hdr_len);
+	if (ixgbe_tx_map(tx_ring, first, hdr_len))
+		goto cleanup_tx_timestamp;
=20
 	return NETDEV_TX_OK;
=20
 out_drop:
 	dev_kfree_skb_any(first->skb);
 	first->skb =3D NULL;
+cleanup_tx_timestamp:
+	if (unlikely(tx_flags & IXGBE_TX_FLAGS_TSTAMP)) {
+		dev_kfree_skb_any(adapter->ptp_tx_skb);
+		adapter->ptp_tx_skb =3D NULL;
+		cancel_work_sync(&adapter->ptp_tx_work);
+		clear_bit_unlock(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state);
+	}
=20
 	return NETDEV_TX_OK;
 }
--=20
2.15.1
