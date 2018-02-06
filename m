Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970300-1517885192-2-1254897509842725436
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
    t=1517885191; b=tN4RU2wM1CO59LPF/J+dL6iMIB2urvNzMxowNw7cG2O6G4p
    86v01MNoFBxGGEsyoSnS9k7FiLC4IShng+dYeRfwIXO/IQCzQG8dXAyiB4mqmyLU
    1oMpioxT4Y3dJq2bLO2Ufd+ZZFrDubATFJ3hjb85Zs0x2IplLID6ILWF387LuV0e
    BkbMxROt5UZaipz6y4LqznE9+wLNf/lHT7c7FmypRnvSDUUcy8ARhmQ813041lQs
    EE0hiyUXf/182Uy5jyqub8S8djL7GTB1p+4FSdUx0yWVO2SD1gZdLvWj4VRRWG+G
    q498k8Bpd5M4/DGwPB62yynnp2knN5wNstHgGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517885191; bh=8k5Yh5JUNUJlo0ZerzeXuWuNhz
    62diX3gQQcajo1Eio=; b=SRfYOz/DuZkUFgYOIvx6pdWBrkv0TUiY6OyvYhDlrS
    YA/T4NDzcukcJYJw9w/QrbrlUlWC2H5c9Z/gy7Zbh6Dhgqel/aIiolELVhvpKwPo
    JFrm13OkuARKHtKaQy9WlwGPXWuld8HqL/H5WbSdKUbswnZfUU7lXiptrKnRV2IG
    pOCj6ukdfbRCRw3zqg/oS4BGp5QM0T7Nb48XXpRUbaHxV5QgLxYc9vXiE+FYQGSe
    blrZPO+cCv5RgvDexc6tG15ICzuHCwQNHYEPHSJgCxdq28rJIwfAtrBuXMy5IXjz
    poB1kGPzG1q8RbAPvjIY8/xoespIVLousLVM7PeaJgyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbeBFCq2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 21:46:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:41436 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeBFCq1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Feb 2018 21:46:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="201497539"
Date: Tue, 6 Feb 2018 10:37:02 +0800
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
Subject: Re: [PATCH v3 06/21] fpga: dfl: adds fpga_cdev_find_port
Message-ID: <20180206023702.GA4084@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-7-git-send-email-hao.wu@intel.com>
 <CANk1AXSNEX_pUTdWDOsXFsgogU2xbBBZwoLJFssqzF+q=hBssA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSNEX_pUTdWDOsXFsgogU2xbBBZwoLJFssqzF+q=hBssA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 04:08:19PM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> A couple comments below.
> 
> > For feature devices, e.g FPGA Management Engine (FME),
> 
> The first use I see of this function in this patchset is the FME PR,
> not the FME, or am I misunderstanding?

Hi Alan

Thanks for the review.

Yes, the first use is in the FME PR, the description should be more
clear here. I will improve it.

> 
> > it may
> > require fpga_cdev_find_port function to find dedicate port for
> > further actions, so export this function from feature device
> > driver module.
> 
> I understand the need for this function, but I'm having a hard time
> following this explanation here.   Suggestion: "For feature devices,
> we need a method to find the port dedicated to the device.  Add a
> function fpga_cdev_find_port to do that"

Will fix it, thanks for the suggestion.

> 
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ----
> > v3: s/fpga_for_each_port/fpga_cdev_find_port/
> >     move fpga_cdev_find_port to fpga-dfl module.
> > ---
> >  drivers/fpga/fpga-dfl.c | 27 +++++++++++++++++++++++++++
> >  drivers/fpga/fpga-dfl.h | 16 ++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/fpga/fpga-dfl.c b/drivers/fpga/fpga-dfl.c
> > index 9294c0a..ce03b17 100644
> > --- a/drivers/fpga/fpga-dfl.c
> > +++ b/drivers/fpga/fpga-dfl.c
> > @@ -873,6 +873,33 @@ void fpga_remove_feature_devs(struct fpga_cdev *cdev)
> >  }
> >  EXPORT_SYMBOL_GPL(fpga_remove_feature_devs);
> >
> > +/**
> > + * __fpga_cdev_find_port - find a port under given container device
> > + * @cdev: container device
> > + * @data: data passed to match function
> > + * @match: match function used to find specific port from the port device list
> > + *
> > + * Find a port device under container device. This function needs to be
> > + * invoked with lock held.
> > + */
> > +struct platform_device *
> > +__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> > +                     int (*match)(struct platform_device *, void *))
> > +{
> > +       struct feature_platform_data *pdata;
> > +       struct platform_device *port_dev;
> > +
> > +       list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> > +               port_dev = pdata->dev;
> > +
> > +               if (match(port_dev, data) && get_device(&port_dev->dev))
> > +                       return port_dev;
> 
> The caller will need to put the port_dev->dev.  Please document that
> in the function header.  I mentioned that in v2.

Sorry, I missed it, will add description on this function header.

Thanks again for the review and comments.

Hao
