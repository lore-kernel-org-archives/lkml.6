Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeFAPAz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:00:55 -0400
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:51952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751706AbeFAPAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:00:50 -0400
From: Nadav Amit <namit@vmware.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, Gil Kupfer <gilkup@gmail.com>,
        Oleksandr Natalenko <onatalen@redhat.com>,
        "ldu@redhat.com" <ldu@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] vmw_balloon: fixing double free when batching mode is
 off
Thread-Topic: [PATCH v3] vmw_balloon: fixing double free when batching mode is
 off
Thread-Index: AQHT2Argu2pZ34klIkGamyuxGjdz+KQZodaAgC4XGICAAtrGAIAAuSeAgAB1toA=
Date: Fri, 1 Jun 2018 15:00:48 +0000
Message-ID: <225A97FC-9215-4234-A181-3D7B45A46C70@vmware.com>
References: <20180419063856.GA7643@kroah.com>
 <20180419181722.12273-1-namit@vmware.com>
 <162DEB66-373B-4E01-8D64-3CE7BEF47920@vmware.com>
 <7B3793E8-8DD9-4566-9CCB-6D1B0C364754@vmware.com>
 <4D5BA2F0-377D-4959-9786-95E195EE2D22@vmware.com>
 <20180601075931.GB12809@kroah.com>
In-Reply-To: <20180601075931.GB12809@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [50.204.119.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2478;7:q94chrAOjxEaLnrUjrPs1wYxvMwOYyvYSP2bKnhYb51yeQycR7dxWG5ofWSaSCNkNTy0wqpb2sYt3gib9LX6VwKDXZiCwQQuV4gl/IrRfxU4g/Ek7OvB9x0F6m5eviajIJxLManOaT8ngV7Zfx6yPqRNBqZgdcf3s8kl0AIcrDb+PS9etqGV6CZf2Fzhi82nHsstRiYqLrJtEyd2DAnpK20VJ1OxoI7CxTmabV+PBlJzBikzgVWs9Ot9iudxP2e/;20:NpECdt6K2ddFWsfRiNfhLSt/ujB5lJdnG2NhFd1KagEawmyEPgUn+1hPdHE360NrtVazjBRzvo9M5vyBqeJH4N2slil03GzW5WwEN4sse5tFxHz/51oBgm04xddxM//hc3puaagxWolaP0u9TYD25FJeycIHUOuMAm0a2R7gFu4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2478;
x-ms-traffictypediagnostic: SN2PR05MB2478:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <SN2PR05MB2478CA5EEE4036C87E62B2D2D0620@SN2PR05MB2478.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2478;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2478;
x-forefront-prvs: 0690E5FF22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39380400002)(39860400002)(396003)(189003)(199004)(97736004)(82746002)(68736007)(33656002)(6916009)(3846002)(6116002)(3280700002)(8936002)(2900100001)(2906002)(105586002)(81166006)(5660300001)(478600001)(305945005)(14454004)(7736002)(106356001)(3660700001)(81156014)(8676002)(45080400002)(486006)(6436002)(6486002)(99286004)(76176011)(2616005)(59450400001)(11346002)(6506007)(446003)(316002)(476003)(93886005)(575784001)(86362001)(36756003)(25786009)(229853002)(54906003)(5250100002)(83716003)(6246003)(6512007)(26005)(39060400002)(186003)(66066001)(102836004)(53936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2478;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jI5vBbBCYeqanYKvJ2XzXI7IRoIJJEsKrqktozWF0TIq018l+IXV5OSE7LAUv9KMHIoQ3GxfB5raJ+2pdO2eMEcYAoGiQ7fYQpRHVGw6B2nxYRwJYJFlOLrdHuOYCGwcKzEaglDnmX8ZfX0mEvNmgaUUtuYMwC48n/SZYg3DZcojWB/B8A4AFrCDh1t9YaSo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0011D3C9F0E5B94B921DA65BBB2228F2@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aa6794e7-49d7-4f2e-7971-08d5c7d0759e
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6794e7-49d7-4f2e-7971-08d5c7d0759e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2018 15:00:48.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2478
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51F1e80011403

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, May 31, 2018 at 08:56:52PM +0000, Nadav Amit wrote:
>> Nadav Amit <namit@vmware.com> wrote:
>> 
>>> Nadav Amit <namit@vmware.com> wrote:
>>> 
>>>> Ping. Please consider it for inclusion for rc4.
>>>> 
>>>> Nadav Amit <namit@vmware.com> wrote:
>>>> 
>>>>> From: Gil Kupfer <gilkup@gmail.com>
>>>>> 
>>>>> The balloon.page field is used for two different purposes if batching is
>>>>> on or off. If batching is on, the field point to the page which is used
>>>>> to communicate with with the hypervisor. If it is off, balloon.page
>>>>> points to the page that is about to be (un)locked.
>>>>> 
>>>>> Unfortunately, this dual-purpose of the field introduced a bug: when the
>>>>> balloon is popped (e.g., when the machine is reset or the balloon driver
>>>>> is explicitly removed), the balloon driver frees, unconditionally, the
>>>>> page that is held in balloon.page.  As a result, if batching is
>>>>> disabled, this leads to double freeing the last page that is sent to the
>>>>> hypervisor.
>>>>> 
>>>>> The following error occurs during rmmod when kernel checkers are on, and
>>>>> the balloon is not empty:
>>>>> 
>>>>> [   42.307653] ------------[ cut here ]------------
>>>>> [   42.307657] Kernel BUG at ffffffffba1e4b28 [verbose debug info unavailable]
>>>>> [   42.307720] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
>>>>> [   42.312512] Modules linked in: vmw_vsock_vmci_transport vsock ppdev joydev vmw_balloon(-) input_leds serio_raw vmw_vmci parport_pc shpchp parport i2c_piix4 nfit mac_hid autofs4 vmwgfx drm_kms_helper hid_generic syscopyarea sysfillrect usbhid sysimgblt fb_sys_fops hid ttm mptspi scsi_transport_spi ahci mptscsih drm psmouse vmxnet3 libahci mptbase pata_acpi
>>>>> [   42.312766] CPU: 10 PID: 1527 Comm: rmmod Not tainted 4.12.0+ #5
>>>>> [   42.312803] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 09/30/2016
>>>>> [   42.313042] task: ffff9bf9680f8000 task.stack: ffffbfefc1638000
>>>>> [   42.313290] RIP: 0010:__free_pages+0x38/0x40
>>>>> [   42.313510] RSP: 0018:ffffbfefc163be98 EFLAGS: 00010246
>>>>> [   42.313731] RAX: 000000000000003e RBX: ffffffffc02b9720 RCX: 0000000000000006
>>>>> [   42.313972] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9bf97e08e0a0
>>>>> [   42.314201] RBP: ffffbfefc163be98 R08: 0000000000000000 R09: 0000000000000000
>>>>> [   42.314435] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc02b97e4
>>>>> [   42.314505] R13: ffffffffc02b9748 R14: ffffffffc02b9728 R15: 0000000000000200
>>>>> [   42.314550] FS:  00007f3af5fec700(0000) GS:ffff9bf97e080000(0000) knlGS:0000000000000000
>>>>> [   42.314599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   42.314635] CR2: 00007f44f6f4ab24 CR3: 00000003a7d12000 CR4: 00000000000006e0
>>>>> [   42.314864] Call Trace:
>>>>> [   42.315774]  vmballoon_pop+0x102/0x130 [vmw_balloon]
>>>>> [   42.315816]  vmballoon_exit+0x42/0xd64 [vmw_balloon]
>>>>> [   42.315853]  SyS_delete_module+0x1e2/0x250
>>>>> [   42.315891]  entry_SYSCALL_64_fastpath+0x23/0xc2
>>>>> [   42.315924] RIP: 0033:0x7f3af5b0e8e7
>>>>> [   42.315949] RSP: 002b:00007fffe6ce0148 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>>>>> [   42.315996] RAX: ffffffffffffffda RBX: 000055be676401e0 RCX: 00007f3af5b0e8e7
>>>>> [   42.316951] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055be67640248
>>>>> [   42.317887] RBP: 0000000000000003 R08: 0000000000000000 R09: 1999999999999999
>>>>> [   42.318845] R10: 0000000000000883 R11: 0000000000000206 R12: 00007fffe6cdf130
>>>>> [   42.319755] R13: 0000000000000000 R14: 0000000000000000 R15: 000055be676401e0
>>>>> [   42.320606] Code: c0 74 1c f0 ff 4f 1c 74 02 5d c3 85 f6 74 07 e8 0f d8 ff ff 5d c3 31 f6 e8 c6 fb ff ff 5d c3 48 c7 c6 c8 0f c5 ba e8 58 be 02 00 <0f> 0b 66 0f 1f 44 00 00 66 66 66 66 90 48 85 ff 75 01 c3 55 48
>>>>> [   42.323462] RIP: __free_pages+0x38/0x40 RSP: ffffbfefc163be98
>>>>> [   42.325735] ---[ end trace 872e008e33f81508 ]---
>>>>> 
>>>>> To solve the bug, we eliminate the dual purpose of balloon.page.
>>>>> 
>>>>> Fixes: f220a80f0c2e ("VMware balloon: add batching to the vmw_balloon.")
>>>>> Cc: stable@vger.kernel.org
>>>>> Reported-by: Oleksandr Natalenko <onatalen@redhat.com>
>>>>> Signed-off-by: Gil Kupfer <gilkup@gmail.com>
>>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>>> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
>>>>> ---
>>>>> drivers/misc/vmw_balloon.c | 23 +++++++----------------
>>>>> 1 file changed, 7 insertions(+), 16 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>>>>> index 9047c0a529b2..efd733472a35 100644
>>>>> --- a/drivers/misc/vmw_balloon.c
>>>>> +++ b/drivers/misc/vmw_balloon.c
>>>>> @@ -576,15 +576,9 @@ static void vmballoon_pop(struct vmballoon *b)
>>>>> 		}
>>>>> 	}
>>>>> 
>>>>> -	if (b->batch_page) {
>>>>> -		vunmap(b->batch_page);
>>>>> -		b->batch_page = NULL;
>>>>> -	}
>>>>> -
>>>>> -	if (b->page) {
>>>>> -		__free_page(b->page);
>>>>> -		b->page = NULL;
>>>>> -	}
>>>>> +	/* Clearing the batch_page unconditionally has no adverse effect */
>>>>> +	free_page((unsigned long)b->batch_page);
>>>>> +	b->batch_page = NULL;
>>>>> }
>>>>> 
>>>>> /*
>>>>> @@ -991,16 +985,13 @@ static const struct vmballoon_ops vmballoon_batched_ops = {
>>>>> 
>>>>> static bool vmballoon_init_batching(struct vmballoon *b)
>>>>> {
>>>>> -	b->page = alloc_page(VMW_PAGE_ALLOC_NOSLEEP);
>>>>> -	if (!b->page)
>>>>> -		return false;
>>>>> +	struct page *page;
>>>>> 
>>>>> -	b->batch_page = vmap(&b->page, 1, VM_MAP, PAGE_KERNEL);
>>>>> -	if (!b->batch_page) {
>>>>> -		__free_page(b->page);
>>>>> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>>>>> +	if (!page)
>>>>> 		return false;
>>>>> -	}
>>>>> 
>>>>> +	b->batch_page = page_address(page);
>>>>> 	return true;
>>>>> }
>>>>> 
>>>>> -- 
>>>>> 2.14.1
>>> 
>>> Greg, can you please include this patch?? 4.17 is almost out of the door,
>>> and the last version was sent a month ago.
>>> 
>>> If you have any reservations, please let me know immediately.
>> 
>> Arnd,
>> 
>> Perhaps you can - the very least - respond (or just include the patch)?
>> 
>> The last version of this patch was sent over a month ago.
> 
> It's too late for 4.17 now, and as this touches core code, I'll wait for
> the next merge window cycle.  It's also not even in my patch review
> queue anymore, I guess the long "does this solve the problem" delays
> that this went through pushed it out.
> 
> So I would need it resent no matter what.

There was no delay from our side. This whole interaction regarding a simple
fix is really frustrating. I will resend the patch.
