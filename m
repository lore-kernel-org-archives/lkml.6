Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891550-1522872476-2-6870432521068528138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522872474; b=Cilr7azswr+L4VvORayl0mz2Gh4stya6bdaG54YIFfLqrou8nv
    KNFz4Axn6V2kCrVBnIdhjiCs9Et5RYwdiFaalTeXrNMUD0QqLDETeDeKobZXkn+l
    BMdGWO/cQGlj3KCeDPkeiOZJuO2jG8k7kwARPJnttGZ1BUlXH+jMzYq/tNchoGeZ
    mKl9qE9nj1n3HJK498dlEybGiNhb+P9jPCVAbDuaoux7nUP2+p+YW+FUKr7Qac9G
    NBjCMY2ok6p5UHhiQuvvIuA7AS9RX/i6ohdJg952svGS/f8xWURYNgvbZHDiWcGC
    QfRGAxWVETQQjsYJPhrsngXGPdCpF+q4kGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522872474; bh=OSI8Ssho7kDUrfTIYe/hQr9zTyxkK5TItHfNP63Y2W
    o=; b=KCaNoGTFKUxbvcS+EBlBldt4tSe5lA8qLEWKZbx07GxFamrRgWy0Urgyi4
    v7ATlJQTewmjXUQ5QAj/+8R5FYujawHL3r6I11IGc+WkLIfeZTh3uFAN93kyMLWD
    WamQrHWbzLx4WqxnssHST0uFtp7r5Ahn+bFS+bqO892qTI8YQNeP6IkyVuYiRSRk
    UDvZzgU1mcES8Iy7EcFY70yWbdVn7pK3p/9ogSkATfW7UagvxuwsIzh3q+j1as7E
    UtgbYqiemKbYn0jxrwtb8zUY4S5c0Q8okALL6N0z450pzp7Nre17WS72XVq7vjkd
    J8K0DEFEob8L+oIQoZ+/OOemBjHQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJACikmfdgfWDwEjVSTDDWOaC4QgPRXaLzVyyRVxvkQCk7l/Sjsg2jv2/n2qle2vHqWqjOl0sGs4/Ow2DQUdaKIzvrcafjcibg0rouUZBp9d78fGktTk
    +AMLKVOWNvr9y1jQFFp6CfaIYFnvbB4ZcqjCCxFPTP1kV75xn3Zsp33uNXmkQZDY40Rhav8/T0B9oJTLYEeBvMGxdhBifpVWXoDt9sF4OoFAYfMDhY18+Qpt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=kvwABCrS-ngNyfv3Ox4A:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=yBXafnvhMt_gKGsW:21 a=EdA8avOTV1kj4D61:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeDDUHl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 16:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbeDDUHj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 16:07:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF194217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AIpwx4+TvaJnM4ordni4BHGGUq3y+ArMB6nbp0UHCKWbpbTTXnwOoAwYp1GqsjV0lvocsuSFkQYXEW1HaE1EX4xdFiQ=
MIME-Version: 1.0
In-Reply-To: <20180403013646.GA31760@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-5-git-send-email-hao.wu@intel.com> <CANk1AXSaE3wQ7jnBkB0TR3kLKnG1XUeHk+LbDSxyRtBxbMNGPw@mail.gmail.com>
 <20180323043304.GA14733@hao-dev> <CANk1AXRbBonnop6Q3=kdXHdZEBoO9cGa6sON7e0GvFwd_TnYfw@mail.gmail.com>
 <20180327023549.GA15476@hao-dev> <CANk1AXQVMCySDjG1_aCxyot612Xg+Vf=vLqk3QY2wpruOAjfpw@mail.gmail.com>
 <20180402042233.GA27618@hao-dev> <CANk1AXRt9Tn6HbYtL3xpYPY=CgUrTgCuvCrYcBVJUObBTX=N9w@mail.gmail.com>
 <20180403013646.GA31760@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Wed, 4 Apr 2018 15:06:57 -0500
X-Gmail-Original-Message-ID: <CANk1AXTRNWH6d+RstjPenYyOjktyAhA35-K_OM_3JZ_T3Ai0gA@mail.gmail.com>
Message-ID: <CANk1AXTRNWH6d+RstjPenYyOjktyAhA35-K_OM_3JZ_T3Ai0gA@mail.gmail.com>
Subject: Re: [PATCH v4 04/24] fpga: add device feature list support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 2, 2018 at 8:36 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Mon, Apr 02, 2018 at 02:06:56PM -0500, Alan Tull wrote:
>> On Sun, Apr 1, 2018 at 11:22 PM, Wu Hao <hao.wu@intel.com> wrote:
>> > On Thu, Mar 29, 2018 at 04:57:22PM -0500, Alan Tull wrote:
>> >> On Mon, Mar 26, 2018 at 9:35 PM, Wu Hao <hao.wu@intel.com> wrote:
>> >>
>> >> Hi Hao,
>> >>
>> >> Currently there is one set of functions that handles port enable,
>> >> disable, and reset and it's in dfl.c and dfl.h, so that's not in any
>> >> driver module that can be switched out if necessary for a different
>> >> implementation of the port.  Finding a way for this patchset to be
>> >> structured for DFL to control what low level manager/port drivers are
>> >> used is the current challenge that I've got a lot of my attention on.
>> >>
>> >> Thanks for the explanations on how virtualization affects how this can
>> >> be implemented.
>> >>
>> >> > On Mon, Mar 26, 2018 at 12:21:23PM -0500, Alan Tull wrote:
>> >> >> On Thu, Mar 22, 2018 at 11:33 PM, Wu Hao <hao.wu@intel.com> wrote:
>> >> >>
>> >> >> >> > +
>> >> >> >> > +/*
>> >> >> >> > + * This function resets the FPGA Port and its accelerator (AFU) by function
>> >> >> >> > + * __fpga_port_disable and __fpga_port_enable (set port soft reset bit and
>> >> >> >> > + * then clear it). Userspace can do Port reset at any time, e.g during DMA
>> >> >> >> > + * or Partial Reconfiguration. But it should never cause any system level
>> >> >> >> > + * issue, only functional failure (e.g DMA or PR operation failure) and be
>> >> >> >> > + * recoverable from the failure.
>> >> >> >> > + *
>> >> >> >> > + * Note: the accelerator (AFU) is not accessible when its port is in reset
>> >> >> >> > + * (disabled). Any attempts on MMIO access to AFU while in reset, will
>> >> >> >> > + * result errors reported via port error reporting sub feature (if present).
>> >> >> >> > + */
>> >> >> >> > +static inline int __fpga_port_reset(struct platform_device *pdev)
>> >> >> >> > +{
>> >> >> >> > +       int ret;
>> >> >> >> > +
>> >> >> >> > +       ret = __fpga_port_disable(pdev);
>> >> >> >> > +       if (ret)
>> >> >> >> > +               return ret;
>> >> >> >> > +
>> >> >> >> > +       __fpga_port_enable(pdev);
>> >> >> >> > +
>> >> >> >> > +       return 0;
>> >> >> >> > +}
>> >> >> >> > +
>> >> >> >> > +static inline int fpga_port_reset(struct platform_device *pdev)
>> >> >> >> > +{
>> >> >> >> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> >> >> >> > +       int ret;
>> >> >> >> > +
>> >> >> >> > +       mutex_lock(&pdata->lock);
>> >> >> >> > +       ret = __fpga_port_reset(pdev);
>> >> >> >> > +       mutex_unlock(&pdata->lock);
>> >> >> >> > +
>> >> >> >> > +       return ret;
>> >> >> >> > +}
>> >> >> >>
>> >> >> >> I'm still scratching my head about how the enumeration code also has
>> >> >> >> code that handles resetting the PL in a FPGA region and
>> >> >> >> enabling/disabling the bridge.  We've discussed this before [1] and I
>> >> >> >> know you've looked into it, I'm still trying to figure out how this
>> >> >> >> can be made modular, so when someone needs to support a different port
>> >> >> >> in the future, it isn't a complete rewrite.
>> >> >> >>
>> >> >> >> Speaking of resets, one way forward would be to create a reset
>> >> >> >> controller for the port (and if possible move the port code to the
>> >> >> >> bridge platform driver).  The current linux-next repo adds support for
>> >> >> >> reset lookups, so that reset controllers are supported for non-DT
>> >> >> >> platforms [2].
>> >> >> >>
>> >> >> >> So the bridge driver would implement the enable/disable functions and
>> >> >> >> create a reset controller, the fpga-region (or whoever else needs it)
>> >> >> >> could look the reset controller and use the reset.  By using the
>> >> >> >> kernel reset framework, we don't have to have that piece of code
>> >> >> >> shared around by having a reset function in a .h file.  And it avoids
>> >> >> >> adding extra dependencies between modules.  Also, where necessary, I'd
>> >> >> >> rather add functionality to the existing bridge/mgr/region frameworks,
>> >> >> >> adding common interfaces at that level to allow reuse (like adding
>> >> >> >> status to fpga-mgr).  Ideally, this DFL framework would sit on top of
>> >> >> >> mgr and bridge and allow those to be swapped out for reuse of the DFL
>> >> >> >> framework on other devices.  Also it will save future headaches as mgr
>> >> >> >> or port implementations evolve.
>> >> >> >
>> >> >> > Thanks a lot for the suggestion. I really really appreciate this.
>> >> >>
>> >> >> Yes, this is a good discussion, thanks.
>> >> >>
>> >> >> >
>> >> >> > Actually if we consider the virutalization case as I mentioned in [1] below,
>> >> >> > that means AFU and its Port will be turned into a PCI VF and assigned (passed
>> >> >> > through) to a virtual machine. There is no FME block on that PCI VF device,
>> >> >> > (the FME is always kept in PCI PF device in the host) and currently the bridge
>> >> >> > is created by FME module for PR functionatily. So in the guest virtual machine,
>> >> >> > nobody creates the reset controller actually.
>> >> >> >
>> >> >> > As I mentioned in [1], one possible method is, put these port reset functions to
>> >> >> > AFU (Port) module, and share those functions with FME bridge module.
>> >> >>
>> >> >> Yes, the port reset functions could move into an AFU driver, and then
>> >> >> also the AFU driver could also create a reset controller and register
>> >> >> a lookup [2] for the reset.  That would be just a few lines of code.
>> >> >> The reset controller would control enabling/disabling the port.  The
>> >> >> bridge driver could get the reset controller to use during FPGA
>> >> >> programming.  That is instead of sharing a reset function with the
>> >> >> bridge driver.   It decouples the FPGA bridge driver and simplifies it
>> >> >> to be something that just needs to control a reset instead of needing
>> >> >> to include a specific .h file that makes  a port reset function
>> >> >> available.
>> >> >
>> >> > Hi Alan
>> >> >
>> >> > Thanks a lot for the feedback. :)
>> >> >
>> >> > The major concern here is, for virtualization case, after we enable the SRIOV
>> >> > to create VFs, AFUs(and ports) are turned into VFs from PF. Once AFUs are moved
>> >> > from PF to VFs, then we should remove all related user interfaces exported by
>> >> > the afu platform device under PF by unregistering these platform devices from
>> >> > the system. So in this case the reset controller created by the AFU platform
>> >> > driver, should be removed when the AFU platform devices are deleted from the
>> >> > system in this case, but we still have FME and FME bridge present on PF, then
>> >> > FME bridge can't find the reset controller any longer to do port enable/disable.
>> >>
>> >> OK
>> >>
>> >> >
>> >> > Sorry, I found my previous description is not accurate.
>> >> >
>> >> > VFs could be passed through to a virtual machine, if we let AFU/Port create
>> >> > reset controller, then the reset controllers are created in the virtual machine.
>> >> > And FME is always in PF in the host, so FME bridge in host have no access to the
>> >> > reset controllers in the virtual machine.
>> >>
>> >> Thanks for the explanation.  Does the current implementation allows
>> >> the port's PORT_CTRL_SFTRST reset bit to be controlled by PF and VF at
>> >> the same time?
>> >
>> > Yes, it allows it to be accessed by PF and VF at the same time, only for Port
>> > Registers, not for AFU registers (any access will cause errors reported by HW).
>>
>> OK that explains a lot.
>>
>> >
>> >> Or is the idea that the VF has to be given up in order to allow the FME PF to
>> >> be able to reprogram?
>> >
>> > Without any notification mechanism between PF and VFs, the safe way of doing the
>> > PR to AFUs (accelerators) on VFs is, 1) hot-unplug the AFU (VF) from the VM,
>> > 2) turn the AFU back to PF from VF, 3) PR to the AFU on PF, 4) turn that AFU to
>> > VF again, 5) hot-plug the AFU (VF) to target VM again. We tested this flow, it
>> > works and doesn't need to shutdown the VM.
>>
>> That sounds like a lot of trouble.
>
> Without notification mechanism, this is the safe way of doing PR. We can't PR a
> AFU (assigned to VM) directly without any notification to VM, as VM owns this
> device (AFU). SW works on guest may get troubles if PR is done at unexpected
> time. For above flow, it's just the pcie hot plug function, and we tested it
> works fine as we expected.
>
>>
>> > But once we have implemented some
>> > methods to notification between PF and VFs, we don't have to do these steps.
>>
>> See below.  Let's get aligned with what we're trying to architect first.
>
> Sure.
>
>>
>> >
>> >> After the AFU and port is turned into a VF, is the port's memory range is
>> >> mapped in both the PF and the VF?
>> >
>> > Yes.
>> >
>> >>
>> >> >
>> >> >>
>> >> >> > I think
>> >> >> > that will make the code in the common DFL framework a little more clean,
>> >> >>
>> >> >> Yes, IIUC that may also make it easier as the port/AFU gets added
>> >> >> functionality that is intended to be controlled by the VF anyway
>> >> >> (while the only port-related thing that is needed by the FME is port
>> >> >> enable/disable).
>> >> >>
>> >> >> > but it
>> >> >> > will introduce some module dependency here for sure, (e.g FME modules can't
>> >> >> > finish PR without AFU (Port) Module loaded).
>> >> >>
>> >> >> That sounds like an OK type of dependency, i.e. if the modules are not
>> >> >> all loaded, it doesn't work. :-)
>> >> >
>> >> > Find a reset controller by lookup, if not found, return error code. It seems
>> >> > not a really hard module dependency between port/afu and FME bridge modules.
>> >>
>> >> That was what I was hoping would work here.  But if the module isn't
>> >> loaded because it failed due to the reset controller in the AFU driver
>> >> went away, then, yes, that won't work.
>> >>
>> >> > But if in FME bridge, it uses functions exposed by port/afu module, that's a
>> >> > hard dependency. : )
>> >>
>> >> Yes I'm trying to find ways to get away from that kind of hard
>> >> dependency.  So when someone uses this with a different port, it won't
>> >> be a huge rewrite of dfl.c and dfl.h.  I understand that the port is
>> >> used by both the AFU and the PR code, that's why it's in a file that
>> >> is included by both of them.  That's going to be a problem as soon as
>> >> this is used with a different port.
>> >
>> > or we could add some callbacks, and let port driver register its own function
>> > for enable/disable operation? But then dfl.c / dfl.h will still see some common
>> > port code there.
>> >
>> >>
>> >> >
>> >> > I can try to move related code to afu/port driver instead in the next version
>> >> > for sure, but I can't create the reset controller per the reason above. Please
>> >> > let me know if more thoughts on this. : )
>> >>
>> >> Maybe that is the way forward.  I'm still thinking about this.  So the
>> >> DFL will create a AFU driver that includes the port.  If someone
>> >> implements a different port, there would be a different id to cause
>> >> that AFU driver to be loaded instead.  It seems a shame that more of
>> >> the AFU code couldn't be reused. That was the original idea of
>> >> fpga-bridge.  Unfortunately it seems that the bridge is needed by both
>> >> the VF and PF so it's complicated by that.
>> >>
>> >> >
>> >> >>
>> >> >> > But anyway it may be still
>> >> >> > acceptable for users as all these modules could be loaded automatically. How do
>> >> >> > you think? :)
>> >> >>
>> >> >> The other thing I want to get right now is if there is a different
>> >> >> AFU/port that needs a different driver.  Can the DFL be changed to
>> >> >> specify what AFU/port to load?  I really really want to avoid large
>> >> >> code rewrites in the future that we can anticipate now.  Such as
>> >> >> someone implements their own static image, it has DFL, but the port is
>> >> >> somewhat different.  Instead of seeing features as just something that
>> >> >> gets added, the DFL also specifies what port driver and mgr driver to
>> >> >> load.  The stuff we discussed above is a good step towards that, but
>> >> >> not all of it.
>> >> >
>> >> > I'm not sure if any vendor
>> >>
>> >> Since this is open source, it's important to remember that vendors
>> >> aren't the only ones driving development of Linux.  Any user of FPGA
>> >> under Linux can (and has) come along and add to this subsystem.  This
>> >> code should not discourage that.
>> >
>> > Agree.
>> >
>> >>
>> >> > wants to create a totally different port here, if
>> >> > yes, then it could have a different feature id in Device Feature Header (DFH).
>> >> > I think it's possible to use that feature id to decide which driver to load
>> >> > (or which platform device to create).
>> >>
>> >> I think it's what we need.
>> >
>> > Yes.
>> >
>> >>
>> >> > But vendors don't have to do that, as it
>> >> > could reuse current port driver and private features added already, or even
>> >> > add some new vendor specific private feature under the port to save cost.
>> >>
>> >> They would have to implement a static image with port registers that
>> >> function the same way for at least port enable/disable/reset.  If they
>> >> need to tweak the driver implementation for their hardware then that's
>> >> not possible or it's ugly at least.
>> >
>> > Agree, in that case, it's better to use a new feature id with a different
>> > port implementation.
>> >
>> >> This is also the case if you have some newer version of you port while
>> >> keeping legacy support for your original port.
>> >
>> > In Device Feature Header, there is a field to indicate the revision of
>> > this Port (private feature has revision bit in DFH too). But we should
>> > not use this field to indicate a totally different implementation.
>> >
>> >>
>> >> I understand that virtualization is making this hard.  Thanks for
>> >> thinking about how this can move forward on this issue.
>> >
>> > Yes, I will try to move the actual port related code into AFU/port driver
>> > in the next version, thanks for the comments and suggestions.
>>
>> I have some serious doubts that's the direction to go in.  Before you
>> do a lot of work in that direction, let me explain again the larger
>> context and what's motivating my comments.
>>
>> The point of having a FPGA framework (fpga-bridge.c, fpga-manager.c,
>> and fpga-region.c) is to separate the layers above the framework
>> (enumeration and interfaces) from the layer below the framework (low
>> level FPGA bridge/manager/region drivers).   The layer above and the
>> layer below shouldn't share code or talk directly to each other.  That
>> kind of workaround defeats the purpose of having a framework and
>> prevents reuse.   If you need a workaround like that, it's probably a
>> case where the framework needs some added functionality that's
>> generally usable.  For example, we've run into that before, in v1,
>> your FPGA manager driver was returning status via its private data.
>> We discussed it and added status to the fpga-mgr framework so you
>> wouldn't need to do that.
>>
>> So implementing fpga_port_enable in the enumeration code and then
>> accessing that code in both the AFU code (upper layer) and the FME
>> bridge driver (lower layer) beaks the model.  When an implementation
>> works around a framework to do what it wants, that mean that none of
>> that implementation is reusable.  A lot of this review has been me
>> trying to understand and untangle that.  I'm trying to guide the
>> development of the FPGA framework to have reusibility.
>>
>> The 'port' is really what the existing FPGA framework calls an FPGA
>> bridge (with added functionality).  The port code should go into the
>> bridge driver dfl-fme-br.c.  There will need to be some new
>> functionality needed for fpga-bridge.c to be able to do what you want
>> - some way of making a reset function available for VF while
>> enable/disable is still available as PF for the fpga-region.c to
>> control.
>
> Understand, actually I have considered to move bridge creation from FME
> to Port, but it's facing the same problem as reset controller, as port
> platform device should be unregisted from system in virtualization case.
> Let me consider further to see if any better approach on this implementation.
> May be back to this thread later for discussion.

It appears that a lot of effort is going into working around the
current BBS limitations with regards to virtualization.  One direct
way for this all to move forward would be to defer virtualization
support for later.  That would involve moving the port code to
dfl-fme-br.c and adding resets to the fpga-bridge framework for the
AFU.  (Also add selection of low level mgr and br driver to DFL).
That gets something working that is modular, just doesn't include
virtualization for the moment.

Alan

>
> Thanks
> Hao
>
>>
>> Thanks,
>> Alan
>>
>> >
>> > Thanks
>> > Hao
>> >
>> >>
>> >> Alan
>> >>
>> >> >
>> >> > Thanks
>> >> > Hao
>> >> >
>> >> >>
>> >> >> Alan
>> >> >>
>> >> >> >
>> >> >> > Thanks
>> >> >> > Hao
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> Alan
>> >> >> >>
>> >> >> >> [1] https://lkml.org/lkml/2017/12/22/398
>> >> >> >> [2] https://patchwork.kernel.org/patch/10247475/
