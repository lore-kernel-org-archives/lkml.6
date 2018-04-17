Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeDQSai (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:30:38 -0400
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:56320
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751230AbeDQSag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:30:36 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Thread-Topic: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Thread-Index: AQHTyrzRqCN7fg42eUKg23bN8kMvXKQFS3EAgAAGZOA=
Date: Tue, 17 Apr 2018 18:30:34 +0000
Message-ID: <CY4PR12MB15574493593120818D9BFE11F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
 <20180417172102.GA3633@pd.tnic>
In-Reply-To: <20180417172102.GA3633@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1816;7:CbhKAuZxkv4eqbSlrjZOkjOadYL9KOzeHtJoNXYAaejbadw7M02u3828IvdxC9BJ8ufHfr6NMgxNTnVI0ZeAyC0dXbLWZxB/U6mpPaxK1O1HHtSZnix5/BQdecTE+B9YW02keYGLF5MRbfVeRRwO6Q/lBkKFDdI4ushKFq+kZrhnH9wfK6abn6KD8m+kd2zgdZWPxEhZQ1Fxs/+Ei1Yb+jdSOghTClQAw8sVBnFtL8BELQ9ce/SZeniibYiYOiSf;20:yHfiFCLIqandmbgMcAcDGJGI/btjVepOt313xWrEO79YoChq7o9Ma+afVAQNaAXQ+wiQEZm/bOqCXSZekjY7MauXQlI1MlX7d4az1JkjseB094Dw79fhIFyxDE8fJ7kGxjSVce5FhEQF2gPzGl3rjxBD/ZHdOYF01IkyYa1Gdl2xBwC/Fp4rIUCR1y7MSedXA6nFKmsttE8phcBpuhIiUPQz6IvQ+xFnzHQ33c7+BO2exf8bCJj2Sm8OkULK6k8n
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1816;
x-ms-traffictypediagnostic: CY4PR12MB1816:
x-microsoft-antispam-prvs: <CY4PR12MB181645516EC5404956E2484DF8B70@CY4PR12MB1816.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1816;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1816;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(39380400002)(396003)(189003)(199004)(13464003)(86362001)(106356001)(7696005)(14454004)(4326008)(6916009)(26005)(74316002)(305945005)(102836004)(8676002)(478600001)(59450400001)(2906002)(6506007)(53546011)(76176011)(54906003)(55016002)(6436002)(5250100002)(229853002)(68736007)(186003)(6246003)(9686003)(53936002)(11346002)(486006)(476003)(105586002)(2900100001)(3280700002)(446003)(316002)(33656002)(97736004)(25786009)(6116002)(3660700001)(3846002)(7736002)(8936002)(99286004)(81156014)(72206003)(81166006)(5660300001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1816;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2fp3HblizvYacRbVEz/4akPuh0jmXAZjUxEWfnGA45PxRbzFWYWKjA8O9VZtk01gmCiEgOFTVhgTCYElqy1K8ghdVQF/IHrZz8u81Fwsm0WmG3QHqyS+l5E3PBbqg/nPi4geDOiWhdoujPfi0SgNMkue5pSefDlUNB+qGN8w/e/VuxJ6NIC5dcCa24rnKb1J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a783a959-22b7-4b76-7413-08d5a4914ef2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a783a959-22b7-4b76-7413-08d5a4914ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:30:34.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1816
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3HIUnlI012128

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, April 17, 2018 1:21 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on
> SMCA systems
> 
> On Mon, Apr 02, 2018 at 02:57:07PM -0500, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > The Intel SDM and AMD APM both state that the auxiliary MCA registers
> > should be read if their respective valid bits are set in MCA_STATUS.
> >
> > The Processor Programming Reference for AMD Fam17h systems has a new
> > recommendation that the auxiliary registers should be saved
> > unconditionally. This recommendation can be retroactively applied to
> > older AMD systems. However, we only need to apply this to SMCA systems
> > to avoid modifying behavior on older systems.
> 
> Applying the logic of that recommendation on older systems: wouldn't it
> be prudent to save them there too, if it helps debugging an MCE?
> 

We could but it's an issue of documentation and testing the older systems.

My first pass at this was to unconditionally read the registers because my
understanding was that registers that aren't accessible would be read-as-zero.
I thought this was a common MCA implementation. But Tony pointed out that
this isn't the case on Intel systems. This is the case on recent AMD systems. But
I don't know if it's the case on older systems which may or may not have
followed the Intel implementation more closely.

So to be safe, HW folks said we can restrict this to only SMCA systems because
1) The recommendation first shows up in the Fam17h PPR.
2) We know it's safe from Fam17h onwards.

> > Define a separate function to save all auxiliary registers on SMCA
> > systems. Call this function from both the MCE handlers and the AMD LVT
> > interrupt handlers so that we don't duplicate code.
> >
> > Print all auxiliary registers in EDAC/mce_amd. Don't restrict this to
> > SMCA systems in order to save a conditional and keep the format similar
> > between SMCA and non-SMCA systems.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> ...
> 
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > index f7666eef4a87..b00d5fff1848 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > @@ -244,6 +244,47 @@ static void smca_configure(unsigned int bank,
> unsigned int cpu)
> >  	}
> >  }
> >
> > +
> > +static bool _smca_read_aux(struct mce *m, int bank, bool read_addr)
> > +{
> > +	if (!mce_flags.smca)
> > +		return false;
> > +
> > +	rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
> > +	rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
> > +
> > +	/*
> > +	 * We should already have a value if we're coming from the
> Threshold LVT
> > +	 * interrupt handler. Otherwise, read it now.
> > +	 */
> > +	if (!m->misc)
> > +		rdmsrl(msr_ops.misc(bank), m->misc);
> > +
> > +	/*
> > +	 * Read MCA_ADDR if we don't have it already. We should already
> have it
> > +	 * if we're coming from the interrupt handlers.
> > +	 */
> > +	if (read_addr)
> 
> Why not
> 
> 	if (!m->addr)
> 
> ?
> 
> And yeah, if it has been read to 0 already, reading it again won't
> change anything.
> 
> And thinking about it more, you don't really need those if-tests, I'd
> say. So what, you'll read one or two MSRs once more. It is not such a
> hot path that we can't stomach the perf penalty of reading the MSRs.
> 

The issue here is because we share this path with the interrupt handlers,
specifically the Deferred error interrupt handler. The DFR handler will
read from MCA_ADDR or MCA_DEADDR so we should just use what it
got. Otherwise, we may read MCA_ADDR and assume it's correct for
the error.

For example,

Deferred error occurs:
- MCA_{STATUS,ADDR,DESTAT,DEADDR} all have valid data.

MCE occurs
- MCA_{STATUS,ADDR} are overwritten with non-zero data.
- MCE handler clears MCA_STATUS. MCA_ADDR is non-zero.

DFR handler finds MCA_STATUS[Deferred] is clear, so it saves
MCA_DESTAT and MCA_DEADDR which is 0.

If !m->addr (which has MCA_DEADDR), then we read MCA_STATUS
which has the address from the MCE.


> > +		rdmsrl(msr_ops.addr(bank), m->addr);
> > +
> > +	/*
> > +	 * Extract [55:<lsb>] where lsb is the least significant
> > +	 * *valid* bit of the address bits.
> > +	 */
> > +	if (m->addr) {
> 
> And that test is probably not needed either: if m->addr is 0, the
> below would be 0 anyway.
> 
> > +		u8 lsb = (m->addr >> 56) & 0x3f;
> > +
> > +		m->addr &= GENMASK_ULL(55, lsb);
> > +	}
> > +
> > +	return true;
> > +}
> 
> IOW, those tests are probably ok but getting rid of them would make the
> code more readable and I think we can afford that here.
> 

Okay, I'll get rid the last test. But the first one is necessary with our current
code flow.

Thanks,
Yazen
