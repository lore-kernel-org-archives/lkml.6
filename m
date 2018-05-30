Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3174725-1527654904-2-18178186924118577021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527654904; b=CjHTnpIhRDcXyl3nh0FEg412SDNYlOS1PXoYtidDT6K0lyvFCE
    ltcmwtA16WOCtL0S+4Y3GYVOpV3z0kbluIHPfWFzy3OS3K3V6QOWiQ0hv3Aw4HIB
    iqxHR/PWCK3i8cR2rBe0VECG3Dhzi+iJ4yPQF8MyHFrM7hcDSTSrbD6Oj3UKTK53
    kmVBpnHG8/sLMaLf7zK2MPG3dp18yl3yChzxYzMcEBX+GqEZ8j/nGc/2X9yFlh5+
    9meGaHDaQEdphHIt0KCbgmLhSukhg2IkvhzVz6GmaLJ8fHghRJ5fx1VXcwhxqkDV
    ROAdJFgwNq4CEtitz83sTkb02KGhARL3bKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527654904; bh=CeADdkq2WcSrOiVjp0dG/LIv4knSa3
    0FHpBX1wAoOsA=; b=kxS6SqpJytaNiO/2yy/BrfMufpcGogURwvYCO75A0W9oRT
    YkHKVQRYU5ABQz+eRGj3jy1ckdxJ1lMOSRwzIbdYkhUgMiH9NkdZM2ijXzJZWuDA
    5wsqAv6p5g2ma7FtJcs4ybCnzi9mJXldTUFzT5uy5YO53Rvp4EwdrIP+AnAKjDty
    5uvEbmyZt4ZYX7HncM+hA4wwbmS0dOpwepOoPnmv7Txp59LL4Ayz0YfloDlsjUB2
    S9+YJf9+VMZ2G8zKqxf7ECPRLgfLFPZT3VbFjddD1RWwf4qCwYTkbdP+GUmy3I8V
    OGSkDmGGMWst8CFfaqHbVqpqnRUswKQu5x5vUVVg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=fromorbit.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=fromorbit.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKA1th97tNhVs+OcL77WWyIQnjaIQGbmdGMZXQKCYvWMr+cEfk8DG6S6NV49A26la8Vl/oZSVq9iXv0c8SWo4+0gxQPdZBonpFwQnOXI6kPGq64rdZbd
    qNC4ekbTQqp84l/pdT8vfLjjPh6fkrilf7rLC3i37Yu+XxwTBxlvfohp5ocMTSkV2NTaO4NDQiZ4cXCAUrHrg5YfyV+mmrMCFiUDeG7YsYbIGMvoCMytTDeM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7-415B0cAAAA:8 a=GvOkAvA3uZluRxjufzAA:9 a=CjuIK1q_8ugA:10
    a=biEYGPWJfzWAr4FL6Ov7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934990AbeE3EfB (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 00:35:01 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:3904 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934541AbeE3Ee6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 00:34:58 -0400
Date: Wed, 30 May 2018 14:34:55 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged
 mounts
Message-ID: <20180530043455.GN23861@dastard>
References: <87o9h6554f.fsf@xmission.com>
 <20180524214617.GG7712@thunk.org>
 <87y3g8y6x9.fsf@xmission.com>
 <20180525035716.GE10363@dastard>
 <8736yar4g3.fsf@xmission.com>
 <20180529221710.GM23861@dastard>
 <87k1rlkh1g.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1rlkh1g.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 09:34:35PM -0500, Eric W. Biederman wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > Yeah, the are some fairly big process and policy things that
> > need to be decided here. Not just at the kernel level, but at
> > distro and app infrastructure level too.
> >
> > I was originally sceptical of supporting kernel filesystems via
> > lkl, but the desire for unprivileged mounts has not gone away
> > and so I'm less worried about accessing filesystems that way
> > than I am of letting the kernel parse untrusted images from
> > untrusted users...
> 
> There is also the more readily available libguestfs which doesn't
> support as many filesystems but does seem available in most linux
> distributions already.  It already has a fuse option available
> with guestmount.  I may have to dig in there and see how to make
> it available without using fusermount.

That only provides host access to filesystems mounted inside guest
VMs, right?  AFAIA, libguestfs is not providing a FUSE
implementation that mounts and parses raw XFS images. e.g it barely
understands anything XFS, and that which it does is via running and
screen-scraping the output of XFS's userspace management tools...

> > I'm not sure what the correct forum for this is - wasn't this
> > something the Plumbers conference was supposed to facilitate?
> 
> Yes.  If we all need to be in a room and talk about things.
> It is early enough in the planning for Plumers that we could
> definitely schedule a talk or a BOF for this.

Ok. I have no idea if I'll be at plumbers - it's an awful long way
from where I am....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
