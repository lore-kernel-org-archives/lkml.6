Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3846313-1527887480-2-7614919651808602852
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527887480; b=LRE59WiislNl4D3DHfp5FH4c4gV/G1cqZrB3JjqzMgCHnpgtin
    8m2fRX1BbQ3BRUOuFJ05AuKozob9GQemJBBbPNYQvibgpvY89/NTT/e1K5i2jpjm
    Q623cxVOvtyX2bCc1pA+lMRjb4YzHU6c0ex11+V/3JsDzDd3YWn8YRZ3/jKbw5yV
    4l7bLyN659K3nIXvDtx0bsgYllHyZnof/UlEhyvCS1O1oDWbq3UJHSBPR3LY+h5q
    eqfCiKd5oEMts6q+DFET8utvFk2btXKQPtaczAb2DfTOdjIZmPJsix5R5L1S+GHP
    DlErxtPbeHhsgOV/m3qnQWHeTGRriQ+SYHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527887480; bh=b+a0imK0Xv1X4EQX1H75OxTGnOvaH9
    FKfv4zZAsjnTA=; b=mjKVIsRn1RpDi1k1btz9nQho0f+swkr3ysikWYbAycAJ3F
    DQpClRu+BayA89Z8u+Zg+8yxqOycjLwodWOUK6ZlO5LC9qzv5Jeu3kfhAFBbnn9X
    eYT0ATnP4kQBy12E0YTlQieqFC5qsRqADP1ugfRe3SE5xugVBnvn14surU6GGy0r
    wiGzwZYFfV9OGlXSg/iwXB8y/3LWZaUmWY/Gl/yrV9IRJ3dBh+ycUQUv33p2L4Vq
    vKAAvlp0cJ8bT2Xboz61s2xHdwXg7Ydfpa0O5HGnlNZpN7Ii10CZvRN2NaRcvF0R
    cg0r2uaLCwvZuUPeDoXDCcYcYGXIZOdj+a7lH6Qg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfE9S6q4frynRycPijdkjWYpii7Zptumg4BkoK+6E2gRyIQ289P4Od6ln3gBJ4oRmHQTjFdFvumSa2tOtNkMRwQtvOFMsfu2toraeXj5VAiiLKyRBgmYE
    oWQMgEqmEs3wZfyTgA8Sde5/Phkrixl1HJrN2xlWsCUkkKbZr56Ba0u7rX7NczdmE5QAH5irCSASYW+dJwrrgmOaKjDH0325mE6zcaleoGyMZ8NO2icfLMvz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=aN9B2TKZ8pQdcslOI6YA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeFAVLP (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 17:11:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:12442 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeFAVLP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:11:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="59663659"
Date: Fri, 1 Jun 2018 15:11:13 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dm: fix test for DAX device support
Message-ID: <20180601211113.GB12821@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Mike Snitzer <snitzer@redhat.com>, Toshi Kani <toshi.kani@hpe.com>,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-xfs@vger.kernel.org
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-4-ross.zwisler@linux.intel.com>
 <20180601201924.GA1144@redhat.com>
 <20180601204604.GB1144@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601204604.GB1144@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jun 01, 2018 at 04:46:04PM -0400, Mike Snitzer wrote:
> On Fri, Jun 01 2018 at  4:19P -0400,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > On Tue, May 29 2018 at  3:51P -0400,
> > Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
> > 
> > > Currently device_supports_dax() just checks to see if the QUEUE_FLAG_DAX
> > > flag is set on the device's request queue to decide whether or not the
> > > device supports filesystem DAX.  This is insufficient because there are
> > > devices like PMEM namespaces in raw mode which have QUEUE_FLAG_DAX set but
> > > which don't actually support DAX.
> > 
> > Isn't that a PMEM bug then?
> > 
> > What is the point of setting QUEUE_FLAG_DAX if it cannot be trusted?

Yup, that seems like a bug.

> > > This means that you could create a dm-linear device, for example, where the
> > > first part of the dm-linear device was a PMEM namespace in fsdax mode and
> > > the second part was a PMEM namespace in raw mode.  Both DM and the
> > > filesystem you put on that dm-linear device would think the whole device
> > > supports DAX, which would lead to bad behavior once your raw PMEM namespace
> > > part using DAX needed struct page for something.
> > 
> > The PMEM namespace in raw mode shouldn't be setting QUEUE_FLAG_DAX, if
> > it didn't then the stacked-up linear DM wouldn't 
> > 
> > > Fix this by using bdev_dax_supported() like filesystems do at mount time.
> > > This checks for raw mode and also performs other tests like checking to
> > > make sure the dax_direct_access() path works.
> > 
> > Sorry "This" does those things where?
> 
> I see you meant bdev_dax_supported() does these additional checks.
> 
> My previous question stands though.  Why is QUEUE_FLAG_DAX getting set
> if the device hasn't already passed these checks?  Shouldn't setting
> QUEUE_FLAG_DAX on request_queue depend on bdev_dax_supported() passing?
> 
> But looking at the drivers that do set QUEUE_FLAG_DAX: they
> don't have the bdev readily available.  Anyway, just strikes me as
> bizarre that a driver can set QUEUE_FLAG_DAX without having to have
> ensured bdev_dax_supported() passes (even if not programatically, but
> that the developer has verified the hooks, et al exist).

I agree that it's a bug that QUEUE_FLAG_DAX is set for raw mode namespaces,
thanks for pointing that out.  I will fix that, but I still think that DM
should be using bdev_dax_supported() like the filesystems do.  Even beyond the
raw mode / fsdax mode thing, this does additional checks that are useful. So,
I think these DM patches are still correct.

> But I'll give up on this line of questioning..
> 
> My dilemma now is: how do I take these changes without first rebasing
> linux-dm.git ontop of Darrick's xfs tree?
> 
> I probably should've reviewed faster and been the one to take the entire
> set (with appropriate acks obviously).
