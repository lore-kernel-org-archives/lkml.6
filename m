Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1959376-1519883965-2-6378306799211457883
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
    t=1519883964; b=o5KeEVwl2QWwiCesXEya24mZ/fW4yGXSAsCgWJr4qXzrLbr
    sUzkbxYuluzTVmD7ktyx81ZMTlURoRvmZQTqnJQTOYctzOxZcYUdLFmi16XGsLae
    wCI5QiGWto4rNEwkWicmFp9CqCwnEWwbHgUm9mm3CUJo+3VBWG4qlASxoLaHyMhK
    mkQe0/L799Sg/IYFqKumx1xQd5rMZgZpzLyg6Ba+zp1p1j4uI7CFsprfbIEV64dC
    MjBL4LupqPgfoiD5POxOc/q5ouHtw+H+kMUIgp7GYk6g1N3Oiws0crb97m82GD+N
    C5C1i0EjYS82GVyGOeqk1YNZeNgCLm0c2QFtDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519883964; bh=4UHtHG+wKijV6ZBOm3sDK9jn71
    3V9Gu9lMyEjUxrTIA=; b=pWmf8mTgdAmi1eYVi5i7N1YGZrjQMD7wN4+zwS1GJp
    TkqnoKuw/Ul8o8nWcTrVCZLivhomv9Fa+SKbKiSC6m/TscCkIHHZcm94lFbZ4K7C
    mcy5S9wI/9stwnk2N4lAiL5/xBJB4mf7dYw/D60JeWnXuiCFUPOkGcmU9WkmzhZe
    LuiSKNo0bPID3tF4U5mPVxab8JXQ3nzCSJpXM4pMys64idTDozNs7Jfo0QKM8b/C
    tb0lR8P20KVHiBJ83lf9NwB4I1y87u2DNAEYeAzfl1vKLF3B0+5ki0xt8PL2UoOk
    Res6jKy89z0K/sPv/fnlByMDnHVH2v5W0qAb8+rEu+ig==
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
        id S966089AbeCAF7X (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 00:59:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:10832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966037AbeCAF7W (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 00:59:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="178982993"
Date: Thu, 1 Mar 2018 13:49:35 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v4 15/24] fpga: dfl-fme-pr: add compat_id support for
 dfl-fme-region platform device.
Message-ID: <20180301054935.GA8999@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-16-git-send-email-hao.wu@intel.com>
 <CANk1AXR9473+QqjF=R2JqqJGPB_XH9k+2qDhh68hN=5Fq4E7uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR9473+QqjF=R2JqqJGPB_XH9k+2qDhh68hN=5Fq4E7uw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 05:06:57PM -0600, Alan Tull wrote:
> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> > This patch adds compat_id support when driver creates the platform
> > device for dfl-fme-region. It allows dfl-fme-region platform driver
> > to create fpga-region with correct compat_id.
> >
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  drivers/fpga/dfl-fme-pr.c | 20 ++++++++++++++++++++
> >  drivers/fpga/dfl-fme-pr.h |  3 +++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> > index 526e90b..c17170b 100644
> > --- a/drivers/fpga/dfl-fme-pr.c
> > +++ b/drivers/fpga/dfl-fme-pr.c
> > @@ -314,6 +314,25 @@ static void fpga_fme_destroy_bridges(struct feature_platform_data *pdata)
> >  }
> >
> >  /**
> > + * fpga_fme_get_region_compat_id - read region compat_id from hardware
> > + *
> > + * @dev: fme device.
> > + */
> > +static struct fpga_region_compat_id
> > +fpga_fme_get_region_compat_id(struct device *dev)
> > +{
> > +       struct fpga_region_compat_id compat_id;
> > +       void __iomem *fme_pr;
> > +
> > +       fme_pr = get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_PR_MGMT);
> > +
> > +       compat_id.id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
> > +       compat_id.id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> 
> I tried building for 32 bit ARM and ran into readq and writeq not
> being defined.  v2 had proper '#indef readq/writeq', so looks like we
> need that after all.

Sorry, it's missing a header file for dfl-fme-pr.h, as some files don't include
dfl.h at this version. That header file has definitions for readq/writeq.

+#include <linux/io-64-nonatomic-lo-hi.h>

will fix it.

Thanks
Hao

> Alan
