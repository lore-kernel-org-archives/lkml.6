Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1958875-1527594736-2-17153259761046780319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527594736; b=Kul7RJCjdiTt2f6nthk1c92YaZwyovwQs4Bc8uPLDrqRkOk+n3
    jMBHJdoN27Pw4Ey4cMyQ+SJgO3/seXsz+KdYLhafTK1QcvbqcdLhtWFdrwCUvtCD
    HsS6qvaITA5HLOCVxBkJOU+6rWduHztX0wWxZzRkCT6/yQA8L2wx7U+1vWiXSSy1
    cGqDzt1BvW5WnnV3kU64hQpuCUekzNtMqZpDtu0RZsAW+84COODcWl2k45ZgbjGs
    mPBd6q2553o4wpBSC66dZUDQgXZ0CNe0GeBuJ6W/+ED2GEvViN0HHQykT9JLORLU
    RKx7W1jQqj9n7gULzTruinttCouc5kvBzCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527594736;
    bh=teFwHQrrqm8x4ZLUQ/m1MOb9Wr76Q1wYl69r6/AK5Ac=; b=KeBvxJ5Wa6Zn
    Y5zO4ox3JUbYl5tCbjwfA63hclfuMZKNg2rxA45xu+INCkDi20v2WhSvAybw6na2
    JFERNkvhevzP2clhxKbthZ7fkIgU95xmwHph1iXbpIPGtvnZSx7pkFSZov3OxV1D
    2UNhLCECWza1b4B/fztV3nrH9iODoUOzXDNMWnngNW0yzOLjtQlg4Rb5tYdpG2Ze
    b08KxDMG4/F68pt6v3JHtHT19IQPg0uJ25Q9+cet75JIPsWc6EyehNmcirYNwtuV
    RwSi16nk5wPQSo3SfD+/U9h2+DzHAfUHOh8NnALvz/ldBfxWseb0sgY6GxB09NHF
    MKZvsFhwDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIyYPRBA50ajYo2CZ/IttZCciPJB/sovkqHmw/ZMoboMGMRRFDOO49xrFzAI8oUURM8aZBIckVetXvFMVlP5gzOaFhI6x5bEthTXDLWVJ6UIY9+kU4hP
    xASP3q/SODjYR+lX4uDK9FjNYJASArE1zWIMF/Rcbey2LkBLvXYmwa1xHaRQ3jbhF62EvVDRryLwfVC1Vgbp57SAM6HHtX7YhnWh9+YJBYq4xU+rtDNsMYCX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=VwXke4_Me_QSIZ1KxZoA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=e2CUPOnPG4QKp8I52DXD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeE2LwO (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 07:52:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:34472 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933395AbeE2LwD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 07:52:03 -0400
Date: Tue, 29 May 2018 05:51:58 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Michal Hocko <mhocko@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] doc: document scope NOFS, NOIO APIs
Message-ID: <20180529055158.0170231e@lwn.net>
In-Reply-To: <20180529082644.26192-1-mhocko@kernel.org>
References: <20180524114341.1101-1-mhocko@kernel.org>
        <20180529082644.26192-1-mhocko@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 29 May 2018 10:26:44 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> Although the api is documented in the source code Ted has pointed out
> that there is no mention in the core-api Documentation and there are
> people looking there to find answers how to use a specific API.

So, I still think that this:

> +The traditional way to avoid this deadlock problem is to clear __GFP_FS
> +respectively __GFP_IO (note the latter implies clearing the first as well) in

doesn't read the way you intend it to.  But we've sent you in more
than enough circles on this already, so I went ahead and applied it;
wording can always be tweaked later.

You added the kerneldoc comments, but didn't bring them into your new
document.  I'm going to tack this on afterward, hopefully nobody will
object.

Thanks,

jon

---
docs: Use the kerneldoc comments for memalloc_no*()

Now that we have kerneldoc comments for
memalloc_no{fs,io}_{save_restore}(), go ahead and pull them into the docs.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/core-api/gfp_mask-from-fs-io.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index 2dc442b04a77..e0df8f416582 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -33,6 +33,11 @@ section from a filesystem or I/O point of view. Any allocation from that
 scope will inherently drop __GFP_FS respectively __GFP_IO from the given
 mask so no memory allocation can recurse back in the FS/IO.
 
+.. kernel-doc:: include/linux/sched/mm.h
+   :functions: memalloc_nofs_save memalloc_nofs_restore
+.. kernel-doc:: include/linux/sched/mm.h
+   :functions: memalloc_noio_save memalloc_noio_restore
+
 FS/IO code then simply calls the appropriate save function before
 any critical section with respect to the reclaim is started - e.g.
 lock shared with the reclaim context or when a transaction context
-- 
2.14.3
