Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3249862-1526420053-2-9802673512784729724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526420052; b=EigCmj48PLWXF1/6soesKssc3mCv3qUr8coOtd2Th8Sl2PPiPF
    ROHT0CjltPnxkKhLz1uREFp1EDsmmwHLAPxSr74WtAUPGJRt81N2s+a3tdJPDzh9
    17ixNZzvr6+b83WDEFRE9vGC4wgBvtCAE/QhYuwx5MOmj8yakSOpA4YavvrMCRGA
    zXMZlDp+qfYqEatTQQPENPk1baijmzzcczjUroqiqTPVy46KlCJoGqZcqykka3CO
    Bhr11p3k0lmiyUYLcWZZ1Ad8f7ohVYjej0nOLfEizXi0ZMLZSn1k8qi8g8knNdew
    dlK4tAtsKDGUypn8ckr5/VrlJ9AIZBe/IM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526420052;
    bh=VAMY+QYB0IBlqZX3u93wZiWj6daygTQkkRj+m64WOSY=; b=m8sz6+qv0AY/
    Hx97doRnV/1AlcCBSo3K9Q47wtRm5F7COGlV66IWL2YD8RKanxKtSsd2DoRlI50o
    cZx6q3zHFLVakgubV9oJqzYveicHikhrQVUMB3EL4zQyrp2DJYlw1lYVPjWaO3CB
    kk7IqSHO6DPxDgVKOBlENEQSxFm3dGbOSJpQiBj0P3iczoamp/fQtMx9RDHMu9kv
    80UMbvc9p+qDhTyQmOtlNTj8etVeU+BUZC4PRVVQv7ZGscGaoh+Eh7OocbG2A69x
    eHFOlc+UK+e1/ODqswJMlqZ/60naBptaiYY/aRbM8AkpEckPRiaZe1N+7FBmiwXR
    cFRLWdwVCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGVmRI2v3T445X2niLWjqUAzSBCmV0e1CkO0gRtlpB0pj3sSqbuY2ctMHs38U12uHZdDHSy+ecwQsli829soG20BsPoItK/Nzkr8X8xERP94tla0km1w
    31IX5GWebHRTelFdrEEWX6F4RoIyjzXadueQKFdLVtRVee1YGuJqYncA/w9AymNP+pvPjFXBngjHEDuEwHkP7WBza69rdK9IQZf/NodKKP4UA33yHt0d1w7s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=LSdmUDBBZZyydVr8SrAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeEOVeJ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 17:34:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeEOVeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 17:34:09 -0400
Date: Tue, 15 May 2018 14:34:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        dhowells@redhat.com, ernesto.mnd.fernandez@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com
Subject: Re: [PATCH] hfsplus: stop workqueue when fill_super() failed
Message-Id: <20180515143407.89e3b0e7d73c89e6071196e0@linux-foundation.org>
In-Reply-To: <964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp>
References: <089e08e567a5b24ae90568bb75d6@google.com>
        <964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 15 May 2018 19:11:06 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> >From ffd64dcf946502e7bb1d23c021ee9a4fc92f9312 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 15 May 2018 12:23:03 +0900
> Subject: [PATCH] hfsplus: stop workqueue when fill_super() failed
> 
> syzbot is reporting ODEBUG messages at hfsplus_fill_super() [1].
> This is because hfsplus_fill_super() forgot to call
> cancel_delayed_work_sync().
> 
> As far as I can see, it is hfsplus_mark_mdb_dirty() from
> hfsplus_new_inode() in hfsplus_fill_super() that calls
> queue_delayed_work(). Therefore, I assume that hfsplus_new_inode() does not
> fail if queue_delayed_work() was called, and the out_put_hidden_dir label
> is the appropriate location to call cancel_delayed_work_sync().

Yes, I was scratching my head over that - it is quite unobvious
whereabouts in hfsplus_fill_super() that the work actually starts
getting scheduled.

"somewhere after the last goto out_put_root" might be true, for now. 
But it isn't at all obvious and it isn't very maintainable.

Perhaps it's simply wrong for hfsplus to be marking things dirty and
performing these complex operations partway through fill_super() before
everything is fully set up.

And I wouldn't be comfortable putting the cancel_work_sync() right at
the end of the hfsplus_fill_super() cleanup because the delayed work
handler might be using things which have already been torn down by that
stage.

So...  ugh.  A solid shotgun approach would be to put a
cancel_work_sync() immediately after each and every goto target in that
cleanup path, but that's just stupid :(

Nasty.  I can't think of anything clever here.  I guess we can go with
this patch for now, and if new problems crop up we can look at moving
the cancel_work_sync() down to a later part of the teardown sequence.
