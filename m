Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeEQNEX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:04:23 -0400
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:29872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751280AbeEQNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:04:21 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>,
        Johannes Hirte <johannes.hirte@datenkhaos.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Thread-Topic: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Thread-Index: AQHTm41cR37jOK/olE2Igoi/oKD/9qP/29aAgAPg84CAAaZJUIArxy4AgAJuKICAAIbngIAAQMoAgAAhoBA=
Date: Thu, 17 May 2018 13:04:19 +0000
Message-ID: <CY4PR12MB1557AB31F5F9D1ECBDAC2DA6F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook> <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook> <20180516224641.GA31929@pd.tnic>
 <20180517064930.GA26421@probook> <20180517104124.GA25595@pd.tnic>
In-Reply-To: <20180517104124.GA25595@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1189;7:tXStrVX/Cf0HtHRM5Bh5ZMlKE6904lvTZ6aZSfjlZ4JCOLcROsxRTWYTwGWa0a8QRzEFuhDQ9YoHy2O0a4N6iU1zcCbvtxHk5+GIjD/km/uuQ8NIind3a/hoN9wrKWVCWaLdHfIXFWzNdQF5fbSZNXvSpOhU+xwSDjLbqhbAvu6CFws9cb1DoSK8mlJmCzWk8IocTzYeA1mn4l21Y1pnXtJdPiNDslagb60o8biqZuHyrP8uNC5LxxuOUH/clQoC;20:Da9vX30DhJQXAy80kYq4CmfHw3wtXd/CP8CxH++qUjhxZlv1X4gMOWHZtbDM1fb29REw+WnCqs3j3pXuF+KCSmKTyHVNx+qxQbXh5cwyfa7tgRvWCiBEJVGGVP5fkEwh1F+6ErsmkjjH75WEyKB7eKxBragHNkhfkwlSq6oqVOOw7VcwYAnzgyTSG9jJsGtlp0LYmEgmydnTef9ir1H2VEHz1Y6WXSorYIxIvQnDHo65e7yPiHb3/0BFE5aMkuh/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1189;
x-ms-traffictypediagnostic: CY4PR12MB1189:
x-microsoft-antispam-prvs: <CY4PR12MB11896955BBE9EC508C45D4EEF8910@CY4PR12MB1189.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1189;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1189;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(39380400002)(199004)(189003)(13464003)(186003)(46003)(486006)(53546011)(33656002)(6506007)(11346002)(446003)(476003)(102836004)(76176011)(7696005)(110136005)(54906003)(93886005)(74316002)(72206003)(106356001)(55016002)(478600001)(5660300001)(105586002)(14454004)(81166006)(8676002)(3280700002)(6116002)(2906002)(8936002)(81156014)(2900100001)(305945005)(3660700001)(7736002)(97736004)(6246003)(229853002)(5250100002)(86362001)(25786009)(4326008)(99286004)(316002)(68736007)(9686003)(6436002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1189;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: a9xanqLpjX//jnKVl3hVNAKnxMxnUu6u5lAZM5c1j5lNF0neZ3bot5/1+AkBuDdMq/1doM1Yoesd6DYZ9b+pGfivu2c+dcbw1tqqSKtgXdsQgQGI/qnC4j7RkDkfT2HyTHkfVi2yzmnrI02bgS/YZFdyYWifXVvEgJlErRdrrzixPYlPq1tLa9u6L6mL6VPp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6f4f1485-0e85-46b0-6068-08d5bbf6b3ab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4f1485-0e85-46b0-6068-08d5bbf6b3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 13:04:19.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HD4QRR011194

> -----Original Message-----
> From: Borislav Petkov <bp@suse.de>
> Sent: Thursday, May 17, 2018 6:41 AM
> To: Johannes Hirte <johannes.hirte@datenkhaos.de>
> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; tony.luck@intel.com;
> x86@kernel.org
> Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
> block
> 
> On Thu, May 17, 2018 at 08:49:31AM +0200, Johannes Hirte wrote:
> > Maybe I'm missing something, but those RDMSR IPSs don't happen on
> > pre-SMCA systems, right? So the caching should be avoided here, cause
> > the whole lookup looks more expensive to me than the simple switch-block
> > in get_block_address.
> 
> Yeah, and we should simply cache all those MSR values as I suggested then.
> 

Yes, you're right. I thought using the existing data structures would work, but it
seems I messed up the implementation.

> The patch at the end should fix your issue.
> 
> Yazen, so I'm working on the assumption that all addresses are the same
> on every core - I dumped them and it looks like this:
> 
>     128 bank: 00, block: 0 : 0xc0002003
>     128 bank: 00, block: 1 : 0x0
>     128 bank: 01, block: 0 : 0xc0002013
>     128 bank: 01, block: 1 : 0x0
>     128 bank: 02, block: 0 : 0xc0002023
>     128 bank: 02, block: 1 : 0x0
>     128 bank: 03, block: 0 : 0xc0002033
>     128 bank: 03, block: 1 : 0x0
>     128 bank: 04, block: 0 : 0x0
>     128 bank: 05, block: 0 : 0xc0002053
>     128 bank: 05, block: 1 : 0x0
>     128 bank: 06, block: 0 : 0xc0002063
>     128 bank: 06, block: 1 : 0x0
>     128 bank: 07, block: 0 : 0xc0002073
>     128 bank: 07, block: 1 : 0x0
>     128 bank: 08, block: 0 : 0xc0002083
>     128 bank: 08, block: 1 : 0x0
>     128 bank: 09, block: 0 : 0xc0002093
>     128 bank: 09, block: 1 : 0x0
>     128 bank: 10, block: 0 : 0xc00020a3
>     128 bank: 10, block: 1 : 0x0
>     128 bank: 11, block: 0 : 0xc00020b3
>     128 bank: 11, block: 1 : 0x0
>     128 bank: 12, block: 0 : 0xc00020c3
>     128 bank: 12, block: 1 : 0x0
>     128 bank: 13, block: 0 : 0xc00020d3
>     128 bank: 13, block: 1 : 0x0
>     128 bank: 14, block: 0 : 0xc00020e3
>     128 bank: 14, block: 1 : 0x0
>     128 bank: 15, block: 0 : 0xc00020f3
>     128 bank: 15, block: 1 : 0x0
>     128 bank: 16, block: 0 : 0xc0002103
>     128 bank: 16, block: 1 : 0x0

Banks 15 and 16 should have an address for block 1 also. Do you have PFEH
enabled on your system? That would cause MISC0 to be RAZ so we won't
get the MISC1 address. I'll try it myself also and let you know. 

>     128 bank: 17, block: 0 : 0xc0002113
>     128 bank: 17, block: 1 : 0x0
>     128 bank: 18, block: 0 : 0xc0002123
>     128 bank: 18, block: 1 : 0x0
>     128 bank: 19, block: 0 : 0xc0002133
>     128 bank: 19, block: 1 : 0x0
>     128 bank: 20, block: 0 : 0xc0002143
>     128 bank: 20, block: 1 : 0x0
>     128 bank: 21, block: 0 : 0xc0002153
>     128 bank: 21, block: 1 : 0x0
>     128 bank: 22, block: 0 : 0xc0002163
>     128 bank: 22, block: 1 : 0x0
> 
> so you have 128 times the same address on a 128 core Zen box.
> 
> If that is correct, then we can use this nice simplification and cache
> them globally and not per-CPU. Seems to work here. Scream if something's
> amiss.
> 

I think this good for now. We'll probably need to change it in the future, but
maybe we can clean up all the thresholding blocks code and make it simpler
when we do change it.

> Thx.
> 
> ---
> From d8614e904d8f63b89d2d204d6fa247c4c416a1b6 Mon Sep 17 00:00:00
> 2001
> From: Borislav Petkov <bp@susede>
> Date: Thu, 17 May 2018 10:46:26 +0200
> Subject: [PATCH] array caching
> 
> Not-Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/mcheck/mce_amd.c | 29 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> index f7666eef4a87..c8e038800591 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> @@ -94,6 +94,11 @@ static struct smca_bank_name smca_names[] = {
>  	[SMCA_SMU]	= { "smu",		"System Management Unit" },
>  };
> 
> +static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
> +{
> +	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
> +};
> +
>  const char *smca_get_name(enum smca_bank_types t)
>  {
>  	if (t >= N_SMCA_BANK_TYPES)
> @@ -443,20 +448,26 @@ static u32 smca_get_block_address(unsigned int
> cpu, unsigned int bank,
>  	if (!block)
>  		return MSR_AMD64_SMCA_MCx_MISC(bank);
> 
> +	/* Check our cache first: */
> +	if (smca_bank_addrs[bank][block] != -1)
> +		return smca_bank_addrs[bank][block];
> +

This hunk could go above the !block. Though maybe the macro is lighter than the
array lookup. It'll work either way, but I'm just thinking out loud.

>  	/*
>  	 * For SMCA enabled processors, BLKPTR field of the first MISC register
>  	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-
> 4).
>  	 */
>  	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank),
> &low, &high))
> -		return addr;
> +		goto out;
> 
>  	if (!(low & MCI_CONFIG_MCAX))
> -		return addr;
> +		goto out;
> 
>  	if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank),
> &low, &high) &&
>  	    (low & MASK_BLKPTR_LO))
> -		return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
> +		addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
> 
> +out:
> +	smca_bank_addrs[bank][block] = addr;
>  	return addr;
>  }
> 

Since we're caching the values during init, we can drop all the *_on_cpu() calls.
What do you think?

Thanks,
Yazen
