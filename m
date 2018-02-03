Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683573-2-3687371261800455647
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683572; b=MxB0FAXd1tS0bNoOV2DEZkhcnRp8SmCSZNwyxolMAqbrvAx
    p5VzUABUkoWp3riA6qjsIMJI4iXfsSN6c9j2NChYWTIG4tCxeAvtFGYlFEMJHw1s
    2aLNssOgICWChFICe/jC3a2L81H1w8ymOfSCEBgQicm3VSvPmaXyuyieAJgTtJ4i
    YXRo4F7OS8B109726jigiAO5DRcw0K4ZXQ7qEn0evksyDHS7XdANEdphWF4Xvjqo
    uD1UCjczDD930cdwRkKF5R606dtHmhu0pNm3tRPhiLPuNXjarQ+ygAcrPoXHR3pS
    InWFv0QlaRzFTDZE2zwJ2A92xh6dxJ/dVN0niIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683572; bh=ZRrtx2
    fW+AnlW8rZ8LLs2NEJ0Ug/nz4k5wtPiWNPZus=; b=JMS87qR7vj8YEIfqmjHSjF
    bHS3+GMv9bBHWm3KDVwPPTmbugTUiiUxsaxF9JwuqOsr+akwdeQveXaNSO8DXW9v
    wSQliGvzDdTM2vI7yeRmuttSEVKYpwpm4VMEIQ2asAUYgs2sAppDM9Wb4qLhjivb
    4aeDh/FNvnSZgsuyqFp1/IwjYmaToiWq/kdmvStjrlAISJ9V5NIrLFlqg0iNN4ye
    O5MDOzMFPzvrdNPg+STt7o0crqeJpYQMyxpkMduSW4unB2RJj7aV8StO6IGnfyO4
    7fCkFwncJ1ym02su+Y1C2H5B1KBlPg4EqAS2P+U3Kc8FPArN9VcudnzGuswebpcQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FHwOwxFJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FHwOwxFJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeBCSqF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:05 -0500
Received: from mail-bl2nam02on0109.outbound.protection.outlook.com ([104.47.38.109]:45293
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753083AbeBCSCS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tushar Dave <tushar.n.dave@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 078/110] e1000: fix disabling
 already-disabled warning
Thread-Topic: [PATCH AUTOSEL for 4.14 078/110] e1000: fix disabling
 already-disabled warning
Thread-Index: AQHTnRj+TKdib96NFEaQw0p1UWuXIg==
Date: Sat, 3 Feb 2018 18:01:19 +0000
Message-ID: <20180203180015.29073-78-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:8wHgpdI4L3nnUckGfnxRjqu3ZMwKgqL2Pd1zNWArkgn3a8BzoTmRu5VKmIpyYCXX1CQxRghBjacorYqDuy2AOxC+Pi0cXj6JUrBnnD65QJkuwGvvSMY1bNDvBqPX069Be/R3XR66d/8+kVj647L6+tOEs3ZdtknHWq/fkQVdluBd3Ctj3PUGlu8EnqYJyb1dsvXUnYwfL88tKX56pi23tuWuRvwHotN4EJ2h4COAvx/OmvIcKFK69JC2jICBmEi3AwjhEZ0QoPlclEpkAE7laTUtKMfVZy6sDJT49lMEzKjevUY3wnqGT4zNSvGT9tvoS6tA0aqX79/vdqoqQJ3yTh9fpQcOJNwjj54GjKo32PoFLOY3mh33gMdNdZlCW+VS;5:DsZUIXcXSqJWpMbzRr7f1MtcpbDWSt8Op1Zg4iwuI5ulLAzbW3Be/9YCQqkEsqYgMwHyRQb6vWGOW/9MFs6kwDg+KDT1Wj6Hbn3U7RoLJIsYLhWf2kl+q2zwOeNpJktantM+80X+6DWBW4McrqfUZ3rRpcaZRh/ICs1b+/U108A=;24:W8OqIZNjEe18J/RmdVaRaC7WhKoCIdHZuwvvSVa2Exj1FQY4Z7wEV4C7DRgeCcFvNyDFjbFVqsls4vvY7vQ3qlI/5mIEopYLgsrJfqfpNXw=;7:gUu6m0h7ngxOLzsmMeCXPXKQSj+qaaRRjk6lVjDEA2uYrr4NbODFXPkbDs6udKtalr92+hKT9QDo6a7oVyXiSYTburB3PQrUlZifc9rHPippgEFy5cGt8ppH0HuqkmzmE/QabvidFpE10dzZeykkUiJmzUQEXlOaIGWYGn6psRtRYbl99PjQLfQ/WkbghGgCCxwHX0m9eZRo/SXr1UbOjCSHlvVcBOWKEiVN/1SPB80zp3M7ZnvPhcftkmCUAMEw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e08e5a7-5659-40d2-c2e8-08d56b303f47
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041A13DBFF0F7013DA44031FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: A7GcB1eVSG4iSIL82HszJ/eih6HyhpCae5Z4uqVSFxnXqltfb309wHck60FhBvE0TKurT/wu/6ndRc3cjAcp8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e08e5a7-5659-40d2-c2e8-08d56b303f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:19.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tushar Dave <tushar.n.dave@oracle.com>

[ Upstream commit 0b76aae741abb9d16d2c0e67f8b1e766576f897d ]

This patch adds check so that driver does not disable already
disabled device.

[   44.637743] advantechwdt: Unexpected close, not stopping watchdog!
[   44.997548] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input6
[   45.013419] e1000 0000:00:03.0: disabling already-disabled device
[   45.013447] ------------[ cut here ]------------
[   45.014868] WARNING: CPU: 1 PID: 71 at drivers/pci/pci.c:1641 pci_disabl=
e_device+0xa1/0x105:
						pci_disable_device at drivers/pci/pci.c:1640
[   45.016171] CPU: 1 PID: 71 Comm: rcu_perf_shutdo Not tainted 4.14.0-0133=
0-g3c07399 #1
[   45.017197] task: ffff88011bee9e40 task.stack: ffffc90000860000
[   45.017987] RIP: 0010:pci_disable_device+0xa1/0x105:
						pci_disable_device at drivers/pci/pci.c:1640
[   45.018603] RSP: 0000:ffffc90000863e30 EFLAGS: 00010286
[   45.019282] RAX: 0000000000000035 RBX: ffff88013a230008 RCX: 00000000000=
00000
[   45.020182] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00203
[   45.021084] RBP: ffff88013a3f31e8 R08: 0000000000000001 R09: 00000000000=
00000
[   45.021986] R10: ffffffff827ec29c R11: 0000000000000002 R12: 00000000000=
00001
[   45.022946] R13: ffff88013a230008 R14: ffff880117802b20 R15: ffffc900008=
63e8f
[   45.023842] FS:  0000000000000000(0000) GS:ffff88013fd00000(0000) knlGS:=
0000000000000000
[   45.024863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.025583] CR2: ffffc900006d4000 CR3: 000000000220f000 CR4: 00000000000=
006a0
[   45.026478] Call Trace:
[   45.026811]  __e1000_shutdown+0x1d4/0x1e2:
						__e1000_shutdown at drivers/net/ethernet/intel/e1000/e1000_main.c:516=
2
[   45.027344]  ? rcu_perf_cleanup+0x2a1/0x2a1:
						rcu_perf_shutdown at kernel/rcu/rcuperf.c:627
[   45.027883]  e1000_shutdown+0x14/0x3a:
						e1000_shutdown at drivers/net/ethernet/intel/e1000/e1000_main.c:5235
[   45.028351]  device_shutdown+0x110/0x1aa:
						device_shutdown at drivers/base/core.c:2807
[   45.028858]  kernel_power_off+0x31/0x64:
						kernel_power_off at kernel/reboot.c:260
[   45.029343]  rcu_perf_shutdown+0x9b/0xa7:
						rcu_perf_shutdown at kernel/rcu/rcuperf.c:637
[   45.029852]  ? __wake_up_common_lock+0xa2/0xa2:
						autoremove_wake_function at kernel/sched/wait.c:376
[   45.030414]  kthread+0x126/0x12e:
						kthread at kernel/kthread.c:233
[   45.030834]  ? __kthread_bind_mask+0x8e/0x8e:
						kthread at kernel/kthread.c:190
[   45.031399]  ? ret_from_fork+0x1f/0x30:
						ret_from_fork at arch/x86/entry/entry_64.S:443
[   45.031883]  ? kernel_init+0xa/0xf5:
						kernel_init at init/main.c:997
[   45.032325]  ret_from_fork+0x1f/0x30:
						ret_from_fork at arch/x86/entry/entry_64.S:443
[   45.032777] Code: 00 48 85 ed 75 07 48 8b ab a8 00 00 00 48 8d bb 98 00 =
00 00 e8 aa d1 11 00 48 89 ea 48 89 c6 48 c7 c7 d8 e4 0b 82 e8 55 7d da ff =
<0f> ff b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 f0 b1 61 82
[   45.035222] ---[ end trace c257137b1b1976ef ]---
[   45.037838] ACPI: Preparing to enter system sleep state S5

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Tested-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000.h      |  3 ++-
 drivers/net/ethernet/intel/e1000/e1000_main.c | 27 ++++++++++++++++++++++-=
----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/etherne=
t/intel/e1000/e1000.h
index d7bdea79e9fa..8fd2458060a0 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -331,7 +331,8 @@ struct e1000_adapter {
 enum e1000_state_t {
 	__E1000_TESTING,
 	__E1000_RESETTING,
-	__E1000_DOWN
+	__E1000_DOWN,
+	__E1000_DISABLED
 };
=20
 #undef pr_fmt
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/et=
hernet/intel/e1000/e1000_main.c
index 1982f7917a8d..3dd4aeb2706d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -945,7 +945,7 @@ static int e1000_init_hw_struct(struct e1000_adapter *a=
dapter,
 static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *e=
nt)
 {
 	struct net_device *netdev;
-	struct e1000_adapter *adapter;
+	struct e1000_adapter *adapter =3D NULL;
 	struct e1000_hw *hw;
=20
 	static int cards_found;
@@ -955,6 +955,7 @@ static int e1000_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 	u16 tmp =3D 0;
 	u16 eeprom_apme_mask =3D E1000_EEPROM_APME;
 	int bars, need_ioport;
+	bool disable_dev =3D false;
=20
 	/* do not allocate ioport bars when not needed */
 	need_ioport =3D e1000_is_need_ioport(pdev);
@@ -1259,11 +1260,13 @@ err_mdio_ioremap:
 	iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
+	disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
 err_alloc_etherdev:
 	pci_release_selected_regions(pdev, bars);
 err_pci_reg:
-	pci_disable_device(pdev);
+	if (!adapter || disable_dev)
+		pci_disable_device(pdev);
 	return err;
 }
=20
@@ -1281,6 +1284,7 @@ static void e1000_remove(struct pci_dev *pdev)
 	struct net_device *netdev =3D pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter =3D netdev_priv(netdev);
 	struct e1000_hw *hw =3D &adapter->hw;
+	bool disable_dev;
=20
 	e1000_down_and_stop(adapter);
 	e1000_release_manageability(adapter);
@@ -1299,9 +1303,11 @@ static void e1000_remove(struct pci_dev *pdev)
 		iounmap(hw->flash_address);
 	pci_release_selected_regions(pdev, adapter->bars);
=20
+	disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
=20
-	pci_disable_device(pdev);
+	if (disable_dev)
+		pci_disable_device(pdev);
 }
=20
 /**
@@ -5156,7 +5162,8 @@ static int __e1000_shutdown(struct pci_dev *pdev, boo=
l *enable_wake)
 	if (netif_running(netdev))
 		e1000_free_irq(adapter);
=20
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
+		pci_disable_device(pdev);
=20
 	return 0;
 }
@@ -5200,6 +5207,10 @@ static int e1000_resume(struct pci_dev *pdev)
 		pr_err("Cannot enable PCI device from suspend\n");
 		return err;
 	}
+
+	/* flush memory to make sure state is correct */
+	smp_mb__before_atomic();
+	clear_bit(__E1000_DISABLED, &adapter->flags);
 	pci_set_master(pdev);
=20
 	pci_enable_wake(pdev, PCI_D3hot, 0);
@@ -5274,7 +5285,9 @@ static pci_ers_result_t e1000_io_error_detected(struc=
t pci_dev *pdev,
=20
 	if (netif_running(netdev))
 		e1000_down(adapter);
-	pci_disable_device(pdev);
+
+	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
+		pci_disable_device(pdev);
=20
 	/* Request a slot slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -5302,6 +5315,10 @@ static pci_ers_result_t e1000_io_slot_reset(struct p=
ci_dev *pdev)
 		pr_err("Cannot re-enable PCI device after reset.\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
+
+	/* flush memory to make sure state is correct */
+	smp_mb__before_atomic();
+	clear_bit(__E1000_DISABLED, &adapter->flags);
 	pci_set_master(pdev);
=20
 	pci_enable_wake(pdev, PCI_D3hot, 0);
--=20
2.11.0
