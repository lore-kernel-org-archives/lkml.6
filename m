Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELs5kVNWH8eZEilAqT7NbycXoP7G5B5LG1SQw2G05gznbZTVQZCWYitERlzod76lxf5UKCQO
ARC-Seal: i=1; a=rsa-sha256; t=1520984618; cv=none;
        d=google.com; s=arc-20160816;
        b=np+PXKT5fUUYPAqClR/oWzgZJ/tJ1/ycPMOsOaD/f7MePVvykNW/nSrt4DhOLOM8J8
         SKTjvGQxFH9/HcEgyGtsKcIV9zfGvsg7FRTX9KdKPanFJ2u7HUY1qUYPdmnpeVzoc/ny
         YaT3M1929j0X3A2/UUeBx1DrpBo2l/V1v/PdS1m3xmIE1rbCi5ZEZCimr9dqZqbT5aqI
         1YtZDPwrmse/pmIdlPBCxfZwzaiXGJnYqRwYDIF8ISrfschG3vAEsd97PFTFwvQq1b/9
         kVbHs9cbYALnEUjnGra2AgE7oo/QtcU/mXopwjeZUbN//tZlx5ZNGhmJcHmTS2zeXd5q
         42yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=DVjf5uk96fN41JZ9d+fzIjW8Tg4yvxFNmWTdhNrZojU=;
        b=EvAan0wKaKypDhZ3eva4Q8eCR4NyWFN81YuXgM5rYwrY1Y5IeduX6Q9P8VPdTXfcab
         r9HtIj/lOTqje90hYMVTKu2735LItGly19P4TMO5ne5/eD2wmpokuEoMP/N4hxOUaatJ
         roXFPu1KweGFFeZYKAh7W8fhpk7/r7CO8jveLyOSHQC54C6uqk9t5VDNDLcOP8ZPKSsD
         9k7nnIgtimYt1DIugfIauPggvbgLOL6iFKR0XTDQ7cwneDnil/NBD5LvzNGkw2dwNA0i
         EiNOXmU9z1VvLz48Vb5yKYXC8iA42E4dPlofBicnfeNhMyXWOS8sxcElttks3BFpJppT
         XQSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=auk0uxex;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.118 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=auk0uxex;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.118 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
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
Thread-Index: AQHTuyUZztiXFyklekiLx1gdTIcwng==
Date: Tue, 13 Mar 2018 23:43:35 +0000
Message-ID: <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
In-Reply-To: <20180131210300.22963-2-pasha.tatashin@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:EWEPLM1AUPPPAaViUvebIc4qz5eDXXIwHUTWsonGPT+cHs7FRa7iBNmnvrOij8WNxb2b06ke58RrP7CnAou7N/dUCUkptejAq53YoYIpFyipi2y2ZlqqauKMpUEg6Cnx2GAGJhe7gCjaZtE6ACqfqXejtxF9AF8yebzJxkL1vT3R5wBmYaoKKQ9Kvzb/NJUn7YS74YbjM/7YZU38PnxuXNi2W40AU296BGYoomrNbhwKH+H//Jp3R2xx/7cFqPL+;20:jy4jUkZDlMwX7rnsBFRUWVwU0vD1UctOGTNuKNF26xZkOD+yE58EdMNaIROiOg+gC2MiNg8ueQVgsTCUGyYY8UHhUNFTNzkH1ymDf013pYq8UGxgNDAJ0AvgQuA7RWyxr4V0pBswqa8h3UoIvWs4oYv0OfEEsfC6Ztew8beSnq4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f01f3de4-5b81-4483-f318-08d5893c3cd6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB0936D0B411CD7CED46821228FBD20@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501255)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(366004)(39860400002)(346002)(39380400002)(199004)(189003)(8936002)(2900100001)(575784001)(26005)(81156014)(76176011)(4326008)(14454004)(102836004)(7416002)(5660300001)(3660700001)(2906002)(1076002)(316002)(10090500001)(68736007)(305945005)(59450400001)(6506007)(86362001)(3846002)(81166006)(186003)(6346003)(22452003)(33896004)(8676002)(3280700002)(99286004)(6116002)(7736002)(53936002)(33716001)(6436002)(6486002)(10290500003)(25786009)(106356001)(97736004)(6512007)(72206003)(478600001)(5250100002)(54906003)(105586002)(9686003)(6246003)(6916009)(86612001)(66066001)(229853002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: x3L3u96bWfgRXQxXft4UE4BRRtuZO/JnzfnyjeHB8fkt/P/lhoJXwRNc+uZg8jn/au1vQdHSl6u2GxoKtObvVg4uk39PijJcFuuUnJJhQWtkLeTBnh7G91Yt/3GBkUVwVIvNOlTtz4/HnytaVIDtsR8pyp+4ue8YQzihZcgoHgSBElGK2jS/PPoaJedmcChZpyVp77bBBIDY/DI5YoF/kT0x6s3+VD8IYeNoutZg6knM/ATxREgptfsRPeBwMwB2mP0RjSNnffj9NQdip7BvQV3c7rLKCrDd9pOhDfBC+M5Y17YdOWle7LYWu5nMhkX885FUGkfo2Sr3cc9LnnaRCA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9732134B9E963143AEC8301E7EBD6B7F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01f3de4-5b81-4483-f318-08d5893c3cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 23:43:35.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1594867967646790265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 04:02:59PM -0500, Pavel Tatashin wrote:
>During boot we poison struct page memory in order to ensure that no one is
>accessing this memory until the struct pages are initialized in
>__init_single_page().
>
>This patch adds more scrutiny to this checking, by making sure that flags
>do not equal to poison pattern when the are accessed. The pattern is all
>ones.
>
>Since, node id is also stored in struct page, and may be accessed quiet
>early we add the enforcement into page_to_nid() function as well.
>
>Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>---

Hey Pasha,

This patch is causing the following on boot:

[    1.253732] BUG: unable to handle kernel paging request at fffffffffffff=
ffe
[    1.254000] PGD 2284e19067 P4D 2284e19067 PUD 2284e1b067 PMD 0
[    1.254000] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[    1.254000] Modules linked in:
[    1.254000] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc5-next-20=
180313 #10
[    1.254000] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS 090007  06/02/2017
[    1.254000] RIP: 0010:__dump_page (??:?)
[    1.254000] RSP: 0000:ffff881c63c17810 EFLAGS: 00010246
[    1.254000] RAX: dffffc0000000000 RBX: ffffea0084000000 RCX: 1ffff1038c7=
82f2b
[    1.254000] RDX: 1fffffffffffffff RSI: ffffffff9e160640 RDI: ffffea00840=
00000
[    1.254000] RBP: ffff881c63c17c00 R08: ffff8840107e8880 R09: ffffed08021=
67a4d
[    1.254000] R10: 0000000000000001 R11: ffffed0802167a4c R12: 1ffff1038c7=
82f07
[    1.254000] R13: ffffea0084000020 R14: fffffffffffffffe R15: ffff881c63c=
17bd8
[    1.254000] FS:  0000000000000000(0000) GS:ffff881c6ac00000(0000) knlGS:=
0000000000000000
[    1.254000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.254000] CR2: fffffffffffffffe CR3: 0000002284e16000 CR4: 00000000003=
406e0
[    1.254000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    1.254000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    1.254000] Call Trace:
[    1.254000] dump_page (/mm/debug.c:80)
[    1.254000] get_nid_for_pfn (/./include/linux/mm.h:900 /drivers/base/nod=
e.c:396)
[    1.254000] register_mem_sect_under_node (/drivers/base/node.c:438)
[    1.254000] link_mem_sections (/drivers/base/node.c:517)
[    1.254000] topology_init (/./include/linux/nodemask.h:271 /arch/x86/ker=
nel/topology.c:164)
[    1.254000] do_one_initcall (/init/main.c:835)
[    1.254000] kernel_init_freeable (/init/main.c:901 /init/main.c:909 /ini=
t/main.c:927 /init/main.c:1076)
[    1.254000] kernel_init (/init/main.c:1004)
[    1.254000] ret_from_fork (/arch/x86/entry/entry_64.S:417)
[ 1.254000] Code: ff a8 01 4c 0f 44 f3 4d 85 f6 0f 84 31 0e 00 00 4c 89 f2 =
48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 2d 11 00 00 <49=
> 83 3e ff 0f 84 a9 06 00 00 4d 8d b7 c0 fd ff ff 48 b8 00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   ff a8 01 4c 0f 44       ljmp   *0x440f4c01(%rax)
   6:   f3 4d 85 f6             repz test %r14,%r14
   a:   0f 84 31 0e 00 00       je     0xe41
  10:   4c 89 f2                mov    %r14,%rdx
  13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
  1a:   fc ff df
  1d:   48 c1 ea 03             shr    $0x3,%rdx
  21:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
  25:   0f 85 2d 11 00 00       jne    0x1158
  2b:*  49 83 3e ff             cmpq   $0xffffffffffffffff,(%r14)          =
     <-- trapping instruction
  2f:   0f 84 a9 06 00 00       je     0x6de
  35:   4d 8d b7 c0 fd ff ff    lea    -0x240(%r15),%r14
  3c:   48                      rex.W
  3d:   b8                      .byte 0xb8
        ...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   49 83 3e ff             cmpq   $0xffffffffffffffff,(%r14)
   4:   0f 84 a9 06 00 00       je     0x6b3
   a:   4d 8d b7 c0 fd ff ff    lea    -0x240(%r15),%r14
  11:   48                      rex.W
  12:   b8                      .byte 0xb8
        ...
[    1.254000] RIP: __dump_page+0x1c8/0x13c0 RSP: ffff881c63c17810 (/./incl=
ude/asm-generic/sections.h:42)
[    1.254000] CR2: fffffffffffffffe
[    1.254000] ---[ end trace e643dfbc44b562ca ]---

--=20

Thanks,
Sasha=
