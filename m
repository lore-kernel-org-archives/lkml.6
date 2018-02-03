Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682196-2-11757527600292804293
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
    t=1517682195; b=AXGDuujKL49/70MYNTS5osPdr0kBHkaOLy+u+eP52qPIZW+
    3JqEmMfGDDcIHFGtDENSlYHWDCFjvV6XoFBU/NesnZSShqiII1vkhRIEeCE7daFA
    1JLPxNmFs7wMR30XjvGuAPRcVxcZzWvb36J8NjmkHc2JWxpCitCA8SeXya6Eyf5P
    BYlg4aYkg+MlqJR66Yl6QPGeheeiFHkPYLYEe/71L3vCa1lBVip12QgT9SicrCzm
    4gTELU/pnZ+R2BLmO3CNTGA/6m/DWQkTtCdjjil977lp6oYpyNw7wgrNO/KKhg7w
    GTaJuM6j7r/kZZmnSrHBRikCktgrQ6KKY+GSuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682195; bh=mcdKpI
    mONmsb1GffDD9B8JpdYAF73oJF0iYKuQ/IzBo=; b=V/ob8YPFu/QccFO7CETKPE
    vru87KxMoIF7ltdFs06Atf1l5Twq6vzsGHAhDK+A5Yb+29O+hvWLF5OzT/CHw4w7
    h+tQlOE0UtsfdqlkRKW5T0dO4AHw9shwjvHEe6t1md67E2tZB99egbHYtuqwAnbI
    WjWldfbPN8hjWiy4b4KxliUOnRWN/2L5+Pr41bXWs7h9iq90V0LIfaHw9WD+iNX0
    WgeTy7L5ed7Y3axz2S9On5jmStdcqg0Jk8p0Ds0Z+ROEYvyM4mJVFHZVk0FhAy16
    2YPKbrIBdcLI8l7+NzIba3NFvxFwP+7gEO3Pu9SDBXdOdx4Ab+PYC393QKsTqQiQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VLfuAm3L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VLfuAm3L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeBCSXL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:11 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:42587
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752542AbeBCSGc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tushar Dave <tushar.n.dave@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 21/32] e1000: fix disabling already-disabled
 warning
Thread-Topic: [PATCH AUTOSEL for 4.4 21/32] e1000: fix disabling
 already-disabled warning
Thread-Index: AQHTnRlz6s2PKpxY5EWTn/elQEkfiw==
Date: Sat, 3 Feb 2018 18:04:35 +0000
Message-ID: <20180203180413.7438-21-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;6:ra7qZCi03vUu4JRcBOwRl2AsSHWmlAdueray+YBluUOG5NS5s9TqoQFz+Nfu0R95tF2prWWzfGsczgKPhdRcSB54gLPRLY3rT+/BsBNyJvQi2vjGrAYZ8cVpzs6lcrEDdV6VY2FqHLX2RLGzbVcCzT7cVNqgcGhTZB1vsaMAvqDg+Y/4OKaX9S9zZ9+eHTHjdHbADG5wmSu2ItAVVIMEifKaDyldK6ss65HAmSqPGohXLEXhcz2z7Lp9Oyan9tOHpmSD1hqAUGcVGvlWKsgBhjz0YNRHrai3fFGcs94tlaGNdeLF1bIFDxW0fJShTy47hUyj8dgSdX88RC+47FRGn5hN1gEHBfEdbP7HBTjhrc5Y6lYUViRt9rCEQdG3JOwd;5:nFiLWqJBiD0Y+01oN8CDX+gp5kNGpf3QKWF1VuuBqefKvUFA+2kmGdDxJPN/gloQncrNdKjlezOrrY/IHM+ys+lVvvDWVW3FEltldcijR5nhzXDhoeQXFPVb9ypRvHbOuj5Wfs5KTVUTdrU/Xq8d2gizxphv2TdCUN6RS/PR+QQ=;24:XFTP/6CCINZYSgz2w61pEGX9MRz59hVmcNki+u0BK25B28WGOELLsDW0/Lr+8LJy7Mf5IxZmKF420Z5Zvf5oP+Uhi8wbozbM2r80O+AyWIU=;7:QThBqkvPdMpeVPhcX6Bxx9vdfD66SDHD8wRgOLDzx9l0Wbbe03Kma+/ZoGlW49c7EaEkxthWMkuzwWQ06Nf1cXWpUYR/vEbj3YBdL4rHpagp1hokv4d/dOW8pOdm051RusJHrCi6ltJWeNNAZIMQsd31Vu8SCx57OKmhugzyYeM/P6PapnPVoiAr0tpfcSk33okHUuVPY7lvNcIfplN1KfNc/LNNgHRVYW9gm5K2HL3PlvgPuv1WajKKbyqKyJjS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da8d4057-e41d-408c-37bf-08d56b30c540
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009F265EAA9930F59C514C4FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: QEA4vOPisFcFRr3xzBHnOlHiDzLfWzV8/r0ZuiEvRzT1Hx1Wt+eFQWGz2f0JkQy5wXQv9YSPvn8Z3ly3gjUXWg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8d4057-e41d-408c-37bf-08d56b30c540
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:35.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index 98fe5a2cd6e3..481e994490ce 100644
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
index 068023595d84..2a1d4a9d3c19 100644
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
@@ -5135,7 +5141,8 @@ static int __e1000_shutdown(struct pci_dev *pdev, boo=
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
@@ -5179,6 +5186,10 @@ static int e1000_resume(struct pci_dev *pdev)
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
@@ -5253,7 +5264,9 @@ static pci_ers_result_t e1000_io_error_detected(struc=
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
@@ -5281,6 +5294,10 @@ static pci_ers_result_t e1000_io_slot_reset(struct p=
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
