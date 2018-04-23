Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755210AbeDWMpU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:45:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58868 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754852AbeDWMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:45:15 -0400
Date: Mon, 23 Apr 2018 13:44:43 +0100
From: Roman Gushchin <guro@fb.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce memory.min
Message-ID: <20180423124442.GB29016@castle.DHCP.thefacebook.com>
References: <20180420163632.3978-1-guro@fb.com>
 <20180420204429.GA24563@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180420204429.GA24563@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:b3a9]
X-ClientProxiedBy: DB6PR0301CA0065.eurprd03.prod.outlook.com
 (2603:10a6:4:54::33) To SN2PR15MB1088.namprd15.prod.outlook.com
 (2603:10b6:804:22::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1088;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;3:ZccWlOuGwEozC4aQryB8egtCuOzzgJGLMj5b6Bt2ciJZNobrwiYi80Vvi9pJczT5+loLqxeBb+FzFhQuSiBGWO/drb9TBBWjrUQ50DtMN56wSNzDS+eM1KuzEwW43JDXzLLH7bQ6RMT30MxjdTQyXb/1LXW1U95XTVN+38d6dDFRlXqoEoJq3EyaNgfT6a8MR0tQx4AbB91i1GPU7FpIqnSY2MxB12Xz83Na+YXNDS/Qsi0YeDVUKEqKAHN9fyz6;25:BlLNzKD8hGRnIVZbzEXzPt6egmDD5/bbaaq4zP2ytNtGCeo9pn7tfrL+OgEyv6jeN6TUskm3csMVZ7LnqTJsNJKiswil2ivzo0KSafkqZKnCG7TfEqCdb4PNLpW98vNl4BGGLkxR0s3u83HtdO8iGwuo3G5mhCs5sfCJ2jVKuRm2HjzJfTWzRUf+owiU6NyywZxHJPkd4SXEA0krKdJFyJJlRTVGkjBMzSeB7EAd66U9KyD3SnK6fvKD3Oqfoc73MbDDvjOCJhZgdtdPrDU2thNkXodLmm4SBDAUiltMal8H2UMpZ3C1X9qxDkrqp/oITFzqzCMJ6Bs5EFdDNJ6Y6g==;31:RskLqAeuF6OWrGR38+HGT1ot9r1varhIHfMMa3hWS1ouDhrYFIg6DvUyOgWUmqNeG8Z+VsN+5PzS5eZzWzEGpdRHyLtSVHVXrxIZqpDKGpjXem+agDwqPOvjrr2/3zoerAmwqMpcZpk4wIRa152ebunpG+epUt4Nhi7u8Z8FBo6mqzhYhIIC/Wve4Z9ROmId7m1IpmV2a4gWRPUi2gjAV72YsB/oe2d9vu2aE/9lqLI=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1088:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:16jwaLYUpK+7T4NJOEHHed9qOdsms1yggznmBMKABHQoFz3Y4L6Y2c/QY+HO04hUrvSherY2TJUY4iH5jQomZddNDb60qNviC4FstJzYs+VvMkSOQ//6f+cG3Zl9BXabAr/QYhOlwI0RTigKyZzeQnFiUlDB2mLTFH7thtRJKJnNtVU1o6R1EBU9yvR8r5CwGDujG/cmhkFtgrDxr4GRX1NbM7uIQAn5vuiVcaTSQddIovLp00PSP50e6JO8mS+zE27ckdlk4GvKsLtLzfx6VUCCG2K7rNsjOvlLne5csl+S33Ebf/iyxal80ZuopVdR5RdagP7G2x3LOuyczkwzboFZO3g4IdmAI4abQaeaZv+QTgq6SAetI61OQrl+XkociPzzyLHjTXCvX1fYcWuk0/Kgtv9WvEyK6QF0TVGa7lpUM9m8F2YYxKvHNZksgYAzRMLmnnONruHpdgFMFoNPNwlOwlKD/SHPEUya5YrST+jKnyFI4s0aewop0rOxdq3M;4:SAIDUUixHHjoQqDCCE62fNuNWuNrW6JEz5Oz4tnEj91mLWVO029j1T83XeSVUL6l+u4fcyukiJmYL8zY75wCwzn2+zFrqLr0l4+/Lp+fHGYIKA39lpZoDDV+sKr1M1x86DcDViB3K5Ji3yCgdxdI4zoVjZLwQJ87T7qdz5qCS7JC8QIzm8j4xl+VVm0soilZ5gmibdZx6kF6PtX3uGpS5IXmSal5Ls4poUYIj+6+SSnjCHpimGEYINHYTlH38kJcTYDAHY648ryA3s2iOHSBXQ==
X-Microsoft-Antispam-PRVS: <SN2PR15MB1088A35C0FDD7AC26096F77CBE890@SN2PR15MB1088.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR15MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1088;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(396003)(346002)(366004)(51914003)(54534003)(316002)(47776003)(9686003)(58126008)(16586007)(55016002)(54906003)(33656002)(8936002)(16526019)(81166006)(52396003)(59450400001)(76176011)(7696005)(52116002)(5660300001)(8676002)(1076002)(6116002)(23726003)(386003)(6506007)(7736002)(229853002)(6916009)(6666003)(50466002)(39060400002)(53936002)(6246003)(305945005)(186003)(4326008)(446003)(86362001)(46003)(11346002)(478600001)(2906002)(25786009)(476003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1088;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1088;23:irOP1NI7fVHiZEWUZkT+pHW31RZMrsgKYvcABJA9W?=
 =?us-ascii?Q?2N+EibmyQtWnRMc10si+mUbe5EYcX9g1eq2jew/HVQvnng4H4qz/ujqhbJBy?=
 =?us-ascii?Q?2U/TkF8FesjLOe+MElWT9SD3GN3W+Kn8Ed3TC6b6PrP1kTu1pY4S80rS92pA?=
 =?us-ascii?Q?D3neTDQ7hif73ErtAQa6WV7RvWmpTZI1oYgU2Yb+Ql2DBhcuc/CDVGE7tpTA?=
 =?us-ascii?Q?Kj9Ept81IHAkZgBpiDvnBXgSnO9Owib27eDCKxSSdvUAmrvi84VSeFSTKW2r?=
 =?us-ascii?Q?ftgOkfL+PjmlpWFQU/njR9jU44XclUN9DntRTuzhEyHsy4coZVzaDuSpft0y?=
 =?us-ascii?Q?PeMCHNaQuNF/MZFoE/0ib+KifrS7v+hWI9W8Q+Utu86jgE1ZSwJKF2LskG/y?=
 =?us-ascii?Q?T7xw/WoyneEMg2XE9SCUEs2RCJS2X4ImJCs7d1S6U2rv7QLpy6BTb4BzJVqX?=
 =?us-ascii?Q?xps7K0hfQP+sgGUYYxXeo5R+tYmphUMDWACPPxgXRpQEKdw2qjimaN6cIFk0?=
 =?us-ascii?Q?rsyJPzLHcSPOxYw/Hi+TG2dVHko1mq73uzNhH24gW6lpFy2po6UtrwrV4jAy?=
 =?us-ascii?Q?PzhZ4PIhKpI07+t+n/ou73uyJJ1yEd4RihhCHI/QcglBxLqoSyfhkN9S6awb?=
 =?us-ascii?Q?7M8z+ckTvTSRHFvd7Xxqq4Q3CmurRJaUpxNpOAdbquE1VUxAPJ8sTbcZQaMG?=
 =?us-ascii?Q?So80DCW/OBZsX3TxMZtLNnoDq4RwmfToun/B+WdH37wnuBWJTzvLWK6BLPPA?=
 =?us-ascii?Q?KVi6iviswymg1LZyW2eizR1ewKsXVYJ6NVW+phsaTB37EHJSVyEL7/69Rcgn?=
 =?us-ascii?Q?VcBB+niTOd+H9dOVfloC3D2u7ErSyIzEUFO/zeQU3P3SNP+OTVY+XrVhJ6OY?=
 =?us-ascii?Q?wJlqNM3OhhTGI//n32I0yTz1rNODFwhMacuOIyCM8SgPwCCRComHOJrRvfQx?=
 =?us-ascii?Q?OvyxH/MDpBLUh0x3Z22dga6wUS0u5GQeVTDnjsPh98+9sqxc3F6jDIRW4e/B?=
 =?us-ascii?Q?NqpW8XAA8qAvI8BCape0aKho4KspCsv+kwOacVQYHyno7iYkOHhMoLeSpD07?=
 =?us-ascii?Q?RoZ425rvVn38Cwfm1/r/ahDhvSE+XGm/Q4Jc9Ex4N+I6EjTjRIBeK44hJkVf?=
 =?us-ascii?Q?GwxosWnEJJ3X7VG8jLPOOg0sTK22CECQkYBZXStt+tsE9TGr2m2/AsAWFLxZ?=
 =?us-ascii?Q?BIR3f5SPpdlNu8=3D?=
X-Microsoft-Antispam-Message-Info: XBKnvx8HJDgUfH55G7cYFfPjUWS6j18PzcPvDwloDTitG1ETdKhnKefUw834G12ihd7moanjPyIU3DiO/1AI2B9B/n+j9gp7zLNoK92KeeMF16XYKBQnCJYYHi2tIBhyHAv0xpLt1/FLa3ARUVk3H9ptRWnEhwKwTyRODU3uFC3QsTnOcwb7a16/3l3cql3g
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;6:7Z4GyheFjIG2hcnnrxGm0OAHrlHQJKayx9QvsWuCC6ok/TsREbH2TTOp1oOeKYX1j8wee9eVYtevPWKFxqrT8z2vssAAmVXfZdQn82phMMeSHPnrqJ6EBJinAzZG4uSxWgNWgNUvmTtrjondpTt1R1WYAziy15K5zzH3d6Bgw4q7UE8QvVKvPDknYalmt2IZ40G6cShaG5AqHrWlqMTVaYpmsN0ghtv1OOsp3YIhTfiFwi2tOej2BQhc6Ng5VZd/5+nNn1KM+dobq7Br3RrdQynS8oP2AHj0ra2hOZ6Wt0AN/Sm01GX2CCgDFEewJs2NklWmAzN84kmXzdKW6xKY9JRnvNw4IP3IwP2zyNvMbo5MX/vYbp4C8fudCKJwcwQbE2kwJ5E/2GUIarz4ZCpvEhI/xh649T5EfclI8iBlZIqBTeHG8UbbQ22DYeIWRq/haM/arDWPN75qAh6/8YHSWQ==;5:n1zQCP1jcfmm1FK2ovd8LKhEdIAztKHakdjER9AWpx3IZ5dzxdkk7zJs68HW317jspd5N41Xs12cDB4m32F97FZd/vBkXzTpUo34hfcdkT/5gZ6JnKVr2J1/qvXVzLO9aDSOjYTa/XnnThlInZnlwABFY4R/B3btj+TptcTZVyI=;24:zwf3q/5B+JP5JP2SgvuBctAw06T4CnX0dGay3I97n5VWbyLTVbD1N4mjvGd785xPWMNSod3xuySUq0BJOBvP4lZb0C8UUoB5kQEWp3L7EDk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;7:3BXuMGtlItbJxhvwiel7Ezx9mRxrRIq7suMrqYeMRGxZXuz0Qb7SS7FxPZSRJHry12gHPgOprlIBKR6z91Wk577NcXBL+zN/PK0c79QXiagb8Vt6JBQYGT6X9qSva7PLtMsERS3Y+7Y4yTjLNGYUEmZCOpoEFWcA5hapKePNIhnMjXvrPSK+zXRl+vad3BCYmORnKNPVz22FoT6TURBdIoGWxDbi8srXXHxFbPyTBop81lSPdlgwTP3d9sqV6zl7;20:pGh86btiDq5rgdoHE/pHa00fpOJ35B+g6rzEAt9ZmItOBpMupW4CLLoWjhq/06QJ9nLEUgI86rmwnmLfwWATLeETjCCt1RbcdEf0SJiraJLv+Cuwcmd20YHFWNxQUjetD9Brxp73Ew5PH9tyGLZpjgva/rEgBwpEzzz+GNkNpBk=
X-MS-Office365-Filtering-Correlation-Id: b9411a5c-1975-41c2-ad8a-08d5a9180703
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 12:44:59.1189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9411a5c-1975-41c2-ad8a-08d5a9180703
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes!

Thanks for the review. I've just sent v2, which closely
follows your advice, really nothing contradictory.

Plus fixed some comments on top of mem_cgroup_protected
and fixed !CONFIG_MEMCG build.

Thank you!

Roman

On Fri, Apr 20, 2018 at 04:44:29PM -0400, Johannes Weiner wrote:
> Hi Roman,
> 
> this looks cool, and the implementation makes sense to me, so the
> feedback I have is just smaller stuff.
> 
> On Fri, Apr 20, 2018 at 05:36:31PM +0100, Roman Gushchin wrote:
> > Memory controller implements the memory.low best-effort memory
> > protection mechanism, which works perfectly in many cases and
> > allows protecting working sets of important workloads from
> > sudden reclaim.
> > 
> > But it's semantics has a significant limitation: it works
> 
> its
> 
> > only until there is a supply of reclaimable memory.
> 
> s/until/as long as/
> 
> Maybe "as long as there is an unprotected supply of reclaimable memory
> from other groups"?
> 
> > This makes it pretty useless against any sort of slow memory
> > leaks or memory usage increases. This is especially true
> > for swapless systems. If swap is enabled, memory soft protection
> > effectively postpones problems, allowing a leaking application
> > to fill all swap area, which makes no sense.
> > The only effective way to guarantee the memory protection
> > in this case is to invoke the OOM killer.
> 
> This makes it sound like it has no purpose at all. But like with
> memory.high, the point is to avoid the kernel OOM killer, which knows
> jack about how the system is structured, and instead allow userspace
> management software to monitor MEMCG_LOW and make informed decisions.
> 
> memory.min again is the fail-safe for memory.low, not the primary way
> of implementing guarantees.
> 
> > @@ -297,7 +297,14 @@ static inline bool mem_cgroup_disabled(void)
> >  	return !cgroup_subsys_enabled(memory_cgrp_subsys);
> >  }
> >  
> > -bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
> > +enum mem_cgroup_protection {
> > +	MEM_CGROUP_UNPROTECTED,
> > +	MEM_CGROUP_PROTECTED_LOW,
> > +	MEM_CGROUP_PROTECTED_MIN,
> > +};
> 
> These look a bit unwieldy. How about
> 
> MEMCG_PROT_NONE,
> MEMCG_PROT_LOW,
> MEMCG_PROT_HIGH,
> 
> > +enum mem_cgroup_protection
> > +mem_cgroup_protected(struct mem_cgroup *root, struct mem_cgroup *memcg);
> 
> Please don't wrap at the return type, wrap the parameter list instead.
> 
> >  int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
> >  			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
> > @@ -756,6 +763,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
> >  {
> >  }
> >  
> > +static inline bool mem_cgroup_min(struct mem_cgroup *root,
> > +				  struct mem_cgroup *memcg)
> > +{
> > +	return false;
> > +}
> > +
> >  static inline bool mem_cgroup_low(struct mem_cgroup *root,
> >  				  struct mem_cgroup *memcg)
> >  {
> 
> The real implementation has these merged into the single
> mem_cgroup_protected(). Probably a left-over from earlier versions?
> 
> It's always a good idea to build test the !CONFIG_MEMCG case too.
> 
> > @@ -5685,44 +5723,71 @@ struct cgroup_subsys memory_cgrp_subsys = {
> >   * for next usage. This part is intentionally racy, but it's ok,
> >   * as memory.low is a best-effort mechanism.
> >   */
> > -bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
> > +enum mem_cgroup_protection
> > +mem_cgroup_protected(struct mem_cgroup *root, struct mem_cgroup *memcg)
> 
> Please fix the wrapping here too.
> 
> > @@ -2525,12 +2525,29 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  			unsigned long reclaimed;
> >  			unsigned long scanned;
> >  
> > -			if (mem_cgroup_low(root, memcg)) {
> > +			switch (mem_cgroup_protected(root, memcg)) {
> > +			case MEM_CGROUP_PROTECTED_MIN:
> > +				/*
> > +				 * Hard protection.
> > +				 * If there is no reclaimable memory, OOM.
> > +				 */
> > +				continue;
> > +
> > +			case MEM_CGROUP_PROTECTED_LOW:
> 
> Please drop that newline after continue.
> 
> > +				/*
> > +				 * Soft protection.
> > +				 * Respect the protection only until there is
> > +				 * a supply of reclaimable memory.
> 
> Same feedback here as in the changelog:
> 
> s/until/as long as/
> 
> Maybe "as long as there is an unprotected supply of reclaimable memory
> from other groups"?
> 
> > +				 */
> >  				if (!sc->memcg_low_reclaim) {
> >  					sc->memcg_low_skipped = 1;
> >  					continue;
> >  				}
> >  				memcg_memory_event(memcg, MEMCG_LOW);
> > +				break;
> > +
> > +			case MEM_CGROUP_UNPROTECTED:
> 
> Please drop that newline after break, too.
> 
> Thanks!
> Johannes
