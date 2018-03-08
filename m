Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486995-2-8319567755367182651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486994; b=hjVwNi43wVJ/ryZPQgfKHCgLekmsM1USLfMgwDwWtm3qmtl
    AuSzWZrVBxZY0ozD00CJN13I5SnJxOBEgOTBwwdw0kZD3YJiietJerUB1iTxrQ3n
    LSkvfUa1h2UZNwIi7lESxBsFmdLUfuYcXAVKpVjyCTs+FXaUd0jNETR5wSlb9VLs
    XMJa1Rx+IRo81ucjvUmckwBf05I4HaDpYvZm/fKPVtdC0DHQdlHzhR3R92d7loyh
    4KF+77IV9rSKduJdJZY8LdsLWZL2o7idsnpsCZ/FlZdx5lcwIW/RI54rMhFl6dDb
    K56luQAFQ0gacbvRZDHG6QOoWLDxMsGAoKNbCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486994; bh=raQQ9x
    KLgyGVnl1uACnPKZf/T+UQdn+kVAD01PcR/HE=; b=mYe/sfEpSluCMei593eQaG
    aVe5iIbBkZgJtfooKSrbowKAqIznwlB/pcc2a4XfLz1hhAoVTahyj9VcBP27UA+O
    Ly1uvcLLMOaQaeUa0hPcGPgi1bAOTMfHxrg514BSn9Ld9YdGIs5RZiDgrhwnqgiT
    IvQzYL/VC5bLbxKJkKnw21jD0LRTY6PGMLLOAJp/x5hcTllKUlubE87gTcIGUK2N
    2l2WEaq7QmyhaYiakSqe7ljiFF0P5UADaJSuA12CM3yClmYt4KORsOezM4bwsZwH
    A10gCmIMx75q6LhQ8LLznF+GhPlke89mZla8H/2xFBLj14xHunP7CYh76HdJ5eFw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IwGULCu4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IwGULCu4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966546AbeCHF3c (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:29:32 -0500
Received: from mail-cys01nam02on0127.outbound.protection.outlook.com ([104.47.37.127]:59427
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935543AbeCHFG4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Trimarchi <michael@amarulasolutions.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 066/101] power: supply: pda_power: move from
 timer to delayed_work
Thread-Topic: [PATCH AUTOSEL for 4.4 066/101] power: supply: pda_power: move
 from timer to delayed_work
Thread-Index: AQHTtpqWvtSt86Idv0aZ2S7lz40mOA==
Date: Thu, 8 Mar 2018 05:01:59 +0000
Message-ID: <20180308050023.8548-66-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:z54ZoiKUFdKW4nhiqe1dmxWYZxNh9TW0F64dlHCUl0fg81tHrpPy/Tf80Q6+UxaDM/3jhRbyVKGSpuN+igRpm18vkYJEyIvHZq7ySa8+1noNdsXlXXDs5ry39sD6Kx69soJ9Ur63K8wAJrSFLFynWWWQmtqfPJKSKvqQ0AKwQUgV7pJh1LzcQvGIDh4SkBzAh6AoWswrwnoQIkBlthM8BpU9DbnBtF9cRCwDjUcy3yXL97FW4zef4K/E7zCTMB/3;20:QjIrt+oMnQqrgMEIc1v0XU/hJGz7k166gopl8pGAEdIiQSsmk5n33gzHrtPNKnyEkQOE7aH+738/62rBOTPCSiuJQ+AcPM7rIvmcfrD7qfXqJqL1fsMAn6FKdMa2TSKKrZu4L9TYktBD6dyNpocCieLYKYPZPnuIENsCfWb4EEg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51774805-eae3-495b-36f1-08d584b268a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016F65CD3AAFD1D74B95C84FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(5890100001)(2501003)(575784001)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9yf57GFGPYonURYuRWqip6aogemrmYqCOwgB0KGbrdFlyzmIriSC30oIKbav3nMClZXF7aBerJbIU7XKG3fMGwolW+EqesDMp98LkKo72Ayi6L4biqAGRlzkzsCcjyx91YR54H7y7ah3uEoyLmlmrDUwDfFhwGsh8fXd2bIiG3447mcWojvfyOmSSbgB1BpSdSiDumgUiqj/56qrpNPY4CorcXGiw3+S87mpG3AQn5+tkRy4uktfo77mQQCljRzFxYzfHA4zcwFuUwIA/sV42XtLXS+dq0twM13l2nK2CSEPahCuHLy8d00Nfsb9SoqSm3oBlvHzXa0oDM9pAkeQqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51774805-eae3-495b-36f1-08d584b268a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:59.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Trimarchi <michael@amarulasolutions.com>

[ Upstream commit 633e8799ddc09431be2744c4a1efdbda13af2b0b ]

This changed is needed to avoid locking problem during
boot as shown:

<5>[    8.824096] Registering SWP/SWPB emulation handler
<6>[    8.977294] clock: disabling unused clocks to save power
<3>[    9.108154] BUG: sleeping function called from invalid context at ker=
nel_albert/kernel/mutex.c:269
<3>[    9.122894] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper=
/0
<4>[    9.130249] 3 locks held by swapper/0/1:
<4>[    9.134613]  #0:  (&__lockdep_no_validate__){......}, at: [<c0342430>=
] __driver_attach+0x58/0xa8
<4>[    9.144500]  #1:  (&__lockdep_no_validate__){......}, at: [<c0342440>=
] __driver_attach+0x68/0xa8
<4>[    9.154357]  #2:  (&polling_timer){......}, at: [<c0053770>] run_time=
r_softirq+0x108/0x3ec
<4>[    9.163726] Backtrace:
<4>[    9.166473] [<c001269c>] (dump_backtrace+0x0/0x114) from [<c067e5f0>]=
 (dump_stack+0x20/0x24)
<4>[    9.175811]  r6:00203230 r5:0000010d r4:d782e000 r3:60000113
<4>[    9.182250] [<c067e5d0>] (dump_stack+0x0/0x24) from [<c007441c>] (__m=
ight_sleep+0x10c/0x128)
<4>[    9.191650] [<c0074310>] (__might_sleep+0x0/0x128) from [<c0688f60>] =
(mutex_lock_nested+0x34/0x36c)
<4>[    9.201660]  r5:c02d5350 r4:d79a0c64
<4>[    9.205688] [<c0688f2c>] (mutex_lock_nested+0x0/0x36c) from [<c02d535=
0>] (regulator_set_current_limit+0x30/0x118)
<4>[    9.217071] [<c02d5320>] (regulator_set_current_limit+0x0/0x118) from=
 [<c0435ce0>] (update_charger+0x84/0xc4)
<4>[    9.228027]  r7:d782fb20 r6:00000101 r5:c1767e94 r4:00000000
<4>[    9.234436] [<c0435c5c>] (update_charger+0x0/0xc4) from [<c0435d40>] =
(psy_changed+0x20/0x48)
<4>[    9.243804]  r5:d782e000 r4:c1767e94
<4>[    9.247802] [<c0435d20>] (psy_changed+0x0/0x48) from [<c0435dec>] (po=
lling_timer_func+0x84/0xb8)
<4>[    9.257537]  r4:c1767e94 r3:00000002
<4>[    9.261566] [<c0435d68>] (polling_timer_func+0x0/0xb8) from [<c00537e=
4>] (run_timer_softirq+0x17c/0x3ec)
<4>[    9.272033]  r4:c1767eb0 r3:00000000
<4>[    9.276062] [<c0053668>] (run_timer_softirq+0x0/0x3ec) from [<c004b00=
0>] (__do_softirq+0xf0/0x298)
<4>[    9.286010] [<c004af10>] (__do_softirq+0x0/0x298) from [<c004b650>] (=
irq_exit+0x98/0xa0)
<4>[    9.295013] [<c004b5b8>] (irq_exit+0x0/0xa0) from [<c000edbc>] (handl=
e_IRQ+0x60/0xc0)
<4>[    9.303680]  r4:c1194e98 r3:c00bc778
<4>[    9.307708] [<c000ed5c>] (handle_IRQ+0x0/0xc0) from [<c0008504>] (gic=
_handle_irq+0x34/0x68)
<4>[    9.316955]  r8:000ac383 r7:d782fc3c r6:d782fc08 r5:c11936c4 r4:e0802=
100
<4>[    9.324310] r3:c026ba48
<4>[    9.327301] [<c00084d0>] (gic_handle_irq+0x0/0x68) from [<c068c2c0>] =
(__irq_svc+0x40/0x74)
<4>[    9.336456] Exception stack(0xd782fc08 to 0xd782fc50)
<4>[    9.342041] fc00:                   d6e30e6c ac383627 00000000 ac3834=
17 ea19c000 ea200000
<4>[    9.351104] fc20: beffffff 00000667 000ac383 d6e30670 d6e3066c d782fc=
94 d782fbe8 d782fc50
<4>[    9.360168] fc40: c026ba48 c001d1f0 00000113 ffffffff

Fixes: b2998049cfae ("[BATTERY] pda_power platform driver")
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/pda_power.c | 49 ++++++++++++++++++++++++++-----------------=
----
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/power/pda_power.c b/drivers/power/pda_power.c
index dfe1ee89f7c7..922a86787c5c 100644
--- a/drivers/power/pda_power.c
+++ b/drivers/power/pda_power.c
@@ -30,9 +30,9 @@ static inline unsigned int get_irq_flags(struct resource =
*res)
 static struct device *dev;
 static struct pda_power_pdata *pdata;
 static struct resource *ac_irq, *usb_irq;
-static struct timer_list charger_timer;
-static struct timer_list supply_timer;
-static struct timer_list polling_timer;
+static struct delayed_work charger_work;
+static struct delayed_work polling_work;
+static struct delayed_work supply_work;
 static int polling;
 static struct power_supply *pda_psy_ac, *pda_psy_usb;
=20
@@ -140,7 +140,7 @@ static void update_charger(void)
 	}
 }
=20
-static void supply_timer_func(unsigned long unused)
+static void supply_work_func(struct work_struct *work)
 {
 	if (ac_status =3D=3D PDA_PSY_TO_CHANGE) {
 		ac_status =3D new_ac_status;
@@ -161,11 +161,12 @@ static void psy_changed(void)
 	 * Okay, charger set. Now wait a bit before notifying supplicants,
 	 * charge power should stabilize.
 	 */
-	mod_timer(&supply_timer,
-		  jiffies + msecs_to_jiffies(pdata->wait_for_charger));
+	cancel_delayed_work(&supply_work);
+	schedule_delayed_work(&supply_work,
+			      msecs_to_jiffies(pdata->wait_for_charger));
 }
=20
-static void charger_timer_func(unsigned long unused)
+static void charger_work_func(struct work_struct *work)
 {
 	update_status();
 	psy_changed();
@@ -184,13 +185,14 @@ static irqreturn_t power_changed_isr(int irq, void *p=
ower_supply)
 	 * Wait a bit before reading ac/usb line status and setting charger,
 	 * because ac/usb status readings may lag from irq.
 	 */
-	mod_timer(&charger_timer,
-		  jiffies + msecs_to_jiffies(pdata->wait_for_status));
+	cancel_delayed_work(&charger_work);
+	schedule_delayed_work(&charger_work,
+			      msecs_to_jiffies(pdata->wait_for_status));
=20
 	return IRQ_HANDLED;
 }
=20
-static void polling_timer_func(unsigned long unused)
+static void polling_work_func(struct work_struct *work)
 {
 	int changed =3D 0;
=20
@@ -211,8 +213,9 @@ static void polling_timer_func(unsigned long unused)
 	if (changed)
 		psy_changed();
=20
-	mod_timer(&polling_timer,
-		  jiffies + msecs_to_jiffies(pdata->polling_interval));
+	cancel_delayed_work(&polling_work);
+	schedule_delayed_work(&polling_work,
+			      msecs_to_jiffies(pdata->polling_interval));
 }
=20
 #if IS_ENABLED(CONFIG_USB_PHY)
@@ -250,8 +253,9 @@ static int otg_handle_notification(struct notifier_bloc=
k *nb,
 	 * Wait a bit before reading ac/usb line status and setting charger,
 	 * because ac/usb status readings may lag from irq.
 	 */
-	mod_timer(&charger_timer,
-		  jiffies + msecs_to_jiffies(pdata->wait_for_status));
+	cancel_delayed_work(&charger_work);
+	schedule_delayed_work(&charger_work,
+			      msecs_to_jiffies(pdata->wait_for_status));
=20
 	return NOTIFY_OK;
 }
@@ -300,8 +304,8 @@ static int pda_power_probe(struct platform_device *pdev=
)
 	if (!pdata->ac_max_uA)
 		pdata->ac_max_uA =3D 500000;
=20
-	setup_timer(&charger_timer, charger_timer_func, 0);
-	setup_timer(&supply_timer, supply_timer_func, 0);
+	INIT_DELAYED_WORK(&charger_work, charger_work_func);
+	INIT_DELAYED_WORK(&supply_work, supply_work_func);
=20
 	ac_irq =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "ac");
 	usb_irq =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "usb");
@@ -385,9 +389,10 @@ static int pda_power_probe(struct platform_device *pde=
v)
=20
 	if (polling) {
 		dev_dbg(dev, "will poll for status\n");
-		setup_timer(&polling_timer, polling_timer_func, 0);
-		mod_timer(&polling_timer,
-			  jiffies + msecs_to_jiffies(pdata->polling_interval));
+		INIT_DELAYED_WORK(&polling_work, polling_work_func);
+		cancel_delayed_work(&polling_work);
+		schedule_delayed_work(&polling_work,
+				      msecs_to_jiffies(pdata->polling_interval));
 	}
=20
 	if (ac_irq || usb_irq)
@@ -433,9 +438,9 @@ static int pda_power_remove(struct platform_device *pde=
v)
 		free_irq(ac_irq->start, pda_psy_ac);
=20
 	if (polling)
-		del_timer_sync(&polling_timer);
-	del_timer_sync(&charger_timer);
-	del_timer_sync(&supply_timer);
+		cancel_delayed_work_sync(&polling_work);
+	cancel_delayed_work_sync(&charger_work);
+	cancel_delayed_work_sync(&supply_work);
=20
 	if (pdata->is_usb_online)
 		power_supply_unregister(pda_psy_usb);
--=20
2.14.1
