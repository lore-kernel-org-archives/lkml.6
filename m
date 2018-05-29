Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1840634-1527586224-2-1682053070010099282
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527586224; b=U+hjspC5ryqsVlZ+bNuG8SM8w8elbe3CTA1iZ1tKyqjS43EGdN
    DxMz3ynGf82/xI7fyMPC8Pjhsw+96Ccmyqf6C8XkSIiYkHqMPrvCIxqj0WHgF9Ok
    XsJJngVSivxTNIQ4lIsiisMO3NLksGgHQ+EAoF0msdz7XNRYGfqapebBIl3/XJsX
    5jRiiX7uoGuBP+0DNNVQd7fCEgsga6pb4GVoAAN3i9oPeOWYts6a/OAcZpUyPCuh
    PxhEvrw8rozAUVB9wqit1QaP4UuGlScG59lPI7qUxT5A3xi89L+RoDBdBBRvqHhw
    PmJji8jqDTmnYcBnYwXj9OhrKlYFH4de12SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527586224; bh=NklG8GhmDiFGy9FHDzwivwBjDaeMZ8
    bF4uemF68heV0=; b=SYnNN0lj6GX+dECUuK0RchBH6ZTCsmjrqPcJeqdRIG6WuA
    yDQr8O7GAAc0X1n5NP1F7CsgxpzKYpnqF/DWUP/fsU05JcQacx2tEpukkGvg/NqI
    CA8e1YM6M1vQA1/qwKPMmzWemBx1JLJtNrE6T6AHYVzbRg9fkAP5SCaWhIots8bL
    jHbTlCAW1MnMw8Xz2b/9dJGj+Loqw2aVSTfjXDk+jIHPC4pcsRAgmEHjVzPYEpb9
    FOhiK4d3EeUoxlUhq6dw073cPXaaZb5y2qGmysjuszxuXbyzlxNdahLJb790HXzO
    7ptWLnQlcsG/pCdd/ZFSAdAnQ1zWiNA/9uTtcDuw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOQlYxwRri1gd5c9cQonNgJsMGt6Lxxur7C/08uS+lUWhG9Y7g6SviJTaq5nbXfQIgh5bKPPDl4UR86sSJ1kJrMCxiOW1q252k4VdHfW+8ns6rSjbPVN
    HheBagQ/FUGkb5D9Xvk7FbCvoQ9ULBdAJ3D+/NG9lTk1Q6Wl8CUnbZIiRYeOpulhZTfxolPRGhK1SUSxtReoAaOKYFudRUFZSLkA3/1wJ/H2kCU5Vr940c4q
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ZTvUnRqd33pkFdXiQeAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeE2JaX (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 05:30:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35876 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeE2JaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 05:30:21 -0400
Date: Tue, 29 May 2018 10:30:50 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, mingo@kernel.org
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Message-ID: <20180529093050.GB6533@arm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525191020.GA5914@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Paul,

On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> This commit documents the scheme used to generate the names for the
> litmus tests.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 1 deletion(-)

Whilst I think documentation like this is extremely important for users,
this feels like it's documenting how to drive parts of diy and I'm not
convinced that it belongs in the kernel source tree as long as the projects
remain separate.

Why not contribute this to the herdtools7 documentation, then just reference
that from here? That would also be helpful for other people interested in
memory models, but perhaps not interested in Linux (assuming such people
exist ;).

Cheers,

Will
