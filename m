Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeBTMHp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:07:45 -0500
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:15520
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751503AbeBTMHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:07:43 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
From: Tariq Toukan <tariqt@mellanox.com>
Subject: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Maor Gottlieb <maorg@mellanox.com>
Message-ID: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
Date: Tue, 20 Feb 2018 14:07:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: DB6PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::26) To AM2PR05MB1137.eurprd05.prod.outlook.com
 (2a01:111:e400:844d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba3ddee1-8873-4fe7-a70d-08d5785a896b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM2PR05MB1137;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB1137;3:UhtfSR34h0YREopuo6SEpWOpuI0OG/nyVrXrSPANm9pMTqqyPCA8cp4dpl17aEzx8OPHzsapIg5bunLaL7aYjZAYrxiEtSg1kJHY6Ej/pJmfMjm29Gfc6iJIrQLptSBhYPAE+c9cQEzIY6cM91qq0M32ppgp21shTLJeT4hEHhc4KqEC5canZ3j3nfVq+Hlqb0tt0gLo7a0rDEAYeUKJ9l3oSJvq+gmlxEu4gYJKlLT1AfNVy/k1OM+WJX6oL4PO;25:LiPxlv/YBi1A8USwh9eAbTeYYdltFLYR/cdpyFESE84Mp9lddqNHSuNxAVZWo7ez4z5/4r3PTBeXcz1pyRPFwZdhGdhJgUAZUHsBaZGb8R1VQHjUofseIEV/t5WoHG1fTwY/QU8TA108fpf1xUOmq55EbPLgpQmt5dJrvMFpyvQIPLt3r5kJrlGDvftvrpuI8dNOw18+sFnPlZzO+uAPwJwAlKV8nEcjNP1FEt7J5MvM7Y53NSYGrg18Xgx6Ywr0vZmj/s2rQ1xIsScc9BTtWujevJk52rHu836t66lUOc0Je1AX3M/eHoJd4bh847xp0bfP3vgvEoLJyzB1xjS1zg==;31:F1ML1wviYal9BMhP247hOhcX5rENNoC51q19yZk0Hf+q+RkCbucXwY16eNXiI4Vynu5fTpssC0JUbE5SK96TaDBfYnI86d3aH3U0mwJjo8Q2HKH7Vz1oDD2+UrktJqICxLN5Yg6zv3cv6RrDHqNaCMDn584PrFO4zVpbeUnjIJOAPIXA3yD4ITDwtlB0iYXsng1QqRpLZMt7QSoHG4lMwphvrMUue0H/vcFA2kak36g=
X-MS-TrafficTypeDiagnostic: AM2PR05MB1137:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB1137;20:hULFRcYn9Hn/r4Vcz5npaTPAcetiPwM2A6v8DEldy9jlaQ+XUF7kXlzJozaowg4EwhtW/W4SEeqAO0KydTCEEpQSotYfzMlS9ji8UNtkOqNdKNLr+oJzFfwb+txFJIBGtqXwmh6jfCdIi9/lIGhhh9G/4/7q02hYVqqC+D4UF5QCN/qw1tIbwlSDokz3xNa//LkIu1GJvzEyMbfHV/DVHj4fiq/JGxidhYsYuotgVZSSkRuELA+MOHgcpw12AiGA3r+DV+1APOhln1jBMQ87KReZOOjCn4orj/hFFWazvmOnpWQfqZd/q9JlCkszx1NuVtXvzDLax0CnRwN1TvXjpeJhceCcjsLRiKD12CN3SerbUupSIqSVwcRtKkC1oJDd2uDDY1Qeq6lb5LQKiF5el9Zp/8RMUo4/oA1eIl4kBnf/UxO1oEd/KkHYa8efjgr4UB2g6l2E8Pmg1fUOnN4v1Pu3hBBmdxoVmY2hLy2ZOBnxuR31sHtD24Pt2HvlUdp9;4:LA8cOFTVwzbuKV6qO+p2e+OEsXhYqa7XoVfdliRjopt6Skrzi8LNJdorDlMbCv0A88KI84b3Y45EFmHuAjEEGjevNwveHTw7qdgwCCl+LdQoFuUZhy70XpEJLCv5qzKNZOaxAFYSxBkrt3ti119Qqdc03tnSzJuuYjmAO9j2GlYNN5CNj99hJaeG4vgEoMEv2s6I1I03DQ9vK3QlmsXcgOY0cEarlVJ6E/xjJO5Aamr340BmdfIDHQIWZ6e/LK0/Py41JJRk3zZqOv4Q+4XYoA==
X-Microsoft-Antispam-PRVS: <AM2PR05MB1137748D1428BF4743A36C34AECF0@AM2PR05MB1137.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM2PR05MB1137;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB1137;
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(53936002)(65826007)(52146003)(2486003)(6486002)(50466002)(305945005)(23676004)(107886003)(106356001)(8676002)(478600001)(45080400002)(52116002)(230700001)(25786009)(8936002)(81156014)(81166006)(86362001)(4326008)(575784001)(6666003)(64126003)(386003)(77096007)(97736004)(26005)(6116002)(59450400001)(3846002)(58126008)(7736002)(16526019)(68736007)(316002)(65956001)(36756003)(67846002)(83506002)(31686004)(66066001)(65806001)(16576012)(5660300001)(2906002)(105586002)(31696002)(47776003)(58493002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB1137;H:[10.8.0.245];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTJQUjA1TUIxMTM3OzIzOnJ1STY0dzN4TERNK2I3czRZYnBoaUhnMFo2?=
 =?utf-8?B?Z3pNWktqR1NOa2RIS29CVnVCbG5iWXRaTDR2MndOL1hPU3YxanpzUndBRklC?=
 =?utf-8?B?dzY0Ykw3cHo1aWxFZlJubUFTSTZQTDZ6MGxCV2Z2L1F6OGVxc3RFR0l3bFVJ?=
 =?utf-8?B?VXM1empMbVNkd2tBdUMxaEs2WTEvelBGZHFRblZURUFqR1BRRjZDZG8xd2cz?=
 =?utf-8?B?dGtRTTF3cW5WTVB6WDRmdER5L09mUFoyNlp5bFJLSDNsTTMrTy9jVm1taW5q?=
 =?utf-8?B?djJuMjhHaUJTU3FLaDB3Ymd6VWZpY1ZXM2plakRXWFlzeldBWFBXY3lyMUxC?=
 =?utf-8?B?cmxKWjJHa0piV1RSTVRHcXJGbE1RVGtnZEh4WEtqZ0piVHdSeGJ4V2JWOEF0?=
 =?utf-8?B?NGNJYVo1cFM5YWxTSjA4ckNHVTBFNnkzUTdpSEJzamNPN0l5eS9zb0t6SGpG?=
 =?utf-8?B?aEFTWEVkMzNpWlJ5U2J1c1lHbS9RYkZscTFvL2VHTTE4UERBZTdsc25EMlBM?=
 =?utf-8?B?cUlOQXRnTUdYcmFmS25NK2xsSHNXcmJQYnY2c3B1K2tHQkhlYlF6TTh5SnJ6?=
 =?utf-8?B?YnlQSDR1Q09mZ3JoMGVtVThaMUJNSmhxbDhOVDZ2RTVGSDU0MmZSSlhTNEpG?=
 =?utf-8?B?cDd1S0pIUlArNUpJL2xPbFJlNnBVSE9EQitJUFVTckpPWUJKQytSS1FJQUgy?=
 =?utf-8?B?Y3dDTUt5T0JuYi9tUkVic0F3M0ZMb1ZHSlB3VUNDRkNMU3AremNUOER6RG9G?=
 =?utf-8?B?dFRQQzZOeEdZTEdkY0ZJRkpSN1lYdzgyU2NOY2l6bmVQUDBRV0V5a1FCU0lB?=
 =?utf-8?B?ai9TeFpWVExpOEwycnVPSFp2UHZXaUpPSmxQUE90aXd2aTNBcDdGbG40TkZQ?=
 =?utf-8?B?bStkZGhObnQ1S3FIWDJjMm92NVByblBuZjYwelV5VWt6aU10YzcwbVpWSy9T?=
 =?utf-8?B?aXRzSkNVeVo1YkhrYjFTZCt5dnpueXZITGhJMStqY1lCc2tidUVlM0dLOTFG?=
 =?utf-8?B?enkrUEZyUUR1Vks1cmFXcUJOVmVsNUJuM2lEY3Jlc0U2YkE2UHhGZVV1TEJY?=
 =?utf-8?B?R0JFS3lXQTIwL1FMWXpwUmRna1ZONENxamZHK3p2NG1LSGhNM3JjbDI3SFlq?=
 =?utf-8?B?SjBOWm15TzNianpCdjhHTUVCSTBqSlRQdXU3bEhjUU5TUGhjbG9TZEI5Q2NY?=
 =?utf-8?B?a0plMVgvQ0V0OHFONDVGYjBrb0cxcmxSZkpjTlZnY1FRVGN6eG1DQTZXSHRE?=
 =?utf-8?B?V1BkY0RmTDNjU0FzL1dOOVpEY1VoWXFrQmR0QUxxc3V0c2Eva0VzOGZiTW5n?=
 =?utf-8?B?V0svSTY1cnVjVDBVMWUvbGxWRWpxWGdXeldCSHRVZWZKU0pwaXAzYmRmcHMr?=
 =?utf-8?B?ckduRmJSMHVwRUhoa0toWU1ZM1pST21pVUp6WmpPUGRmZ1BxajdMdy9mcTRX?=
 =?utf-8?B?WkQ4clhkU09GYVkzelZGaFZUb0NiWCtmeExBWEU3WFBSQ0pBczFxc01LbVV4?=
 =?utf-8?B?cVpzRGRrYklKeEZGY2Y2N2NNR0VvSW9tR2R6T3dsZnVVRmhscGRwMTZCOVFm?=
 =?utf-8?B?VytCSDdXeXA5aHZrcjlERnVtK3BLdGFKZTh3RDF4YmJJSFYxSnpnNEUzeXUv?=
 =?utf-8?B?dVVMSFZpYVhnenJzUWdPWitXNHExNWozZy9nM1pVbCtpZGh2eUEvUmVwWkt3?=
 =?utf-8?B?YUxYalFTeEhFV05DdDBhOGNJMWo5N0MzeCtpd2NGY3c2MFRTdWZDU0FsNWJx?=
 =?utf-8?B?dEVHY3hzUkZ0dEFBUi8wekxiVmVIN0ZSV0Q4Z3dtZTlxZXNoVDlBamRzRTBN?=
 =?utf-8?B?K0p0L3hKczlvd1J2QnNZNEFaTVo2eGJPbVpNbER4cEVyTUE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB1137;6:0xFyqBGNEaCTBoB2qS/plOBUKxukRuaxPujH47DTiOkflv9GVHRPvAn6FOOYqIAhqQheJs5zZw8u8km9zo/2ZuqUWaAGtwdKV1Elk43pMc4GirCsJA1GflhkmYgic6DzPJlkOcuk+EHiczN7IYxnM9lZkaRV6YVko+Jo1xzJ9Y3N6j1rgVGAzmY5SGCgVEnMAuJU9a4lEPCccLtGkNwgcG3Cjvb35rsN8NyXHPJ8P3Fjy/6ZPBpo+pPg8TMBXvIi+IKVpDYphjEfS/FThfm6Pmjnwp9k6hPCSKiEzosGr54aYemyYKJkFv4SQEofEctIKK8b0gzZv5pKGI4kNW32YEKC+5f5Lyd4r0O4+9Lpds8=;5:n8sIoeKDux07NMT5YuVN9gs8FSbOuCOEZymGfXI0uiPb3VPjKL7CUoFwbkM2VUBd+EXWXlTWvZgm7xt+wZ+o7aEbpS3aRAjbIuU8t2EsBFkaHP3jlPe/+XRSJCjdGD3kf4SnnoFnYvh+jSAD2o+tZ9exSISdAWoXclMoSXQDPgI=;24:DumjXpDyaOceajZ1E1HlFS9jrCa0ItpYglvCjzX45UNKWFsBUijMtbjpU2w6sCdcYx7bRPV3O8SVzzZFTrAwyhldbFNdMUxknwsab846Tqw=;7:lBg0zz1ivikm5rWiybZ8obG28rQIE2Q9nu2foMJiE4/pgR4w6RMAXdBT1JxWXphYnxR3R5WeCZJzTljDTnW/JIcqdDPEKktMWaUpx839ItXZtsb1/IWS+HbMjNjFEDQpQDkbP1ysdeaEFZWyuheCOp8ss4EKre+ysvApMYX2/acO30fOPErquC5SZADoAtEC4YXzzfE7OHRVH9beuvyz68O6lYgKX7jnVixe1PKQzwy3kj7PCJmKrlJTxKx33yJe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 12:07:38.4624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3ddee1-8873-4fe7-a70d-08d5785a896b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB1137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

We started seeing new issues in our net-device daily regression tests.
They are related to patch [1] introduced in kernel 4.15-rc1.

We frequently see a warning in dmesg [2]. Repro is not consistent, we 
tried to narrow it down to a smaller run but couldn't.

In addition, sometimes (less frequent) the warning is followed by a 
panic [3].

I can share all needed details to help analyze this bug.
If you suspect specific flows, we can do an educated narrow down.

Regards,
Tariq


[1] 2f75d9e1c905 genirq: Implement bitmap matrix allocator

[2]
[ 8664.868564] WARNING: CPU: 5 PID: 0 at kernel/irq/matrix.c:370 
irq_matrix_free+0x30/0xd0
[ 8664.891905] Modules linked in: bonding rdma_ucm ib_ucm rdma_cm iw_cm 
ib_ipoib ib_cm ib_uverbs ib_umad mlx5_ib mlx5_core mlxfw mlx4_ib ib_core 
mlx4_en mlx4_core devlink macvlan vxlan ip6_udp_tunnel udp_tunnel 8021q 
garp mrp stp llc mst_pciconf(OE) nfsv3 nfs fscache netconsole dm_mirror 
dm_region_hash dm_log dm_mod dax kvm_intel kvm irqbypass pcspkr 
i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables 
ata_generic cirrus drm_kms_helper syscopyarea sysfillrect pata_acpi 
sysimgblt fb_sys_fops ttm drm e1000 serio_raw virtio_console i2c_core 
floppy ata_piix [last unloaded: mst_pci]
[ 8664.905117] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G           OE 
4.15.0-for-upstream-perf-2018-02-08_07-00-42-18 #1
[ 8664.907613] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS Ubuntu-1.8.2-1ubuntu2 04/01/2014
[ 8664.910144] RIP: 0010:irq_matrix_free+0x30/0xd0
[ 8664.912624] RSP: 0018:ffff88023fd43f70 EFLAGS: 00010002
[ 8664.915149] RAX: 0000000000026318 RBX: ffff880157a77ec0 RCX: 
0000000000000000
[ 8664.917679] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff880237038400
[ 8664.920244] RBP: ffff880237038400 R08: 00000000e8ba3c69 R09: 
0000000000000000
[ 8664.922813] R10: 00000000000003ff R11: 0000000000000ad9 R12: 
ffff88023fc40000
[ 8664.925345] R13: 0000000000000000 R14: 0000000000000001 R15: 
000000000000002b
[ 8664.927872] FS:  0000000000000000(0000) GS:ffff88023fd40000(0000) 
knlGS:0000000000000000
[ 8664.930455] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8664.932996] CR2: 0000000000f2c030 CR3: 000000000220a000 CR4: 
00000000000006e0
[ 8664.935557] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 8664.938051] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 8664.940541] Call Trace:
[ 8664.942980]  <IRQ>
[ 8664.945399]  free_moved_vector+0x4e/0x100
[ 8664.947787]  smp_irq_move_cleanup_interrupt+0x89/0x9e
[ 8664.950134]  irq_move_cleanup_interrupt+0x95/0xa0
[ 8664.952480]  </IRQ>
[ 8664.954800] RIP: 0010:native_safe_halt+0x2/0x10
[ 8664.957052] RSP: 0018:ffffc90000ccfee0 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdf
[ 8664.959186] RAX: ffffffff818ab6e0 RBX: ffff880236233f00 RCX: 
0000000000000000
[ 8664.960499] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[ 8664.961774] RBP: 0000000000000005 R08: 0000000000000000 R09: 
0000000000000000
[ 8664.963048] R10: 00000000000003ff R11: 0000000000000ad9 R12: 
ffff880236233f00
[ 8664.964345] R13: ffff880236233f00 R14: 0000000000000000 R15: 
0000000000000000
[ 8664.965579]  ? __cpuidle_text_start+0x8/0x8
[ 8664.966808]  default_idle+0x18/0xf0
[ 8664.968040]  do_idle+0x150/0x1d0
[ 8664.969249]  cpu_startup_entry+0x19/0x20
[ 8664.970477]  start_secondary+0x133/0x170
[ 8664.971700]  secondary_startup_64+0xa5/0xb0
[ 8664.972909] Code: 41 56 41 89 f6 41 55 41 89 d5 89 f2 41 54 4c 8b 24 
d5 60 24 18 82 55 48 89 fd 53 48 8b 47 28 44 39 6f 04 77 06 44 3b 6f 08 
72 0b <0f> ff 5b 5d 41 5c 41 5d 41 5e c3 49 01 c4 41 80 7c 24 0c 00 74
[ 8664.975420] ---[ end trace 8be4ba51cd83f4bd ]---


[3]
[ 8943.038767] BUG: unable to handle kernel paging request at 
000000037a6b561b
[ 8943.040114] IP: free_moved_vector+0x61/0x100
[ 8943.041531] PGD 0 P4D 0
[ 8943.042855] Oops: 0002 [#1] SMP PTI
[ 8943.044128] Modules linked in: bonding rdma_ucm ib_ucm rdma_cm iw_cm 
ib_ipoib ib_cm ib_uverbs ib_umad mlx5_ib mlx5_core mlxfw mlx4_ib ib_core 
mlx4_en mlx4_core devlink iptable_filter fuse btrfs xor zstd_decompress 
zstd_compress xxhash raid6_pq vfat msdos fat binfmt_misc bridge macvlan 
vxlan ip6_udp_tunnel udp_tunnel 8021q garp mrp stp llc mst_pciconf(OE) 
nfsv3 nfs fscache netconsole dm_mirror dm_region_hash dm_log dm_mod dax 
kvm_intel kvm irqbypass pcspkr i2c_piix4 nfsd auth_rpcgss nfs_acl lockd 
grace sunrpc ip_tables ata_generic cirrus drm_kms_helper syscopyarea 
sysfillrect pata_acpi sysimgblt fb_sys_fops ttm drm e1000 serio_raw 
virtio_console i2c_core floppy ata_piix [last unloaded: mst_pci]
[ 8943.052038] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W  OE 
4.15.0-for-upstream-perf-2018-02-08_07-00-42-18 #1
[ 8943.053350] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS Ubuntu-1.8.2-1ubuntu2 04/01/2014
[ 8943.054654] RIP: 0010:free_moved_vector+0x61/0x100
[ 8943.055940] RSP: 0018:ffff88023fd43fa0 EFLAGS: 00010007
[ 8943.057233] RAX: 000000037a6b561b RBX: ffff880157a77ec0 RCX: 
0000000000000001
[ 8943.058506] RDX: 00000000000155a8 RSI: 00000000000155a8 RDI: 
ffff880237038400
[ 8943.059784] RBP: ffff880157a77ec0 R08: 00000000e8ba3c69 R09: 
0000000000000000
[ 8943.061051] R10: 0000000000000000 R11: 0000000000000000 R12: 
000000007f0c0001
[ 8943.062462] R13: 00000000000155a8 R14: 0000000000000001 R15: 
0000000000cc620d
[ 8943.063726] FS:  0000000000000000(0000) GS:ffff88023fd40000(0000) 
knlGS:0000000000000000
[ 8943.064993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8943.066253] CR2: 000000037a6b561b CR3: 000000010badc000 CR4: 
00000000000006e0
[ 8943.067522] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 8943.068771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 8943.070029] Call Trace:
[ 8943.071273]  <IRQ>
[ 8943.072503]  smp_irq_move_cleanup_interrupt+0x89/0x9e
[ 8943.073794]  irq_move_cleanup_interrupt+0x95/0xa0
[ 8943.075048]  </IRQ>
[ 8943.076288] RIP: 0010:native_safe_halt+0x2/0x10
[ 8943.077530] RSP: 0018:ffffc90000ccfee0 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdf
[ 8943.078795] RAX: ffffffff818ab6e0 RBX: ffff880236233f00 RCX: 
0000000000000000
[ 8943.080077] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[ 8943.081435] RBP: 0000000000000005 R08: 00000000e8ba3c69 R09: 
0000000000000000
[ 8943.082683] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff880236233f00
[ 8943.083932] R13: ffff880236233f00 R14: 0000000000000000 R15: 
0000000000000000
[ 8943.085185]  ? __cpuidle_text_start+0x8/0x8
[ 8943.086438]  default_idle+0x18/0xf0
[ 8943.087694]  do_idle+0x150/0x1d0
[ 8943.088921]  cpu_startup_entry+0x19/0x20
[ 8943.090163]  start_secondary+0x133/0x170
[ 8943.091402]  secondary_startup_64+0xa5/0xb0
[ 8943.092659] Code: 44 00 00 48 8b 3d c8 f7 9f 01 44 89 f1 44 89 e2 44 
89 ee e8 e2 05 0b 00 48 c7 c0 20 50 01 00 4a 8d 04 e0 4a 03 04 ed 60 24 
18 82 <48> c7 00 00 00 00 00 48 8b 45 28 48 85 c0 74 20 48 8b 55 20 48
[ 8943.095371] RIP: free_moved_vector+0x61/0x100 RSP: ffff88023fd43fa0
[ 8943.096685] CR2: 000000037a6b561b
[ 8943.098120] ---[ end trace 8be4ba51cd83f4c0 ]---
[ 8943.099387] Kernel panic - not syncing: Fatal exception in interrupt
[ 8943.101170] Kernel Offset: disabled
[ 8943.102410] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt
