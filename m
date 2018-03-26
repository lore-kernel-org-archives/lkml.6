Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCZUFl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:05:41 -0400
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:20704
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbeCZUFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:05:39 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Thread-Topic: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Thread-Index: AQHTxTbgS6+ZvZR8h0mCmC3vV5RUb6Pi6MAAgAAGmcA=
Date: Mon, 26 Mar 2018 20:05:37 +0000
Message-ID: <DM5PR12MB1916CB8536B257923AC76CA7F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326191526.64314-2-Yazen.Ghannam@amd.com>
 <20180326193526.GK25548@pd.tnic>
In-Reply-To: <20180326193526.GK25548@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1785;7:vi/lAQqy8RQ2C2uMpmwyLGHjOOZZEQlnpCnWjCkVJK0UxNqXsvy6g/vG3JXulry5IwnIM8AFpNnhw16moKMQrqneqcxd+8iDjb5HGqhLy7KQhqJqXezXolvfrY7ZnsME7gLk4tYBlxjEAEviIKAcXThY7dMdUsbme5rvc4Us4+CFthOMhodim+1kxFwfbPZKH0VuUEQE6QbsGqA9uk3b0ek/pxoNekr5s6WQnFU1uy+eeKhhmMQK6GPlphul2iGW;20:Sl3FLVV/wSTMcgW9iCThvOnjT4E2+k+zJI8xe6wrJRm0FyPN8nZ8JAeOhApIpjg3an0gAwFMZ72z6GE2WwOQQTn05ERLAK0Q1eNxdY9sbCFgLwdFW4yuDESHL6d9VWGd1eyvn+H47B0iPSmnm/33nT+zbbnEIR0B4A4b2K1LlloHfTZ7ralIczXbpc3eeuu0tnwT+hIPWTDkhrlYsCCjmlmRpPSwmof59vnJcWxNLbaJAJpeS/Loepf11+m5vmV6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1979416d-ca47-4b25-cb87-08d59354f0fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1785;
x-ms-traffictypediagnostic: DM5PR12MB1785:
x-microsoft-antispam-prvs: <DM5PR12MB1785ED05E03E9B1F1CA94B14F8AD0@DM5PR12MB1785.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1785;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1785;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(189003)(199004)(13464003)(86362001)(11346002)(106356001)(446003)(68736007)(5660300001)(46003)(6246003)(14454004)(6506007)(105586002)(478600001)(7696005)(6916009)(53546011)(316002)(476003)(99286004)(6436002)(6116002)(575784001)(2906002)(74316002)(76176011)(54906003)(2900100001)(229853002)(72206003)(186003)(53936002)(3280700002)(9686003)(55016002)(3660700001)(33656002)(7736002)(8676002)(5250100002)(81166006)(81156014)(305945005)(4326008)(25786009)(102836004)(8936002)(97736004)(486005)(486005)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1785;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: o5RkgjxUXFFWIaAIyx9g6ej27F4j7TMO5bK1fh5jtJrSlPUKY6vQ0/Vm26/hCtP+6TTbQQ0eo1vbdfr0s6JAQKFVH1zlIFpupanQ3TwzAtds1YiciSl/KToPT2P75vCQ5/t1iPmin/JWJ4Nm+1S+5WzMkzjgFLAiBjuZX/naxxgLhMtXrt8fvYHTGxqNz3N2oThlQxqb6GJss9LV6e873N2kwzi5HWDKDEAMU1GSArtqsB39k0J/E5o7khjk1CTNDn/w6LWW3B40Dpx/lRpFGPESRE9zR2GJt2Ad1AB4TIOJVkqvuD8UVgdkCIl4hKtMPsFOanP3UBrRw0qzh5Fc/g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979416d-ca47-4b25-cb87-08d59354f0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 20:05:37.1959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1785
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2QK5jSa010430

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-
> owner@vger.kernel.org> On Behalf Of Borislav Petkov
> Sent: Monday, March 26, 2018 3:35 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND}
> register contents
> 
> On Mon, Mar 26, 2018 at 02:15:26PM -0500, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > The Intel SDM and AMD APM both state that the contents of the
> MCA_ADDR
> > register should be saved if MCA_STATUS[ADDRV] is set. The same applies
> > to MCA_MISC and MCA_SYND (on SMCA systems) and their respective valid
> > bits.
> >
> > However, the Fam17h Processor Programming Reference states
> > "Error handlers should save the values in MCA_ADDR, MCA_MISC0, and
> > MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
> > MCA_STATUS[SyndV] are zero."
> 
> Well, then you can't remove valid bit checks for older families. This
> sounds like F17h only.
> 
> If so, it better be abstracted away cleanly and not changing the generic
> code.
> 

Sure, I can do that. But I didn't think it was necessary because it doesn't hurt
to read the registers whether or not the valid bits are set.

> >
> > This is to ensure that all MCA state information is collected even if
> > software cannot act upon it (because the valid bits are cleared).
> >
> > So always save the auxiliary MCA register contents even if the valid
> > bits are cleared. This should not affect error processing because
> > software should still check the valid bits before using the register
> > contents for error processing.
> >
> > Also, print MCA_{ADDR,MISC,SYND} even if their valid bits are not set.
> > Printing from EDAC/mce_amd is included here since we want to do this on
> > AMD systems.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/kernel/cpu/mcheck/mce.c     | 23 +++++++----------------
> >  arch/x86/kernel/cpu/mcheck/mce_amd.c | 10 +++-------
> >  drivers/edac/mce_amd.c               | 10 +++-------
> >  3 files changed, 13 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c
> b/arch/x86/kernel/cpu/mcheck/mce.c
> > index 42cf2880d0ed..a556e1cadfbc 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -248,19 +248,14 @@ static void __print_mce(struct mce *m)
> >  	}
> >
> >  	pr_emerg(HW_ERR "TSC %llx ", m->tsc);
> > -	if (m->addr)
> > -		pr_cont("ADDR %llx ", m->addr);
> > -	if (m->misc)
> > -		pr_cont("MISC %llx ", m->misc);
> > +	pr_cont("ADDR %016llx ", m->addr);
> > +	pr_cont("MISC %016llx\n", m->misc);
> 
> You simply can't do this - this is generic code, not AMD only.
> 

I can change this if you'd like. I just thought it would be simpler to
make the change here since we're just printing the values.

Thanks,
Yazen
