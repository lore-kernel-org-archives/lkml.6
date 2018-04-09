Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240560-2-9398366914549356057
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
    1523240559; b=NAkPMrySOeexULqVLLiPVNCrs0VBGQIO1qy1o6mDp+gFDUrFhB
    iWNVzaKSsus0Wb6+sqnABimMk2Iy3jqbgNYD3EEGfyJx6uA7buGJrU5LscCsSmqr
    Hgg4dJ5s5oGlihQ006mbQHtxrfyUaxZvkpFTk+3sTAe3mniFBdyfIXn56/i/YNlh
    RQzNf0jt+NL2Ik+bBZkvJ/a0EMMxoGjKNY82ZMbpN7+DGAU9ueGOG9zVe3G+ru7l
    O+fTt79nGoqb3sU6//NqlrCnc+Jh6l5QElMPE3oDFdut8i0VsSD2erQrTDGmiN1q
    eflvoyOACmhzfl/Dt9AV+4UvoZ6NWcl8RyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240559; bh=sCkdtetybf
    3W/Qbd5I8Qn1aGUQlPvmHPF22HvhTYaFg=; b=u5FIeTZnJRhnJfF91Vafc6TP7Y
    0P61oodnq8YyxXlp/uRS2SNtAEV0jnAGJjQNNbfviauiukFdIKZDY6i5AZ9+aTwB
    NUQ9Z66d5BzSDVq7v9P3+6cwPOTJK+krOZD3AcST2/OOPQXFKcZTg2NZ+wZB9dXz
    Q+TIbsSpvDWo2hemPAV/Wv3Z3JyYxUfIqzid6r9OdXGzrfSBsnBJmEkKCVM1+Pc4
    /Z33Bz7pi31oXC6ms4SdPjzHy1Z4P3qnC/6R6Fvdpw5lMGXAKy+rUSOSKn0aKMWg
    KTz/y8cAnHcYWIldSoj5f1WUiSmXflejwOEc7EKQY16qLWX8sOvzsLC3GTCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EwgbLiuO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EwgbLiuO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH8HUVVYZbkCnBdjefHHPFkgYY7fWagO7pHbSLgq5o9eAhgIr1f8klwsAr+WL4kZz7odyuCEMTFYQZs52wva+7F6ofPzLhVq6MSLJCoXtIw+NeGNp+By
    wdNwnVhU+/jFsjbb8kJNoJk5TI+J+6E8JIeakZ1T33EKq85Unv+sb1ybnsS99JbAGjCXrud0eT7u5Zk0LlAn6q/Gd+1kR8da62b0O+LdfV+nt8ZAhlNavx2C
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=Y2_x_n7zU42nOnbLo8UA:9
    a=zz_jtDW6Q1VDNVcO:21 a=y6sKZ4TK0xXHHzTG:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754851AbeDICVy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:21:54 -0400
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:9678
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756031AbeDIA3k (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 110/293] i40evf: assign num_active_queues
 inside i40evf_alloc_queues
Thread-Topic: [PATCH AUTOSEL for 4.9 110/293] i40evf: assign num_active_queues
 inside i40evf_alloc_queues
Thread-Index: AQHTz5kZet1POMSreE6BRb+oumHUoQ==
Date: Mon, 9 Apr 2018 00:24:19 +0000
Message-ID: <20180409002239.163177-110-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:A7X/sD2UCB/eRwPaBuYOPLBmbwp0/O78nr2n5kiS87fnrrSVw+rt2C0kuahF2KX9+p/OqCZ1rXyngqJwNxuCu4GEkSRYLOY2DlD4durJcrl4I1+2cUOelr8upF450HE/TzKQ83r+AA8YZGrT3KoaG9aR1DNN40s3xuIIDpTPjoWD4KgONYidqEeJMrYtlnIx0EnnAgjyOQLSEzlhagswQOCvpCsjFNivUHVDTGTmsHyQvvZn2eGOXes53XKhZ9pF;20:bKz/n9ulhJl0lwwYkMmthljs5j6UL4uwkHSCIIjb8OTRrl9KpsnYzQIHQLgyrJrpz3jQkSe0fcDfojnXOgsspNclwbuhmMWMd1Ado1T5j9EgZ457IpA//nTgokAJqL7Id3hMP+vatoz/U3NHT+SiANd3WHCu95/XPUnfmuc9WSk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5baf6ec-ef99-4653-d05c-08d59db0f916
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967C01647C1CF6B2BE301E8FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(15760500003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: M9Ois2KJxVlOIbzg6ARXz7nMD0LeFGHenWejBCGo+pPyY/o3VqCc057F2bdofT+T/dHlCcakc9Xd4Zbkq154q9lR4feVKuVNmSsnHl1rZ94S+AF5N/pW6Kby2mYWeFuVUa1/AjHp3W1tRHSlUHWhHD85wsZlPJm8GPfjmyRuw34Elt/KnU8iCSgonYI0RbQ2Ks9oYnlnFj/vS0ql7E6a9n832hrTYdpIE+ajJCjET7fa3EaaELWjvpYYpBts2nMTavPSPvt3xlGfwvDPQijGc+954yJnQaMWIj3as63pX1iKp6epbXB0tL6aIrkDAuzMXPFXv3NtR09pquUjttHyDtXH24cBvOBJJkRBTN4NHV0yW7vFGfeNXQmsoCQ1v0fQZrbkm2PudiHqUrzk6i1B37/YM2RD4nv6a2Ko+Ky7Kfk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5baf6ec-ef99-4653-d05c-08d59db0f916
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:19.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 65c7006f234c9ede887d468f595f259a5c5cc552 ]

The variable num_active_queues represents the number of active queues we
have for the device. We assign this pretty early in i40evf_init_subtask.

Several code locations are written with loops over the tx_rings and
rx_rings structures, which don't get allocated until
i40evf_alloc_queues, and which get freed by i40evf_free_queues.

These call sites were written under the assumption that tx_rings and
rx_rings would always be allocated at least when num_active_queues is
non-zero.

Lets fix this by moving the assignment into the function where we
allocate queues. We'll use a temporary variable for storage so that we
don't assign the value in the adapter structure until after the rings
have been set up.

Finally, when we free the queues, we'll clear the value to ensure that
we do not loop over the rings memory that no longer exists.

This resolves a possible NULL pointer dereference in
i40evf_get_ethtool_stats which could occur if the VF fails to recover
from a reset, and then a user requests statistics.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/=
ethernet/intel/i40evf/i40evf_main.c
index 14372810fc27..34fc948bf550 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1123,6 +1123,7 @@ static void i40evf_free_queues(struct i40evf_adapter =
*adapter)
 {
 	if (!adapter->vsi_res)
 		return;
+	adapter->num_active_queues =3D 0;
 	kfree(adapter->tx_rings);
 	adapter->tx_rings =3D NULL;
 	kfree(adapter->rx_rings);
@@ -1139,18 +1140,22 @@ static void i40evf_free_queues(struct i40evf_adapte=
r *adapter)
  **/
 static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 {
-	int i;
+	int i, num_active_queues;
+
+	num_active_queues =3D min_t(int,
+				  adapter->vsi_res->num_queue_pairs,
+				  (int)(num_online_cpus()));
=20
-	adapter->tx_rings =3D kcalloc(adapter->num_active_queues,
+	adapter->tx_rings =3D kcalloc(num_active_queues,
 				    sizeof(struct i40e_ring), GFP_KERNEL);
 	if (!adapter->tx_rings)
 		goto err_out;
-	adapter->rx_rings =3D kcalloc(adapter->num_active_queues,
+	adapter->rx_rings =3D kcalloc(num_active_queues,
 				    sizeof(struct i40e_ring), GFP_KERNEL);
 	if (!adapter->rx_rings)
 		goto err_out;
=20
-	for (i =3D 0; i < adapter->num_active_queues; i++) {
+	for (i =3D 0; i < num_active_queues; i++) {
 		struct i40e_ring *tx_ring;
 		struct i40e_ring *rx_ring;
=20
@@ -1172,6 +1177,8 @@ static int i40evf_alloc_queues(struct i40evf_adapter =
*adapter)
 		rx_ring->rx_itr_setting =3D (I40E_ITR_DYNAMIC | I40E_ITR_RX_DEF);
 	}
=20
+	adapter->num_active_queues =3D num_active_queues;
+
 	return 0;
=20
 err_out:
@@ -2440,9 +2447,6 @@ static void i40evf_init_task(struct work_struct *work=
)
 	adapter->watchdog_timer.data =3D (unsigned long)adapter;
 	mod_timer(&adapter->watchdog_timer, jiffies + 1);
=20
-	adapter->num_active_queues =3D min_t(int,
-					   adapter->vsi_res->num_queue_pairs,
-					   (int)(num_online_cpus()));
 	adapter->tx_desc_count =3D I40EVF_DEFAULT_TXD;
 	adapter->rx_desc_count =3D I40EVF_DEFAULT_RXD;
 	err =3D i40evf_init_interrupt_scheme(adapter);
--=20
2.15.1
