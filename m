Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518515684-2-11085593691024694694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518515684; b=NLpIT6KMcU+D8szxHnVd5hhSn31TcnLzY5u5WlZzNLATyyr
    qaKpqbWxxE0NHAqN4k+tARAXIR5foUgkZxTAyOkcTz1HfkTRKVbeJL5/nHfT5g7k
    XNmCbiFZvSWbvGls6eEL6+XLCDNO4FtwqL/LD18ZRS/qojoJitSDRlAeKYXoAik3
    KagBTroElyQr8LclnT3BiqaTorkoU23qkizerfyHF1CN+g7qd6zH/Rb4KrOnkJBQ
    kPmsY5KMMNCzGJYbdBl7aYg95Os0UrhGWmLtJ99ThSAQpUJjhPGBuY18vBP4cUDd
    2MwIfZxyVMwhWgrkcUjNdW1Ldzf+NHJ94OrXiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518515684; bh=o5lSn/CT7T9dp/NvsgfLkfhIW7
    YDQW4MlU3GHoTvZoI=; b=mH9Pac3gFQnLEm1aWUs4hb/J7FHhG9waqllUoUetzD
    bPLsOEf5m2vhipPZ0jt+T6KQ1neeo3hj+nzVxQvjQU2SF+/d2HWvbPvP7dbA8dId
    rklhPnsRdniL8p1Am2ftq0SOcJ92S0cFMx8H/ayxC94fJm/kNcDWInIvi2bB7wgE
    KgAuUEVpkRRWCxAyF9x8gEMpirCYeAMk8uFztuYlqeUCr+xlRZgHocq3Y0vs22OV
    ZO5S83gCLHukJJ2wuTQBoq+C4m9XkYKtxPp+24wc4IRLYK8B4rV2OOyLy2kbvJ4N
    FCDFcGK8Mu/5m08vGhPtyyzLJmU2PYNoPNNFukc5WDRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934352AbeBMJpo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:45:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:36969 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933860AbeBMJpk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:45:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="34283649"
Date: Tue, 13 Feb 2018 17:36:08 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "luwei.kang@intel.com" <luwei.kang@intel.com>,
        "yi.z.zhang@intel.com" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v3 08/21] fpga: add Intel FPGA DFL PCIe device
Message-ID: <20180213093608.GA4809@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-9-git-send-email-hao.wu@intel.com>
 <f5ae8e5edf88420e89cfbe754407b92e@AcuMS.aculab.com>
 <20171128031519.GA25705@hao-dev>
 <CANk1AXRBEcz5_j+v0oTAXfH10hrPbHGabdR8Pqt07exYxYgfCw@mail.gmail.com>
 <20171205033330.GA19730@hao-dev>
 <CANk1AXRdU6usqtsCUjjSC8Fk2SS8iKn+Ow4PvCiRpSBAcDwWjw@mail.gmail.com>
 <20171206053015.GA19023@hao-dev>
 <CANk1AXS6xa8FTBTk5Q2PWcijb1Uuy=XFAFFin-R2dU2y-iruvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS6xa8FTBTk5Q2PWcijb1Uuy=XFAFFin-R2dU2y-iruvw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:59:21PM -0600, Alan Tull wrote:
> On Tue, Dec 5, 2017 at 11:30 PM, Wu Hao <hao.wu@intel.com> wrote:
> > On Tue, Dec 05, 2017 at 11:00:22AM -0600, Alan Tull wrote:
> >> On Mon, Dec 4, 2017 at 9:33 PM, Wu Hao <hao.wu@intel.com> wrote:
> >> > On Mon, Dec 04, 2017 at 01:46:59PM -0600, Alan Tull wrote:
> >> >> On Mon, Nov 27, 2017 at 9:15 PM, Wu Hao <hao.wu@intel.com> wrote:
> >> >> > On Mon, Nov 27, 2017 at 10:28:04AM +0000, David Laight wrote:
> >> >> >> From: Wu Hao
> >> >> >> > Sent: 27 November 2017 06:42
> >> >> >> > From: Zhang Yi <yi.z.zhang@intel.com>
> >> >> >> >
> >> >> >> > The Intel FPGA device appears as a PCIe device on the system. This patch
> >> >> >> > implements the basic framework of the driver for Intel PCIe device which
> >> >> >> > is located between CPU and Accelerated Function Units (AFUs), and has
> >> >> >> > the Device Feature List (DFL) implemented in its MMIO space.
> >> >> >>
> >> >> >> This ought to have a better name than 'Intel FPGA'.
> >> >> >> An fpga can be used for all sorts of things, this looks like
> >> >> >> a very specific architecture using a common VHDL environment to
> >> >> >> allow certain types of user VHDL be accessed over PCIe.
> >> >> >
> >> >> > Hi David
> >> >> >
> >> >> > This patch adds a pcie device driver for Intel FPGA devices which implements
> >> >> > the DFL, e.g Intel Server Platform with In-package FPGA and Intel FPGA PCIe
> >> >> > Acceleration Cards. They are pcie devices, and all have DFL implemented in
> >> >> > the MMIO space, so we would like to use one kernel driver to handle them.
> >> >> >
> >> >> > With this full patchset, it just provides user the interfaces to configure
> >> >> > and access the FPGA accelerators on Intel DFL based FPGA devices. For sure,
> >> >> > users can develop and build their own logics via tools provided by Intel,
> >> >> > program them to accelerators on these Intel FPGA devices, and access them
> >> >> > for their workloads.
> >> >>
> >> >> I don't see anything Intel specific here.  This could all be named dfl-*
> >> >
> >> > The maybe some device specific things, e.g Intel FPGA devices supported by this
> >> > driver always have FME DFL at the beginning on the BAR0 for PF device.
> 
> I'm thinking that another user could add their PCI id's and a static
> FPGA image that has a DFL in the right place for this to work for
> them.
> 
> >> >
> >> > But I think this should be the right direction for better code reuse, it could
> >> > save efforts for other vendors who want to use DFL and follow the same way.
> 
> I appreciate your understanding here.
> 
> >> >
> >> > Thanks for the comments. I will rename this driver in the next version.
> >>
> >> Thanks!
> >>
> >> Regarding file names, it seems like the files added to drivers/fpga
> >> could be uniformly named dfl-*.[ch].  Some are fpga-dfl-*.[ch] while
> >> other are currently dfl-*.[ch] currently.
> >
> > Sure, will have all related drivers files renamed to dfl-*.[ch].
> 
> Actually, I'll reverse that a bit.  The enumeration code, including
> the pcie part is all sufficiently general to run on anything that has
> a DFL struct located in the right place.  But individual feature
> drivers (currently only the fme-mgr) will be vendor specific and could
> be named intel-*.

Hi Alan,

I unified all the drivers to use dfl-* in the v4 patchset, including fme-mgr.
As I feel it's hard to say which FME functions (sub features, registers) are
vendor specific and which FME functions are not, from the spec, they all belong
to FME, and people can be reused for sure. So I didn't rename it back to Intel
driver in the v4 patchset. :)

Thanks
Hao


> 
> Alan
