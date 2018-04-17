Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDQNbl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:31:41 -0400
Received: from mail-sn1nam01on0040.outbound.protection.outlook.com ([104.47.32.40]:31993
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753282AbeDQNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:31:39 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Thread-Topic: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Thread-Index: AQHTm41cR37jOK/olE2Igoi/oKD/9qP/29aAgAPg84CAAaZJUA==
Date: Tue, 17 Apr 2018 13:31:37 +0000
Message-ID: <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook> <20180416115624.GA1543@probook>
In-Reply-To: <20180416115624.GA1543@probook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1896;7:P4PvFwIDCMpObPEyfdB8WHQwJqecOBv6XX1fWbYt0+1iCawy2p2BbdFqocctIg9T3wHjYL8Pe3yKtzW9je4XT4e4X35DB8k/wTOsQ8T0v1u0GVtpV++WCr7qNlEiAq/rtB5cl+JHUo1Z2/kZtCXoNkEwtF4qvmtGZGBC2zJ+6loLxBAEXv9M1Z9U8WqdmanLgKWlRinK1yH7Pv5v7RjTOyj0qN1h5UqlAUoX3AJxcUiho69cyueNdN/+xkhySB64;20:gNvcI3Xzd/1BCWo7QRM+gtRkLYSi1c2ljsDHCXHDv0MMVO7E0SjC4qqjLW1+Mc3Y+gvBH4QIcOSgDbsDwU9dPP+NFWFUl+X9r9RTATOrFotqc69KfdkQ6DjM9P7Sy8hihLoZRv2eMAHsWTt4B5A46SGFwwBR0ZxaBmtIVTUFPy3r/fUNmLikXS11Y6Qe8DPDxZKyWP2ZClM3jO0/KEhJ1WxGbuNkXEgo0OExAkW/t1ylBoloiUPh1xPrBCiu0zpo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1896;
x-ms-traffictypediagnostic: CY4PR12MB1896:
x-microsoft-antispam-prvs: <CY4PR12MB1896EC1C82A1C988AAC62BFAF8B70@CY4PR12MB1896.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(211171220733660)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1896;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1896;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(39380400002)(199004)(189003)(13464003)(6246003)(81156014)(76176011)(2906002)(9686003)(81166006)(7696005)(99286004)(26005)(186003)(8936002)(3660700001)(11346002)(3280700002)(53936002)(6916009)(446003)(478600001)(5250100002)(6116002)(229853002)(33656002)(476003)(97736004)(2900100001)(3846002)(54906003)(25786009)(8676002)(74316002)(93886005)(316002)(72206003)(5660300001)(59450400001)(6436002)(486006)(66066001)(68736007)(53546011)(106356001)(7736002)(305945005)(55016002)(4326008)(102836004)(6506007)(105586002)(86362001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1896;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: E68ZK8SHmJ+F4t2fNr9V5+0IqRu19p+UbTD/wxKHzSLGXOLSR5u2dQsdr7wjcNyaj1j+26VoPgIBHc9MIoHantz04dpcHTkXpB88km9qeDlAfqB3KTD9mDHY4+T23uEmEFzJh+PpYpoaLevES07/M6m6hvrK2MulPk1tKJRjItO4Do+ojUZobKjnavBlbn3+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f4e249d7-c5e5-46a9-b82f-08d5a4678bab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e249d7-c5e5-46a9-b82f-08d5a4678bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 13:31:37.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1896
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3HDVids016000

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-
> owner@vger.kernel.org> On Behalf Of Johannes Hirte
> Sent: Monday, April 16, 2018 7:56 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; bp@suse.de;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
> block
> 
> On 2018 Apr 14, Johannes Hirte wrote:
> > On 2018 Feb 01, Yazen Ghannam wrote:
> > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > >
> > > The block address is saved after the block is initialized when
> > > threshold_init_device() is called.
> > >
> > > Use the saved block address, if available, rather than trying to
> > > rediscover it.
> > >
> > > We can avoid some *on_cpu() calls in the init path that will cause a
> > > call trace when resuming from suspend.
> > >
> > > Cc: <stable@vger.kernel.org> # 4.14.x
> > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > ---
> > >  arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > > index bf53b4549a17..8c4f8f30c779 100644
> > > --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > > +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > > @@ -436,6 +436,21 @@ static u32 get_block_address(unsigned int cpu,
> u32 current_addr, u32 low, u32 hi
> > >  {
> > >  	u32 addr = 0, offset = 0;
> > >
> > > +	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
> > > +		return addr;
> > > +
> > > +	/* Get address from already initialized block. */
> > > +	if (per_cpu(threshold_banks, cpu)) {
> > > +		struct threshold_bank *bankp = per_cpu(threshold_banks,
> cpu)[bank];
> > > +
> > > +		if (bankp && bankp->blocks) {
> > > +			struct threshold_block *blockp = &bankp-
> >blocks[block];
> > > +
> > > +			if (blockp)
> > > +				return blockp->address;
> > > +		}
> > > +	}
> > > +
> > >  	if (mce_flags.smca) {
> > >  		if (smca_get_bank_type(bank) == SMCA_RESERVED)
> > >  			return addr;
> > > --
> > > 2.14.1
> >
> > I have a KASAN: slab-out-of-bounds, and git bisect points me to this
> > change:
> >
> > Apr 13 00:40:32 probook kernel:
> ================================================================
> ==
> > Apr 13 00:40:32 probook kernel: BUG: KASAN: slab-out-of-bounds in
> get_block_address.isra.3+0x1e9/0x520
> > Apr 13 00:40:32 probook kernel: Read of size 4 at addr ffff8803f165ddf4 by
> task swapper/0/1
> > Apr 13 00:40:32 probook kernel:
> > Apr 13 00:40:32 probook kernel: CPU: 1 PID: 1 Comm: swapper/0 Not
> tainted 4.16.0-10757-g4ca8ba4ccff9 #532
> > Apr 13 00:40:32 probook kernel: Hardware name: HP HP ProBook 645
> G2/80FE, BIOS N77 Ver. 01.12 12/19/2017
> > Apr 13 00:40:32 probook kernel: Call Trace:
> > Apr 13 00:40:32 probook kernel:  dump_stack+0x5b/0x8b
> > Apr 13 00:40:32 probook kernel:  ? get_block_address.isra.3+0x1e9/0x520
> > Apr 13 00:40:32 probook kernel:  print_address_description+0x65/0x270
> > Apr 13 00:40:32 probook kernel:  ? get_block_address.isra.3+0x1e9/0x520
> > Apr 13 00:40:32 probook kernel:  kasan_report+0x232/0x350
> > Apr 13 00:40:32 probook kernel:  get_block_address.isra.3+0x1e9/0x520
> > Apr 13 00:40:32 probook kernel:  ? kobject_init_and_add+0xde/0x130
> > Apr 13 00:40:32 probook kernel:  ? get_name+0x390/0x390
> > Apr 13 00:40:32 probook kernel:  ? kasan_unpoison_shadow+0x30/0x40
> > Apr 13 00:40:32 probook kernel:  ? kasan_kmalloc+0xa0/0xd0
> > Apr 13 00:40:32 probook kernel:  allocate_threshold_blocks+0x12c/0xc60
> > Apr 13 00:40:32 probook kernel:  ? kobject_add_internal+0x800/0x800
> > Apr 13 00:40:32 probook kernel:  ? get_block_address.isra.3+0x520/0x520
> > Apr 13 00:40:32 probook kernel:  ? kasan_kmalloc+0xa0/0xd0
> > Apr 13 00:40:32 probook kernel:
> mce_threshold_create_device+0x35b/0x990
> > Apr 13 00:40:32 probook kernel:  ? init_special_inode+0x1d0/0x230
> > Apr 13 00:40:32 probook kernel:  threshold_init_device+0x98/0xa7
> > Apr 13 00:40:32 probook kernel:  ?
> mcheck_vendor_init_severity+0x43/0x43
> > Apr 13 00:40:32 probook kernel:  do_one_initcall+0x76/0x30c
> > Apr 13 00:40:32 probook kernel:  ?
> trace_event_raw_event_initcall_finish+0x190/0x190
> > Apr 13 00:40:32 probook kernel:  ? kasan_unpoison_shadow+0xb/0x40
> > Apr 13 00:40:32 probook kernel:  ? kasan_unpoison_shadow+0x30/0x40
> > Apr 13 00:40:32 probook kernel:  kernel_init_freeable+0x3d6/0x471
> > Apr 13 00:40:32 probook kernel:  ? rest_init+0xf0/0xf0
> > Apr 13 00:40:32 probook kernel:  kernel_init+0xa/0x120
> > Apr 13 00:40:32 probook kernel:  ? rest_init+0xf0/0xf0
> > Apr 13 00:40:32 probook kernel:  ret_from_fork+0x22/0x40
> > Apr 13 00:40:32 probook kernel:
> > Apr 13 00:40:32 probook kernel: Allocated by task 1:
> > Apr 13 00:40:32 probook kernel:  kasan_kmalloc+0xa0/0xd0
> > Apr 13 00:40:32 probook kernel:  kmem_cache_alloc_trace+0xf3/0x1f0
> > Apr 13 00:40:32 probook kernel:  allocate_threshold_blocks+0x1bc/0xc60
> > Apr 13 00:40:32 probook kernel:
> mce_threshold_create_device+0x35b/0x990
> > Apr 13 00:40:32 probook kernel:  threshold_init_device+0x98/0xa7
> > Apr 13 00:40:32 probook kernel:  do_one_initcall+0x76/0x30c
> > Apr 13 00:40:32 probook kernel:  kernel_init_freeable+0x3d6/0x471
> > Apr 13 00:40:32 probook kernel:  kernel_init+0xa/0x120
> > Apr 13 00:40:32 probook kernel:  ret_from_fork+0x22/0x40
> > Apr 13 00:40:32 probook kernel:
> > Apr 13 00:40:32 probook kernel: Freed by task 0:
> > Apr 13 00:40:32 probook kernel: (stack is not available)
> > Apr 13 00:40:32 probook kernel:
> > Apr 13 00:40:32 probook kernel: The buggy address belongs to the object at
> ffff8803f165dd80
> >  which belongs to the cache kmalloc-128 of size 128
> > Apr 13 00:40:32 probook kernel: The buggy address is located 116 bytes
> inside of
> >  128-byte region [ffff8803f165dd80, ffff8803f165de00)
> >  Apr 13 00:40:32 probook kernel: The buggy address belongs to the page:
> > Apr 13 00:40:32 probook kernel: page:ffffea000fc59740 count:1
> mapcount:0 mapping:0000000000000000 index:0x0
> > Apr 13 00:40:32 probook kernel: flags: 0x2000000000000100(slab)
> > Apr 13 00:40:32 probook kernel: raw: 2000000000000100
> 0000000000000000 0000000000000000 0000000180150015
> > Apr 13 00:40:32 probook kernel: raw: dead000000000100
> dead000000000200 ffff8803f3403340 0000000000000000
> > Apr 13 00:40:32 probook kernel: page dumped because: kasan: bad access
> detected
> > Apr 13 00:40:32 probook kernel:
> > Apr 13 00:40:32 probook kernel: Memory state around the buggy address:
> > Apr 13 00:40:32 probook kernel:  ffff8803f165dc80: fc fc fc fc fc fc fc fc 00 00
> 00 00 00 00 00 00
> > Apr 13 00:40:32 probook kernel:  ffff8803f165dd00: 00 00 00 00 00 00 00 fc
> fc fc fc fc fc fc fc fc
> > Apr 13 00:40:32 probook kernel: >ffff8803f165dd80: 00 00 00 00 00 00 00
> 00 00 00 00 00 00 fc fc fc
> > Apr 13 00:40:32 probook kernel:                                                              ^
> > Apr 13 00:40:32 probook kernel:  ffff8803f165de00: fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc
> > Apr 13 00:40:32 probook kernel:  ffff8803f165de80: fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc
> > Apr 13 00:40:32 probook kernel:
> ================================================================
> ==
> >
> 
> Putting the whole chaching part under the
> 
> if (mce_flags.smca) {
> 
> solved the issue on my Carrizo.
> 

Thanks for reporting this. I'm able to reproduce this on my Fam17h system. The
caching should still be the same on non-SMCA systems. Putting it all under the
SMCA flags effectively removes it on Carrizo.

Here are when get_block_address() is called:
1) Boot time MCE init. Called on each CPU. No caching.
2) Init of the MCE device. Called on a single CPU. Values are cached here.
3) CPU on/offling which calls MCE init. Should use the cached values.

It seems to me that the KASAN bug is detected during #2 though it's not yet clear
to me what the issue is. I need to read up on KASAN and keep debugging.

Do any of the maintainers have any suggestions?

Thanks,
Yazen
