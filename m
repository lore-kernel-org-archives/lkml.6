Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681356-2-13441226752949139071
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
    t=1517681355; b=CbjKjVmypuWzxWLv3MrfTmAnOge0esLODZt4gFoPhPs1QCl
    ZxlRwijA8MYXBnttINwLRtWd7bwj0fNOUPxGNHEz8sXyPeOAA9aPrav8JvmKXlcn
    wrpYDruGiQcTOV5w19Zdb0MIjsBWgsIHcDb5vRj9ZulybbyIMGHDrtpdh3UJ2EjC
    TCNKC88rDTT44VtAt+SC1uSsfHZUNKySrgPmhLtzHnF5Oiain6GxXV1t0RoLI24v
    s5sKZc6llqzmcuQ14n2qxhh09aDnGKtcyjZJRokNNeR0IEtO1/e7M871hdJq0Y/T
    O7ASBaIbeuM7Nj/9Ee4w6F9Rp7c/nGAsSTPghWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681355; bh=oJ4cQr
    TAxG+kRHkFGADQxgXB5en2dV59E3PrXWWdXEg=; b=VBl5ciUnSw6aN8aVLBEuAh
    nPc9MnhWwMfnhfYx88wq9nwkmByl6nYVNF3Vj98h3GocxxrMo5Zw7uWWhTjt12xb
    ESyfty7tZDgFWblcW9XprIQCxCmT/zM0GyrnLglp8oascnKpE1Pz+rcw1oIIrQoR
    b7WR3q2O5XkWt0gZoz+3xQRbYBQUN1V46xFD/ur1fvnIOeknUSL+OiLMCVTCP0gF
    eKW88LztSIPIssEIckr72zfF9WsiAP+u3Z+rvndOKStmev5sV5BbrwOIEaHxV3SJ
    qW6GRAsHjXpZ24/lXPGE14X+3zmam3MoMtvdjaXUlK8ezRWLh44D4kzkRQD+488Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V261+6Qo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V261+6Qo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeBCSJG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:09:06 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752602AbeBCSHZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tushar Dave <tushar.n.dave@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 15/24] e1000: fix disabling already-disabled
 warning
Thread-Topic: [PATCH AUTOSEL for 3.18 15/24] e1000: fix disabling
 already-disabled warning
Thread-Index: AQHTnRmFncS1gCVgh0uLnaKuXToZPA==
Date: Sat, 3 Feb 2018 18:05:06 +0000
Message-ID: <20180203180444.10801-15-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:tOMTI8kg4iVerIqDm0E50LgwuC3WxcrAd4yTq/8dj8L2p3xH3ZMrUYvq/cWAJOW38+P/iV9ju42woK+EXB7mBS90Kb5yaQJ0A3y3cCG5J50/aAPUtlIKJ+zb2FWhjajiRnFsDN/Pus7mMB4hiYLII/Di0CApFufNYVKXehQnMui4T4WF/2QL8yc/0bzZ4ouRJ6N1UCdcQqpguEew1sSl0A5uVQyzgIt+3F4pSvwi0WloRpPXk5gonAAnT6VYI1zjyY5beMNqtE8AWCh0tFLGpFflhHceCu85oQswJSn0hremamriqZvwFL6q61hy+mgfEW+XbiFmjQeWr9KDL+/mBJH1f9Q7WjCZBLtbOWUh4KZQ0XvYQElIepwGqMCfMc9o;5:jT7WBQH9Z7LUOCWJdDDp1vWW3c9hJjyDQRM0xw67r7AsyeulUBJy2ie+daY5odlK/HjZwetSwX/U1rilgCoF4TWl6BlwSvQTaTLtwHmQqWOtCeHuEyUF2cEF+vtbb28jS3BszJ8mMwUEfN808wY6UBYhk91AbAklpmBfpeIHAcY=;24:u3uafmgCKrCKPctv2FR2OH+KtWmyNvWmp+etM5yqUdS0rXneINGu7kBYHd3fp39TzAAY1yrH7qLLfOMhwpfer84FlqqUGuqXTn8wPyGVOU8=;7:73YI8n7k4HZttp54S/pilPQ8lqD4nbu4mEu0tAsrK25ZQTzQjvJsl890vW8UQbcOk0kCvOLjeBoIJpgi3rchasyVNbTpm+j+lfrVLwjg722a+ymw1IwOZvVyR/3vsYsvubmRymLgPYqtF2tKV+BVkmvo4VwgEF3zEYuDZKB1TPVTj6c9eGNMLVx4+BFF4pg3G8aMV6t1N1Z910jQEy38d7ynI9j+9ZDEV+nb7G64iyjIydNsKzPvmlTLLrRX/0AU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 881f707a-807f-48d1-8b54-08d56b30e154
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099384414B5CC2EFCB60A996FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: wJvV0wilwtw7HQLdp1tVzYMOmAUwu0LC2LH+HfJkvhQBIC3Yc9j6xIEckg2FlhRzrIvNoY/d3d6uJmSY9XAXFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881f707a-807f-48d1-8b54-08d56b30e154
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:06.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
index 69707108d23c..4cd6dac110f0 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -328,7 +328,8 @@ struct e1000_adapter {
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
index 3a06cae4ff68..883d971c6cca 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -940,7 +940,7 @@ static int e1000_init_hw_struct(struct e1000_adapter *a=
dapter,
 static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *e=
nt)
 {
 	struct net_device *netdev;
-	struct e1000_adapter *adapter;
+	struct e1000_adapter *adapter =3D NULL;
 	struct e1000_hw *hw;
=20
 	static int cards_found =3D 0;
@@ -950,6 +950,7 @@ static int e1000_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 	u16 tmp =3D 0;
 	u16 eeprom_apme_mask =3D E1000_EEPROM_APME;
 	int bars, need_ioport;
+	bool disable_dev =3D false;
=20
 	/* do not allocate ioport bars when not needed */
 	need_ioport =3D e1000_is_need_ioport(pdev);
@@ -1250,11 +1251,13 @@ err_mdio_ioremap:
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
@@ -1272,6 +1275,7 @@ static void e1000_remove(struct pci_dev *pdev)
 	struct net_device *netdev =3D pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter =3D netdev_priv(netdev);
 	struct e1000_hw *hw =3D &adapter->hw;
+	bool disable_dev;
=20
 	e1000_down_and_stop(adapter);
 	e1000_release_manageability(adapter);
@@ -1290,9 +1294,11 @@ static void e1000_remove(struct pci_dev *pdev)
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
@@ -5137,7 +5143,8 @@ static int __e1000_shutdown(struct pci_dev *pdev, boo=
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
@@ -5181,6 +5188,10 @@ static int e1000_resume(struct pci_dev *pdev)
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
@@ -5255,7 +5266,9 @@ static pci_ers_result_t e1000_io_error_detected(struc=
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
@@ -5283,6 +5296,10 @@ static pci_ers_result_t e1000_io_slot_reset(struct p=
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
