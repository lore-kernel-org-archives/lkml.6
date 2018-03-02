Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeCBW3G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:29:06 -0500
Received: from mail-sg2apc01on0114.outbound.protection.outlook.com ([104.47.125.114]:24864
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750892AbeCBW3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:29:03 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Any known soft lockup issue with vfs_write()->fsnotify()?
Thread-Topic: Any known soft lockup issue with vfs_write()->fsnotify()?
Thread-Index: AdOycop0dWu76knCT0ybPuj6bfAx4A==
Date: Fri, 2 Mar 2018 22:28:50 +0000
Message-ID: <KL1P15301MB000645A10FE2B20421A7F3DBBFC50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-02T22:28:48.1670835Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:a::719]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0053;6:realZfrOZVOfoPcs5D1JXBHDEQ59+3hTRX9Jqwus1piVi2kZ1ym9TfHK0Q3XDX4KR5H55R7Qs5Yu1SLuP2OcebnJUnmuHOrgz7tfu+nksw8D4EKf7o5QLLh2AXGq2fGb2fcrYxoXzZSXBFbXq4AKTnkLxMM/sffXoszdAQ/IjI4PjOMSrfaP/qnwp27tQE6XJWvav6GDvJTBnssnmkblY3V7DQ0p2QSAc49rKcwEtS2lvVMWOPE9TQshq0jx8itkFPHRmoT0JeGuM8+ictEOsMaaxYKPeJGXDJt9TsZLlL+p2cKI+A0ch/WR4OjtTfECDcl0iH8VLoTpiGSK1gnzJU0ZwX1oWGhWfApLdb70Dn8WfP5aYuWKs/IygKD5B2aj;5:6yhyomp5SYt4iXycb1vFkttOx50jHZQYjMcknCj+IQ5gDutLA1ezjB9LaOoH5pT3fi6HdQnPGzR6okPFEgXm2ShwBXGWglLocqIoMzz0TzYsuJClI1WXVGFHH/2JGRjku16bWlbvpRIqw6TiPL+AIQriYh6fOLJxgMqV6YVxGg8=;24:GHBmg7+7EpBoo105PZEZQIbTIDiUMQdfJ5yj2N5+0iUrPoGrKq5R0eu+IFQaWbBZhZhYrKDwQTCIMLDkYAexmLScArZ9v7RNlX7K7pKavxk=;7:GP9P03gFOVdjAVfUiuvkoAcwIjNxcnAD6moRU49x4c6OAtYGWr24j8AKejIewOcwt3xvsXa5B5hEJnIggIIe9oG5S+AFUOab/PGROxhXIIeOH2mdYge+G2r6pK73sf8dgfKTggVetpGSwZn4SgoiB0aTzCpPgTrmHk2gAcb+FTnvROK58LuQRZw5RSl/SjbxzLn9avBA/fwEeYr+w+JfwVU4Ob3sWwPIznGlnxqjOJ8oignH9rGvH8ZEf9HNc5zR
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce556731-d0d6-4b9e-e4c3-08d5808cf9c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:KL1P15301MB0053;
x-ms-traffictypediagnostic: KL1P15301MB0053:
x-microsoft-antispam-prvs: <KL1P15301MB0053BF0AB68465F4D5289B56BFC50@KL1P15301MB0053.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(166708455590820)(148717330147763);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:KL1P15301MB0053;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0053;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(102836004)(68736007)(305945005)(2501003)(6116002)(7696005)(110136005)(81156014)(5660300001)(10090500001)(53936002)(81166006)(33656002)(54906003)(8676002)(74316002)(86612001)(59450400001)(99286004)(25786009)(6436002)(9686003)(10290500003)(106356001)(8936002)(3280700002)(316002)(97736004)(2900100001)(107886003)(966005)(22452003)(3660700001)(4326008)(478600001)(39060400002)(7736002)(14454004)(2906002)(6306002)(8990500004)(6506007)(77096007)(105586002)(186003)(575784001)(86362001)(55016002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0053;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: xtdq/70djahOPyz+aFTv0uP3rYciqIcL4lRcn9M5U8jcb1UCD9NIuO/V6IpVielwO58fuX7XIp9jqskgCGv/JB/07yWlh2R5wBcsEAk+D6/mLunmUDWRUEZ8vf+orhNmRyC4mI3HVG3Lj/XNZvQPjOCQ0Rkern8fquGZ7oooMpo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce556731-d0d6-4b9e-e4c3-08d5808cf9c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 22:28:50.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w22MTD6c000705

Hi,
Recently people are getting a soft lock issue with vfs_write()->fsnotify(). 
The detailed calltrace is available at:
https://github.com/coreos/bugs/issues/2356
https://github.com/coreos/bugs/issues/2364

The kernel versions showing up the issue are:
4.14.11-coreos 
4.14.19-coreos
4.13.0-1009 -- this is the kernel with which I'm personally seeing the lockup.

I have not got a chance to try the latest mainline kernel yet.

Before the lockup error message suddenly appears, Linux has been running fine for many hours.
I have NOT found a consistent way to reproduce the lockup yet.

Looks the kernel is stuck in fsnotify(), when it tries to get the fsnotify_mark_srcu lock.

"git log fs/notify/fsnotify.c" on the latest mainline shows that some recent patches might help.

I'd like to check if this is a known issue.

Looking forward to your insights!

Thanks,
-- Dexuan

For your convenience, this is a calltrace from the first link:

18h 30m 8.626s(   4ms): ip-172-45-43-199 login: [67361.641359] watchdog: BUG: soft lockup - CPU#10 stuck for 22s! [java:87260]
18h 42m 40.116s(751490ms): [67361.644600] Modules linked in: xfs xt_statistic xt_nat xt_recent ipt_REJECT nf_reject_ipv4 xt_comment xt_mark veth nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter xt_conntrack br_netfilter bridge stp llc ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c crc32c_generic vxlan ip6_udp_tunnel udp_tunnel overlay mousedev psmouse sb_edac i2c_piix4 i2c_core evdev edac_core button xenfs xen_privcmd sch_fq_codel nls_ascii nls_cp437 vfat fat dm_verity dm_bufio ext4 crc16 mbcache jbd2 fscrypto crc32c_intel ata_piix aesni_intel xen_blkfront libata aes_x86_64 crypto_simd cryptd glue_helper scsi_mod ixgbevf dm_mirror dm_region_hash dm_log dm_mod dax
18h 42m 40.142s(  26ms): [67361.668103] CPU: 10 PID: 87260 Comm: java Not tainted 4.14.11-coreos #1
18h 42m 40.142s(   0ms): [67361.670391] Hardware name: Xen HVM domU, BIOS 4.2.amazon 08/24/2006
18h 42m 40.144s(   2ms): [67361.672581] task: ffff90d6009dbc80 task.stack: ffffb2388f704000
18h 42m 40.149s(   5ms): [67361.674604] RIP: 0010:fsnotify+0x166/0x520
18h 42m 40.149s(   0ms): [67361.675971] RSP: 0018:ffffb2388f707e10 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff0c
18h 42m 40.150s(   1ms): [67361.678462] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
18h 42m 40.152s(   2ms): [67361.680986] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffffffff907294c0
18h 42m 40.157s(   5ms): [67361.683340] RBP: ffff90d2eddffed8 R08: 0000000000000000 R09: 0000000000000000
18h 42m 40.157s(   0ms): [67361.685709] R10: ffffdd941da7a100 R11: 0000000000000000 R12: ffff90d2eddfff00
18h 42m 40.159s(   2ms): [67361.688199] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
18h 42m 40.165s(   6ms): [67361.690579] FS:  00007f491c3f4700(0000) GS:ffff90d6ef880000(0000) knlGS:0000000000000000
18h 42m 40.165s(   0ms): [67361.693227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
18h 42m 40.166s(   1ms): [67361.695206] CR2: 000000c421288300 CR3: 00000005ba5fc002 CR4: 00000000001606e0
18h 42m 40.175s(   9ms): [67361.697655] Call Trace:
18h 42m 40.175s(   0ms): [67361.698499]  vfs_write+0x14f/0x1a0
18h 42m 40.175s(   0ms): [67361.699656]  SyS_write+0x52/0xc0
18h 42m 40.175s(   0ms): [67361.700745]  do_syscall_64+0x59/0x1c0
18h 42m 40.175s(   0ms): [67361.701996]  entry_SYSCALL64_slow_path+0x25/0x25
18h 42m 40.175s(   0ms): [67361.703536] RIP: 0033:0x7f4b5566643d
18h 42m 40.176s(   1ms): [67361.704751] RSP: 002b:00007f491c3f0ef0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
18h 42m 40.179s(   3ms): [67361.707375] RAX: ffffffffffffffda RBX: 0000000000000032 RCX: 00007f4b5566643d
18h 42m 40.188s(   9ms): [67361.709849] RDX: 00000000000000f0 RSI: 00007f491c3f0f50 RDI: 0000000000000f40
18h 42m 40.188s(   0ms): [67361.712205] RBP: 00007f491c3f0f20 R08: 00007f491c3f1030 R09: 00000005f4ff70d8
18h 42m 40.188s(   0ms): [67361.714573] R10: 0000000000052f06 R11: 0000000000000293 R12: 00000000000000f0
18h 42m 40.188s(   0ms): [67361.716924] R13: 00007f491c3f0f50 R14: 0000000000000f40 R15: 0000000000000000
18h 42m 40.191s(   3ms): [67361.719331] Code: 40 4c 89 7c 24 48 4c 89 7c 24 08 8b 44 24 18 25 00 00 03 00 89 44 24 34 4d 85 e4 0f 95 c2 48 83 7c 24 08 00 0f 95 c1 89 c8 08 d0 <0f> 84 96 03 00 00 84 d2 0f 84 e8 02 00 00 48 8b 44 24 40 84 c9
