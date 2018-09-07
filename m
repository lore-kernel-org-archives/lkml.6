Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50223C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B492083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iwtiOqEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B492083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeIGFjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:39:18 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728506AbeIGFOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icTABggDoornXOQeRF1zC/goSaGFBYnnw+WGQZsTlhU=;
 b=iwtiOqEwgC9kJ1Ae1hAokblViVGKy8R9Q0r4h/D3FH9dYZMWRz12LNLjHcFnlhclysfAMNSRs8eGiB1krWflhuphEP6DZ6UTLvMHj7vw++g+DZ/E8qnP33MO7AWlN8icD+9B2ctxXPe+YqeA95JImcUoymJC1xlvXcKr9Nbx4+s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Golan Ben Ami <golan.ben.ami@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 14/88] iwlwifi: cancel the injective function
 between hw pointers to tfd entry index
Thread-Topic: [PATCH AUTOSEL 4.18 14/88] iwlwifi: cancel the injective
 function between hw pointers to tfd entry index
Thread-Index: AQHURkLBpOqnI0eYYU61q4y8UMkajg==
Date:   Fri, 7 Sep 2018 00:36:02 +0000
Message-ID: <20180907003547.57567-14-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:28pgn+oHTWBIg2/0EiTZrfQSkrtJrYVb/9T6MRbhEw5mUDUbVQGW9GdoOHRmAMny3YAtRCMLt/6hp7F1pkTnK65AGO9P6aPR7jRs5FmjekYIHjCCBAwgR/NfnM/NnBxY31GRPUvHPh0GMXwnRWl5ulljNWeSlECixeQSeIwxQImltHdjIO1JM794e0tyHpkd975ufviXpK7nsExiSYAbRGt/3APfnOiETgdPiHa3kmKJzWiff7kfvkv17xR4pvj9NzEq05sBGBmdCHJTWKWa1DMHVUYwj+U7ko+5EIUZge36l4u9pvVdFlFABN/avszrV086TicT6/kFagEX92+Eqg9jEl+d7Gcj0l5z/a9VIaPaOM3vWw8WN/bZWfYra5mHE8T9of7h1C/gPDPBBmF8F8hoybYmvKlEqoCG9Nj3LKrUXZzXzY53vp+b5r50eYi9S8/csm0WIwiG1ib9nfUHaQ==;5:6AHRkT1g60e+qjKoyzHno2t/4yN2jVzWdN15zC6+55TLHQ0KtntDDNsQfzdK2Xu2A8yA4vVqdPTskLjSQRkLBOd3rbWl4gGmJ+9BcycVxma3L6K9eUjgeHDcPkFKqUsEqoP0wxRua9m1ej0IVbW1NliJr1I+IC5mLGaHfEJkLsk=;7:GIiEkDigYy5SUA4mW8xiBx7FdOCp6GIhQDm5Trtwn3O9CRiUshzULjAApqGvKv7PjksDfHvw4hfxYfTkZ0jmoVnzk8ImR6Iw6BRR6BtXVRpr7qz9OvM4SAztBIRs46PnVI0XK9Nw4MLLjY6+f5GwQDWnTlVChCx2g9GrLmuHpENbVZmQFN53leStqJnFgnOiIHbStDBia0urNhVmVmCj/TypODiy8ECfnuqf8tedZgCBGjnw1876jeys0RaCnCeJ
x-ms-office365-filtering-correlation-id: a4c42eb9-92d4-4327-ff51-08d61459e417
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07733EB6687E2C62A8C38186FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X54Wk1JmT2Ytgz+6P8rCIgYn4QW5Hw7sglQD2IaFanzDY7OGaMN+JH1zT3kX2DzIpxbvdq31kpVMkZGNOMEav7H5caG6/TfgJcdPPTSw2o6MKRPJ8ebepo9YPjJEilASiBDD5l1o/j4PuKUw86MyRzPymZVsoiAsktzwLIzAfM7kEainK6SqH9zUQPDwaHbid3N2nvi2OM5+GE3mhPfTpwU6oJFavvtDNAHN6IRCeAgnsCpZtUm5zAudng32Ek20R8rcs6pthl1UKnJP6VGIL+OXD4uryHyFf9449PVHnmN7UMvqgBm6qWMNOc0bO6PBZrZXv8p56h8PWRgHo0xmpewSBOiovkYp5GuNBV9sjao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c42eb9-92d4-4327-ff51-08d61459e417
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:02.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

[ Upstream commit f5955a6cc3862a02d46f50b723c3172d24d749a5 ]

Nowadays, the tfd queue max size is 2^8, and the reserved size in the
command header sequence field for the tfd entry index is 8 bits,
allowing an injective function from the hw pointers to the tfd entry index
in the sequence field.

In 22560 devices the tfd queue max size is 2^16, meaning that
the hw pointers are 16 bit long (allowing to point to each entry
in the tfd queue). However, the reserved space in the sequence field for
the tfd entry doesn't change, and we are limited to 8 bit.
This requires cancelling the injective function from hw pointer to
tfd entry in the sequence number.

Use iwl_pcie_get_cmd_index to wrap the hw pointer's to the n_window
size, which is maximum 256 in tx queues, and so, keep the injective
function between the window wrapped hw pointers to tfd entry index in
the sequence.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 12 ++++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/n=
et/wireless/intel/iwlwifi/pcie/internal.h
index 45ea32796cda..92b38a21cd10 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -660,7 +660,7 @@ static inline void iwl_enable_fw_load_int(struct iwl_tr=
ans *trans)
 	}
 }
=20
-static inline u8 iwl_pcie_get_cmd_index(struct iwl_txq *q, u32 index)
+static inline u8 iwl_pcie_get_cmd_index(const struct iwl_txq *q, u32 index=
)
 {
 	return index & (q->n_window - 1);
 }
@@ -730,9 +730,13 @@ static inline void iwl_stop_queue(struct iwl_trans *tr=
ans,
=20
 static inline bool iwl_queue_used(const struct iwl_txq *q, int i)
 {
-	return q->write_ptr >=3D q->read_ptr ?
-		(i >=3D q->read_ptr && i < q->write_ptr) :
-		!(i < q->read_ptr && i >=3D q->write_ptr);
+	int index =3D iwl_pcie_get_cmd_index(q, i);
+	int r =3D iwl_pcie_get_cmd_index(q, q->read_ptr);
+	int w =3D iwl_pcie_get_cmd_index(q, q->write_ptr);
+
+	return w >=3D r ?
+		(index >=3D r && index < w) :
+		!(index < r && index >=3D w);
 }
=20
 static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wir=
eless/intel/iwlwifi/pcie/tx.c
index 473fe7ccb07c..11bd7ce2be8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1225,9 +1225,13 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *=
trans, int txq_id, int idx)
 	struct iwl_txq *txq =3D trans_pcie->txq[txq_id];
 	unsigned long flags;
 	int nfreed =3D 0;
+	u16 r;
=20
 	lockdep_assert_held(&txq->lock);
=20
+	idx =3D iwl_pcie_get_cmd_index(txq, idx);
+	r =3D iwl_pcie_get_cmd_index(txq, txq->read_ptr);
+
 	if ((idx >=3D TFD_QUEUE_SIZE_MAX) || (!iwl_queue_used(txq, idx))) {
 		IWL_ERR(trans,
 			"%s: Read index for DMA queue txq id (%d), index %d is out of range [0-=
%d] %d %d.\n",
@@ -1236,12 +1240,13 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans =
*trans, int txq_id, int idx)
 		return;
 	}
=20
-	for (idx =3D iwl_queue_inc_wrap(idx); txq->read_ptr !=3D idx;
-	     txq->read_ptr =3D iwl_queue_inc_wrap(txq->read_ptr)) {
+	for (idx =3D iwl_queue_inc_wrap(idx); r !=3D idx;
+	     r =3D iwl_queue_inc_wrap(r)) {
+		txq->read_ptr =3D iwl_queue_inc_wrap(txq->read_ptr);
=20
 		if (nfreed++ > 0) {
 			IWL_ERR(trans, "HCMD skipped: index (%d) %d %d\n",
-				idx, txq->write_ptr, txq->read_ptr);
+				idx, txq->write_ptr, r);
 			iwl_force_nmi(trans);
 		}
 	}
--=20
2.17.1
