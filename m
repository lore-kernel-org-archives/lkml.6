Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeCMUZF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:25:05 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:37608 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbeCMUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:25:04 -0400
From: "Kroening, Gary" <gary.kroening@hpe.com>
To: "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from
 CAPID6 register
Thread-Topic: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from
 CAPID6 register
Thread-Index: AQHTuvyO0D+Of7czYkGr25KCDMyAqKPOm6/g
Date: Tue, 13 Mar 2018 20:24:59 +0000
Message-ID: <CS1PR84MB01181FC374E9E14AD2EA6618F6D20@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
References: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary.kroening@hpe.com;
x-originating-ip: [192.48.179.6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CS1PR84MB0040;7:tGMIdbllAr9pwPGW0AorxkMJmEzmv6O9CuOs5TG5hVN1+WKZyuV0yzW5uxnAySQNdytc6nfu9pisd/iZGxkerJc5fHIl8MsMLeqN9XPKQRE2ihtIHQ5L1xuGtpfMU2qIGGOQ6p6t9xcjjFUoU4EOs5yQUiIMnTnVa7fXzdod/mMmmZtgC0tj69iC+6cE9/C2razHmF9CZOkhfkHf6MO3MmU4MtkWSJr/hSKritpo3n3zvNGbsBjy9Tkfd4pzCbGC
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(13464003)(6246003)(39060400002)(105586002)(110136005)(6506007)(2906002)(81156014)(186003)(2201001)(305945005)(229853002)(74316002)(81166006)(55016002)(2950100002)(86362001)(26005)(2900100001)(59450400001)(6116002)(478600001)(3846002)(7696005)(76176011)(54906003)(66066001)(6436002)(8936002)(25786009)(53546011)(4326008)(3280700002)(99286004)(53936002)(33656002)(97736004)(102836004)(106356001)(68736007)(9686003)(3660700001)(5660300001)(7736002)(14454004)(5250100002)(2501003)(8676002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR84MB0040;H:CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aee4ce59-33d0-4b38-294f-08d589207e98
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CS1PR84MB0040;
x-ms-traffictypediagnostic: CS1PR84MB0040:
x-microsoft-antispam-prvs: <CS1PR84MB0040486D78B630A5B2D2F906F6D20@CS1PR84MB0040.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(158342451672863)(9452136761055)(85827821059158)(222181515654134)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CS1PR84MB0040;BCL:0;PCL:0;RULEID:;SRVR:CS1PR84MB0040;
x-forefront-prvs: 0610D16BBE
x-microsoft-antispam-message-info: SVxh4hb6e15qwifEg6Cm+0OmIITC53tG2HnVND9ybUgw7fZIdpmsodzImZuvXzJVNe2wfOJqI9NcdrOWE0ngRFZfcykBOTs3Ac31XIyV4XbhHw8KzG4DAbbK0VAPR26LU+Mm6cqdl3/qHChh3iyT7/VdmtICYrgs+socsgSc7WOXSPG7hluWYqOoHSrOZVCT6HGCqQVoj69jwX+BU3VOEX7VI/sNOQZf6+HT0BnlTHNKAyqt2uVWADnOGOFQsaAcbi8u3LQi3UNvH+90b/sJsopRFj3TbLnWERGBA3/Ov+pwkaa4T7NDp1/KOBb3CL4srX3fAGQ1xUf8QhlD1d5dEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aee4ce59-33d0-4b38-294f-08d589207e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 20:24:59.7559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR84MB0040
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested this patch on the same set of hubless (single-segment) and scalable (segment-per-socket) configurations as for Kan's version 1.

As far as we can tell this will also work for Cascade Lake, but will need revisiting for Ice Lake.

Thanks.
Gary

> -----Original Message-----
> From: kan.liang@linux.intel.com [mailto:kan.liang@linux.intel.com]
> Sent: Tuesday, March 13, 2018 1:52 PM
> To: mingo@redhat.com; hpa@zytor.com; tglx@linutronix.de;
> peterz@infradead.org; andy.shevchenko@gmail.com
> Cc: Kroening, Gary; Travis, Mike; Banman, Andrew; Sivanich, Dimitri;
> Anderson, Russ; x86@kernel.org; linux-kernel@vger.kernel.org; Kan Liang
> Subject: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from
> CAPID6 register
> 
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The number of CHAs is miscalculated on multi PCI domain systems on
> Skylake server.
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
> 
> Changes since V1:
>  - add missed pci_dev_put()
>  - Drop ugly casting by using hweight32()
>  - Add comments for macros.
> 
>  arch/x86/events/intel/uncore_snbep.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c
> b/arch/x86/events/intel/uncore_snbep.c
> index 6d8044a..8970f71 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3562,24 +3562,27 @@ static struct intel_uncore_type *skx_msr_uncores[]
> = {
>  	NULL,
>  };
> 
> +/*
> + * To determine the number of CHAs, it should read bits 27:0 in the
> CAPID6
> + * register which located at Device 30, Function 3, Offset 0x9C. PCI ID
> 0x2083.
> + */
> +#define SKX_CAPID6		0x9c
> +#define SKX_CHA_BIT_MASK	GENMASK(27, 0)
> +
>  static int skx_count_chabox(void)
>  {
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
> +		goto out;
> 
> -	pci_dev_put(chabox_dev);
> -	return count;
> +	pci_read_config_dword(dev, SKX_CAPID6, &val);
> +	val &= SKX_CHA_BIT_MASK;
> +out:
> +	pci_dev_put(dev);
> +	return hweight32(val);
>  }
> 
>  void skx_uncore_cpu_init(void)
> --
> 2.7.4
