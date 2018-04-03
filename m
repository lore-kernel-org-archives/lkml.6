Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDCNzk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:55:40 -0400
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:9184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750776AbeDCNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:55:38 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ingo Molnar <mingo@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>
Subject: RE: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Thread-Topic: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Thread-Index: AQHTyrFJKPMqgSsBDkysEhYXPXzBJKPu4YMAgAAvpBA=
Date: Tue, 3 Apr 2018 13:55:36 +0000
Message-ID: <CY4PR12MB1557216A1882A4CFC43248D3F8A50@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180402183424.48222-1-Yazen.Ghannam@amd.com>
 <20180403110352.izr2kvsd3ys4drjq@gmail.com>
In-Reply-To: <20180403110352.izr2kvsd3ys4drjq@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1352;7:p2X4C7WYSYVoVceIEVWbpcO8So1vPVOQ/zGtjp5eYwOce56sWdb+guesieXWj0Er1/vcRs7H/ezv8mxd4vnR6mAvCEYxP6ypGMjn0CP55m/oLjEjxo1AzZCWmHfbWxIDQpsUkyMkrR6qif7UqD5oI3+DPLEoNwHp5mH/mDmkYixT/1IwFg3LiFdy8sI/CCxdx3Fb1dlUhDgUD+Ni+LaEIrBJtRBmQNydv4chKMYGvdScaSgjTAJs6jf9N2+6VZWQ;20:iU8H8jTtGmUXzQ6F09aauvPJXo4foiaevNlml8YqUsFDH4PuOIPSv7H4CDrj7fVk7pHoRvbOGuAJw7jl2JdZyxeDr5R20yIwcVb/gBJXhiuaCO2mXRznjqNmP45U8DARJ7yQtqFeQk1K7qFOY5cgVGegQ7CiC1rzJJAZ5VmJCBGTlNypOP0GtAi/YzQzGPGHcuY6pxyBAjNZ9wL/fO50DpKrTujLpo52FXFTRkpk4dcW9/51DR23Miivedj4sAul
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f26e9671-dfea-4ac3-1a93-08d5996a93c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1352;
x-ms-traffictypediagnostic: CY4PR12MB1352:
x-microsoft-antispam-prvs: <CY4PR12MB13521AF3B84B889ADD300D10F8A50@CY4PR12MB1352.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1352;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1352;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(13464003)(316002)(25786009)(2900100001)(229853002)(3280700002)(5660300001)(81166006)(8676002)(81156014)(8936002)(33656002)(54906003)(3660700001)(105586002)(53546011)(5250100002)(6506007)(106356001)(68736007)(14454004)(6436002)(55016002)(186003)(46003)(99286004)(76176011)(6116002)(478600001)(4326008)(7696005)(72206003)(9686003)(53936002)(2906002)(74316002)(446003)(11346002)(305945005)(7736002)(97736004)(6916009)(476003)(102836004)(486005)(486005)(86362001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1352;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7ToGUtrpuFm0yiI/y5anu8Gmgcpd5eTf/9yZph1Bmac8d5bk0WdbImQEWrNsJp021KiAka1hI2yspOBiH9ehQZtPSLhpnsl2HsJv9v6u5AXH2cK31Zl9pxMXTEkCBsuY2Ya1whTrxNMV05yceuldg45l+JCa3fzBNbvoCBrABnjo0VRMtjuaeR0jEZUvDR4yF2AOIepzYAUAW/9+L3mNjPor1DotRm3Ob6Nq8XZcEgIUkIAykQ1zaEDj2EYrjR7gV/JdWTZf9Vj4RBQnR/v3PDW3NwfpxH0dIM5d+NL9+ZeGa9YgIhDcXOUFPzXrTvYTg6kPOJ3CZMNYOdklcBi4cFJF7Y3IHtLm3DeuDgr5YWlHG1iIoXEVk359efCfKbqy0T2buEH8EuD66jzVzDdX2KyqwFBQiVhOvJEHgsUT+ik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26e9671-dfea-4ac3-1a93-08d5996a93c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 13:55:36.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1352
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w33Dtitq001528

> -----Original Message-----
> From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo Molnar
> Sent: Tuesday, April 3, 2018 7:04 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@suse.de
> Subject: Re: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD
> systems
> 
> 
> * Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> 
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
> > not allow deeper cstates than C1 on current systems.
> >
> > With play_dead() we expect the OS to use the deepest state available.
> > The deepest state available on AMD systems is reached through SystemIO
> > or HALT. If MWAIT is available, we use it instead of the other methods,
> > so we never reach the deepest state.
> >
> > Don't try to use MWAIT to play_dead() on AMD systems. Instead, we'll use
> > CPUIDLE to enter the deepest state advertised by firmware. If CPUIDLE is
> > not available then we fallback to HALT.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/kernel/smpboot.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index ff99e2b6fc54..67cf00b25f83 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1536,6 +1536,9 @@ static inline void mwait_play_dead(void)
> >  	void *mwait_ptr;
> >  	int i;
> >
> > +	/* Don't try native MWAIT on AMD. Stick to CPUIDLE and HALT. */
> > +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> > +		return;
> 
> The comment should mainly explain the 'why is this done', not the 'what is done'
> which is pretty obvious from the code ...
> 

Yes, I'll drop that comment since the commit message has the explanation.

Thanks,
Yazen
