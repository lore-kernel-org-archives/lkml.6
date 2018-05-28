Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeE1SgG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:36:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933255AbeE1SgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:36:04 -0400
From: Song Liu <songliubraving@fb.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Song Liu <liu.song.a23@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, "Kernel Team" <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
Thread-Topic: WARNING and PANIC in irq_matrix_free
Thread-Index: AQHT9GSPvVlQSgBGI0+pRnF2w/wY8aRE+2SAgACA+QA=
Date: Mon, 28 May 2018 18:34:57 +0000
Message-ID: <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
 <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
 <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
 <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR00MB227;7:MUIsF5X+6YbEbsCJrhjRf2uGntFji+1O19yfwCv3rg42I7J3yzTXUoJl3TDn5977O+DMUsLFkkjhnf9akWjAym/PEbeo3yhDbPTQnPB4xlSTV11m7Kn/vz950ZL+pxEnbO1ES5vRE065/fCAXYt88fjM/fdp/7SoKctFblQfy4Y77WKhQryGY54alU3p4DMIaBp4zFZcgs4Vkt3KFZpqCKPL6NG7DN9RWODD6hOJUDIMjzYpCBqFPGH7zUowZgFP;20:yNZFwWR6p16inO3wSyoFX5TLQbIUdhQxTA3TtaoSN9Tv7J2Kq1OrW61J9gZARicQUUGnUxa3dbrg1fVvy+ncFrjLeTTQWwX4WZvQ2iUJ+cz7QvdIFomiJL4To/h1BI7e+lpFpS8dajM2BTgLYzii4j8Q0s/+8BzIjR1AQerYR3Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHSPR00MB227;
x-ms-traffictypediagnostic: MWHSPR00MB227:
x-microsoft-antispam-prvs: <MWHSPR00MB22753F0030B12BC15F0E84FB36E0@MWHSPR00MB227.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHSPR00MB227;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR00MB227;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(33656002)(476003)(6916009)(5660300001)(4326008)(6246003)(105586002)(46003)(39060400002)(5250100002)(106356001)(50226002)(8676002)(81156014)(14454004)(81166006)(76176011)(59450400001)(25786009)(2900100001)(8936002)(6512007)(53936002)(45080400002)(53546011)(305945005)(7736002)(97736004)(102836004)(186003)(6506007)(86362001)(6116002)(99286004)(478600001)(3660700001)(82746002)(575784001)(316002)(68736007)(3280700002)(93886005)(83716003)(2906002)(446003)(11346002)(36756003)(6486002)(6436002)(57306001)(486006)(229853002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR00MB227;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Pc0d/GckgDdsofsJBh6c1PZ1ajNHVvdSv6LyKIQWYGaVqgUoo1Ej/VLWJGxxFURjBgx5fUWHvw50VOj+4QFA145BhyqQzVc/cmkcZN5lKZQSJiGYfj4SGTZR2ydpIaq4tUtSYi4yEfYt5Bf5S5/Q+dHlTgOTKrGBUOD49KkyCs8sOMB4yqhNYM6LgRmDOB8P
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29B5AEA22B2835438DE13D3D1369D53A@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0e8644bd-1f46-4a8c-feb0-08d5c4c9b6a4
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8644bd-1f46-4a8c-feb0-08d5c4c9b6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 18:34:57.3592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB227
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SIaC4I019867



> On May 28, 2018, at 3:53 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Fri, 25 May 2018, Song Liu wrote:
>> On Wed, May 23, 2018 at 1:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> On Wed, 23 May 2018, Tariq Toukan wrote:
>>>> I have your patch merged into my internal branch, it prints the following:
>>>> 
>>>> [ 4898.226258] Trying to clear prev_vector: 0
>>>> [ 4898.226439] Trying to clear prev_vector: 0
>>>> 
>>>> i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.
>>> 
>>> Could you please enable the vector and irq matrix trace points and capture
>>> the trace when this happens?
> 
> Does the patch below fix it?
> 
> Thanks,
> 
> 	tglx
> 
> 8<-------------------
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index bb6f7a2148d7..54af3d4884b1 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -148,6 +148,7 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
> 	 * prev_vector for this and the offlined target case.
> 	 */
> 	apicd->prev_vector = 0;
> +	apicd->move_in_progress = false;
> 	if (!apicd->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
> 		goto setnew;
> 	/*

This doesn't fix the issue with bnxt. Here is a trace with this patch:

[  569.222495] WARNING: CPU: 20 PID: 0 at kernel/irq/matrix.c:373 irq_matrix_free+0x32/0xd0
[  569.238811] BUG: unable to handle kernel
[  569.238811] NULL pointer dereference
[  569.238812]  at 0000000000000000
[  569.238812] IP: bnxt_poll+0x163/0x830
[  569.238812] PGD 0
[  569.238812] P4D 0
[  569.238813] Oops: 0002 [#1] SMP PTI
[  569.238813] Modules linked in:
[  569.238813]  nfsv3
[  569.238814]  nfs
[  569.238814]  fscache
[  569.238814]  ip6table_raw
[  569.238814]  ip6table_mangle
[  569.238815]  iptable_raw
[  569.238815]  iptable_mangle
[  569.238815]  ip6table_filter
[  569.238816]  xt_NFLOG
[  569.238816]  xt_comment
[  569.238816]  xt_statistic
[  569.238816]  iptable_filter
[  569.238817]  nfnetlink_log
[  569.238817]  tcp_diag
[  569.238817]  inet_diag
[  569.238817]  sb_edac
[  569.238818]  x86_pkg_temp_thermal
[  569.238818]  intel_powerclamp
[  569.238818]  coretemp
[  569.238818]  kvm_intel
[  569.238818]  kvm
[  569.238819]  irqbypass
[  569.238819]  iTCO_wdt
[  569.238819]  iTCO_vendor_support
[  569.238819]  lpc_ich
[  569.238819]  efivars
[  569.238820]  mfd_core
[  569.238820]  i2c_i801
[  569.238820]  ipmi_si
[  569.238820]  ipmi_devintf
[  569.238820]  ipmi_msghandler
[  569.238821]  button
[  569.238821]  acpi_cpufreq
[  569.238821]  sch_fq_codel
[  569.238821]  nfsd
[  569.238821]  nfs_acl
[  569.238822]  lockd
[  569.238822]  auth_rpcgss
[  569.238822]  oid_registry
[  569.238822]  grace
[  569.238822]  sunrpc
[  569.238823]  fuse
[  569.238823]  loop
[  569.238823]  efivarfs
[  569.238823]  autofs4
[  569.238824] CPU: 20 PID: 0 Comm: swapper/20 Not tainted 4.16.0-00391-g3742c6a #813
[  569.238824] Hardware name: Quanta Leopard ORv2-DDR4/Leopard ORv2-DDR4, BIOS F06_3B12 08/17/2017
[  569.238824] RIP: 0010:bnxt_poll+0x163/0x830
[  569.238825] RSP: 0018:ffff883ffef83b18 EFLAGS: 00010006
[  569.238825] RAX: 000000002c000000 RBX: 0000000000000000 RCX: 0000000000000000
[  569.238825] RDX: 0000000000000000 RSI: ffff881fdc53c000 RDI: ffff881f55a1da80
[  569.238826] RBP: ffff883ffef83b60 R08: 0000000000000011 R09: 000000004fbf4c8d
[  569.238826] R10: ffff883ffef83ab0 R11: ffff883fec6eee02 R12: ffff881ff6be2780
[  569.238826] R13: 0000000000000000 R14: ffff881f55a1da80 R15: 0000000000000000
[  569.238827] FS:  0000000000000000(0000) GS:ffff883ffef80000(0000) knlGS:0000000000000000
[  569.238827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  569.238827] CR2: 0000000000000000 CR3: 000000000220a003 CR4: 00000000003606e0
[  569.238827] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  569.238828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  569.238828] Call Trace:
[  569.238828]  <IRQ>
[  569.238828]  ? __skb_tx_hash+0x94/0xb0
[  569.238829]  netpoll_poll_dev+0xc5/0x1a0
[  569.238829]  netpoll_send_skb_on_dev+0x12c/0x200
[  569.238829]  netpoll_send_udp+0x2d5/0x410
[  569.238829]  write_ext_msg+0x1e7/0x200
[  569.238830]  ? scnprintf+0x3a/0x70
[  569.238830]  console_unlock+0x35c/0x530
[  569.238830]  vprintk_emit+0x225/0x340
[  569.238830]  ? irq_matrix_free+0x32/0xd0
[  569.238831]  vprintk_default+0x1f/0x30
[  569.238831]  vprintk_func+0x35/0x70
[  569.238831]  printk+0x43/0x4b
[  569.238832]  ? irq_matrix_free+0x32/0xd0
[  569.238832]  __warn+0x6f/0x150
[  569.238832]  ? irq_matrix_free+0x32/0xd0
[  569.238832]  report_bug+0x83/0xe0
[  569.238833]  do_invalid_op+0x2c/0x70
[  569.238833]  invalid_op+0x1b/0x40
[  569.238833] RIP: 0010:irq_matrix_free+0x32/0xd0
[  569.238834] RSP: 0018:ffff883ffef83f58 EFLAGS: 00010002
[  569.238834] RAX: 0000000000000014 RBX: 0000000000014140 RCX: 0000000000000000
[  569.238835] RDX: 0000000000000000 RSI: 0000000000000014 RDI: ffff881fff028c00
[  569.238835] RBP: ffff883ffef83fc0 R08: ffff883ffefa1c40 R09: 0000000000000000
[  569.238836] R10: 0000000000000000 R11: 0000000000000000 R12: ffff883ffefa4e00
[  569.238836] R13: 0000000000000000 R14: 0000000000000014 R15: ffff881fff028c00
[  569.238836]  ? free_moved_vector+0x60/0x110
[  569.238836]  smp_irq_move_cleanup_interrupt+0x91/0xa9
[  569.238837]  irq_move_cleanup_interrupt+0xc/0x20
[  569.238837]  </IRQ>
[  569.238837] RIP: 0010:cpuidle_enter_state+0xb6/0x2c0
[  569.238837] RSP: 0018:ffffc9000c5d7e80 EFLAGS: 00000246
[  569.238838]  ORIG_RAX: ffffffffffffffdf
[  569.238838] RAX: ffff883ffefa1080 RBX: ffffe8ffff780d00 RCX: 000000000000001f
[  569.238838] RDX: 20c49ba5e353f7cf RSI: 0000000000000004 RDI: 0000000000000000
[  569.238838] RBP: ffffc9000c5d7eb8 R08: fffa7b7805587a32 R09: ffffffff822ec140
[  569.238839] R10: ffffc9000c5d7e60 R11: 0000000000004817 R12: 0000000000000004
[  569.238839] R13: 0000000000000004 R14: 0000000000000014 R15: 0000008487066592
[  569.238839]  cpuidle_enter+0x17/0x20
[  569.238839]  call_cpuidle+0x2d/0x40
[  569.238840]  do_idle+0x109/0x1a0
[  569.238840]  cpu_startup_entry+0x1d/0x20
[  569.238840]  start_secondary+0x10e/0x120
[  569.238840]  secondary_startup_64+0xa5/0xb0
[  569.238841] Code:
[  569.238841] 89
[  569.238841] 02
[  569.238841] 41
[  569.238841] f6
[  569.238842] 44
[  569.238842] 24
[  569.238842] 36
[  569.238842] 40
[  569.238842] 74
[  569.238842] 02
[  569.238843] 89
[  569.238843] 02
[  569.238843] 8b
[  569.238843] 44
[  569.238843] 24
[  569.238843] 1c
[  569.238844] 49
[  569.238844] 8b
[  569.238844] 96
[  569.238844] c8
[  569.238844] 00
[  569.238844] 00
[  569.238845] 00
[  569.238845] 41
[  569.238845] 89
[  569.238845] 86
[  569.238845] c0
[  569.238845] 00
[  569.238846] 00
[  569.238846] 00
[  569.238846] 41
[  569.238846] 23
[  569.238846] 84
[  569.238846] 24
[  569.238847] d4
[  569.238847] 00
[  569.238847] 00
[  569.238847] 00
[  569.238847] 0d
[  569.238847] 00
[  569.238848] 00
[  569.238848] 00
[  569.238848] 2c
[  569.238848] <89>
[  569.238848] 02
[  569.238848] 85
[  569.238849] db
[  569.238849] 0f
[  569.238849] 85
[  569.238849] e7
[  569.238849] 00
[  569.238849] 00
[  569.238850] 00
[  569.238850] f6
[  569.238850] 44
[  569.238850] 24
[  569.238850] 1b
[  569.238850] 01
[  569.238851] 74
[  569.238851] 40
[  569.238851] 49
[  569.238851] 8b
[  569.238851] 96
[  569.238851] a8
[  569.238852] RIP: bnxt_poll+0x163/0x830 RSP: ffff883ffef83b18
[  569.238852] CR2: 0000000000000000
