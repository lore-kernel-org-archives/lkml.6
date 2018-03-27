Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569313-1522118771-2-348419497560284025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522118770; b=vNl34nR1+z9gpvNFhKbmvaTf1UPzopoSS6FKcCtzyni/IqH
    RrMtL/cQqhJProxSYJ7YR+xuEnrjg362Ff8qUmtlNJ7oUoKgm3+sdxDTFe2001xv
    BLv4vAbWcWSoN2Ky4hdHx6RPqSLpn7ORjOYWIZhzkwQ/Fz+HaToZjpWDpRg8EIhk
    hsw6m53x94RcQvyGXVpvdlhk9w+vavlmhIdc7PQpDZKm9gAToUvYj2DSP6hIQsJ0
    Ay4pGwf1UxoYkWU5NgZVaWKURn87Cx1ARssI6Hk/iayEFzSApb25VPdRWwZrLrJg
    mnSvI2aMUBJ/yLqWu+twlisHosBS7VRCXGEm5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522118770; bh=aWDep30909KYvzMCQUqjWuF85V
    iX8eDRE4yHf/Xnemk=; b=PMFduOa5CVQd82mUXesaDCrW+gid5v54gy/w2q7ebv
    uYV6ns9TJeqrO0e0Rf1ZvYmSVUvA3eOP2xTEkYXsWYgEjmQsMm+ttpfAzFhrNUI1
    6SIoEGU16lMXCRhYbw92Kf2ejfgyxHL0BVfWwQyPQLWJ566L8VgALGnhDcsmCXOO
    kOYPnlBGC8ii9tvgSpWZ7zAr25hwkB58Ip4g1s+G8EijfZdLVm3hTItBNmFTS2gm
    H3TNwZuOoAwZGP3zr4N4rrZxk5zf/ItXbz3i1DfyhjrCFQCW8omrzBLe6rxetZiF
    fQODtffBRZTI0XWFNpFblRr8wbLROWCWFhpUxHt4DXoQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIgz1oWmcWqI9pnlvaSoJCEuetNdfY7ifU5mqKmptifPzo0nfMDGQXLxAsK7A7VFravgTrYtdC/VmgO7nuUwFSgWgAukok5d7VliwnaDQeXzE1XZVjSW
    UfdBapH0xgo9qmeDtl1wfNXk5BE0A4iFNEmBhQU166NRfnHnc9gCxJWVSt0qUTGL/g5SFqyeoxtxSeIkbmAuxyj9j1vgh4nVxbYimBq2N91uLnW0A3uroQgl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=J4IW9DOgNfxxvRPxTwAA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeC0Cp5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 22:45:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:52874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752197AbeC0Cp4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 26 Mar 2018 22:45:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="40905436"
Date: Tue, 27 Mar 2018 10:35:49 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v4 04/24] fpga: add device feature list support
Message-ID: <20180327023549.GA15476@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-5-git-send-email-hao.wu@intel.com>
 <CANk1AXSaE3wQ7jnBkB0TR3kLKnG1XUeHk+LbDSxyRtBxbMNGPw@mail.gmail.com>
 <20180323043304.GA14733@hao-dev>
 <CANk1AXRbBonnop6Q3=kdXHdZEBoO9cGa6sON7e0GvFwd_TnYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRbBonnop6Q3=kdXHdZEBoO9cGa6sON7e0GvFwd_TnYfw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 12:21:23PM -0500, Alan Tull wrote:
> On Thu, Mar 22, 2018 at 11:33 PM, Wu Hao <hao.wu@intel.com> wrote:
> 
> >> > +
> >> > +/*
> >> > + * This function resets the FPGA Port and its accelerator (AFU) by function
> >> > + * __fpga_port_disable and __fpga_port_enable (set port soft reset bit and
> >> > + * then clear it). Userspace can do Port reset at any time, e.g during DMA
> >> > + * or Partial Reconfiguration. But it should never cause any system level
> >> > + * issue, only functional failure (e.g DMA or PR operation failure) and be
> >> > + * recoverable from the failure.
> >> > + *
> >> > + * Note: the accelerator (AFU) is not accessible when its port is in reset
> >> > + * (disabled). Any attempts on MMIO access to AFU while in reset, will
> >> > + * result errors reported via port error reporting sub feature (if present).
> >> > + */
> >> > +static inline int __fpga_port_reset(struct platform_device *pdev)
> >> > +{
> >> > +       int ret;
> >> > +
> >> > +       ret = __fpga_port_disable(pdev);
> >> > +       if (ret)
> >> > +               return ret;
> >> > +
> >> > +       __fpga_port_enable(pdev);
> >> > +
> >> > +       return 0;
> >> > +}
> >> > +
> >> > +static inline int fpga_port_reset(struct platform_device *pdev)
> >> > +{
> >> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >> > +       int ret;
> >> > +
> >> > +       mutex_lock(&pdata->lock);
> >> > +       ret = __fpga_port_reset(pdev);
> >> > +       mutex_unlock(&pdata->lock);
> >> > +
> >> > +       return ret;
> >> > +}
> >>
> >> I'm still scratching my head about how the enumeration code also has
> >> code that handles resetting the PL in a FPGA region and
> >> enabling/disabling the bridge.  We've discussed this before [1] and I
> >> know you've looked into it, I'm still trying to figure out how this
> >> can be made modular, so when someone needs to support a different port
> >> in the future, it isn't a complete rewrite.
> >>
> >> Speaking of resets, one way forward would be to create a reset
> >> controller for the port (and if possible move the port code to the
> >> bridge platform driver).  The current linux-next repo adds support for
> >> reset lookups, so that reset controllers are supported for non-DT
> >> platforms [2].
> >>
> >> So the bridge driver would implement the enable/disable functions and
> >> create a reset controller, the fpga-region (or whoever else needs it)
> >> could look the reset controller and use the reset.  By using the
> >> kernel reset framework, we don't have to have that piece of code
> >> shared around by having a reset function in a .h file.  And it avoids
> >> adding extra dependencies between modules.  Also, where necessary, I'd
> >> rather add functionality to the existing bridge/mgr/region frameworks,
> >> adding common interfaces at that level to allow reuse (like adding
> >> status to fpga-mgr).  Ideally, this DFL framework would sit on top of
> >> mgr and bridge and allow those to be swapped out for reuse of the DFL
> >> framework on other devices.  Also it will save future headaches as mgr
> >> or port implementations evolve.
> >
> > Thanks a lot for the suggestion. I really really appreciate this.
> 
> Yes, this is a good discussion, thanks.
> 
> >
> > Actually if we consider the virutalization case as I mentioned in [1] below,
> > that means AFU and its Port will be turned into a PCI VF and assigned (passed
> > through) to a virtual machine. There is no FME block on that PCI VF device,
> > (the FME is always kept in PCI PF device in the host) and currently the bridge
> > is created by FME module for PR functionatily. So in the guest virtual machine,
> > nobody creates the reset controller actually.
> >
> > As I mentioned in [1], one possible method is, put these port reset functions to
> > AFU (Port) module, and share those functions with FME bridge module.
> 
> Yes, the port reset functions could move into an AFU driver, and then
> also the AFU driver could also create a reset controller and register
> a lookup [2] for the reset.  That would be just a few lines of code.
> The reset controller would control enabling/disabling the port.  The
> bridge driver could get the reset controller to use during FPGA
> programming.  That is instead of sharing a reset function with the
> bridge driver.   It decouples the FPGA bridge driver and simplifies it
> to be something that just needs to control a reset instead of needing
> to include a specific .h file that makes  a port reset function
> available.

Hi Alan

Thanks a lot for the feedback. :)

The major concern here is, for virtualization case, after we enable the SRIOV
to create VFs, AFUs(and ports) are turned into VFs from PF. Once AFUs are moved
from PF to VFs, then we should remove all related user interfaces exported by
the afu platform device under PF by unregistering these platform devices from
the system. So in this case the reset controller created by the AFU platform
driver, should be removed when the AFU platform devices are deleted from the
system in this case, but we still have FME and FME bridge present on PF, then
FME bridge can't find the reset controller any longer to do port enable/disable.

Sorry, I found my previous description is not accurate.

VFs could be passed through to a virtual machine, if we let AFU/Port create
reset controller, then the reset controllers are created in the virtual machine.
And FME is always in PF in the host, so FME bridge in host have no access to the
reset controllers in the virtual machine.

> 
> > I think
> > that will make the code in the common DFL framework a little more clean,
> 
> Yes, IIUC that may also make it easier as the port/AFU gets added
> functionality that is intended to be controlled by the VF anyway
> (while the only port-related thing that is needed by the FME is port
> enable/disable).
> 
> > but it
> > will introduce some module dependency here for sure, (e.g FME modules can't
> > finish PR without AFU (Port) Module loaded).
> 
> That sounds like an OK type of dependency, i.e. if the modules are not
> all loaded, it doesn't work. :-)

Find a reset controller by lookup, if not found, return error code. It seems
not a really hard module dependency between port/afu and FME bridge modules.
But if in FME bridge, it uses functions exposed by port/afu module, that's a
hard dependency. : )

I can try to move related code to afu/port driver instead in the next version
for sure, but I can't create the reset controller per the reason above. Please
let me know if more thoughts on this. : )

> 
> > But anyway it may be still
> > acceptable for users as all these modules could be loaded automatically. How do
> > you think? :)
> 
> The other thing I want to get right now is if there is a different
> AFU/port that needs a different driver.  Can the DFL be changed to
> specify what AFU/port to load?  I really really want to avoid large
> code rewrites in the future that we can anticipate now.  Such as
> someone implements their own static image, it has DFL, but the port is
> somewhat different.  Instead of seeing features as just something that
> gets added, the DFL also specifies what port driver and mgr driver to
> load.  The stuff we discussed above is a good step towards that, but
> not all of it.

I'm not sure if any vendor wants to create a totally different port here, if
yes, then it could have a different feature id in Device Feature Header (DFH).
I think it's possible to use that feature id to decide which driver to load
(or which platform device to create). But vendors don't have to do that, as it
could reuse current port driver and private features added already, or even
add some new vendor specific private feature under the port to save cost.

Thanks
Hao

> 
> Alan
> 
> >
> > Thanks
> > Hao
> >
> >
> >>
> >> Alan
> >>
> >> [1] https://lkml.org/lkml/2017/12/22/398
> >> [2] https://patchwork.kernel.org/patch/10247475/
