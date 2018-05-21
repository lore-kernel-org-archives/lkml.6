Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937579-2-6455749249306915409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937579; b=PJbbbBkT1m/dw9hZunyLl6Htog/zPdpoPtuWMVaekcrk16NiO7
    xkzorVl5QtSoPfP/2oTLxCyrEYCk9GX6bP8klj92SW7fLpoCvlt3k4Pz2RjF5zSM
    VisgfxFVqLvu2k0ei5boMI3T0MezfgA+DVWKGduwYLnpRKzNOIhWQs/J7D0UvC4a
    SZzpq6O3ogKEdJI8soKJdAFT6YUtTFJMJ5ou2+pHJ1IQERtZztGPdbNlc53AkNfM
    lyk5Zzu+124yNjgYrk3lIxKgRv01YluHi3POAsAH3et5bWxgIj2LlyOPTorNa6Zi
    Qr+Vu0yx9ldcEOinneJnRR8MGlzI3fwgAOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937579; bh=3OUR9rnWEvluPkTv7SQeFZ26MbHYKa
    5VZ0QEGzXzRDM=; b=GaFulzihIrWqq4zWHqLKiTaz4TCLBWU+nP1qsmL+ydQgnk
    TSEot9ezx7MmJqF4rgUbFJ1SAWUJdTy0b2rkXiW2kp/GuQ/RzfoaO1DrMibwitLk
    drhmy7zUm43JzSWGCeMX5K6UuY6PaJ+H03at3eckrxwMp3AdDQsCM3X++JJ5igdU
    6Zv//XG7Q1uhU//zGHvE8YP8Z38weaTEchmuu5c3vpQoO2xi1tlkwgYkH7oG5whi
    ceOn76Of4omVxEhE/FarUQ4G7vo8dxyyAgP5pfnQ8x9LMwIBn8Tmrd94FFwKUdpP
    OmSJgeMDdBzrrwD+s3/cE6nr0NyegMqBVz4Ecucg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=nvRR1HdY x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=nvRR1HdY x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBgFrWkT6ZBE2OloliQcDzwqBC/zsvF/cTUvfp5idM5/i0M14OrEsL/z7ZKekh2WGbh4DAfDU+3AotxgBzEm6YbY7NpQkGd5mknD8paDoGr4dbeCIpb6
    poYqL3YJisrdbabo1QfVaN93kk9h/rAAyaOXc+nl4DOhzzFcv+mvNcAYyzP7VfPxuFC3hDK7BZSH76n5e7LPEUKwvGMEC3vUXmx7LW9sBqgq6/rOeCaMXgUl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8
    a=lUoSDrnz3zN8yKeRpAYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeEUVTg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753005AbeEUVTd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:19:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 44/95] btrfs: fix crash when trying to resume balance without the resume flag
Date: Mon, 21 May 2018 23:11:34 +0200
Message-Id: <20180521210457.060115712@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 02ee654d3a04563c67bfe658a05384548b9bb105 upstream.

We set the BTRFS_BALANCE_RESUME flag in the btrfs_recover_balance()
only, which isn't called during the remount. So when resuming from
the paused balance we hit the bug:

 kernel: kernel BUG at fs/btrfs/volumes.c:3890!
 ::
 kernel:  balance_kthread+0x51/0x60 [btrfs]
 kernel:  kthread+0x111/0x130
 ::
 kernel: RIP: btrfs_balance+0x12e1/0x1570 [btrfs] RSP: ffffba7d0090bde8

Reproducer:
  On a mounted filesystem:

  btrfs balance start --full-balance /btrfs
  btrfs balance pause /btrfs
  mount -o remount,ro /dev/sdb /btrfs
  mount -o remount,rw /dev/sdb /btrfs

To fix this set the BTRFS_BALANCE_RESUME flag in
btrfs_resume_balance_async().

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3964,6 +3964,15 @@ int btrfs_resume_balance_async(struct bt
 		return 0;
 	}
 
+	/*
+	 * A ro->rw remount sequence should continue with the paused balance
+	 * regardless of who pauses it, system or the user as of now, so set
+	 * the resume flag.
+	 */
+	spin_lock(&fs_info->balance_lock);
+	fs_info->balance_ctl->flags |= BTRFS_BALANCE_RESUME;
+	spin_unlock(&fs_info->balance_lock);
+
 	tsk = kthread_run(balance_kthread, fs_info, "btrfs-balance");
 	return PTR_ERR_OR_ZERO(tsk);
 }
