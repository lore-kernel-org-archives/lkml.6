Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3314020-1519920340-8-5679724984904461474
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
    t=1519920339; b=Jb76/2cW5OTbFV8t25rGDCZi4uHxzMTN0vzR28MGRAk/X/H
    RDpND3MLi/xRHcgtw0giLVzdLiLUAe3fzbjrfwb3QRJG2OgHxtMHr1MKi3rOFj0a
    pAFN/mYP2DL8wn/VKgpvtYzZUjSz7F+rBv7avbw1xkDT6KCWALhIxVoeMNgYUHrz
    8EoM0+o71grjyDmJ0INx9l24QmZkxUKsj2MDjjnvtG0Sou4G7eethwor28l1c5T6
    GyLs7AT9OGtUZd1PHQXHb58qDDBvcMm/i2KdPQfGZ+Gew5s//xBLXk7gV6gwrA9S
    e7cJydFyax5/KyaKSCrilMgBUjFhQXC1OFJjY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519920339; bh=htui7muR2H0kYcO41TlU9/we2S
    BEvo6FZ7lrzgjVRms=; b=Ad/VYhfUsvBs1dTI567FY7KDzG7UXxtN6nEp0Fm8xR
    MfwBPeyK9fP9c7Ut8/V9S6glsEtV7lJDaEezQmEwUpgcN27eBywjIJL0D9Lkc7Qd
    F2favQemHcfImNSpBNICexklLWT1b1HE5PIvhS7w4dCtAgEuERWS6Vo+IHI/tlFN
    RGPw9so52/EbrvpajZ0KJ8qu/u6LwfvhYSmDkRQo3au7htEjouydJ53fOwk8JRlp
    LFS6WDySIAHFNkgONFmNiRFA65BPbixmbQbl5qv3F/G3iV54sBfUiCf9msUBgQ9o
    GYFcH82CUHkoRqv5ICKJ1RSDsL4QCB7/TKEsaZqSQVdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032143AbeCAQEw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 11:04:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:50433 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032700AbeCAQEu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 11:04:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="21337346"
Date: Thu, 1 Mar 2018 23:55:06 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v4 15/24] fpga: dfl-fme-pr: add compat_id support for
 dfl-fme-region platform device.
Message-ID: <20180301155506.GA13141@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-16-git-send-email-hao.wu@intel.com>
 <CANk1AXR9473+QqjF=R2JqqJGPB_XH9k+2qDhh68hN=5Fq4E7uw@mail.gmail.com>
 <20180301054935.GA8999@hao-dev>
 <CANk1AXRp_oKnLemFS4C7MgJwyFsjOUxgbYN0=S5wdSiUP9iM0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRp_oKnLemFS4C7MgJwyFsjOUxgbYN0=S5wdSiUP9iM0g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 09:59:16AM -0600, Alan Tull wrote:
> On Wed, Feb 28, 2018 at 11:49 PM, Wu Hao <hao.wu@intel.com> wrote:
> > On Wed, Feb 28, 2018 at 05:06:57PM -0600, Alan Tull wrote:
> >> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> >> > +
> >> > +       compat_id.id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
> >> > +       compat_id.id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> >>
> >> I tried building for 32 bit ARM and ran into readq and writeq not
> >> being defined.  v2 had proper '#indef readq/writeq', so looks like we
> >> need that after all.
> >
> > Sorry, it's missing a header file for dfl-fme-pr.h, as some files don't include
> > dfl.h at this version. That header file has definitions for readq/writeq.
> >
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> >
> > will fix it.
> 
> Hi Hao,
> 
> That sounds good.  I was able to build if I added it.  There are a
> couple issues in the enumeration code:
> 
> In file included from
> /home/atull/repos/linux-socfpga/include/linux/kernel.h:11:0,
>                  from /home/atull/repos/linux-socfpga/include/linux/list.h:9,
>                  from /home/atull/repos/linux-socfpga/include/linux/module.h:9,
>                  from /home/atull/repos/linux-socfpga/drivers/fpga/dfl.c:13:
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl.c: In function
> 'parse_feature_list':
> /home/atull/repos/linux-socfpga/include/linux/bitops.h:7:24: warning:
> left shift count >= width of type [-Wshift-count-overflow]
>  #define BIT(nr)   (1UL << (nr))
>                         ^
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl.h:73:19: note: in
> expansion of macro 'BIT'
>  #define DFH_EOL   BIT(40)   /* End of list */
>                    ^
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl.c:643:12: note: in
> expansion of macro 'DFH_EOL'
>    if ((v & DFH_EOL) || !ofst)
>             ^
> 
> and
> 
>   CC      drivers/fpga/dfl-fme-mgr.o
> In file included from
> /home/atull/repos/linux-socfpga/include/linux/kernel.h:11:0,
>                  from /home/atull/repos/linux-socfpga/include/linux/list.h:9,
>                  from
> /home/atull/repos/linux-socfpga/include/linux/kobject.h:19,
>                  from /home/atull/repos/linux-socfpga/include/linux/device.h:16,
>                  from
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl-fme-pr.c:20:
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl-fme-pr.c: In function
> 'pr_mgmt_init':
> /home/atull/repos/linux-socfpga/include/linux/bitops.h:7:24: warning:
> left shift count >= width of type [-Wshift-count-overflow]
>  #define BIT(nr)   (1UL << (nr))
>                         ^
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl.h:113:27: note: in
> expansion of macro 'BIT'
>  #define FME_PORT_OFST_IMP BIT(60)
>                            ^
> /home/atull/repos/linux-socfpga/drivers/fpga/dfl-fme-pr.c:449:23:
> note: in expansion of macro 'FME_PORT_OFST_IMP'
>    if (!(port_offset & FME_PORT_OFST_IMP))

Hi Alan

I think it needs to use BIT_ULL instead of BIT.
will fix them in the next version.

Thanks
Hao

>                        ^
> Alan
> 
> 
> >
> > Thanks
> > Hao
> >
> >> Alan
