Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbeEHUmi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:42:38 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:45859 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755775AbeEHUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:42:36 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2110:2393:2559:2562:2692:2828:2895:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:7903:7904:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12438:12663:12740:12760:12895:13095:13161:13229:13439:14096:14097:14181:14659:14721:21080:21433:21451:21611:21627:30029:30030:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: maid56_167fc3a528e07
X-Filterd-Recvd-Size: 3942
Message-ID: <eeb51d36cd50f892630e0424cded20ad6bc47501.camel@perches.com>
Subject: Re: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From: Joe Perches <joe@perches.com>
To: Gary R Hook <gary.hook@amd.com>, "Hook, Gary" <ghook@amd.com>,
        kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Date: Tue, 08 May 2018 13:42:33 -0700
In-Reply-To: <239fdd0c-9497-7275-4e74-d6ccd028e823@amd.com>
References: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
         <201805080700.Jm8moLQz%fengguang.wu@intel.com>
         <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
         <e671945494d54cdcf65c6d2af9f9f69d65fb2583.camel@perches.com>
         <239fdd0c-9497-7275-4e74-d6ccd028e823@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 15:07 -0500, Gary R Hook wrote:
> On 05/08/2018 01:48 PM, Joe Perches wrote:
> > On Tue, 2018-05-08 at 12:08 -0500, Hook, Gary wrote:
> > > On 5/7/2018 6:47 PM, kbuild test robot wrote:
> > > > 
> > > > All error/warnings (new ones prefixed by >>):
> > > > 
> > > >      In file included from include/linux/intel-iommu.h:32:0,
> > > >                       from drivers/gpu/drm/i915/i915_drv.h:41,
> > > >                       from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
> > > >      include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
> > > > > > include/linux/iommu.h:706:8: error: parameter name omitted
> > > > 
> > > >       struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> > > >              ^~~~~~
> > > >      In file included from include/linux/intel-iommu.h:32:0,
> > > >                       from drivers/gpu/drm/i915/i915_drv.h:41,
> > > >                       from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
> > > > > > include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
> > > > 
> > > >       struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> > > >              ^~~~~~
> > > > 
> > > > vim +706 include/linux/iommu.h
> > > > 
> > > >      700	
> > > >      701	#ifdef CONFIG_IOMMU_DEBUGFS
> > > >      702	void iommu_debugfs_setup(void);
> > > >      703	struct dentry *iommu_debugfs_new_driver_dir(char *);
> > > >      704	#else
> > > >      705	static inline void iommu_debugfs_setup(void) {}
> > > >    > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> > > >      707	#endif
> > > >      708	
> > > 
> > > I have no problems with adding parameter names. But
> > > scripts/checkpatch.pl doesn't seem to check for this, nor require it.
> > > Should checkpatch be updated?
> > 
> > I'm pretty sure that's not feasible.
> 
> Ugh. This is a definition, not a declaration. My bad. Which is likely 
> why I decided to apologize up front.
> 
> > And when the compiler tells you you've stuffed up some
> > syntactical bit, why should checkpatch duplicate the
> > output error message too?
> 
> Well, that's the point: neither the 4.8 nor 5.4 compiler complained 
> about this.

Perhaps because CONFIG_IOMMU_DEBUGFS was set in the .config
for all the compilation previously performed?

>  Not as an error, despite the fact that (now that I read what 
> is actually here, as opposed to what I think is there) this is wrong. 
> Had an error message been emitted, and the make stopped, I would have 
> figure this out before embarrassing myself in front of the entire interwebs.

There's no reason for that figuring out to be necessary.
Linux compilation complexity is pretty high and almost
no one understands it completely.

cheers, Joe
