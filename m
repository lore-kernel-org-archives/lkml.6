Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeCMFHG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:07:06 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:13003 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeCMFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:07:04 -0400
From: "Kroening, Gary" <gary.kroening@hpe.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
CC: "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
Thread-Topic: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
Thread-Index: AdO2UfB8yN2vSnEwTbiLc015dBFinAEGp+QAAAaS7GA=
Date: Tue, 13 Mar 2018 05:06:59 +0000
Message-ID: <CS1PR84MB0118227E1E8F1257E37C75C3F6D20@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
In-Reply-To: <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.48.179.6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CS1PR84MB0293;7:er2JpGYrogFX8cuo7KLvGDbk9vM5kWvRajnSk33oaG/CUEGdpqozJ1wfXaJqvWc5s3kZjDRye0qllgxzo/Gli7OXI5i10Tg6BXXT/tz5CEr6ivBy+WmvcdtArvjxJUbQKAQEGog3gQB7rJzK3t5zM0Cdp9ZqiW4hIwSo5SBro2Yyui3kJoKh6lr8ANa7TYGosD/EDwLy64VpsEZTCcY2SLSLsyeIufoMqdNCSURYOGCWbw0lmQ4biGPn3eMrxiYv
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(39380400002)(366004)(51914003)(13464003)(199004)(189003)(53546011)(33656002)(26005)(316002)(102836004)(106356001)(53936002)(76176011)(74316002)(6506007)(3280700002)(3846002)(97736004)(2900100001)(229853002)(6116002)(59450400001)(81156014)(2201001)(8676002)(110136005)(8936002)(81166006)(86362001)(6246003)(186003)(25786009)(2950100002)(68736007)(14454004)(99286004)(55016002)(6436002)(54906003)(5250100002)(4326008)(5660300001)(9686003)(2501003)(7696005)(66066001)(305945005)(3660700001)(2906002)(105586002)(478600001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR84MB0293;H:CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28d02d2b-8b0a-40b9-1541-08d588a04000
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CS1PR84MB0293;
x-ms-traffictypediagnostic: CS1PR84MB0293:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary.kroening@hpe.com;
x-microsoft-antispam-prvs: <CS1PR84MB029308F94993E3CEC47542BBF6D20@CS1PR84MB0293.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(158342451672863)(9452136761055)(222181515654134)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CS1PR84MB0293;BCL:0;PCL:0;RULEID:;SRVR:CS1PR84MB0293;
x-forefront-prvs: 0610D16BBE
x-microsoft-antispam-message-info: rJqVPZXaE735VNENCMRYL6NOcXPgCw0AkSlKKwS7+8srg9EbAy+xJe2VgFk+hu5Nl/995JRfv2HMJO44XbVz/bUvofnKxkvdh2+q3YXmjS3U2IxMp4GXFCm8JD3zhxvHghLmADq0qTwBIa5i3AkYi3Q05pZ8+nQ/19Evzdo50PwauxzHJ3cYmbXiLt5Dzd01Wc4jKH0ncK9O0wEwIz/Ew+jjlL8X5nFzNeL5DK80C5vumgnpbXVqasYOvTPbmxj3ZLtXRkwnCVZ7zqye5AEi4B27k7aR9GAIvxbMMhYRCzs/ABL+Z7SNfW8UNNkUQCQFa04/Wam5v/rYewmaI0mPIA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d02d2b-8b0a-40b9-1541-08d588a04000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 05:06:59.0810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR84MB0293
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2D57EOd003204

Thanks, Kan -- your patch looks good, and cleaner than the previous method!

Tonight, I've tested it on our in-house simulator for the following configurations. The simulator has been matching hardware well for this issue -- we'll do more testing on real hardware, but I'm confident you have it right.

Terminology:

"hubless" -- equivalent to "glueless" or "white box" where our BIOS sets things up with a single bus for all sockets.

"scalable" -- BIOS assigns a new segment/domain for each socket

Configurations tested so far:
- single-socket hubless/scalable
- two sockets, scalable
- four sockets, hubless
- eight sockets, scalable

In all cases, skx_count_chabox() is returning 28 for Skylake server.
Thanks for the quick response!
Gary

> -----Original Message-----
> From: Liang, Kan [mailto:kan.liang@linux.intel.com]
> Sent: Monday, March 12, 2018 8:43 PM
> To: Kroening, Gary; mingo@redhat.com; hpa@zytor.com; tglx@linutronix.de;
> peterz@infradead.org
> Cc: Travis, Mike; Banman, Andrew; Sivanich, Dimitri; Anderson, Russ;
> x86@kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on multi-pci-
> segment arches
> 
> 
> 
> On 3/7/2018 3:33 PM, Kroening, Gary wrote:
> > For systems with a single PCI segment, it is sufficient to look for the
> > bus number to change in order to determine that all of the CHa's have
> > been counted for a single socket.
> >
> > However, for multi PCI segment systems, each socket is given a new
> > segment and the bus number does NOT change.  So looking only for the
> > bus number to change ends up counting all of the CHa's on all sockets
> > in the system.  This leads to writing CPU MSRs beyond a valid range and
> > causes an error in ivbep_uncore_msr_init_box().
> >
> > The fix is to check for either the bus number or segment number to
> change.
> >
> 
> Hi Gary,
> 
> There is a recommended way in uncore document to query the number of
> CHAs on Skylake server.
> I have a patch to implement the new way.
> 
> Could you please take a look at the patch and see if it can fix your
> issue?
> 
> 
> Thanks,
> Kan
> 
> ------
>  From 55f54b2fa3021c691c2fd4f5cfc8f441fd104e91 Mon Sep 17 00:00:00 2001
> From: Kan Liang <kan.liang@linux.intel.com>
> Date: Mon, 12 Mar 2018 13:03:40 -0700
> Subject: [PATCH] perf/x86/intel/uncore: Querying number of CHAs from
> CAPID6 register
> 
> The number of CHAs is miscalculated on multi PCI domain systems on
> Skylake server
> 
> (From Kroening, Gary:
> 
> For systems with a single PCI segment, it is sufficient to look for the
> bus number to change in order to determine that all of the CHa's have
> been counted for a single socket.
> However, for multi PCI segment systems, each socket is given a new
> segment and the bus number does NOT change.  So looking only for the
> bus number to change ends up counting all of the CHa's on all sockets
> in the system.  This leads to writing CPU MSRs beyond a valid range and
> causes an error in ivbep_uncore_msr_init_box().)
> 
> To determine the number of CHAs, it should read bits 27:0 in the CAPID6
> register located at Device 30, Function 3, Offset 0x9C. These 28 bits
> form a bit vector of available LLC slices and the CHAs that manage those
> slices.
> 
> Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore
> support")
> Reported-by: Kroening, Gary <gary.kroening@hpe.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/x86/events/intel/uncore_snbep.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c
> b/arch/x86/events/intel/uncore_snbep.c
> index d4672ed..a42715b 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3575,24 +3575,20 @@ static struct intel_uncore_type
> *skx_msr_uncores[] = {
>   	NULL,
>   };
> 
> +#define SKX_CAPID6		0x9c
> +#define SKX_CHA_BIT_WIDTH	28
> +
>   static int skx_count_chabox(void)
>   {
> -	struct pci_dev *chabox_dev = NULL;
> -	int bus, count = 0;
> +	struct pci_dev *dev = NULL;
> +	u32 val = 0;
> 
> -	while (1) {
> -		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d,
> chabox_dev);
> -		if (!chabox_dev)
> -			break;
> -		if (count == 0)
> -			bus = chabox_dev->bus->number;
> -		if (bus != chabox_dev->bus->number)
> -			break;
> -		count++;
> -	}
> +	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
> +	if (!dev)
> +		return 0;
> 
> -	pci_dev_put(chabox_dev);
> -	return count;
> +	pci_read_config_dword(dev, SKX_CAPID6, &val);
> +	return bitmap_weight((unsigned long *)&val, SKX_CHA_BIT_WIDTH);
>   }
> 
>   void skx_uncore_cpu_init(void)
> --
> 2.7.4
