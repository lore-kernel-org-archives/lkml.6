Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474615-2-5209501675285477329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474615; b=PiPkXlU9pY+dg+RunfRe9TS0zACBCvns66pVMszL6cjtBP6
    6fiYc1FNDWdmNRlbfkTD5XrxOyN/U/FKLU5zSSuYe8CCY0yoUpGoJKsAPE/oCzNr
    cuhddV+u0vmxgeaDX7mS1e2LtykyC0wF22z+6n/vmieuLgfw9lAWj/yBkW5wBf51
    7b2I/ebeek9lCP+iBw8LvqAHWjLFyJzvOM9y5U8e3SZV+RyUdkvINdpJWplhysJv
    db/ni4rz283ZOhh/EaQ50L6nmza1pypHNBJElF6WHsOZBgcciN+e3l1vJJhlZPZ0
    zXa+Y7Jr04o6wG7D/eX/tzyVGOXDHHW2VU7PcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474615; bh=tcRnv7
    8g0iE4UmGscfxa3BIJAzg8kW3VV+SDTk5NjsU=; b=hxQeqktpqDHqoN9O8x6Kkl
    nCV9Hkq4spG5bpgEOW8H9oX/GVUHnndcQ1T3DgW/3wx4IwRhR8eYiGtg6Ly6vrQJ
    E7tMgpzKqcJfadDLSDIkGsrrN5rO8zgOve5e1niWkXailKWd1mX78qhfcc1Xtn6m
    Dds/MEOTn2nhUtJEryCoEQNn0KazdtuRUysdmoaX7nU2rwCit6vj48gDT466ztNH
    lmQVBOZ5Tq1Y/C1tVPmhm4X9DyjT0cJJk0vOcbCJkCvmGPX4oy+W3LbYpTxYZtLJ
    EldVRDoyX/H/7Q5faySMYrgIV06ocCNFnfIBOJ9FqrEbYBBHelanzVrbVFelYcTQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VD38Ytg5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleektdejnecuvehluhhsthgvrhfuihiivgepjeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VD38Ytg5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleektdejnecuvehluhhsthgvrhfuihiivgepjeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeCSPuL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:11 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:7883
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933855AbeCSPt4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 101/124] i40evf: don't rely on
 netif_running() outside rtnl_lock()
Thread-Topic: [PATCH AUTOSEL for 4.15 101/124] i40evf: don't rely on
 netif_running() outside rtnl_lock()
Thread-Index: AQHTv5nH0ktFhBZoD0Kg+7bKsBvqAw==
Date: Mon, 19 Mar 2018 15:48:52 +0000
Message-ID: <20180319154645.11350-101-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:0SOq18zigyO0kZRRHQNy3HKcpuL/MegGDNvM2rPykdfK/CSlD0Y6ci5iWVmi/+7JPPf1AbTXY9gmxWo+F+J9vJN92bj3cbwE/t6bzrmDfqqo+2IqhnZprKvSEy8zMQojr/Uions6AetDHtTHryqYVON1OAr7XLZ0YjT9y39y8xlM/cQKlOMXZn//gG/PCTOivDYYlT7SrlVIehyBmCRK6CNJKglrOxcJsFnPqW5SC6TjjOqlXlM10BqUw8L2mmwO;20:SIgEZDduc2pURsNWnnFG3ARwKKCT6PrQyQWVRT6+N3DERr9VyEpTe2cZe7aZEwtNQ2Tyf1fO55iQEFpQ3ZLC0/zFtSEYqtBG7Sp3xGuC4zfl7wu1Shs+lUNIf4i9DO9ji3WaIpYcC1QITO9jOVGcT73HA2pnTYuo73bAkbuNzhs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 158e4eb5-e4c7-4a5d-2d7f-08d58db1078e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919DBDBAB7E6C061C62A26FFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: D17WY/WO3N0SyJdbYoVk3x4CvcrxmtAvaI0N1znU7qsiB3/2psQHbJ6xzb69gs2xhkoNU+zcrVQrAnnBLo3YwOfQya1DoKSsui+7ooSivuTd1P6Uu68QSxYhwZn48DZ/pga0smlZ4rGHcyQHOfz4TBP17WTyBvpNlhKWyLMvucWfvtNOV5k8vUJNgTIlxfNaE8xVu1pae0BlDvcRRbQGTBbNM1/YtBKbUwzhx/JdHH5A7P4Nff5FdTMx56WXnQS/jfvd6nP7OkmH0zMQfdPa92TK/9UHEQSAN0uQEaEhztY9GxXnt8LJdVHuTwp6IEcKc51UhfuHqAq7hKSqMuifag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158e4eb5-e4c7-4a5d-2d7f-08d58db1078e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:52.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 44b034b406211fc103159f82b9e601e05675c739 ]

In i40evf_reset_task we use netif_running() to determine whether or not
the device is currently up. This allows us to properly free queue memory
and shut down things before we request the hardware reset.

It turns out that we cannot be guaranteed of netif_running() returning
false until the device is fully up, as the kernel core code sets
__LINK_STATE_START prior to calling .ndo_open. Since we're not holding
the rtnl_lock(), it's possible that the driver's i40evf_open handler
function is currently being called while we're resetting.

We can't simply hold the rtnl_lock() while checking netif_running() as
this could cause a deadlock with the i40evf_open() function.
Additionally, we can't avoid the deadlock by holding the rtnl_lock()
over the whole reset path, as this essentially serializes all resets,
and can cause massive delays if we have multiple VFs on a system.

Instead, lets just check our own internal state __I40EVF_RUNNING state
field. This allows us to ensure that the state is correct and is only
set after we've finished bringing the device up.

Without this change we might free data structures about device queues
and other memory before they've been fully allocated.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/=
ethernet/intel/i40evf/i40evf_main.c
index 7b2a4eba92e2..0b23bf6d7873 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1796,7 +1796,11 @@ static void i40evf_disable_vf(struct i40evf_adapter =
*adapter)
=20
 	adapter->flags |=3D I40EVF_FLAG_PF_COMMS_FAILED;
=20
-	if (netif_running(adapter->netdev)) {
+	/* We don't use netif_running() because it may be true prior to
+	 * ndo_open() returning, so we can't assume it means all our open
+	 * tasks have finished, since we're not holding the rtnl_lock here.
+	 */
+	if (adapter->state =3D=3D __I40EVF_RUNNING) {
 		set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 		netif_carrier_off(adapter->netdev);
 		netif_tx_disable(adapter->netdev);
@@ -1854,6 +1858,7 @@ static void i40evf_reset_task(struct work_struct *wor=
k)
 	struct i40evf_mac_filter *f;
 	u32 reg_val;
 	int i =3D 0, err;
+	bool running;
=20
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
@@ -1913,7 +1918,13 @@ static void i40evf_reset_task(struct work_struct *wo=
rk)
 	}
=20
 continue_reset:
-	if (netif_running(netdev)) {
+	/* We don't use netif_running() because it may be true prior to
+	 * ndo_open() returning, so we can't assume it means all our open
+	 * tasks have finished, since we're not holding the rtnl_lock here.
+	 */
+	running =3D (adapter->state =3D=3D __I40EVF_RUNNING);
+
+	if (running) {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up =3D false;
@@ -1964,7 +1975,10 @@ static void i40evf_reset_task(struct work_struct *wo=
rk)
=20
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
=20
-	if (netif_running(adapter->netdev)) {
+	/* We were running when the reset started, so we need to restore some
+	 * state here.
+	 */
+	if (running) {
 		/* allocate transmit descriptors */
 		err =3D i40evf_setup_all_tx_resources(adapter);
 		if (err)
--=20
2.14.1
