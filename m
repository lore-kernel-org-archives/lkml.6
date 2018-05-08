Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbeEHSsJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:48:09 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:54693 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932621AbeEHSsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:48:07 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:967:973:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2559:2564:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:6119:7903:8526:9025:9040:10004:10394:10400:10848:11026:11232:11473:11658:11914:12043:12048:12050:12438:12555:12663:12679:12740:12760:12895:12986:13095:13439:14096:14097:14180:14181:14659:14721:21060:21080:21347:21433:21451:21611:21627:30029:30030:30054:30070:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: sleep07_29830ac1cdb38
X-Filterd-Recvd-Size: 4099
Message-ID: <e671945494d54cdcf65c6d2af9f9f69d65fb2583.camel@perches.com>
Subject: Re: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From: Joe Perches <joe@perches.com>
To: "Hook, Gary" <ghook@amd.com>, kbuild test robot <lkp@intel.com>,
        Gary R Hook <gary.hook@amd.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Date: Tue, 08 May 2018 11:48:03 -0700
In-Reply-To: <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
References: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
         <201805080700.Jm8moLQz%fengguang.wu@intel.com>
         <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 12:08 -0500, Hook, Gary wrote:
> On 5/7/2018 6:47 PM, kbuild test robot wrote:
> > Hi Gary,
> > 
> 
> I imagine these questions have been asked before, so I'll ask for
> forgiveness up front.
> 
> 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on iommu/next]
> > [also build test ERROR on v4.17-rc4 next-20180507]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Gary-R-Hook/iommu-Enable-debugfs-exposure-of-IOMMU-driver-internals/20180508-062918
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> > config: x86_64-randconfig-x016-201818 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >          # save the attached .config to linux build tree
> >          make ARCH=x86_64
> 
> Is the gcc 7 compiler now a requirement to build the kernel? Or only to 
> run krobot tests?
> 
> Is this the earliest version of the compiler that can be used? I'm still 
> using 4.8 and 5.4, which seems to suffice for the kernel.
> 
> Googling about this has been fruitless.
> 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >     In file included from include/linux/intel-iommu.h:32:0,
> >                      from drivers/gpu/drm/i915/i915_drv.h:41,
> >                      from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
> >     include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
> > > > include/linux/iommu.h:706:8: error: parameter name omitted
> > 
> >      struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> >             ^~~~~~
> >     In file included from include/linux/intel-iommu.h:32:0,
> >                      from drivers/gpu/drm/i915/i915_drv.h:41,
> >                      from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
> > > > include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
> > 
> >      struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> >             ^~~~~~
> > 
> > vim +706 include/linux/iommu.h
> > 
> >     700	
> >     701	#ifdef CONFIG_IOMMU_DEBUGFS
> >     702	void iommu_debugfs_setup(void);
> >     703	struct dentry *iommu_debugfs_new_driver_dir(char *);
> >     704	#else
> >     705	static inline void iommu_debugfs_setup(void) {}
> >   > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> >     707	#endif
> >     708	
> 
> I have no problems with adding parameter names. But 
> scripts/checkpatch.pl doesn't seem to check for this, nor require it. 
> Should checkpatch be updated?

I'm pretty sure that's not feasible.

And when the compiler tells you you've stuffed up some
syntactical bit, why should checkpatch duplicate the
output error message too?

btw:  That's an unnecessary ; at the end of that non-void
function and it should probably be something like:

static inline struct dentry *iommu_debugfs_new_driver_dir(char *dir)
{
	return NULL;
}
