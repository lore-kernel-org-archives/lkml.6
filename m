Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3451457-1527039808-2-16164545333048927889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527039808; b=X11Y8VCxvSbag1UPR0DQJheR1EZBYPb4G86Mpj8rFLs6/JrUTa
    E/gVCMfqE2Hr1PZr+UA9MgppKSE5Drr7XNAvbHgtYegeDjAa/6JXz2WvtYSDHK9p
    lXj0uFlzmQKnPUGlBFVZ7aNKxTRHl/sVy8lCI0Mm6JXlxzGrvuXFaND/s70u7O9g
    IOb1K7JaZMK9rHVpDRB2QUWLgG58sxOiY9VEkeD20Unrw7W/vNxCCg3SLsT9Di3p
    +6++BJmwcSReQ7+InilyUc/9/xK05SBWu8fdAVH//0yEHb8fZHwqSle/cGA6kfCB
    N7l5A2NA21grDTjWOE7/IHW9lSfnwGZUKUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527039808; bh=xmB6EufqYNSao4m1y438HhMxkHGHVG
    Lfyhkh5+8VAaA=; b=Eb4WDDfF4TY+r1nL86QRKzaeI1A8GSjthfNci1Dnnv/Ov3
    XzIDDWJMaq9DtWtLDwdlzvTE8eEP969/ZsoHQzes+fltUhSjgQ6aCUhzJRvyygOI
    kYuWincJ412AlrQn3CsnUMRATcyyfXNSWEGOzSZ5hExum9O2BxZhbrXwFELvWqp8
    pJYojKVfLp1bwvsgAebLJJZwP6lb+FAN/4H/lTR8E+gI7ofJGF7wzMN+G2fdQMYF
    mKlwoDbOBZnL3dDEdxdtrxY/CPTnLIcRZ1B6LYln7RQMsquD0f/I2sxebDXs8sud
    Zh99icvAh3Cd2UNmsI2iHR9blyFcILV2c2fHjWvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBazlakiK4/Q418cN72IGO/yEN3SswodAf6cbTG1gSYX7m7UJZwiCLXfIhdgFV61pVM2viyZpZk9wjQ+attsw0Zin9MJcQJ8ANkS0ql2Q4WjDqT88Vfu
    7OcibOn0lEIqkI+BFiW6GjEhJ9mSWEkStu1Bn0bnrf5E/caGvzYZ9iYiZ1/Ls+PO3NzWiBZUzO2EPkaegntLxv0TpJcDXpgXAe7MQbEh1T4InZ7sAMYDnLNU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8 a=wUsz4rfA6hnfVHkDaTwA:9
    a=jlvn0s9filvoresM:21 a=T4y-Y9CSUR4MnYRj:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeEWBnZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 21:43:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53896 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeEWBnY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 21:43:24 -0400
Date: Wed, 23 May 2018 02:43:18 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: YAaioRace (was Re: [PATCH 08/31] aio: implement IOCB_CMD_POLL)
Message-ID: <20180523014318.GI30522@ZenIV.linux.org.uk>
References: <20180522113108.25713-1-hch@lst.de>
 <20180522113108.25713-9-hch@lst.de>
 <20180522220524.GE30522@ZenIV.linux.org.uk>
 <20180523004530.GG30522@ZenIV.linux.org.uk>
 <20180523004904.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523004904.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 01:49:04AM +0100, Al Viro wrote:

> > Looks like we want to call ->ki_cancel() *BEFORE* removing from the list,
> > as well as doing fput() after aio_complete().  The same ordering, BTW, goes
> > for aio_read() et.al.
> > 
> > Look:
> > CPU1:	io_cancel() grabs ->ctx_lock, finds iocb and removes it from the list.
> > CPU2:	aio_rw_complete() on that iocb.  Since the sucker is not in the list
> > anymore, we do NOT spin on ->ctx_lock and proceed to free iocb
> > CPU1:	pass freed iocb to ->ki_cancel().  BOOM.
> 
> BTW, it seems that the mainline is vulnerable to this one.  I might be
> missing something, but...

It is, but with a different attack vector - io_cancel(2) won't do it (it
does not remove from the list at all), but io_destroy(2) bloody well will.

IMO, we need this in mainline; unless somebody has a problem with it, to
#fixes it goes:

fix io_destroy()/aio_complete() race

If io_destroy() gets to cancelling everything that can be cancelled and
gets to kiocb_cancel() calling the function driver has left in ->ki_cancel,
it becomes vulnerable to a race with IO completion.  At that point req
is already taken off the list and aio_complete() does *NOT* spin until
we (in free_ioctx_users()) releases ->ctx_lock.  As the result, it proceeds
to kiocb_free(), freing req just it gets passed to ->ki_cancel().

Fix is simple - remove from the list after the call of kiocb_cancel().  All
instances of ->ki_cancel() already have to cope with the being called with
iocb still on list - that's what happens in io_cancel(2).

Cc: stable@kernel.org
Fixes: 0460fef2a921 "aio: use cancellation list lazily"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/aio.c b/fs/aio.c
index 8061d9787e54..49f53516eef0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -634,9 +634,8 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
+		list_del_init(&req->ki_list);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
