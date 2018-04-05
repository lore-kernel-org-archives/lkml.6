Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+j2AIKSzBHItvCgMfo6HAtcJUhNfLJ019q8BAZPO0YkO1hMkVXqBfDiQ00OEROSJ/mQyTA
ARC-Seal: i=1; a=rsa-sha256; t=1522956181; cv=none;
        d=google.com; s=arc-20160816;
        b=sDRE2HWhxcmPCkxDnGgVamNbbIfTEQER8TttJ87/kyQTAyEmEcbDh26FbmzDTvn6nL
         sGQH1pU6bu0fHNHA1BREoCuKNwPKoq0pvNwGbIPwu7Oa0Ks06FcvJvC2KdG+Fo3z7W7i
         wy77yk3udCDJJOPD0v6wVLwcLbUt7SLyhp8cWNpTKEPFT2LZ2bhubC08Ickf3OBxPU+1
         cKWuagCHR42tAmiMMFZ6pntDBxZk1SLdEs0P5PH9ZCp1B98A9v4mfkku0FJogF+gjULl
         z0jxRH77Eg05Mb5JkxfJwWsXbJjsHzF2tYK1jutSEfdLeV1NmYuHW9Tf9LuLZiv/pddA
         JXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=YBv+M7BNW4LBWAEpr3ZP58wDOfp0+TncPZx8yd0sMUk=;
        b=bNQFVLzn1sbtofJL/sP8vO0WCe1CzkLJc6EZ5wIiHjHWGS4naorIucLFOK/8aOFfed
         yI8vou4+bevDNEur200z6MmxFDhNN2XxlAMshHz+BdttlB2XVVUMiLP5fObLXZohqO18
         /dm/xQ3zrhaeZy+6guYbrb+9UnGIuucezSbt9/E2vpL+QefxWvEkmjZNUBNkJGHiTihk
         WwaERgibcHmiJ1FSqstcUAkm4sfKJ0S7GjG8YmlFsggIjQ0RgcFL9qWIX1Nu1TtMBKdi
         +Hny6N6+qCtcngRoZ6+Uf0lpayugv/4EZUS7RriQeMzy9fCE/0f36isdLBIQnHC3C5vm
         2PMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=majzbxMf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.127 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=majzbxMf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.127 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
CC: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"mhocko@suse.com" <mhocko@suse.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity
 checking
Thread-Topic: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity
 checking
Thread-Index: AQHTuyUZztiXFyklekiLx1gdTIcwnqPO42KAgAAEKACAAsMQAIAAG5MAgB45xgCAAlOlAIAAXR0A
Date: Thu, 5 Apr 2018 19:22:58 +0000
Message-ID: <20180405192256.GQ7561@sasha-vm>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
 <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
 <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
 <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy>
 <20180404021746.m77czxidkaumkses@xakep.localdomain>
 <20180405134940.2yzx4p7hjed7lfdk@xakep.localdomain>
In-Reply-To: <20180405134940.2yzx4p7hjed7lfdk@xakep.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:5yu30D05FDu30zba3h7Fk6QBIgfUJlF7FPyG3K8jzAs4u77tx3FObHKfPBhbMBuGpbTmJOUzLci24NkIDfGNaIfMxbmswCZbMyTeZVrT9xECEdq+8R4+HR+2ATfaHLMJ0sS6r0oo4d3FdQw+OpfNoIxJefPnz3hh9Kd8tAx8pyzl4+xAlbUHEl4IsY1JyUFRqJX4jJxeas8Rx41q6fO/ra2BJpI44KcAg4oDsxOLSSkvq6dCa61+9XBJTXidcR51;20:5CnqBl7QElrbgRwu7AQCg7fbByEA2Au6QpHE1nyJl/3pltn4acPfgesXi5KRPvMVPdVYLq4/CagmIQdQ1V635LPDiXN7WLQ548KCyvP5ilYt2GiBTOsgzK84ZkdvCSn6GJ7dlqHjv4bfcsKpU/kZ/QIlDaEfo+JJk4bepbAQu38=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 05b01a58-7a67-40aa-4fbd-08d59b2aa40b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983C7AC1076A028F49506A8FBBB0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(275809806118684);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(316002)(476003)(25786009)(54906003)(66066001)(6116002)(3846002)(486006)(97736004)(72206003)(10290500003)(478600001)(33716001)(5250100002)(446003)(6512007)(9686003)(11346002)(2900100001)(229853002)(3280700002)(33656002)(2906002)(6486002)(3660700001)(26005)(1076002)(53936002)(93886005)(22452003)(186003)(6246003)(86362001)(6506007)(102836004)(14454004)(8676002)(105586002)(59450400001)(99286004)(106356001)(575784001)(7736002)(76176011)(4326008)(5660300001)(6436002)(8936002)(86612001)(68736007)(6916009)(7416002)(10090500001)(81156014)(33896004)(305945005)(81166006)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4EsvLv++HtSyt/m/Fr/CddAkMPQT8OrBDWEFEWOyW+CMdetooGzykRWrqFy1M03dCVclbhu2GtCVzwqrNO+44lhTwdgke0mJ1OeJSm8i2ehWztRNJWHwRXNTceLqWROvhsV+KCAaikzexg7DDTYqSRGStmRygD+0jYTVX8pitabg3Wjo4hhRS10DNgCJAwdHIl5PtxfenU4xqiBp/EaV+WEHoTz4T1SmpXo3Tw4FeC3xeR+a9TQ5cu+y99cNYj8ubz7PMbgMtghIfiVghp2NrBcdDgTSx+z5CVt0a5JwwRiu2Sr2D7xWrdLDt0ho73NDja/d0rrbZ5ekx4WPYwJMYKWUBV+JO/em/SmqVQCVaT8uzZqvlC0QgGRCLsRNtQsRAS+aQ7LVi/tER5Ds9xqfYTcMlp4oImdkxqiV7M/Ig8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6BAACC377512341912E3366B4DA7D4A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b01a58-7a67-40aa-4fbd-08d59b2aa40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 19:22:58.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1596935300720697081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 09:49:40AM -0400, Pavel Tatashin wrote:
>> Hi Sasha,
>>
>> I have registered on Azure's portal, and created a VM with 4 CPUs and 16=
G
>> of RAM. However, I still was not able to reproduce the boot bug you foun=
d.
>
>I have also tried to reproduce this issue on Windows 10 + Hyper-V, still
>unsuccessful.

I'm not sure why you can't reproduce it. I built a 4.16 kernel + your 6
patches on top, and booting on a D64s_v3 instance gives me this:

[    1.205726] page:ffffea0084000000 is uninitialized and poisoned
[    1.205737] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffff=
ffffffffffff
[    1.207016] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffff=
ffffffffffff
[    1.208014] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
[    1.209087] ------------[ cut here ]------------
[    1.210000] kernel BUG at ./include/linux/mm.h:901!
[    1.210015] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[    1.211000] Modules linked in:
[    1.211000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0+ #10
[    1.211000] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090007  06/02/2017
[    1.211000] RIP: 0010:get_nid_for_pfn+0x6e/0xa0
[    1.211000] RSP: 0000:ffff881c63cbfc28 EFLAGS: 00010246
[    1.211000] RAX: 0000000000000000 RBX: ffffea0084000000 RCX: 00000000000=
00000
[    1.211000] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffed038c7=
97f78
[    1.211000] RBP: ffff881c63cbfc30 R08: ffff88401174a480 R09: 00000000000=
00000
[    1.211000] R10: ffff8840e00d6040 R11: 0000000000000000 R12: 00000000021=
07fff
[    1.211000] R13: fffffbfff4648234 R14: 0000000000000001 R15: 00000000000=
00001
[    1.211000] FS:  0000000000000000(0000) GS:ffff881c6aa00000(0000) knlGS:=
0000000000000000
[    1.211000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.211000] CR2: 0000000000000000 CR3: 0000002814216000 CR4: 00000000003=
406f0
[    1.211000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    1.211000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    1.211000] Call Trace:
[    1.211000]  register_mem_sect_under_node+0x1a2/0x530
[    1.211000]  link_mem_sections+0x12d/0x200
[    1.211000]  topology_init+0xe6/0x178
[    1.211000]  ? enable_cpu0_hotplug+0x1a/0x1a
[    1.211000]  do_one_initcall+0xb0/0x31f
[    1.211000]  ? initcall_blacklisted+0x220/0x220
[    1.211000]  ? up_write+0x78/0x140
[    1.211000]  ? up_read+0x40/0x40
[    1.211000]  ? __asan_register_globals+0x30/0xa0
[    1.211000]  ? kasan_unpoison_shadow+0x35/0x50
[    1.211000]  kernel_init_freeable+0x69d/0x764
[    1.211000]  ? start_kernel+0x8fd/0x8fd
[    1.211000]  ? finish_task_switch+0x1b6/0x9c0
[    1.211000]  ? rest_init+0x120/0x120
[    1.211000]  kernel_init+0x13/0x150
[    1.211000]  ? rest_init+0x120/0x120
[    1.211000]  ret_from_fork+0x3a/0x50
[    1.211000] Code: ff df 48 c1 ea 03 80 3c 02 00 75 34 48 8b 03 48 83 f8 =
ff 74 07 48 c1 e8 36 5b 5d c3 48 c7 c6 00 ca f5 9e 48 89 df e8 82 13 d5 fd =
<0f> 0b 48 c7 c7 00 24 2e a1 e8 05 36 c1 fe e8 af 07 ea fd eb ac
[    1.211000] RIP: get_nid_for_pfn+0x6e/0xa0 RSP: ffff881c63cbfc28
[    1.211017] ---[ end trace d86a03841f7ef229 ]---
[    1.212020] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    1.213000] BUG: KASAN: stack-out-of-bounds in update_stack_state+0x64c/=
0x810
[    1.213000] Read of size 8 at addr ffff881c63cbfaf8 by task swapper/0/1
[    1.213000]
[    1.213000] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D          4.1=
6.0+ #10
[    1.213000] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090007  06/02/2017
[    1.213000] Call Trace:
[    1.213000]  dump_stack+0xe3/0x196
[    1.213000]  ? _atomic_dec_and_lock+0x31a/0x31a
[    1.213000]  ? vprintk_func+0x27/0x60
[    1.213000]  ? printk+0x9c/0xc3
[    1.213000]  ? show_regs_print_info+0x10/0x10
[    1.213000]  ? lock_acquire+0x760/0x760
[    1.213000]  ? update_stack_state+0x64c/0x810
[    1.213000]  print_address_description+0xe4/0x480
[    1.213000]  ? update_stack_state+0x64c/0x810
[    1.213000]  kasan_report+0x1d7/0x460
[    1.213000]  ? console_unlock+0x652/0xe90
[    1.213000]  ? update_stack_state+0x64c/0x810
[    1.213000]  __asan_report_load8_noabort+0x19/0x20
[    1.213000]  update_stack_state+0x64c/0x810
[    1.213000]  ? __read_once_size_nocheck.constprop.2+0x50/0x50
[    1.213000]  ? put_files_struct+0x2a4/0x390
[    1.213000]  ? unwind_next_frame+0x202/0x1230
[    1.213000]  unwind_next_frame+0x202/0x1230
[    1.213000]  ? unwind_dump+0x590/0x590
[    1.213000]  ? get_stack_info+0x42/0x3b0
[    1.213000]  ? debug_check_no_locks_freed+0x300/0x300
[    1.213000]  ? __unwind_start+0x170/0x380
[    1.213000]  __save_stack_trace+0x82/0x140
[    1.213000]  ? put_files_struct+0x2a4/0x390
[    1.213000]  save_stack_trace+0x39/0x70
[    1.213000]  save_stack+0x43/0xd0
[    1.213000]  ? save_stack+0x43/0xd0
[    1.213000]  ? __kasan_slab_free+0x11f/0x170
[    1.213000]  ? kasan_slab_free+0xe/0x10
[    1.213000]  ? kmem_cache_free+0xe6/0x560
[    1.213000]  ? put_files_struct+0x2a4/0x390
[    1.213000]  ? _get_random_bytes+0x162/0x5a0
[    1.213000]  ? trace_hardirqs_off+0xd/0x10
[    1.213000]  ? lock_acquire+0x212/0x760
[    1.213000]  ? rcuwait_wake_up+0x15e/0x2c0
[    1.213000]  ? lock_acquire+0x212/0x760
[    1.213000]  ? free_obj_work+0x8a0/0x8a0
[    1.213000]  ? lock_acquire+0x212/0x760
[    1.213000]  ? acct_collect+0x776/0xe80
[    1.213000]  ? acct_collect+0x2e4/0xe80
[    1.213000]  ? acct_collect+0x2e4/0xe80
[    1.213000]  ? lock_acquire+0x760/0x760
[    1.213000]  ? lock_downgrade+0x910/0x910
[    1.213000]  __kasan_slab_free+0x11f/0x170
[    1.213000]  ? put_files_struct+0x2a4/0x390
[    1.213000]  kasan_slab_free+0xe/0x10
[    1.213000]  kmem_cache_free+0xe6/0x560
[    1.213000]  put_files_struct+0x2a4/0x390
[    1.213000]  ? get_files_struct+0x80/0x80
[    1.213000]  ? do_raw_spin_trylock+0x1f0/0x1f0
[    1.213000]  exit_files+0x83/0xc0
[    1.213000]  do_exit+0x9be/0x2190
[    1.213000]  ? do_invalid_op+0x20/0x30
[    1.213000]  ? mm_update_next_owner+0x1200/0x1200
[    1.213000]  ? get_nid_for_pfn+0x6e/0xa0
[    1.213000]  ? get_nid_for_pfn+0x6e/0xa0
[    1.213000]  ? register_mem_sect_under_node+0x1a2/0x530
[    1.213000]  ? link_mem_sections+0x12d/0x200
[    1.213000]  ? topology_init+0xe6/0x178
[    1.213000]  ? enable_cpu0_hotplug+0x1a/0x1a
[    1.213000]  ? do_one_initcall+0xb0/0x31f
[    1.213000]  ? initcall_blacklisted+0x220/0x220
[    1.213000]  ? up_write+0x78/0x140
[    1.213000]  ? up_read+0x40/0x40
[    1.213000]  ? __asan_register_globals+0x30/0xa0
[    1.213000]  ? kasan_unpoison_shadow+0x35/0x50
[    1.213000]  ? kernel_init_freeable+0x69d/0x764
[    1.213000]  ? start_kernel+0x8fd/0x8fd
[    1.213000]  ? finish_task_switch+0x1b6/0x9c0
[    1.213000]  ? rest_init+0x120/0x120
[    1.213000]  rewind_stack_do_exit+0x17/0x20
[    1.213000]
[    1.213000] The buggy address belongs to the page:
[    1.213000] page:ffffea00718f2fc0 count:0 mapcount:0 mapping:00000000000=
00000 index:0x0
[    1.213000] flags: 0x17ffffc0000000()
[    1.213000] raw: 0017ffffc0000000 0000000000000000 0000000000000000 0000=
0000ffffffff
[    1.213000] raw: ffffea00718f2fe0 ffffea00718f2fe0 0000000000000000 0000=
000000000000
[    1.213000] page dumped because: kasan: bad access detected
[    1.213000]
[    1.213000] Memory state around the buggy address:
[    1.213000]  ffff881c63cbf980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[    1.213000]  ffff881c63cbfa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1=
 f1 f1
[    1.213000] >ffff881c63cbfa80: f1 f8 f2 f2 f2 00 00 00 00 00 00 00 00 00=
 f3 f3
[    1.213000]                                                             =
    ^
[    1.213000]  ffff881c63cbfb00: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[    1.213000]  ffff881c63cbfb80: f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00 f2=
 f2 f2
[    1.213000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    1.213033] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[    1.213033]
[    1.214000] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x0000000b=
