Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeDDDgq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 23:36:46 -0400
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:42253
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbeDDDgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 23:36:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 4 Apr 2018 06:36:25 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Message-ID: <20180404033625.gkn4q7kb2xf6d6mo@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180327102116.GA2464@arm.com>
 <20180401111108.mudkiewzn33sifvk@yury-thinkpad>
 <20180403134832.2cdae64uwuot6ryz@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403134832.2cdae64uwuot6ryz@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [58.11.97.202]
X-ClientProxiedBy: HE1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (10.170.250.47) To BN6PR07MB2898.namprd07.prod.outlook.com (10.173.28.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22427af-9a11-49d4-ba92-08d599dd47b6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2898;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;3:ejfoJE/uLM/FfQF08NrjRHTMK6Fla8s2D/00s9HrMvpQUwBtxo0ToU2PWDXB0EqSJE4ozAZlipYn00cJ4Lytn9pVaUbh7ijR8li0wm3zUkZNmj7APWbLLm8OAQHm8+6VlJjGW/pYSjQv2MSdk/zIoahhZBARuEOo6qXq61IgK3IFXyNkaYwfltiydWBPPfZyqkcVsUsHKzMSRbPe8AWBeyekCWoZ5Jt5H0Zu4a+QmJdZY8W8799zlfiuJdNuKWCl;25:v8X+F6L0IQLmN9bx5/qtBO/DixZAedoNYJRAxTredzjyw4Z+4fX9lKf0n6YT/ybb472B6nQnUZVULQc+wQF4kWwtpvVB7SE6CyWudZMVcziCrjGDtDClplPFwjo8ZjBDd1CCRTeQaI5KJsoUTRTlAzcSzeIWLOuxYJsHMJms4IpDB2kFu+KK7O4ga8XhkuAIk+LsrPG+RsM1Njti3FnZ/CnbU5ALIIuc87e/2dTcjecpbn7UgwmA6KO92F3gM7ugY2+z1OwzkMeEOT2q9ASEPBYoCXq0zudSZ+q1CbvUGsThPkIoqU1t7xWAKjQHRFE8Xy/2RRxCby2gtAEhv70xUA==;31:xRcv313jieMvUEnTBTO6Z5CnXYVAbhVAOoab3DkvI24D7gLv5n/OC0gFaDe3rQCpy/KaN7zBvawsecXAssggR2UZ4wCkd+/DjS29Ccn5aMXxcSw8OwFAjLf45lCeWLCD3Fb4kMypS8J07jT8QBtE5makhzpQs630+k0o5Wowt06hhBayq1W4hIhLVRDKNkhDDfr0I5sEVjXpETHESDzSBrzWFk0EYh5ATANwbju25xc=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2898:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;20:jE2O3mkxdvOSDdN50OeQPg7CTFXAginB7MpgO4spZTEW4JbUi8J/P7nI7fN8zur9vcQnLtxdMK/uZEPzplap2WO36aQVAMUtnTfC53c7H6OLHF8lvjGkWWSMR9ho4NWWhZAObf4YwRiHskGkCWO8lluqBPYOFl/QVzferjuLK+Ad5/g4IZmNJl3k5WFmt0WrJTz+XkECJfoJeCjrcTWI/c47+3JKb13Mf5lbYI8rIbI03N3GNgvKOhJfOW5mhc+mcB2kqm0M6jQYk9NPH30TAFcElfq8BWIW0VLXlrG09M9DiixO+aArl350pTvPxiy8luzaJfBWaFQfb1IBNyPyLn6l5Jz1mRMB9FajTdO7JhdFdidJ2FXucYeqHQtWPKHRx9Rz90+4igzHfTtjLlTnJSCPcU5M+uC4WAtBbue09c5eDvPwsec4eXIYMOTIUGVON3Ex0f3BI6MgyI6S5T9DNKSqLPOQORTddOvXPTU2HD1NKYrHVDq9w6mMvnO2dGod0vqGfloJkTC4HJ5vaVRpbjNInR8xbLaDRgAoQPsYN1z+6kpJQQERcSm6zhyJNyeW4gIuXPuYQaufHa70rDu8tMiZ5fAAANqrWn2fv2lZc5A=;4:Vyb/BnR2sOpfGlCD3jzNij1I1n3Z+nnJmQyfsCV3nK2CCY6kfAFqdq/6mCAf+XTMCWdCJNwtkTkFcS46S44kY6oC3f66d2jYcCUATcb/VvcRa0RJQviUwEcX8Wi/DLQRN3sagRv2qlslDCksNgyJAn2duMSC3hc6N0blhs2DZ5dGxAn0ksrsDEZp3o9nLZUgFOvy1pNLuijkC3t61eOZitlnpR0AMdEp0/yjkm3E6cHBXvMU0/KGnz5wweNjvJ3jIunWRSjFQufjKrKiH/nK7w==
X-Microsoft-Antispam-PRVS: <BN6PR07MB289854E9CC2C8B66227460EDE3A40@BN6PR07MB2898.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR07MB2898;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2898;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(186003)(16526019)(8676002)(42882007)(54906003)(58126008)(2906002)(50466002)(81156014)(6486002)(81166006)(6116002)(3846002)(23726003)(105586002)(76506005)(33716001)(345774005)(478600001)(6246003)(6666003)(9686003)(25786009)(229853002)(4326008)(106356001)(53936002)(72206003)(47776003)(1076002)(386003)(26005)(66066001)(6916009)(68736007)(7416002)(446003)(16586007)(956004)(93886005)(476003)(5660300001)(52116002)(6496006)(11346002)(305945005)(316002)(76176011)(7736002)(33896004)(8936002)(97736004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2898;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2898;23:MEiE9SVd3zETTYATqGp/3pjyAY2GNrxyEhQOiZo2E?=
 =?us-ascii?Q?lycCMQdttoYWTfQR4ijWKfiWNNALMa1Zh2jiEJ8ZRJ4ftxpq8gu2fYs0ZIVU?=
 =?us-ascii?Q?wYYzBFjeY511Q6VPW5UI6gAp/dtX8y0i4avBsgallcsmUVEVZcL0LKxP5FsE?=
 =?us-ascii?Q?Rv1RW8/5rWeNOs1jyaiCpmGPcnUQUL40N9sXnwZNF/d0QMywFytPWF2UHcSU?=
 =?us-ascii?Q?p2mB17FmzkD906uII2Cs8MTUek9uadiKxf/UFuY9fdVIdv5dpvHxfdHbww7T?=
 =?us-ascii?Q?7pmylbpnGt1un3B28yvf57ZEjjF9uAhBodFtcuvvqFxBNe8l81xJzeRZwcby?=
 =?us-ascii?Q?cEfxn+GHNCCp3tLyUZ8FC1YuBN7ZS5S2kj05j08U3lTJOzGMolOJ11gBdMpl?=
 =?us-ascii?Q?vw3fnLn4io+ohdfF6k3POk/REG6h3e5RSsa2kHGFVqJ/jdDYMKxSnNP2yLex?=
 =?us-ascii?Q?Wio8Mvq04hiCTclE+JWIBxaQUv9ywmL3p4SBatq5kCp/wr9t7ZLexqoZIN2/?=
 =?us-ascii?Q?f60E+1z6L+8iyjN1wIfE4eq6/l9Zz0sVsAkHPx0zjnqwgBfovIuVUdx5TnkF?=
 =?us-ascii?Q?Vb+Qoabq3Bi+DIW+V/2O3rEYVILr0PURbgzrMvErFWBSd4XCcbS4nDm1wAWD?=
 =?us-ascii?Q?/q82e0RHT35AmZzsEEuhumLtIEJOYvTmPu6waYOCZD+/t+nW0PWAMijZYksi?=
 =?us-ascii?Q?t68t0wN5qb1ZmYguwPlfmlLDWM6Q1tkKIXHWIi9J16sGnkkqgTfceW8AfCBV?=
 =?us-ascii?Q?cEwKDbUO+d2kA2duyOsZFDMP5ILwvEdH4fH/JEvMoUIlk3U4HbzLjnUeCsQ3?=
 =?us-ascii?Q?5l97n+1ZiUFw+NpgXqjoEPl0mfTdT0evO0mha1SVYoAerecRTVjopshPIsv8?=
 =?us-ascii?Q?NzpsflO026b0WyjIRAROM0NRT+6XhCyLGYXtAPbLqci+ZgA8r0ea7sBlAx8W?=
 =?us-ascii?Q?sMoTBb9eSjMbfN+QIQl7gE8XLtIoDrFS9jyntSxOTWo3rxvodgGSeS6+706U?=
 =?us-ascii?Q?TXYaWezYnc0aKHxQ9klB8X4ScJQagHYJ7JIyG5lWD/1E6VrnA6ZCLYqYJvE0?=
 =?us-ascii?Q?lQnL1i6zcRUxy1R58mRWMFNi3p0e9UTflMyxXd6BvbQa9TJlXSu7QDK7TNzv?=
 =?us-ascii?Q?Yb5NZAyXz0Nst/0+lxpgIGXM+7vFx+Tsr49bJqCNY1um/5fMMqrr7mGxLUmD?=
 =?us-ascii?Q?C4Gr7H9CL2blsJNU+K0P9eMvuFN+S7wa7gYYBFFt4ko09QOCVGgZpA4zBvy1?=
 =?us-ascii?Q?tY+4s1gT2i2EvWWE4JuXWwtUJ1MQM42jhodaMoexvjGNtO+DwnU5f/aT4vys?=
 =?us-ascii?Q?E/kn36pQgXbvfzeNA4qXd5Z+kzd1QjXguXo/UgeJAyv+zU2OcMlyZOho4ouo?=
 =?us-ascii?Q?H9oJXSg8w/9VX2wEiKBei4lTJ0=3D?=
X-Microsoft-Antispam-Message-Info: 4oX9Ua+e+dtF/slJJ/Dc2p7d51O9oF+k2nQBms23r3nPbLPlA2GCfpk17qQz5njQtrxOzdMcUGBTyFLWuDE6kLiTE1oqSC0OVQI0mQTkqqHJcekYcd/XP2VupQG1T4ZrJjz1F5YDk3P4Tc3TZkOUE7d8dmFR6HcOtQIMt1dFwHib7xiSO45eoj5Byjjl7niP
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;6:OX0jHsBwVBN3bcj2wIWjb8eox/IZf1HJH2NSgE36TLa+BFJAPkYi22U0FlChYSm4Q7VMEsMm34Tn5872T077EsHJiK5OHvg9vjNjrmf6SpAzATV8druu67O0Dh4S+WvMu3XE1w2huWXpkuj7Q+xtHk0wKCY2yXlBpmltdBL234tZZgyCuTr+WqMmW4maOfg1jEeovufDMagpEPxMfRfbheIivroueAgK1j1QEbmfayiOclXDrWHik6oxfulblgzPIGfpopHmzseE+0PH99mulBF44FlQPG4rKA2/gXLBZOKeWsQY61L1GiiiiULxfWtAB/kxGwZOpt+pzyenEK7VVGhtnQptakLptP24IIab32YA95MUIOEb8bGCCTh4GO7OuaprSZsdTQMbeI+fYFWlq2NGC+RbWabq/dhECpcHGK1UXp5iBqNeTPVWEQ8CxaJbocusSa0iN5gsZu0hZSCKCw==;5:7VLQE0w8n3yxfalUBvGE/RfI8Do4kdBkhiR0BQdmR0tWRAxUv5/wSP0p2s6x8lvm0os3CKOzNeeFwi0r0gtS0Y5WGWv62+gK5VmWfjP/1kEITv0Fe7A+ajX3MKBSaQPXSRUsYaoyYvKSJXdDK/vtaXK+ClxnjLww1KcAkWYngi8=;24:BEHuje4SJv1KaOQNN2h2jZ+JeXrEY/tOPAZKY/R89Pup7MUZIWEbwcUk3/GTVAzjrSruzbchc5KyjuhNTkad2isgwL+CDbq8rRYotNQ1JkA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;7:ivav1wLZWqoeFhoLmxJ6JZSRunMHtOg4+guIig1tC5K5AJOeGXq9/Yh70UFn6HGR7wVDtzkDX7Jt0fAWf+NlEKyInWQIUtno/8LaDUxz6Kuf5IqNYe7yBJDXNoDAZcajMqfuqtqqss2BIJwoIA9s4o6FdOTgHHavr+wZfKJZuJBUraRnUzGEq/XW43y9XtP4p4XoLe3eO4NI2s08VZe8VgeEXAebsVjaIr/0SJ03ZtrmNaAVm9DnEqR55z1kUfd0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 03:36:40.2714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22427af-9a11-49d4-ba92-08d599dd47b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2898
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for review.

On Tue, Apr 03, 2018 at 02:48:32PM +0100, Mark Rutland wrote:
> Hi Yury,
> 
> On Sun, Apr 01, 2018 at 02:11:08PM +0300, Yury Norov wrote:
> > +/*
> > + * Flush I-cache if CPU is in extended quiescent state
> > + */
> 
> This comment is misleading. An ISB doesn't touch the I-cache; it forces
> a context synchronization event.
> 
> > +	.macro	isb_if_eqs
> > +#ifndef CONFIG_TINY_RCU
> > +	bl	rcu_is_watching
> > +	tst	w0, #0xff
> > +	b.ne	1f
> 
> The TST+B.NE can be a CBNZ:
> 
> 	bl	rcu_is_watching
> 	cbnz	x0, 1f
> 	isb
> 1:
> 
> > +	/* Pairs with aarch64_insn_patch_text for EQS CPUs. */
> > +	isb
> > +1:
> > +#endif
> > +	.endm
> > +
> >  el0_sync_invalid:
> >  	inv_entry 0, BAD_SYNC
> >  ENDPROC(el0_sync_invalid)
> > @@ -840,8 +861,10 @@ el0_svc:
> >  	mov	wsc_nr, #__NR_syscalls
> >  el0_svc_naked:					// compat entry point
> >  	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
> > +	isb_if_eqs
> >  	enable_dbg_and_irq
> > -	ct_user_exit 1
> > +	ct_user_exit
> 
> I don't think this is safe. here we issue the ISB *before* exiting a
> quiesecent state, so I think we can race with another CPU that calls
> kick_all_active_cpus_sync, e.g.
> 
> 	CPU0				CPU1
> 
> 	ISB
> 					patch_some_text()
> 					kick_all_active_cpus_sync()
> 	ct_user_exit
> 
> 	// not synchronized!
> 	use_of_patched_text()
> 
> ... and therefore the ISB has no effect, which could be disasterous.
> 
> I believe we need the ISB *after* we transition into a non-quiescent
> state, so that we can't possibly miss a context synchronization event.
 
I decided to put isb() in entry because there's a chance that there will
be patched code prior to exiting a quiescent state. But after some
headscratching, I think it's safe. I'll do like you suggested here.

Thanks,
Yury
