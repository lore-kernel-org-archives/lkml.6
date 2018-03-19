Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484405-2-600015148192230686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484404; b=i0iPSFL07+YBLGrbYQ7BzMT26PjwtbimUEClNrlyBm4+/i7
    8lbOa82B3mZfUf1Hi5mFoEs5ynmYd0gVzVe0LJJVs73fTzYYzRqLTHftbCcogrjZ
    ahWEun9GKdxfwP/u8AKQzanxn/xyjZXcJoyeD0ZXOfYHICMtnp6Zri2t0Rxa5tF7
    xq5ZrFZQZs0Lk+lE8+eTimROqTdU4VjuvG7+2/lvONlG6vPHQ3wSaVy0XfKhQkd7
    Qnl/vv7KmYVB0zZqOMgXde3YTdSBadBJJUMAI3BghfGyI5IUraATSHDSXEeiyEiR
    qgaPmsVWfYGVo1VM3wI8cQtTz/4L1D8Ll0Sk9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484404; bh=o/DHGcFWH0rNDUJXpeat66flhm
    vo7NETQB909cLpdA8=; b=E1m0k6qOTolYQyg0UoI7efJVICIuoRBZ+eHbnT60Cn
    TuEgE7xIGQwq3/uPkOr3PxUEOV9Vzph1vWHEPWW+4txIfup1jkGMZ7hdvHSzcBYv
    PASWe2zFvWgvS0grKxpQpO2GIxMsgN8I08lPnI3hYa4cwMmPn7h3ua85iXi93OHz
    QQxCLkij/PH7poY/PLnz2sMZJvIxnV3u6mMDypBnLdhI6ba+gexfQx4t7tJ3gp1b
    /GkV0fpDWQqylKa7tnS6isDBVeaLNzWPn2KhVARQsciIrdum9GEZj4EwfPqeFKmL
    yNJc35QTb7fiKPbTj79CUaNHjbPlD+5Apdy0G0kCSaSQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffedugeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffedugeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032197AbeCSSdU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:33:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032179AbeCSSdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.15 31/52] xfs: preserve i_rdev when recycling a reclaimable inode
Date: Mon, 19 Mar 2018 19:08:29 +0100
Message-Id: <20180319180736.793938090@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit acd1d71598f7654b6d7718bcbe979992295c672a upstream.

Commit 66f364649d870 ("xfs: remove if_rdev") moved storing of rdev
value for special inodes to VFS inodes, but forgot to preserve the
value of i_rdev when recycling a reclaimable xfs_inode.

This was detected by xfstest overlay/017 with inodex=on mount option
and xfs base fs. The test does a lookup of overlay chardev and blockdev
right after drop caches.

Overlayfs inodes hold a reference on underlying xfs inodes when mount
option index=on is configured. If drop caches reclaim xfs inodes, before
it relclaims overlayfs inodes, that can sometimes leave a reclaimable xfs
inode and that test hits that case quite often.

When that happens, the xfs inode cache remains broken (zere i_rdev)
until the next cycle mount or drop caches.

Fixes: 66f364649d870 ("xfs: remove if_rdev")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_icache.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -295,6 +295,7 @@ xfs_reinit_inode(
 	uint32_t	generation = inode->i_generation;
 	uint64_t	version = inode->i_version;
 	umode_t		mode = inode->i_mode;
+	dev_t		dev = inode->i_rdev;
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -302,6 +303,7 @@ xfs_reinit_inode(
 	inode->i_generation = generation;
 	inode->i_version = version;
 	inode->i_mode = mode;
+	inode->i_rdev = dev;
 	return error;
 }
 
