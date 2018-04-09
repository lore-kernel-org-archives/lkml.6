Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241097-5-11328907164969740544
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
    1523241097; b=i5mpakWwNe98abp/+vCLTtqiDhV0EdGuUD6Dmhbng68859XT7N
    NIWjiHvwoBAdMdnjchG1YhGw+po7Y9nblg8izpZbxM9REGoifubXp05QbmpdBcqj
    YWy8d+21JqDCZiLTHuAFEfdm04A4NVWVHuGql65E9wuDh1KOfUl3xBrrF8V0Drxx
    X8jz84dVJTOVszt8wD/AINpxCAEg/2ikwcVqXH12kEEBQIKyso7GnfrG1oxnOA3N
    nhbVlEYw/409SHxunwY1nFaEO/IGqjXxNSLM8ZNWj0hgqNg2Ut6eJI02zKCEKgSh
    Kf2wUvHJG1I5SdYO3gcJ9ZtEcMYoniit1eHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241097; bh=l21n0JQvhz
    jMN3PZdoTnpkfPyBX4xsSTrMAlNhsFyio=; b=GkiyvM+5Vo8OkQA93J6R/PNJGr
    PI6r14hDNk87ByqBUNj3/j8JhRoRXKInyWR7ahvFYSSkqZdPYmNRrqN3SQxjBH8f
    q9aHHuGMF/lzOeIjtmV7FlLsfGP21vRfPcCdRUo5QW3WJBXQjGsFjxEr0iF5EFrA
    cbXM9OByowacv/VLhxvJkJ+6h+GITGMC2VpVC4EkWKuSg6iH5V5UIv01rTjgaOHq
    x3EJ6QwlfQtk/MnqT1+ZgBg80m/ot/wNiAuqeFTkfTC5SHC/f49UH9t6e2xyBCzm
    +m1GVES91VqrqrfdGSCDIscPly6UVjjBbgQsZvQGT91V8lJoSKERu62iOEaA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XMAEwvfD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XMAEwvfD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMgaDAbQ5iImoKsoRngIb1RHtxs/aDUsXLYrfAZ0N7n2SFbrjVWivvVCQuGjz3pnHBUJE9Sa0Ny+fGRSDCOUII/2j4uLfE/FqKv4C4k3zC90rd2NgaCM
    S/ffBsBi9J2dvICp7tdI4IwsFQ5oxwwDt85nUDvsUD712i9LicWvhRgHygCpphXZETdtdyLSla7GE/SOy/IryTud+1bmEj4aFQXmKQhP7i17f6560L2EBTu6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=dq2cNPrMAAAA:8 a=yMhMjlubAAAA:8
    a=zz7Vc1meF-ew3THYyscA:9 a=wPNLvfGTeEIA:10 a=UrzWRhJOTTn3oDX10iyi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeDICbR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:31:17 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:61393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754317AbeDIA2V (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 069/293] ixgbe: avoid permanent lock of
 *_PTP_TX_IN_PROGRESS
Thread-Topic: [PATCH AUTOSEL for 4.9 069/293] ixgbe: avoid permanent lock of
 *_PTP_TX_IN_PROGRESS
Thread-Index: AQHTz5kGT8AfNTcEF0CHM8jFvsDt0A==
Date: Mon, 9 Apr 2018 00:23:47 +0000
Message-ID: <20180409002239.163177-69-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:nfEf/MwOPBkPA4cguhwWPud9YuSHQmE744Hvn+jGTfbUK7vloFayGjSWV7X3/6pm/lfdnRhs0/QeKAYhhtR9nwa36cSc169J3k5kNAnWFB7841zFrYnWRfOSdsCd7JNpDK2UA68U1jtLltps4Igzcm9PuiGOAAoUcystrXSFXvKj9qxGPeVS06A+TeqLPCCuAEKyeP95MI+8D9kA2juymFY4Hh7KkuE4BmngWQQonczbEAWH6puSsjSLtfFqvg9w;20:pKq7LcP/wukuLqP4V7L+YI7mdFJQ3BVC7T6U0bG4Uo4qZ1axVjjlawTWW13wXp9xf6WRHLfYzOT6ffFqZ6zmbrmNII2xV1aX4HzoMtf/w/zFSHYrT5c7W2qTXaoLIWSPEfzPeu8PU+VLaQngLcJaKIkKo85NbC7Hu34LnRbZWUw=
X-MS-Office365-Filtering-Correlation-Id: 0fc2a0bd-2cdc-466d-b54a-08d59db0c6aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08717886EFD0A709CCB470DBFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: l4SgD/L7UnnDGJVAkmRttuJAuuUH5RSgBLbWvH48jXat0YyqU2Ia2aRlJpuFZF7TK/HLlDIAEHjj9qfjurgxm4RR4F7bvO6cwy2jirqBzdVfszYDNbRKyhd7szVnsmBZ6+EfInMFr9h1p/bP7pOj+AIpPSyK0wIt2KgcnUyUd4Y+V85X/WV5bsf7Zmv0jKOB0Wa9CDyRUHkZXf7graDbOHLLMy3oHj8nDqScyApusctcaqX1Y5upThwzo6e9NMTJ2isUGEU1BcCFWfwYkRCYYyZ2tDlkbCsECvZVXuqVuU/V4Sz4XFdNTG+c6O+sjpMkhj8RPGPL4f4Tc4UrCUKGp6edb9dmXAzSBHibs2hZOsPNk3QklJMbV1+gcWqur8a7/l+32XKD/UsaXY8kmy5KNvONKiUbjKa7xDMz74MOBdM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc2a0bd-2cdc-466d-b54a-08d59db0c6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:47.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index a5428b6abdac..4856cf83f9e4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7472,9 +7472,9 @@ static inline int ixgbe_maybe_stop_tx(struct ixgbe_ri=
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
@@ -7601,7 +7601,7 @@ static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 		mmiowb();
 	}
=20
-	return;
+	return 0;
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
=20
@@ -7617,6 +7617,8 @@ dma_error:
 	}
=20
 	tx_ring->next_to_use =3D i;
+
+	return -1;
 }
=20
 static void ixgbe_atr(struct ixgbe_ring *ring,
@@ -7917,13 +7919,21 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *s=
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
