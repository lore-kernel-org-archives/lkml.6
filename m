Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4967-1517891173-2-5543976335298055357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517891173; b=lurg9MyPW9nH0auDzqg/rB7tTTxE9M0R/Gy1mhvNIv8yo7O
    uPdzF9v9G7BGm17puEtCa26Vgz9GMvJONbsAzLpqSIkhwcMYqveBwI3QKrZ69EEa
    SWHFIMxusqjR49IvgU4d8AC05BsaOMuTTtZ+q72hYMiZtnanieX0CDaxEDnn3uyp
    N6Ri7uu6mvps1T0syHzq6ac0Ml3z4jFM4xCQC0omRUY9N1ec4jroJAOvk2xDvdfD
    UmBFFhu0Z30AXNBsPdY6IuiT8BO9GIBYybB1ixczOF/b8CX2wT4oaAhSvRAguAgy
    PYWqR8+oAgbM2zlsaQOQdXu35CEFGAfkNEBJ10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517891173; bh=OMH2j3H8VwKU3BAkpkGvxEMW0aUsmyf/ONb8+L
    UQ9F0=; b=dyKCICiZemb+sMa57lB5R2aikWPdEWf77xSZue1Mdu/AXnEgfTo8xo
    iRO3F3U0NVm9PmQNdcZrjhqmoBCQLNz8uN/Yo5ndLAydLIPkmtGcmDIf5ji1IEYt
    866Ha3CKUcakNMTiyLiK6Z8tdTNWmdrb/N+yGIwAa2IKFeYSNCubg6w245O1OOnP
    lBBfYke9DK6Bu5eVuVxvsJVycggNYcWt1599Ai4gXwaKT3BSpAFGPQKPdbaQ+gyv
    RwSylA8cC7AzG6V18rcToMutV0CWZPQ3ktIoFiehMM4aPTh4FqlT8quqMiud8XsJ
    Kidj17JzT8hU9VGRQz9Pzj0mk2zz5Knw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeBFE0K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 23:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbeBFE0K (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Feb 2018 23:26:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CC9217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x224shXEVgzVq1oBhW3hOm2/R/Vs3kaKHfqvG+BaOWP6pXIB3wrnGvkK9SWJEf55ZtcKuIDpiCBBD3JGHlL5EKHQ=
MIME-Version: 1.0
In-Reply-To: <20180206021756.GA3971@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-15-git-send-email-hao.wu@intel.com> <CANk1AXS-ON+Pcxtk-AY1XxH8Paw2aFBjiqhuCz7cA4cyuAQMUA@mail.gmail.com>
 <20180202094213.GB17015@hao-dev> <20180203002626.GA51125@eluebber-mac02.jf.intel.com>
 <20180203104124.luniynyrr6iwxozd@derp-derp.local> <20180204100546.GB26184@hao-dev>
 <CANk1AXRxkUqPqknzb+-apvjZM6MFRom9fscHPmMc8MTYSLpooA@mail.gmail.com> <20180206021756.GA3971@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Mon, 5 Feb 2018 22:25:27 -0600
X-Gmail-Original-Message-ID: <CANk1AXTYtLu_cnKG75FjBRCf5FAoHFj6saNRncYPjQpJoXd1eg@mail.gmail.com>
Message-ID: <CANk1AXTYtLu_cnKG75FjBRCf5FAoHFj6saNRncYPjQpJoXd1eg@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] fpga: dfl: add fpga manager platform driver for FME
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>,
        "Luebbers, Enno" <enno.luebbers@intel.com>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 8:17 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Mon, Feb 05, 2018 at 11:21:52AM -0600, Alan Tull wrote:
>> On Sun, Feb 4, 2018 at 4:05 AM, Wu Hao <hao.wu@intel.com> wrote:
>> > On Sat, Feb 03, 2018 at 11:41:24AM +0100, Moritz Fischer wrote:
>> >> Hi Hao,
>> >>
>> >> On Fri, Feb 02, 2018 at 04:26:26PM -0800, Luebbers, Enno wrote:
>> >> > Hi Hao, Alan,
>> >> >
>> >> > On Fri, Feb 02, 2018 at 05:42:13PM +0800, Wu Hao wrote:
>> >> > > On Thu, Feb 01, 2018 at 04:00:36PM -0600, Alan Tull wrote:
>> >> > > > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
>> >> > > >
>> >> > > > Hi Hao,
>> >> > > >
>> >> > > > A few comments below.   Besides that, looks good.
>> >> > > >
>> >> > > > > This patch adds fpga manager driver for FPGA Management Engine (FME). It
>> >> > > > > implements fpga_manager_ops for FPGA Partial Reconfiguration function.
>> >> > > > >
>> >> > > > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
>> >> > > > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> >> > > > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
>> >> > > > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
>> >> > > > > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
>> >> > > > > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> >> > > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
>> >> > > > > ----
>> >> > > > > v3: rename driver to dfl-fpga-fme-mgr
>> >> > > > >     implemented status callback for fpga manager
>> >> > > > >     rebased due to fpga api changes
>> >> > > > > ---
>> >> > > > >  .../ABI/testing/sysfs-platform-fpga-dfl-fme-mgr    |   8 +
>> >> > > > >  drivers/fpga/Kconfig                               |   6 +
>> >> > > > >  drivers/fpga/Makefile                              |   1 +
>> >> > > > >  drivers/fpga/fpga-dfl-fme-mgr.c                    | 318 +++++++++++++++++++++
>> >> > > > >  drivers/fpga/fpga-dfl.h                            |  39 ++-
>> >> > > > >  5 files changed, 371 insertions(+), 1 deletion(-)
>> >> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr
>> >> > > > >  create mode 100644 drivers/fpga/fpga-dfl-fme-mgr.c
>> >> > > > >
>> >> > > > > diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr
>> >> > > > > new file mode 100644
>> >> > > > > index 0000000..2d4f917
>> >> > > > > --- /dev/null
>> >> > > > > +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr
>> >> > > > > @@ -0,0 +1,8 @@
>> >> > > > > +What:          /sys/bus/platform/devices/fpga-dfl-fme-mgr.0/interface_id
>> >> > > > > +Date:          November 2017
>> >> > > > > +KernelVersion:  4.15
>> >> > > > > +Contact:       Wu Hao <hao.wu@intel.com>
>> >> > > > > +Description:   Read-only. It returns interface id of partial reconfiguration
>> >> > > > > +               hardware. Userspace could use this information to check if
>> >> > > > > +               current hardware is compatible with given image before FPGA
>> >> > > > > +               programming.
>> >> > > >
>> >> > > > I'm a little confused by this.  I can understand that the PR bitstream
>> >> > > > has a dependency on the FPGA's static image, but I don't understand
>> >> > > > the dependency of the bistream on the hardware that is used to program
>> >> > > > the bitstream to the FPGA.
>> >> > >
>> >> > > Sorry for the confusion, the interface_id is used to indicate the version of
>> >> > > the hardware for partial reconfiguration (it's part of the static image of
>> >> > > the FPGA device). Will improve the description on this.
>> >>
>> >> I'm not sure userland should be making the call on whether what you're
>> >> trying to load is compatible or not.
>>
>> Could you explain more about what your concern was about this (unless
>> Hao has covered it below)?
>>
>> It makes sense to me in this use case at least since userspace has a
>> pile of images and is choosing which one to load.
>>
>> >> Isn't there a way to check this in
>> >> your PR reconfiguration handler in-kernel?
>> >
>> > Hi Moritz
>> >
>> > Actually with current driver interface, doing a partial reconfiguration with an
>> > incompatible image, then driver will report PR failure with error code
>> > FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR as hardware checks it, but anyway user
>> > needs to know hardware interface_id information to find or re-generated correct
>> > images. I think it's more flexible to leave it to userspace on using this
>> > information exposed by driver. : )
>> >
>> > Thanks
>> > Hao
>> >
>> >>
>> >> > >
>> >> >
>> >> > The interface_id expresses the compatibility of the static region with PR
>> >> > bitstreams generated for it. It changes every time a new static region is
>> >> > generated.
>>
>> In the near future the DFL framework will be used with SoC's that have
>> a hard FPGA PR manager (that's not part of the static region).  The
>> hard FPGA manager driver won't know anything about the static region.
>>
>> >> >
>> >> > Would it make more sense to have the interface_id exposed as part of the FME
>> >> > device (which represents the static region)? I'm not sure - it kind of also
>> >> > makes sense here, where you would have all the information in one place (if the
>> >> > interface_id matches, I can use this component to program a bitstream).
>>
>> According to the intel-fpga.txt document, the identifier for the
>> static image is at
>>
>> /sys/class/fpga_region/regionX/fpga-dfl-fme.n/bitstream_id
>
> Hi Alan

Hi Hao,

>
> This bitstream_id refects the full static region version. As you know, PR is
> only a sub feature of the FME functional unit, it's possible that we have
> different static region (different bitstream_id) but it has the exact same
> PR sub feature under the FME, only changes on other sub features or function
> units.

OK, thanks for that explanation.  That makes sense but could have
easily been different.  Please document this somewhere.

Alan
