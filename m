Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeD3PjG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:39:06 -0400
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:7653
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753582AbeD3PjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:39:04 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@suse.de>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        "x86@kernel.org" <x86@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Woods, Brian" <Brian.Woods@amd.com>
Subject: RE: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
Thread-Topic: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
Thread-Index: AQHT310NMNLPHU+8P0W67M8E2o7v6aQYBx+AgAAIxoCAAVsfAA==
Date: Mon, 30 Apr 2018 15:38:59 +0000
Message-ID: <MWHPR12MB1566866B2ACF36EAD7E4856AF8820@MWHPR12MB1566.namprd12.prod.outlook.com>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
 <20180429175305.GB19814@pd.tnic>
 <a4b1d937-c5b8-67d0-b5f0-312145fefc09@roeck-us.net>
In-Reply-To: <a4b1d937-c5b8-67d0-b5f0-312145fefc09@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR12MB1552;7:tbfaYSVC96+gPH22sv1pJ591gsT/rOY2YiWf0A6jN+qRiDKgAXH/AjgovB+2/lEHZswf2G68WcpS73uW/7gXBLLDs3bFXBfaeVSofVIIY8mm9osmSKKEUpD++k6w7xtGB3QKGC3Z5hgZbcKmUFTn2rFqRKwmF1qdjp/o+iCoFDH2vEC6P/TPlKaQPg8LImctUewgdFQI23mSaOZIs0ilix1FXIAPCbr9SyYped9NZtAKCZ074O+D9p+wQ7ES0M15;20:U58sNZjudso8fk3+qTTA3XTWbZnkJYPdRjoHDyK2nk259E4GKc4u2uB447Nsx1OtodCApkc+11lCia5mFlUXBDhivL3ZC4B0NeY3nPg2ePdsQjJItllMPuQ3i1CjugGcoNVyQ0PD22h3/dyJrmKBOD0vJYV5/ib8oXaPHttzxmsIf6FLk2RtK3pFwKc3QWbxJJ/wPxLyuSXQ0UwOgHjGygxzntX7bnd/a3S1aQhiiAyV3D9WeNWOI0a0H+dV+nN4
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(13464003)(189003)(199004)(3846002)(6116002)(6246003)(106356001)(81156014)(26005)(33656002)(2906002)(3280700002)(5250100002)(7696005)(74316002)(7736002)(3660700001)(305945005)(8936002)(5660300001)(81166006)(14454004)(86362001)(68736007)(8676002)(186003)(575784001)(25786009)(9686003)(6436002)(486006)(59450400001)(6506007)(99286004)(105586002)(72206003)(53936002)(66066001)(446003)(2900100001)(316002)(54906003)(478600001)(229853002)(102836004)(110136005)(76176011)(11346002)(476003)(4326008)(55016002)(53546011)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1552;H:MWHPR12MB1566.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1552;
x-ms-traffictypediagnostic: MWHPR12MB1552:
x-microsoft-antispam-prvs: <MWHPR12MB1552AF10E2727F3A1CD02FAAF8820@MWHPR12MB1552.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1552;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1552;
x-forefront-prvs: 0658BAF71F
x-microsoft-antispam-message-info: IbJ4MtuvdyZF8cctxeYnwcDGpXcmas/HhDLgakeo9GMFHxPyev/K3Wj1obK2NwdaG87HbwMlLPyim7VODfy3ftRjXbQs2a3D2ZwftlCANAImz9HZ+7rQ7byWUMjUQqgNGf0KRI3/p8O47jH3AMLm7H9Nib6MU6ynyinrR8gVy0JpH3EMpHpyfXvHqXQnBU2w
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 032314f3-8727-40e9-52e7-08d5aeb07e38
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032314f3-8727-40e9-52e7-08d5aeb07e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:38:59.6328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1552
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3UFdAps030863

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Sunday, April 29, 2018 2:24 PM
> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
> <Yazen.Ghannam@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Clemens Ladisch
> <clemens@ladisch.de>; x86@kernel.org; Jean Delvare <jdelvare@suse.com>;
> linux-kernel@vger.kernel.org; linux-hwmon@vger.kernel.org; Woods, Brian
> <Brian.Woods@amd.com>
> Subject: Re: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
> 
> On 04/29/2018 10:53 AM, Borislav Petkov wrote:
> > On Sat, Apr 28, 2018 at 06:54:38PM -0700, Guenter Roeck wrote:
> >> Add Raven Ridge root bridge and data fabric PCI IDs.
> >> This is required for amd_pci_dev_to_node_id() and amd_smn_read().
> >>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >> This patch is a prerequisite for the second patch in the series.
> >> I'll be happy to apply both patches through hwmon if that is acceptable
> >> (and Cc: stable for 4.16+). If not, I'll be happy to wait for this patch
> >> to be available upstream.
> >>
> >> Since that there is no public documentation available for Raven Ridge,
> >> PCI IDs are derived from output of lspci.
> >>
> >>   arch/x86/kernel/amd_nb.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> >> index c88e0b127810..bd33613ecb7c 100644
> >> --- a/arch/x86/kernel/amd_nb.c
> >> +++ b/arch/x86/kernel/amd_nb.c
> >> @@ -14,8 +14,11 @@
> >>   #include <asm/amd_nb.h>
> >>
> >>   #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
> >> +#define PCI_DEVICE_ID_AMD_17H_RR_ROOT	0x15d0
> >
> > I think the nomenclature we decided upon at the time was
> >
> > ...AMD_<family>H_M<model>H...
> >
> > PCI_DEVICE_ID_AMD_15H_M10H_F3, for example.
> >
> > And in this case, it should be
> >
> > PCI_DEVICE_ID_AMD_17H_M<which model is RV>H_F<PCI function
> number>
> >
> 
> Makes sense.
> 
> > Yazen, which is the first model of Raven Ridge?
> >
> 
> 2400G is model 17 (0x11). I was unable to find information if there are
> other chips/models using the same set of PCI IDs.
> 
> I'll wait for additional feedback before resending.

There are other models using the same set of IDs, but the first is 10h.

Also, the F3 IDs for Fam17h and Fam17hMod10h are used in both amd_nb.c
and k10temp.c. Can you please delete the F3 IDs from these files and add
them to "include/linux/pci_ids.h"?

Thanks!

-Yazen
