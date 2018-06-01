Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3846313-1527885998-2-2387882695195972978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527885998; b=KQdyVDShAJ01Oi5Z84D5a4S2JTPMtfOVaZB5v9IWbmBr0FkwCN
    ihA40ma7BjCulrEnL1CyegzBcE5924VspuQiJK3sc+Zjkj8tWPOg5IH+QwczuW77
    UOfCmJEd9pbIQpiC5M+VF8g/LKX8GokJg5F25AIxpuU2SIZ4pjXSzipt8Zd3xHLW
    hl3hUsJpu+OWXO+7ydlVn2iNZVfwJxvxxqi4tWSrB6+H6HUHerG+94LzZY9RQcEU
    MKKBKML7+k0KUZpBBlExxcSsiAKn13Lm27c29GT4Zh+9tskE09MBf3/DukiXw8pk
    BFzD7O+zv7dmNBkKT6nKb4RPbR0zpZ8PoefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527885998; bh=Xz7BIrydaqioJfjLc6Fj88cQ93h3sN
    ZpMIkiuhsf6ao=; b=EvB/ZCvMDgeWquAo0lxgjXUg+kR/9fafxLmEwg8ARaLWKm
    uPVZ8i5ivgtYdZL8KyaVB91QIMXNxbtOohrTygcP2MtGyOaBbFrZXTBci7W4mLDk
    QkoZTZMRxjQUPec3LUkaVBPHE2vtWWEM4/t50AnvihbZxgSkDWJjXo/6II+XqE0W
    1upQa9tJQkwVepZ3juWhYDVxiN5uRlUbQphrMXSMS0gVezAytaeWUqW0B0qne3wT
    Q2afqP+zgyGLQl/8h6RLd60sbC9S9fiVRC8Skm6JrYrlGzYXEqYBeFAWbBHB5w84
    TBPrjX5/3XesEb/eF8FWlSi+cvsqTLatYmSXj8lA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEbWwyK4/CHwhIcvAKKTnlalIrPJs8DaVl9ona7V14X5ahswvnx1tfs7yRy6cVhZ2QTYN2fAEwGgKz54NO/eQsEnVEe3Jrz47LuOPjSexVVIuJjfSzOC
    Z++xfKmIe9k/m3s90srwlvxfv8Fujuzt1Zm3lKlC3qWw2Jlg3i14IuhTHD0VgEn+ZGcOO83CkEMJg3UeCF3ln75+HeS49Mopo60I0tBHiJq0nM2m0JHHXWuH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=6fRSesKdBoVJWA_5YRIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeFAUqZ (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 16:46:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750724AbeFAUqX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:46:23 -0400
Date: Fri, 1 Jun 2018 16:46:04 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dm: fix test for DAX device support
Message-ID: <20180601204604.GB1144@redhat.com>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-4-ross.zwisler@linux.intel.com>
 <20180601201924.GA1144@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601201924.GA1144@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jun 01 2018 at  4:19P -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Tue, May 29 2018 at  3:51P -0400,
> Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
> 
> > Currently device_supports_dax() just checks to see if the QUEUE_FLAG_DAX
> > flag is set on the device's request queue to decide whether or not the
> > device supports filesystem DAX.  This is insufficient because there are
> > devices like PMEM namespaces in raw mode which have QUEUE_FLAG_DAX set but
> > which don't actually support DAX.
> 
> Isn't that a PMEM bug then?
> 
> What is the point of setting QUEUE_FLAG_DAX if it cannot be trusted?
>  
> > This means that you could create a dm-linear device, for example, where the
> > first part of the dm-linear device was a PMEM namespace in fsdax mode and
> > the second part was a PMEM namespace in raw mode.  Both DM and the
> > filesystem you put on that dm-linear device would think the whole device
> > supports DAX, which would lead to bad behavior once your raw PMEM namespace
> > part using DAX needed struct page for something.
> 
> The PMEM namespace in raw mode shouldn't be setting QUEUE_FLAG_DAX, if
> it didn't then the stacked-up linear DM wouldn't 
> 
> > Fix this by using bdev_dax_supported() like filesystems do at mount time.
> > This checks for raw mode and also performs other tests like checking to
> > make sure the dax_direct_access() path works.
> 
> Sorry "This" does those things where?

I see you meant bdev_dax_supported() does these additional checks.

My previous question stands though.  Why is QUEUE_FLAG_DAX getting set
if the device hasn't already passed these checks?  Shouldn't setting
QUEUE_FLAG_DAX on request_queue depend on bdev_dax_supported() passing?

But looking at the drivers that do set QUEUE_FLAG_DAX: they
don't have the bdev readily available.  Anyway, just strikes me as
bizarre that a driver can set QUEUE_FLAG_DAX without having to have
ensured bdev_dax_supported() passes (even if not programatically, but
that the developer has verified the hooks, et al exist).

But I'll give up on this line of questioning..

My dilemma now is: how do I take these changes without first rebasing
linux-dm.git ontop of Darrick's xfs tree?

I probably should've reviewed faster and been the one to take the entire
set (with appropriate acks obviously).
