Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3826334-1527886802-2-13109548350178498271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527886801; b=OCf8IpBfPXWphvPbjdwn26z1helvnI2GcGh2biAfuigSOO/ciH
    0ye9x84bFDElqUaIVr0CeN7Fa9yVk/NGsg+E0TgVOyx8CNbLdfTi9epUh0k+hzj6
    rQ+ye+9kCyulAwg0vMUXoc94yV/AIwWjrF/4UqhvUug0Uzy3cIindr2AL2lwnq0J
    hLbiiFdjzl70FqZpucyAID7HjufHA240uiKDT4MHXuBW+ybhv/s1h22l1Wq+WP1y
    KeqbRZy/DWmBdwo+UTA2aaMbEqwR8hXvMSLoun+nnBw3YmZeQyW3KoJexaf0yA3v
    hVzY5ecwECS3754Ejx8FyQprVLHpEN3Y4VWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527886801; bh=VV7ZiPnN8bVwd6FSg0+I5XXl1zP4fP
    Z4R87DCizVkXU=; b=XChDtF0OVykKmOfrx6Lppjg0LBW88hkoFJVKsw1EeoEHR0
    6XE9sGKEcV8dvqFI/lEPSYp5WNyuGhf/JWSGS06av3PfQ7L7k540RcmjHXK7qcwg
    0i3pfwv0fjzdbpGNML8BtlPz5K51eljFTs/8nvqKcrRYY5RN1e6T8KkKFgGV58N2
    dPhISYSK3lo3mWyVbIwgBGn5U4Kdh31A2XkIBKrsXz1VSOb4GTgpm7IXsdyjMYU8
    PK2G0Ea3GN0dYp06OH4WTnZpyTxoxCjmfbh2pcYxZ5GbJzYfgjP1Baa5Hwz3ZSep
    YQC93gpaqo9jgxR9SLGnPqCvFrosOtnFVGgWXScw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLhYzuGh6QkdCE/9h43GTzhWvYPyCZGd1XmMb7ztgMgbJuhHxsDTmXc9r4bXLTvb7vx4flz7HaoJl8N7y4SokqQbT7jjl+E6QAwHG7eC0Bc3b+AZ+sTW
    JMtzOhfIflp+l5E01AFtYanetBxut36F/62zuocwPEwLd+5TKuRsV1S3PD1l2mD7aKgEMcFB451iD8vI2khp/kEfkWLEB/3HKX2Tiu2njQP0aC0fdMo2SwJ5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=JS8pMu8bv_ITxmbrg-MA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbeFAU75 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 16:59:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:53818 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeFAU7w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:59:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="44014363"
Date: Fri, 1 Jun 2018 14:59:50 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Mike Snitzer <snitzer@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [dm-devel] [PATCH v2 2/7] dax: change bdev_dax_supported() to
 support boolean returns
Message-ID: <20180601205950.GA12821@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>, Toshi Kani <toshi.kani@hpe.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-3-ross.zwisler@linux.intel.com>
 <20180529212510.GJ30110@magnolia>
 <20180529220114.GA13948@linux.intel.com>
 <20180531191332.GB7825@magnolia>
 <20180531205206.GA12681@redhat.com>
 <20180531222645.GA6086@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531222645.GA6086@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 03:26:45PM -0700, Darrick J. Wong wrote:
> On Thu, May 31, 2018 at 04:52:06PM -0400, Mike Snitzer wrote:
> > On Thu, May 31 2018 at  3:13pm -0400,
> > Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > 
> > > On Tue, May 29, 2018 at 04:01:14PM -0600, Ross Zwisler wrote:
> > > > On Tue, May 29, 2018 at 02:25:10PM -0700, Darrick J. Wong wrote:
> > > > > On Tue, May 29, 2018 at 01:51:01PM -0600, Ross Zwisler wrote:
> > > > > > From: Dave Jiang <dave.jiang@intel.com>
> > > > > > 
> > > > > > The function return values are confusing with the way the function is
> > > > > > named. We expect a true or false return value but it actually returns
> > > > > > 0/-errno.  This makes the code very confusing. Changing the return values
> > > > > > to return a bool where if DAX is supported then return true and no DAX
> > > > > > support returns false.
> > > > > > 
> > > > > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > > > > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > > > > 
> > > > > Looks ok, do you want me to pull the first two patches through the xfs
> > > > > tree?
> > > > > 
> > > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > 
> > > > Thanks for the review.
> > > > 
> > > > I'm not sure what's best.  If you do that then Mike will need to have a DM
> > > > branch for the rest of the series based on your stable commits, yea?
> > > > 
> > > > Mike what would you prefer?
> > > 
> > > I /was/ about to say that I would pull in the first two patches, but now
> > > I can't get xfs to mount with pmem at all, and have no way of testing
> > > this...?
> > 
> > Once you get this sorted out, please feel free to pull in the first 2.
> 
> Sorted.  It'll be in Friday's for-next.  Ross helped me bang on the pmem
> devices w/ ndctl to enable fsdax mode and twist qemu until everything
> worked properly. ;)

For anyone else who would like to simulate persistent memory using QEMU, I've
added some hints here:

https://nvdimm.wiki.kernel.org/pmem_in_qemu
