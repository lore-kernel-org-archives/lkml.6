Return-Path: <namit@vmware.com>
X-Google-Smtp-Source: AB8JxZq7lRg1CNEpYvXQ0rPTsJ7GiaIr1J/QVAkHXbbuQuG29pNDt9ZkI/WgYk+MfjZjxDypiaf0
ARC-Seal: i=1; a=rsa-sha256; t=1525109443; cv=none;
        d=google.com; s=arc-20160816;
        b=P26jBInqe/Ghp/bYpSjBL4f6CK2D5SPDUta/7xOX07KqzoDVaXqd2eSPrzPtLYen6k
         GgDEGiE+newkY4SjcUjeuLFQSV5XDJ/wTsYg98DNDjQZUvVsV3zPEqpCjIaE3SN5O0AQ
         fuLamu4Z42cS9h8syhnXyzbbU8mwfqb79LOw6muJRpqF3A3RW7BmP/OBpQISg7H+QX8s
         qjMTq1MjaFl7CgjnI6a3eT2fjHAjg3M7TbBOcoJTqX5T0bbXK4dALMBh0ELcBfafqo1g
         zkeESmcuSwcY07VQpR/vH4H4Mbj4vTdsiqHv7sM2+XQjG5B+P/1h9j+6rAsKALoUz9kY
         1tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tF/qqbW0epQzBrzkOtNASBJJSMh5zaoHtaL5kHy+Kx8=;
        b=ei9kOjAZMD5Y4UHkaa+Ls+F4vt2KAukQkJE3jrjLjg3OIm5gSReepDTH9WlfJzgU/b
         Roi2VswVfrFKjH2oJYze483Vm1/FWvuQ2omunPQob9ctszBklmT8GQMekOxGJfjg9Z6x
         ex3Yap5yjowFtxS++1YVimRVob/fQnrVoV3Pe800Da4gqQNE/fKWG+aJbH0OKcUABx/Q
         Ite3Ov1KGj2WjbsbD4q7Ykouz8IGm3JFAGl2vpKYeZUa5aPugGeAEXJS0IH0MYnB9PjL
         B6KXCbSHy544KtnS+i2m79Q7Pk/JyD7/LKukSrDV+aJvH9U40s7bTuhFwU3XDhsstsrC
         Bebw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@onevmw.onmicrosoft.com header.s=selector1-vmware-com header.b=bcByF1JV;
       spf=pass (google.com: domain of namit@vmware.com designates 104.47.42.42 as permitted sender) smtp.mailfrom=namit@vmware.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@onevmw.onmicrosoft.com header.s=selector1-vmware-com header.b=bcByF1JV;
       spf=pass (google.com: domain of namit@vmware.com designates 104.47.42.42 as permitted sender) smtp.mailfrom=namit@vmware.com
From: Nadav Amit <namit@vmware.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Xavier Deguillard <xdeguillard@vmware.com>, pv-drivers
	<pv-drivers@vmware.com>, LKML <linux-kernel@vger.kernel.org>, Gil Kupfer
	<gilkup@gmail.com>, Oleksandr Natalenko <onatalen@redhat.com>,
	"ldu@redhat.com" <ldu@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] vmw_balloon: fixing double free when batching mode is
 off
Thread-Topic: [PATCH v3] vmw_balloon: fixing double free when batching mode is
 off
Thread-Index: AQHT2Argu2pZ34klIkGamyuxGjdz+KQZodaA
Date: Mon, 30 Apr 2018 17:30:41 +0000
Message-ID: <162DEB66-373B-4E01-8D64-3CE7BEF47920@vmware.com>
References: <20180419063856.GA7643@kroah.com>
 <20180419181722.12273-1-namit@vmware.com>
In-Reply-To: <20180419181722.12273-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2734;7:nMqxcnTXjf10n3Ru++gC6HmNLjyhyUBCEKTtWge07kgJau7xowuJn0t3SaVEYl2rsFehACyrAJ/iTfgJVTX2qnfsJK0NDnpz2mZLoot584avrBUFVfTrvufJiqHFJFg6c3XaMALhN5HWm3TMsoetmqP/aVGeRH9lh9+qgmkHYkOz/gcjxsfTNJ8/8Iooin9I1WSVeJ1//4iqejBftVqTpKTouVB3YJvgJQS9+p0jthBn+eZcJCdaFEChkjbe0bje;20:LqtNrRfuXSqSHDBFftKnHEm+9w7Mv+gtFcXD3bKSGOnDp2oNqadAf/YxqzbZ7dCHXc5/LNvafuNOBPHevWCu9D7N3HyBrFpz+fEEoxKrYXILWAlujUPyqeX5fLx9eAxaYBUY8gUk/PWv29m00GwqeuHtPgD2ebyv1iBqCNq4BO8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2734;
x-ms-traffictypediagnostic: SN2PR05MB2734:
x-microsoft-antispam-prvs: <SN2PR05MB273415DE745D05A5EAAD3729D0820@SN2PR05MB2734.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR05MB2734;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2734;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(39380400002)(199004)(189003)(4326008)(86362001)(575784001)(68736007)(39060400002)(3280700002)(2906002)(97736004)(486006)(6512007)(478600001)(25786009)(305945005)(3660700001)(6436002)(2616005)(476003)(11346002)(446003)(83716003)(45080400002)(5250100002)(3846002)(36756003)(14454004)(6486002)(6116002)(229853002)(54906003)(110136005)(106356001)(26005)(105586002)(59450400001)(99286004)(66066001)(316002)(2900100001)(6346003)(82746002)(81166006)(81156014)(8676002)(8936002)(102836004)(5660300001)(53936002)(7736002)(6246003)(76176011)(186003)(33656002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2734;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: r8kZ5VfVQjNRArjTQpahRRJUqR97HRjfS8aPupZgDIgQVG1UOCT/2ITILzg9hs4HegBG100UUT8WGfHl1gRdPXVMrc212sLM9KR8CB/Tr34HJo+870qh5GqG5fes0obMwBAkBjoJzQsAFSFGCmCIZW1DWUnwErgLybwmt7xIlXzIkgeWvjSE1BuiDsE3akvM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAB64644AD310448B82CB3836365ECDE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e776ffa2-693a-4467-0720-08d5aec018bf
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e776ffa2-693a-4467-0720-08d5aec018bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 17:30:41.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2734
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598199610006290875?=
X-GMAIL-MSGID: =?utf-8?q?1599193160057711173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ping. Please consider it for inclusion for rc4.

Nadav Amit <namit@vmware.com> wrote:

> From: Gil Kupfer <gilkup@gmail.com>
>=20
> The balloon.page field is used for two different purposes if batching is
> on or off. If batching is on, the field point to the page which is used
> to communicate with with the hypervisor. If it is off, balloon.page
> points to the page that is about to be (un)locked.
>=20
> Unfortunately, this dual-purpose of the field introduced a bug: when the
> balloon is popped (e.g., when the machine is reset or the balloon driver
> is explicitly removed), the balloon driver frees, unconditionally, the
> page that is held in balloon.page.  As a result, if batching is
> disabled, this leads to double freeing the last page that is sent to the
> hypervisor.
>=20
> The following error occurs during rmmod when kernel checkers are on, and
> the balloon is not empty:
>=20
> [   42.307653] ------------[ cut here ]------------
> [   42.307657] Kernel BUG at ffffffffba1e4b28 [verbose debug info unavail=
able]
> [   42.307720] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
> [   42.312512] Modules linked in: vmw_vsock_vmci_transport vsock ppdev jo=
ydev vmw_balloon(-) input_leds serio_raw vmw_vmci parport_pc shpchp parport=
 i2c_piix4 nfit mac_hid autofs4 vmwgfx drm_kms_helper hid_generic syscopyar=
ea sysfillrect usbhid sysimgblt fb_sys_fops hid ttm mptspi scsi_transport_s=
pi ahci mptscsih drm psmouse vmxnet3 libahci mptbase pata_acpi
> [   42.312766] CPU: 10 PID: 1527 Comm: rmmod Not tainted 4.12.0+ #5
> [   42.312803] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 09/30/2016
> [   42.313042] task: ffff9bf9680f8000 task.stack: ffffbfefc1638000
> [   42.313290] RIP: 0010:__free_pages+0x38/0x40
> [   42.313510] RSP: 0018:ffffbfefc163be98 EFLAGS: 00010246
> [   42.313731] RAX: 000000000000003e RBX: ffffffffc02b9720 RCX: 000000000=
0000006
> [   42.313972] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9bf97=
e08e0a0
> [   42.314201] RBP: ffffbfefc163be98 R08: 0000000000000000 R09: 000000000=
0000000
> [   42.314435] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc=
02b97e4
> [   42.314505] R13: ffffffffc02b9748 R14: ffffffffc02b9728 R15: 000000000=
0000200
> [   42.314550] FS:  00007f3af5fec700(0000) GS:ffff9bf97e080000(0000) knlG=
S:0000000000000000
> [   42.314599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.314635] CR2: 00007f44f6f4ab24 CR3: 00000003a7d12000 CR4: 000000000=
00006e0
> [   42.314864] Call Trace:
> [   42.315774]  vmballoon_pop+0x102/0x130 [vmw_balloon]
> [   42.315816]  vmballoon_exit+0x42/0xd64 [vmw_balloon]
> [   42.315853]  SyS_delete_module+0x1e2/0x250
> [   42.315891]  entry_SYSCALL_64_fastpath+0x23/0xc2
> [   42.315924] RIP: 0033:0x7f3af5b0e8e7
> [   42.315949] RSP: 002b:00007fffe6ce0148 EFLAGS: 00000206 ORIG_RAX: 0000=
0000000000b0
> [   42.315996] RAX: ffffffffffffffda RBX: 000055be676401e0 RCX: 00007f3af=
5b0e8e7
> [   42.316951] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055be6=
7640248
> [   42.317887] RBP: 0000000000000003 R08: 0000000000000000 R09: 199999999=
9999999
> [   42.318845] R10: 0000000000000883 R11: 0000000000000206 R12: 00007fffe=
6cdf130
> [   42.319755] R13: 0000000000000000 R14: 0000000000000000 R15: 000055be6=
76401e0
> [   42.320606] Code: c0 74 1c f0 ff 4f 1c 74 02 5d c3 85 f6 74 07 e8 0f d=
8 ff ff 5d c3 31 f6 e8 c6 fb ff ff 5d c3 48 c7 c6 c8 0f c5 ba e8 58 be 02 0=
0 <0f> 0b 66 0f 1f 44 00 00 66 66 66 66 90 48 85 ff 75 01 c3 55 48
> [   42.323462] RIP: __free_pages+0x38/0x40 RSP: ffffbfefc163be98
> [   42.325735] ---[ end trace 872e008e33f81508 ]---
>=20
> To solve the bug, we eliminate the dual purpose of balloon.page.
>=20
> Fixes: f220a80f0c2e ("VMware balloon: add batching to the vmw_balloon.")
> Cc: stable@vger.kernel.org
> Reported-by: Oleksandr Natalenko <onatalen@redhat.com>
> Signed-off-by: Gil Kupfer <gilkup@gmail.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> ---
> drivers/misc/vmw_balloon.c | 23 +++++++----------------
> 1 file changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 9047c0a529b2..efd733472a35 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -576,15 +576,9 @@ static void vmballoon_pop(struct vmballoon *b)
> 		}
> 	}
>=20
> -	if (b->batch_page) {
> -		vunmap(b->batch_page);
> -		b->batch_page =3D NULL;
> -	}
> -
> -	if (b->page) {
> -		__free_page(b->page);
> -		b->page =3D NULL;
> -	}
> +	/* Clearing the batch_page unconditionally has no adverse effect */
> +	free_page((unsigned long)b->batch_page);
> +	b->batch_page =3D NULL;
> }
>=20
> /*
> @@ -991,16 +985,13 @@ static const struct vmballoon_ops vmballoon_batched=
_ops =3D {
>=20
> static bool vmballoon_init_batching(struct vmballoon *b)
> {
> -	b->page =3D alloc_page(VMW_PAGE_ALLOC_NOSLEEP);
> -	if (!b->page)
> -		return false;
> +	struct page *page;
>=20
> -	b->batch_page =3D vmap(&b->page, 1, VM_MAP, PAGE_KERNEL);
> -	if (!b->batch_page) {
> -		__free_page(b->page);
> +	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!page)
> 		return false;
> -	}
>=20
> +	b->batch_page =3D page_address(page);
> 	return true;
> }
>=20
> --=20
> 2.14.1
