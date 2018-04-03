Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeDCOru (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:47:50 -0400
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com ([104.47.32.83]:46101
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeDCOrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:47:48 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ingo Molnar <mingo@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>
Subject: RE: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Thread-Topic: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Thread-Index: AQHTyrFJKPMqgSsBDkysEhYXPXzBJKPu4YMAgAAvpBCAAAzzgIAAASwg
Date: Tue, 3 Apr 2018 14:47:46 +0000
Message-ID: <CY4PR12MB15574BF988D5E24957D27471F8A50@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180402183424.48222-1-Yazen.Ghannam@amd.com>
 <20180403110352.izr2kvsd3ys4drjq@gmail.com>
 <CY4PR12MB1557216A1882A4CFC43248D3F8A50@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180403144043.23o5aijs4hlyj2dj@gmail.com>
In-Reply-To: <20180403144043.23o5aijs4hlyj2dj@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1621;7:Yofv8hyuENBvYDp+F8jY5vs1RhwjbGK9xZniHUkfE2+yERe9N3qJ3a1FB3juxTd4b7u8jXLtZpLL2/SvZb/IUoCZu/qo9D9NZuRrC/fwxxNHfldViwvrVprMOgEqMODEZ/yTICmQ8efHosxiD3qlbbq9Jj83EtWe3+uMcWZMJxhDsPXPhId0E2SL5oGMKdI/buETMqyQNvpNDsWEYacckpiHIinDk8Pu3r90Rd/uXlDyedda7krMwv3GXMgkE6g6;20:NPp5U/Mfwd7yKFTyMmMdslqV/nra6oQIIZquxBlrodgmw79SPXMaR6CcI663e8xZtQ6mkeT3ZgexjAWIWLSrivK9HSYYZayw+OhUxq6vGzUBdjrgcilgC1FNkHuAMioxrJdNSALLdvQCp77trzqKifnJO+BBZ10NERmm9B19xhDLWtRy6rsE245FwgyWqUSat7FU5btSdnqx6+kyE0JQXAPbJHSCgwhA9jEuCUKoewuyVdoJZK8+hGkPYUSbvaNW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c223b109-8076-448b-9c23-08d59971dd9a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1621;
x-ms-traffictypediagnostic: CY4PR12MB1621:
x-microsoft-antispam-prvs: <CY4PR12MB162188A58F78FD94073EE36EF8A50@CY4PR12MB1621.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1621;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1621;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(13464003)(199004)(189003)(186003)(316002)(9686003)(53936002)(106356001)(55016002)(66066001)(6116002)(68736007)(3846002)(5660300001)(3280700002)(229853002)(72206003)(33656002)(54906003)(6436002)(105586002)(102836004)(26005)(25786009)(3660700001)(53546011)(6506007)(478600001)(2906002)(7736002)(7696005)(4326008)(6916009)(2900100001)(446003)(8936002)(8676002)(59450400001)(14454004)(486005)(476003)(11346002)(486005)(81166006)(81156014)(305945005)(74316002)(86362001)(6246003)(93886005)(5250100002)(99286004)(97736004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1621;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6/GhkWisCg/fkrhpAMJF3NHGZYLyCx76nDrgXxy/WniC14EIIvxIYzIWHwAVaUTMYBxi6/KZ3+/Q3kvc/Tuo6hBEWJi3Nd9t8+5EbYUpoRZVIi9pYTnfibA98EKYV/v0komoNvCYIU+LgAwcGNbjTZF5pe7MlMYknxN11YLsJz1t/s1ECilxKZo5RggrR4XRxUbP3nX30ILQQZkkiVJ1uEGIyQK9pM2TLJX2sjFdOligYMFB6tVZ2aggVziuLs9KEjuz97DIyAHfwyrl3Xeun+7pgFIX2ej1sRk7P5qCaztcSD9UiS3cWVbofyHZPU4qrnYaxnpFa3Yl7da8zHFbgkcPj7e0O39F/wTHREaL8f3iFXGI9cHVkP/7IL41loTXqx6e1rJPH6yFnli4DQKASpgZJXWbqNx3cuBMGoVY5HE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c223b109-8076-448b-9c23-08d59971dd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 14:47:46.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1621
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w33EluQa005216

> -----Original Message-----
> From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo Molnar
> Sent: Tuesday, April 3, 2018 10:41 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@suse.de
> Subject: Re: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD
> systems
> 
> 
> * Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo
> Molnar
> > > Sent: Tuesday, April 3, 2018 7:04 AM
> > > To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> > > Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@suse.de
> > > Subject: Re: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD
> > > systems
> > >
> > >
> > > * Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> > >
> > > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > > >
> > > > Recent AMD systems support using MWAIT for C1 state. However, MWAIT
> will
> > > > not allow deeper cstates than C1 on current systems.
> > > >
> > > > With play_dead() we expect the OS to use the deepest state available.
> > > > The deepest state available on AMD systems is reached through SystemIO
> > > > or HALT. If MWAIT is available, we use it instead of the other methods,
> > > > so we never reach the deepest state.
> > > >
> > > > Don't try to use MWAIT to play_dead() on AMD systems. Instead, we'll use
> > > > CPUIDLE to enter the deepest state advertised by firmware. If CPUIDLE is
> > > > not available then we fallback to HALT.
> > > >
> > > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > ---
> > > >  arch/x86/kernel/smpboot.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > > index ff99e2b6fc54..67cf00b25f83 100644
> > > > --- a/arch/x86/kernel/smpboot.c
> > > > +++ b/arch/x86/kernel/smpboot.c
> > > > @@ -1536,6 +1536,9 @@ static inline void mwait_play_dead(void)
> > > >  	void *mwait_ptr;
> > > >  	int i;
> > > >
> > > > +	/* Don't try native MWAIT on AMD. Stick to CPUIDLE and HALT. */
> > > > +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> > > > +		return;
> > >
> > > The comment should mainly explain the 'why is this done', not the 'what is
> done'
> > > which is pretty obvious from the code ...
> > >
> >
> > Yes, I'll drop that comment since the commit message has the explanation.
> 
> Or rather, explain the 'why' in the comment, because otherwise this is a pretty
> obscure condition that is not self-documenting?
> 

Okay, how about this?

"MWAIT only provides shallow Cstates on AMD systems. Fallback to CPUIDLE and
HALT to have access to deeper Cstates."

Thanks,
Yazen
