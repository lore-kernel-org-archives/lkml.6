Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeC1M7t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 08:59:49 -0400
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:33301
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751840AbeC1M7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 08:59:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 28 Mar 2018 15:59:32 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
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
Message-ID: <20180328125932.dhzwoxhext4h7hgh@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180326085313.GA4016@andrea>
 <20180326145735.57ba306b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326145735.57ba306b@gandalf.local.home>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [171.101.210.188]
X-ClientProxiedBy: AM4PR0701CA0035.eurprd07.prod.outlook.com
 (2603:10a6:200:42::45) To MWHPR07MB2909.namprd07.prod.outlook.com
 (2603:10b6:300:1e::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b3c720e-b78f-4ad3-6d38-08d594abc636
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2909;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2909;3:XHoLYIuRBIcTWWsAF2h0kCJUOQEEvd2+Ie2pwYeOPTqlNrv4i5uUS9OJPIWmglgYEa8UxldTfjCfTBkbpSTiIp8PWahtST50nDxHGquIxhntHX14tk5QNcM02AQQvXAveJS4B8/o2qJpa89rUoy+elnyFvR5VkVNBmSzdbushVEADoYDwFxLGZSnblLTdI4jUEXp+hfXToeGTM4SOL9GbS/5I7ZnAJ+7NX/IdkJUNz/0f53mgBSnzz7+Qm1KrCVC;25:sIdFqmydYLmse+4VNTa2xVhXM7ryFj7hZc5E5wSHCUv/Lr/46cmk/lU2OIeE3Z7YNwq0iitP58p26JuvZ/8TtpEkwUlmXZDYOpvcY9oFFxkWP6iAQOtZTgAWhlEMOI8X2AV/SmviZ/ZFakrBaEqQxh/eY2kCju/tYwi5SbViFgIpVl0R2ArrgWLWruldPrmo0/QWmPH4SNDGNwNxQAnQ/k4BFUmfjWFqW94OJc2nZjBHfJcN/yOkIDnULpHv8duWscrpeCsXXTxzol5kPnvjNWP67mAdJdpmXlUiTSOvl/BQThyfW1oMUbOEyLk8HmgguGyY4RX910tCwE0IOEWHdg==;31:jtX7w7a7SL5Dw8wwdp1ec7mIctlbORShxfvQ1gMfIbk+YnNVYgYbHR8MDPIsA+J/LS+TYaWsl5Tcl7KAsd/PpXJxZUgjdRJ0+M26Kzw4U9/oOhIiE4OJl/ZoOX3xmwYTRSMu8vTLRMPGWlEQtbgpueafR94Oj9RjoU6gngivlz07BJ75yZaSB9qzFG4aVuO2Frb+uhjpTHdf9Ck+qT5Q5miezBC0Cxu5Gimpt97TXPw=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2909:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2909;20:LlMNDelSM5Ph1g+f35rhqFTrBj/elouvLtTjeCasHVXq4sKRWMlH39dHur8yk9E8cP1xME6dZRXYwYkdl7In7OF7X03/tNx0mWYyOvbJxveig69WzAeji7hyr6HiAaYq/4ZEeLlaGyGNTV+s9EfMmi+R4vKFdSX/J8Qs6vh1qZ/Mlbjeh9DyWpI6my6LtHc8zghLxBDwJKC1CwuqjWDNrcSxZSDy/Z/42sERA3in4c7OM8gD4p7TUu+SPYehjOMS5j8YmRSMTC1EU9AZfizHTM7O4JgIDqfFfiXPb0NJM0n/5JpsBULyPC4y4fl7Gd9SRonymTEmKo+ih5P1GVC0lFRDalyBkvXfa18K65j7Pv2KHUaQf5E3toI2Fw1FitHDV1UWZEOaHqb3KZIX7ozFv6LmowJoo1mlSi+RtQ+2IoxRznBWMwtBIH+PD1U8smw8ruNo4U9sIsbOKjSUEkyC2DpRYCF4Q8LZ46vgrdHnFhA9LOe8399ZPN4ICPYBYLHOWfWdO3lu4runQ8+BEK42FzrZyLROVmpRiZKCHO8blMu8MAZjjPnDuNfBiKzD2ZS4zobENMcYQlzScvJWIEznS59rFfGN9FrRl5NPrHnSkho=
X-Microsoft-Antispam-PRVS: <MWHPR07MB29098A711872CA29E6A83060E3A30@MWHPR07MB2909.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR07MB2909;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2909;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2909;4:DQp9IkZyDMcb5fNVt+0ISWT6MbJGjVkI361tkBWRyQ1hr+60R3T/ldyFQOHVNuSgHXhJPAG5mWVuM9zMWwmw9At4b1aGJ8F8b3bZNS3rIxlY43n0eV6IxsPeS/XhMJ9MJRWDo1+YW47MsO2sQjBTpIj2UK6pHQIfpVzpt8uBQGJbnY7aV/HHkg6xMRwFXbZ/p+9xTm0lKPqO9I6UwOKVtS3d7CRJiZ6qKlrVLvZpabDrz5aY6DbR7EZKUOd7Phe2zgKXZF7NKynKpWk8UaHNkomYqKvlA5Qu95x2XXYhwO4O1A+2KFjbV7FdW/3xUR/N7V/EvsmvKQlWn7UxfodPsck0x0LUzT9A7JRwZyZhrvc=
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(376002)(396003)(346002)(39850400004)(39380400002)(189003)(199004)(52314003)(68736007)(5660300001)(105586002)(7416002)(6486002)(8936002)(72206003)(2906002)(7736002)(305945005)(53936002)(478600001)(9686003)(81166006)(50466002)(23726003)(1076002)(6916009)(81156014)(6246003)(8676002)(6666003)(97736004)(229853002)(6116002)(3846002)(76506005)(26005)(66066001)(47776003)(16526019)(186003)(106356001)(16586007)(93886005)(316002)(58126008)(446003)(25786009)(956004)(486005)(486005)(476003)(11346002)(33716001)(4326008)(42882007)(6496006)(76176011)(59450400001)(54906003)(33896004)(386003)(52116002)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2909;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2909;23:XrNn6EjS0lziALvkF0c/KHty9s4yqoeEnQOl6dyn/?=
 =?us-ascii?Q?+VcCpO9Ww9wSj5awLAchFHD6tvMwVeby75rlF34/6h2UqsP7Apc0HgYYu5WO?=
 =?us-ascii?Q?bLgc/Thxq5xBOMm+rPWjN2LXoTOJ63mnPRjXekvu0cs2B4SlUyTybrWqhtIp?=
 =?us-ascii?Q?0HyXgR/L/ZNnt5v0pzFOONcbPmhVfysKG0Y3A+9vNQaHSby26WjrgbjJv8gB?=
 =?us-ascii?Q?AgIyVA04hMaz894NJW2nYj+YIodx11M47tTJfKhCVD3TBscMKx60Olf380fv?=
 =?us-ascii?Q?TzZQ2W7kaWjDxe9RLyQllWmW1AarftJ1U+80fWO3U970FTC6/PQ5HZICYHzJ?=
 =?us-ascii?Q?B+Xq69Q6p/Y0OIzFI32XrT90mLghdVS+pu/gQAwSnmlZQdk+lGfm9fxCmf5Q?=
 =?us-ascii?Q?HAgt/foJMTG5h637iHfpvrD6V0WOeKAbBUO8hvtAeLuNd/9I2a0FoHkFGb2W?=
 =?us-ascii?Q?3B5uzDQsf6+gEFHcZEvsCGnHQwaU1ZKQ67x6/4/TPL0e7b1s5yirVyJwPLMO?=
 =?us-ascii?Q?NtAj7gQB4GaEFPJf4FwfVai61A82AZyDPpYjwfm21XG4Y8yToVOiCn2AAg8q?=
 =?us-ascii?Q?Y5Rvns8znvLr/p3mwl44u5/yVDqYsxIbqlEXYxMA6VL0sfC4nXNg9ggjhBcE?=
 =?us-ascii?Q?HwS3qTeqrIOu6K1WN+fzFAnNiy/wIw5Pg1oQVrxAMfl3Uxv1W7CWaUV1VT7m?=
 =?us-ascii?Q?R00tme9BI6GyyWsgY0yM0W0dwOiTLk5taMOEo/YTxr097sfGe47+j6K6MdU2?=
 =?us-ascii?Q?WV+JcCvVHB5xQzxYBIsXcATfgqeXOBeM9rr5PQunQwBIdWezNu3nSfWjkAiB?=
 =?us-ascii?Q?/kR18vx0ODWo9aaM2MRHB3A16URNB8OMZvtY51Wgse3cHntr5v7M1mmrJuLr?=
 =?us-ascii?Q?v9v2+wUmeROFc6w9YAHZ6r0fI+eA+kmqcT1g+2murkWav73E5jXx40QpcjMy?=
 =?us-ascii?Q?ZYmCbmaurG9qvn/2/zS2uXu6DRRuCLpoaTGOyLlzWNKEmL1pZPu9+oSUE6tI?=
 =?us-ascii?Q?D/YxGmiW9SR5861sLRCT48dc5m9BCgLT0xHFX8xpwdFpGhBMIKplpbAPZnZm?=
 =?us-ascii?Q?5tDoCX9VP/LzPazBm6AGodWSZ4SeCxG5hAYz8U75VvN0v6QyMJpHhAG53v/Z?=
 =?us-ascii?Q?VjM/x3zkQY3vAe6+r3qwLtdD6qSy8v4KWu28+Pgk+iJwXkolTxBdl097vZ3i?=
 =?us-ascii?Q?Gm9v1Hh+3QXSAQquHLcGW0vQstvVGyrCmjyHEA6F7jlPYiCIfXCCkBhHl4na?=
 =?us-ascii?Q?/a5Aq1ebtplqgTFzQ9Pux9tlb2tqmFV4AyloyXF1OxYb6l3oIA7aILDGV35A?=
 =?us-ascii?Q?gL6yAGP3itzSgznxMdqXPsZP+Qvy64zy00imLxYyta9HoGah8SPZ2HcOwt7v?=
 =?us-ascii?Q?vIg5J8UJDs9NWzr6l+gDY//u0d/KPzaiEK4fmgNDxB1ukXvfkZK8BPgvgmOC?=
 =?us-ascii?Q?a2AF9WCa/Y0lTLsInjrZFpWDY1Nl9E=3D?=
X-Microsoft-Antispam-Message-Info: TgGOO12ljZa9FtRSpKBWrvfCE+jCm7ZojJeY+YNas9wG1D9xXhORUPofnxhRGN+mzZTSDFzT7qvjVI0RzR462iy+5HpLIyCdA9ECk1CmrhGNZOpoJgHmIxsjpSmBg590Ym5xOUALmvtkEXn6ciQCprG8thDhHkeI6UmhYhMSaFriATrdAT38ABw8bgdpJTYa
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2909;6:SglNb6XX9lVdZWXJyNZa5wvZobRcH5IMrDua0xhDolXGbGtGc80UgNAluJ4UQXk/VJZZQHPAucu9pJpRAizJToYFIn8YD/q2S9QzWyIssyVJM7JgnWE4Pnt3/iztXKWFp4rXkJdGS0pUAc9EqIYmwLu1spO4NbVlWqhDmZwXbbVE1xh7TW1g6BJ8f6xfqZjjKbkb0ELwDirEk7DFX3FJD02LlPhjxi6CjMRVNf7d1Iz8Dw0TynrbE1V2S53HIDeldZKTlxZ1ZlxyMB3qhtVyo7RSBvq+pqQazrpL9UaMrFwgYe1P72iXKMJ9r6HM38mgV7vnOXeZ/RCehMls2fmRGidFhP4NxcoU3DEDkc66FSg2ZbZky/qEWLuAHXZYKw0tUrIrvJr3kp0M+N0XyTj1DK5ypsh0CHdkiFRkfnv8ZPuxMcRj2TA2S9eOxGW31nozGKQJS2+460nIBSMMzSRdSg==;5:+R7NIQa/8riBIyqbbI2Dp0azITHcF9zVP4+UxBsXYB7fNsljWaetQXCeYT+KXHI9uApnzhQblhJuC3b8CcWDiYo9mgHhTXtdaGkpUw6C6g8PggLQ0YxCPJ7xvbIT0du+Xcr+xvtOy36TQzkH6NcD7kaF3Lvjyr9Z+fn2EPTrcGs=;24:2diRohw1KIbXq+pqPqu6xCriyrBnhWEy5xVoQqI+u05Oa2tlB3DC9nwsAZU88VEUirFpVfDCKrBLKJ+/uJv4F3koqmuoTjmfoimAvR81GdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2909;7:LXBL6lLJh53Mebqv/oVnrQ0hoW88DEd1BbXy9jc3hq2LkqganOeuXHSLqK8/mC49BsVT6Nf4EDC+w20VwVdyZLQk5S9DU1hEGe1N40M786sL5w7BVWsExd8yXkiH8FBTwsGKRkltd0xiFFy8MxBJhgGF96vz16V4y2rMaoRdXmuCEIuGh1m85VvEUyIP78pOYjTeym5gE7Du7KBr0rHvfyEsveXHYPGuShWs9FlMciTAx8S/uCUegAt7S3UkwWTi
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 12:59:41.7942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c720e-b78f-4ad3-6d38-08d594abc636
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2909
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 02:57:35PM -0400, Steven Rostedt wrote:
> On Mon, 26 Mar 2018 10:53:13 +0200
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > > --- a/kernel/smp.c
> > > +++ b/kernel/smp.c
> > > @@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> > >  
> > > +/**
> > > + * kick_active_cpus_sync - Force CPUs that are not in extended
> > > + * quiescent state (idle or nohz_full userspace) sync by sending
> > > + * IPI. Extended quiescent state CPUs will sync at the exit of
> > > + * that state.
> > > + */
> > > +void kick_active_cpus_sync(void)
> > > +{
> > > +	int cpu;
> > > +	struct cpumask kernel_cpus;
> > > +
> > > +	smp_mb();  
> > 
> > (A general remark only:)
> > 
> > checkpatch.pl should have warned about the fact that this barrier is
> > missing an accompanying comment (which accesses are being "ordered",
> > what is the pairing barrier, etc.).
> 
> He could have simply copied the comment above the smp_mb() for
> kick_all_cpus_sync():
> 
> 	/* Make sure the change is visible before we kick the cpus */
> 
> The kick itself is pretty much a synchronization primitive.
> 
> That is, you make some changes and then you need all CPUs to see it,
> and you call: kick_active_cpus_synch(), which is the barrier to make
> sure you previous changes are seen on all CPUS before you proceed
> further. Note, the matching barrier is implicit in the IPI itself.
>
>  -- Steve

I know that I had to copy the comment from kick_all_cpus_sync(), but I
don't like copy-pasting in general, and as Steven told, this smp_mb() is
already inside synchronization routine, so we may hope that users of
kick_*_cpus_sync() will explain better what for they need it...
 
> 
> > 
> > Moreover if, as your reply above suggested, your patch is relying on
> > "implicit barriers" (something I would not recommend) then even more
> > so you should comment on these requirements.
> > 
> > This could: (a) force you to reason about the memory ordering stuff,
> > (b) easy the task of reviewing and adopting your patch, (c) easy the
> > task of preserving those requirements (as implementations changes).
> > 
> >   Andrea

I need v2 anyway, and I will add comments to address all questions in this
thread.

I also hope that we'll agree that for powerpc it's also safe to delay
synchronization, and if so, we will have no users of kick_all_cpus_sync(),
and can drop it.

(It looks like this, because nohz_full userspace CPU cannot have pending
IPIs, but I'd like to get confirmation from powerpc people.)

Would it make sense to rename kick_all_cpus_sync() to smp_mb_sync(), which
would stand for 'synchronous memory barrier on all online CPUs'?

Yury
