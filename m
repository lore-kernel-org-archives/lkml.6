Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1536396-1522084931-2-11347922084632855550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522084930; b=nO2WikKC8QBQ3G8u0rxwBVKHkKRGRA2A6bVpWCMqhVb2iGJ
    Dz/vQ3OdKr9f0dvJWGBwQEjxELXzyZZhgEFEOYP1J9qSd59upuTWPFmw2SQE+5+0
    PLo2wEPUoLU+Qigjg++W8Sf9FKs+J2WK6V7PCj8QbyGpRRgzAiY1O1N4Qz7LVzad
    hbWon52xolB8iMqimCZ79zp/LxpInoKwt4x2HChFcoGDpxSqrvTB2J36eorAADg2
    y5QP5FbGVG2cDSHG+GTAbYp3p7IFsncIh4CNb9vBxIqZbtf+yEnjJZ3HXuVxscsL
    JyNh9j0J8hzEpF0LuEnykdnRF572MeZ5JH8eYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1522084930; bh=XiEyA98w3cubwRNINVfbuUSr9IgxnnUAUZLrlC
    DIeak=; b=f/s81UXV1Gjwmo+i7gh74YU8ymZLQnUWxRdFc5SoKEWPP5Fd8FaBPB
    RhcVx5eaB7HADNI/f16PomW64v+/awN7/XX73yhvnNNxi77Fw5+ms0Kxw7ncqCvu
    0Udv3vIx/yJbaORzBI/uPkR5UhT599wMVjqyqAv9BaZnnFBMJo+mOI7iDSarqDWP
    R2uwomm0q/VSX3oqIXrYzjBh7KJwKmKQEwzFrSAYTeGiLCcuFBa3WI1kmWiahlc5
    x5uCvcIwsl6/+1y2TGYgvaC6v8H8NlBymKKnfR2JwQBcPz7wPNlUA7k5lHZKqgfK
    DTn1vxqdzpeV7BJ2nPyYxPx/Swtyk0tg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHgkIg/DDxsgbqQPIFeA3yAeYvYsvyyAibvEKkVjw0EJ5sySG3lyIHWlOA+CwjOAmrIgLDbdK/VqtaRmKKw5aed/iKiCNbibWYKQk9J1Y94l2q1khAvO
    4WY1zBisVZ3kibsDmzM9TlvrJXxmh402iJoxrW90umw+EGy1CIKwK2hXcXGeh2Lte4uPXQa9Dtk4wfnE8RW7BaNeZ4d6TJ6YENOhtnMwIqFTT43DDRTbJlN7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=jNoIzjoSry1d3VJ1u5gA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeCZRWH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 13:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbeCZRWG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 26 Mar 2018 13:22:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D22172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELtbKGsvJKYHzEoaHfOdc56DzwZKMXlMQRcZPK5InZc9fRmE2gZbCJkjaR3RuhKXXzn+kCkSQyac4JZtQwwxn4M=
MIME-Version: 1.0
In-Reply-To: <20180323043304.GA14733@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-5-git-send-email-hao.wu@intel.com> <CANk1AXSaE3wQ7jnBkB0TR3kLKnG1XUeHk+LbDSxyRtBxbMNGPw@mail.gmail.com>
 <20180323043304.GA14733@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Mon, 26 Mar 2018 12:21:23 -0500
X-Gmail-Original-Message-ID: <CANk1AXRbBonnop6Q3=kdXHdZEBoO9cGa6sON7e0GvFwd_TnYfw@mail.gmail.com>
Message-ID: <CANk1AXRbBonnop6Q3=kdXHdZEBoO9cGa6sON7e0GvFwd_TnYfw@mail.gmail.com>
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

On Thu, Mar 22, 2018 at 11:33 PM, Wu Hao <hao.wu@intel.com> wrote:

>> > +
>> > +/*
>> > + * This function resets the FPGA Port and its accelerator (AFU) by function
>> > + * __fpga_port_disable and __fpga_port_enable (set port soft reset bit and
>> > + * then clear it). Userspace can do Port reset at any time, e.g during DMA
>> > + * or Partial Reconfiguration. But it should never cause any system level
>> > + * issue, only functional failure (e.g DMA or PR operation failure) and be
>> > + * recoverable from the failure.
>> > + *
>> > + * Note: the accelerator (AFU) is not accessible when its port is in reset
>> > + * (disabled). Any attempts on MMIO access to AFU while in reset, will
>> > + * result errors reported via port error reporting sub feature (if present).
>> > + */
>> > +static inline int __fpga_port_reset(struct platform_device *pdev)
>> > +{
>> > +       int ret;
>> > +
>> > +       ret = __fpga_port_disable(pdev);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       __fpga_port_enable(pdev);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static inline int fpga_port_reset(struct platform_device *pdev)
>> > +{
>> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> > +       int ret;
>> > +
>> > +       mutex_lock(&pdata->lock);
>> > +       ret = __fpga_port_reset(pdev);
>> > +       mutex_unlock(&pdata->lock);
>> > +
>> > +       return ret;
>> > +}
>>
>> I'm still scratching my head about how the enumeration code also has
>> code that handles resetting the PL in a FPGA region and
>> enabling/disabling the bridge.  We've discussed this before [1] and I
>> know you've looked into it, I'm still trying to figure out how this
>> can be made modular, so when someone needs to support a different port
>> in the future, it isn't a complete rewrite.
>>
>> Speaking of resets, one way forward would be to create a reset
>> controller for the port (and if possible move the port code to the
>> bridge platform driver).  The current linux-next repo adds support for
>> reset lookups, so that reset controllers are supported for non-DT
>> platforms [2].
>>
>> So the bridge driver would implement the enable/disable functions and
>> create a reset controller, the fpga-region (or whoever else needs it)
>> could look the reset controller and use the reset.  By using the
>> kernel reset framework, we don't have to have that piece of code
>> shared around by having a reset function in a .h file.  And it avoids
>> adding extra dependencies between modules.  Also, where necessary, I'd
>> rather add functionality to the existing bridge/mgr/region frameworks,
>> adding common interfaces at that level to allow reuse (like adding
>> status to fpga-mgr).  Ideally, this DFL framework would sit on top of
>> mgr and bridge and allow those to be swapped out for reuse of the DFL
>> framework on other devices.  Also it will save future headaches as mgr
>> or port implementations evolve.
>
> Thanks a lot for the suggestion. I really really appreciate this.

Yes, this is a good discussion, thanks.

>
> Actually if we consider the virutalization case as I mentioned in [1] below,
> that means AFU and its Port will be turned into a PCI VF and assigned (passed
> through) to a virtual machine. There is no FME block on that PCI VF device,
> (the FME is always kept in PCI PF device in the host) and currently the bridge
> is created by FME module for PR functionatily. So in the guest virtual machine,
> nobody creates the reset controller actually.
>
> As I mentioned in [1], one possible method is, put these port reset functions to
> AFU (Port) module, and share those functions with FME bridge module.

Yes, the port reset functions could move into an AFU driver, and then
also the AFU driver could also create a reset controller and register
a lookup [2] for the reset.  That would be just a few lines of code.
The reset controller would control enabling/disabling the port.  The
bridge driver could get the reset controller to use during FPGA
programming.  That is instead of sharing a reset function with the
bridge driver.   It decouples the FPGA bridge driver and simplifies it
to be something that just needs to control a reset instead of needing
to include a specific .h file that makes  a port reset function
available.

> I think
> that will make the code in the common DFL framework a little more clean,

Yes, IIUC that may also make it easier as the port/AFU gets added
functionality that is intended to be controlled by the VF anyway
(while the only port-related thing that is needed by the FME is port
enable/disable).

> but it
> will introduce some module dependency here for sure, (e.g FME modules can't
> finish PR without AFU (Port) Module loaded).

That sounds like an OK type of dependency, i.e. if the modules are not
all loaded, it doesn't work. :-)

> But anyway it may be still
> acceptable for users as all these modules could be loaded automatically. How do
> you think? :)

The other thing I want to get right now is if there is a different
AFU/port that needs a different driver.  Can the DFL be changed to
specify what AFU/port to load?  I really really want to avoid large
code rewrites in the future that we can anticipate now.  Such as
someone implements their own static image, it has DFL, but the port is
somewhat different.  Instead of seeing features as just something that
gets added, the DFL also specifies what port driver and mgr driver to
load.  The stuff we discussed above is a good step towards that, but
not all of it.

Alan

>
> Thanks
> Hao
>
>
>>
>> Alan
>>
>> [1] https://lkml.org/lkml/2017/12/22/398
>> [2] https://patchwork.kernel.org/patch/10247475/
