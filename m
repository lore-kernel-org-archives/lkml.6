Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495787-2-13336101492834923926
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
    t=1521495787; b=stubSJwUUSSOG3o4k6LMR2zUQAUOJQh5UQsrXOFFqSy+ssg
    wl65KO61vT2zzT1Jh2ubG901dr1Mq+5NGIAHPqltNKdx49+2pTZ6I2LVsMLd1omR
    dVsU1GlTMoqIeLms3AVvi+nOhcnfEr9Gh1yrqMPuhfhMEoBX+ztS4/FCxZY1NIf9
    jOdIcOYAV4o9IuCLgE8jRc7zMPE58/7KTy0zn5QOysgNhwDsrR6oFqEK4Jn/ZXkO
    vid14o34MGvvDrsQTwOuzA4xp1wQbY4dW4GFweLmqsiQd9QvSEnCEsBNZoe9cOma
    dLzDMT1NJE8+fHOCjd8N9e4xYBlCYK3ipJqaaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495787; bh=N8mt0K
    Zumika2xCQHDYH/SC0PjzKn5tYzrVA5dC/0XY=; b=H1bPzAcIxs08d00WCXVcHv
    bBsB2BNf4yaoHuT0fvFf3Ye/zIq8BBE98daGwu/NrkkoYb9uvV0mt+G/rjppowDj
    sar0/B1Pk789yJ5eKdXkMv9dB0RElfZIJIn64CcSQ8+Hci134q5LigO+Q3oC2/WH
    BetaE4GaK8ALP/fYc9oxYZKUXZYWkgrBFNiFwqfFXez5zo0uPj4QhyY6CNdDZ6Ed
    FAkijBNyMnTbnniZZptYuq25Wg0ermOewTJzSgbMd89Ywk/r20ppK6NCv9kb21Vw
    7P2zD9ZUNIoYAGTxEp5hq7rxB+Sm0AhHYIYr202NOdpra2At7eTo/cAu2gY8hyVg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lGT4nPv9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelkedttdenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lGT4nPv9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelkedttdenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965001AbeCSP6p (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:58:45 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934634AbeCSP4s (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 76/97] i40evf: don't rely on netif_running()
 outside rtnl_lock()
Thread-Topic: [PATCH AUTOSEL for 4.14 76/97] i40evf: don't rely on
 netif_running() outside rtnl_lock()
Thread-Index: AQHTv5rNF71vCW6hAU25Tv59cqO7yA==
Date: Mon, 19 Mar 2018 15:56:11 +0000
Message-ID: <20180319155411.12348-76-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:GFBek4dOESRdkFnIZEE95i3/fdJdLpadQPUmqg00qgJQRP53NctyGsZbRLfIK89cvvdgCchuxZVDaxG4Y6vlMTUWaCW3Ycr9FK6aTMDfZYsck1n3mCyQ5ThXPQgYxJQlDEOvOrrMVmGXb6O4A8f7v0dIs2l0FgwaUoCLETyVe5b1DFJOVrNZsDde6VNPRHzTZ1VvQOfKz5qMJ+MqTo8wT4VD4NcQlWOpIvipMi6sDzE3avq5MIC2RTmtW/SSO5+1;20:NNFhYtPriQRtqPF1oWNDW9aPdGviDPQjqonHpjVsBShNP9Z7IaREYdWWlBZd52wQ0xjNXzGF4pzUbYcGpFuQORX/HkZ/Mf9pySjvuNhM8gVM5x/V7qeH0qyKAyOl+BlJ004ifPv62u7cF5MGwhr69eJrkyG5s5Yll2iIke6imw8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b78815f2-e7c9-43eb-eea3-08d58db1ffcb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031FDBAF2271B541A4577E1FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EPk2W8ntpHLneQP2vqMh150qjuPMUco3DqgwSiv1BS1KOKbZyo23rJvtlemKuZA8Ft0hOGkzcvitgW2Udq/bi0h3RFNdByxlvu9c9bXyWvuFl2pW/DAcGX5hcU8C5RQoCd0XbUG8fEObnlwJ2SIigyajrHtDQKEj4uuK759MTee93gio82QQ+3KBwlf0+2/pZDCUZVbVM5AK0MTQFutC19erl5M0hUdlOFpS3EhibdaElVXsGGDfS436tA8kSVEp4CfpUEuU+It9CmxxRVlGryu3XliMqMn3S5zUPYmFWIsD7lIHigANzEa/jeCpXr45+GwDmwZQNQyZddLPm0mHwA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78815f2-e7c9-43eb-eea3-08d58db1ffcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:11.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 1ccad6f30ebf..4eb6ff60e8fc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1775,7 +1775,11 @@ static void i40evf_disable_vf(struct i40evf_adapter =
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
@@ -1833,6 +1837,7 @@ static void i40evf_reset_task(struct work_struct *wor=
k)
 	struct i40evf_mac_filter *f;
 	u32 reg_val;
 	int i =3D 0, err;
+	bool running;
=20
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
@@ -1892,7 +1897,13 @@ static void i40evf_reset_task(struct work_struct *wo=
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
@@ -1936,7 +1947,10 @@ static void i40evf_reset_task(struct work_struct *wo=
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
