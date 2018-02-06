Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1871329-1517943271-2-16549579904557445800
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
    t=1517943270; b=DS9M63wM18jAxSuMVsMAo978pgP5/9QE0zp+DPKpi8+BnYV
    M7YFhMPgCCroCxfNAVn4qqBVodjE9xvuRocal/2g10CaVnG9VU4UfWz//eMu5MxN
    dcAmSPQdFRbzMPc3rLQeXFAl9cbF06BB6qD/cYGbWaC4x8XfE6SOgjKdqtaKGktP
    R7m7UC3E3glsdYa6K7PuxR0QUusBDtZyAED+Qysan326gVeWIwIXV5kag4K8PEnP
    xSopGGTpgnx9qWiZ567UsxstyuipGLzJOjNo/jArZa7U6v2PZAewcJl7CuYkNg1A
    1eH2HFVEizOh/FksyG0YxB2KSJofV8mzosLSmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517943270; bh=xp2wIv+/ajqGxSHXqEHvU81Jmj/MQuNfI9cTsB
    F66Bg=; b=MmIcqRdF8gKHe36CNykBwPEQejcwcpxgHrhvc+RuJ01UZGu5YM/gH/
    lGEIM9+yKOjPvo5v6VOvfGDavaQ8brgyd0IQzsjGAvz0NqGZhBHQPpuy07OOPp2Y
    h6bKpowbNLk39LEmvpyv/ONBUtpKN0OsoR/vGJidurPSmKv7rG9ipjcWkyo50c+o
    PGc5KBrml9h2eEqSLtVv4NkJh4AmtMx7QqzRPXDz7GYevZBwy/ZmUkWKi+is5uMx
    nM/s+AIKnHcfwR0Dfd39L/2p6j5EZsO+hWJ7ayQOEixz7O/fTE/dN6wLKg7kCNsN
    5JcLe/kDuUvnkH5QzcV2Rvh7F6GnAW2A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeBFSy2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 13:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753026AbeBFSy1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 6 Feb 2018 13:54:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6763F2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x227TfEx6sCYBDuoUFaBCvFmqAqL/O+KfBEiWzK6ROs1w9kHxwZPfdRlhMqZCkcSgDOjj4cNh0cU8n1XKzkglCtE=
MIME-Version: 1.0
In-Reply-To: <20180206064706.GB4882@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-15-git-send-email-hao.wu@intel.com> <CANk1AXS-ON+Pcxtk-AY1XxH8Paw2aFBjiqhuCz7cA4cyuAQMUA@mail.gmail.com>
 <20180202094213.GB17015@hao-dev> <20180203002626.GA51125@eluebber-mac02.jf.intel.com>
 <20180204093706.GA26184@hao-dev> <20180205183644.GA52136@eluebber-mac02.local>
 <20180206014700.GA3883@hao-dev> <CANk1AXRe85Ns1_cUPdn02yS9Gc6i5cYYhko7snvjfzxQSzUzNA@mail.gmail.com>
 <20180206064706.GB4882@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Tue, 6 Feb 2018 12:53:44 -0600
X-Gmail-Original-Message-ID: <CANk1AXRe2hN6zQENmm_Try63S3qQr6FHg=x2J6GLam7oNZp9xw@mail.gmail.com>
Message-ID: <CANk1AXRe2hN6zQENmm_Try63S3qQr6FHg=x2J6GLam7oNZp9xw@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] fpga: dfl: add fpga manager platform driver for FME
To: Wu Hao <hao.wu@intel.com>
Cc: "Luebbers, Enno" <enno.luebbers@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
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

On Tue, Feb 6, 2018 at 12:47 AM, Wu Hao <hao.wu@intel.com> wrote:
> On Mon, Feb 05, 2018 at 10:25:54PM -0600, Alan Tull wrote:
>> On Mon, Feb 5, 2018 at 7:47 PM, Wu Hao <hao.wu@intel.com> wrote:
>> > On Mon, Feb 05, 2018 at 10:36:45AM -0800, Luebbers, Enno wrote:
>> >> Hi Hao,
>> >>
>> >> On Sun, Feb 04, 2018 at 05:37:06PM +0800, Wu Hao wrote:
>> >> > On Fri, Feb 02, 2018 at 04:26:26PM -0800, Luebbers, Enno wrote:
>> >> > > Hi Hao, Alan,
>> >> > >
>> >> > > On Fri, Feb 02, 2018 at 05:42:13PM +0800, Wu Hao wrote:
>> >> > > > On Thu, Feb 01, 2018 at 04:00:36PM -0600, Alan Tull wrote:
>> >> > > > > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
>> >> > > > >
>> >> > > > > Hi Hao,
>> >> > > > >
>> >> > > > > A few comments below.   Besides that, looks good.
>> >> > > > >
>> >> > > > > > This patch adds fpga manager driver for FPGA Management Engine (FME). It
>> >> > > > > > implements fpga_manager_ops for FPGA Partial Reconfiguration function.
>> >> > > > > >
>> >> > > > > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
>> >> > > > > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> >> > > > > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
>> >> > > > > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
>> >> > > > > > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
>> >> > > > > > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> >> > > > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
>> >> > > > > > ----
>> >> > > > > > v3: rename driver to dfl-fpga-fme-mgr
>> >> > > > > >     implemented status callback for fpga manager
>> >> > > > > >     rebased due to fpga api changes
>> >> > > > > > ---
>> >> > > > > >  .../ABI/testing/sysfs-platform-fpga-dfl-fme-mgr    |   8 +
>> >> > > > > >  drivers/fpga/Kconfig                               |   6 +
>> >> > > > > >  drivers/fpga/Makefile                              |   1 +
>> >> > > > > >  drivers/fpga/fpga-dfl-fme-mgr.c                    | 318 +++++++++++++++++++++
>> >> > > > > >  drivers/fpga/fpga-dfl.h                            |  39 ++-
>> >> > > > > >  5 files changed, 371 insertions(+), 1 deletion(-)
>> >> > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr
>> >> > > > > >  create mode 100644 drivers/fpga/fpga-dfl-fme-mgr.c
>> >> > > > > >
>> >> > > > > > diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr
>> >> > > > > > new file mode 100644
>> >> > > > > > index 0000000..2d4f917
>> >> > > > > > --- /dev/null
>> >> > > > > > +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme-mgr
>> >> > > > > > @@ -0,0 +1,8 @@
>> >> > > > > > +What:          /sys/bus/platform/devices/fpga-dfl-fme-mgr.0/interface_id
>> >> > > > > > +Date:          November 2017
>> >> > > > > > +KernelVersion:  4.15
>> >> > > > > > +Contact:       Wu Hao <hao.wu@intel.com>
>> >> > > > > > +Description:   Read-only. It returns interface id of partial reconfiguration
>> >> > > > > > +               hardware. Userspace could use this information to check if
>> >> > > > > > +               current hardware is compatible with given image before FPGA
>> >> > > > > > +               programming.
>> >> > > > >
>> >> > > > > I'm a little confused by this.  I can understand that the PR bitstream
>> >> > > > > has a dependency on the FPGA's static image, but I don't understand
>> >> > > > > the dependency of the bistream on the hardware that is used to program
>> >> > > > > the bitstream to the FPGA.
>> >> > > >
>> >> > > > Sorry for the confusion, the interface_id is used to indicate the version of
>> >> > > > the hardware for partial reconfiguration (it's part of the static image of
>> >> > > > the FPGA device). Will improve the description on this.
>> >> > > >
>> >> > >
>> >> > > The interface_id expresses the compatibility of the static region with PR
>> >> > > bitstreams generated for it. It changes every time a new static region is
>> >> > > generated.
>> >> > >
>> >> > > Would it make more sense to have the interface_id exposed as part of the FME
>> >> > > device (which represents the static region)? I'm not sure - it kind of also
>> >> > > makes sense here, where you would have all the information in one place (if the
>> >> > > interface_id matches, I can use this component to program a bitstream).
>> >> >
>> >> > Hi Enno
>> >> >
>> >> > Yes, this interface is under fpga-dfl-fme-mgr.0, and fpga-dfl-fme-mgr.0 is
>> >> > under fpga-dfl-fme.0. It's part of the FME device for sure. From another
>> >> > point of view, it means if anyone wants to do PR on this Intel FPGA device,
>> >> > he needs to find the FME device firstly, and then check if any fpga manager
>> >> > created under this FME device, if yes, check the interface_id before PR via
>> >> > the FME device node ioctl.
>> >>
>> >> That sounds good, thank you!
>> >>
>> >> >
>> >> > >
>> >> > > Sorry for my limited understanding of the infrastructure - would this same
>> >> > > "fpga-dfl-fme-mgr.0" be used for PR if we had multiple PR regions? In that case
>> >> > > it would need to expose multiple interface_ids (or we'd have to track both
>> >> > > interface IDs and an identifier for the target PR region).
>> >> >
>> >> > Yes, the fpga manager could be shared with different PR regions.
>> >> >
>> >> > Sorry, I'm not sure where we need to expose multiple interface_ids and why.
>> >>
>> >> It's basically a question of how to determine bitstream compatibility - either,
>> >> there's a separate interface_id per reconfigurable region, or there is a single
>> >> interface_id for the entire device. Both make sense from a certain perspective.
>> >>
>> >> If there are multiple interface_ids per device (one per region), the driver
>> >> would need to expose all of them. If there's only a single one, the driver only
>> >> exposes that one ID - compatibility would be determined by looking at both that
>> >> single interface_id _and_ the identifier/number of the targeted region.
>> >>
>> >> I would prefer a separate interface_id per region - it seems more generic and
>> >> flexible.
>>
>> Hi Enno,
>>
>> I agree with this.
>>
>> >
>> > It's possible to have per region interface_id (or even both per dev interface_id
>> > and per region interface_id at the same time), but per FME PR sub feature
>> > implementation, it supports multiple PR regions, but only provide one interface
>> > id, so at least in this case, it's not per-region information per my
>> > understanding. We can consider it later when hardware really supports it. : )
>>
>> Hi Hao,
>>
>> I understand that in the case of this PR hardware, the region to
>> program is selected when the region_id to program is written to a PR
>> hardware control register.  For another example, Arria10 has a hard PR
>> hardware and the PR bitstream lands in the area of the FPGA for which
>> it was compiled.  In that case, for the PR bitstream to be compatible
>> with a PR region, the layout of the edge connections also needs to be
>> compatible, so compatibility is per-region in that case instead of
>> per-PR hardware.
>
> Hi Alan,
>
> Thanks a lot for the explanation. :)
>
> I fully understand the consideration of adding per-region interface_id.
>
>> And besides, as I said yesterday, the hard PR
>> hardware would not know what the static region ID is when this
>> framework is used with such a device.
>
> Yes, is it possible that hard PR hardware with different versions, requires
> different images or different methods for compatibility checking?

Because it is really hardware and not something in the FPGA fabric,
the hard PR hardware isn't going to change versions very often.  It
has to be designed to be flexible and not add any constraints on the
PR regions.  If some feature is added or a bug is fixed, that's just a
driver issue at most and should not affect PR region compatibility.
PR region compatibility would only be dependent on the static FPGA
image and the regions that are created in it.  It could be exported in
terms of a single static region ID or per-region ID.

>
>>
>> That's why I think making the id per-region may be more future proof,
>> even if it may see unnecessary in the case of the original blue bits
>> this was written for.
>
> I feel that per-PR hardware interface id is useful in some cases, and maybe
> in some cases, both per-PR hardware and per-region interface ids are needed
> for its compatibility checking, so shall we leave developers to decide to
> implement per-PR hardware or per-region or both interface ids based on their
> own hardware implementations? How do you think? :)

That gives us 3 sets of id's.  Seems overly complicated and the
userspace would have to figure out which set of id's to use.  I want
to see an interface that isn't more complicated than it needs to be
but still can be expected to be ok for the future (as far as we can
anticipate).

Would per-region id's cause any problems that you can see?  I
understand that the region id's would all be the same value for a
given PR hardware in your use case, but that doesn't seem like it
would be hard to implement or that it opens up some possible failure.

Alan
