Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484446-2-16142306066168423439
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
    t=1521484446; b=rmuvIsxJMsbZ+sLspw5wc4vykgEQsAYQU90KRVD4GTTf+WL
    ojv2n/d6KWLRiecYb6pgaBQpicckh4dv6stPkYIFy6j52lyFtuQwOtTPYb/e6600
    x5997nFcnjLs3C1InK+dhIx/BCZ7fpAxl3YRnrPKL8EyMD534p0gX724ceGBUW5h
    CYHCzVSoZQQIJ0esqKMCHIqPpAE6tdFLrFtT+dw4ZqCO4eDHkMOg4Ay1oWt0eY8B
    /h9CVX1LsSMkeunM5A+hA3zqUzhfih01yVcQibdjtMdLgR6Y54VmOQ+ufegoylLF
    UlwRmfn6jlYEyRzragV2Mnl27q8kfMVP/YvJFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484446; bh=xb7t7ujzzonbXs8WgzdqLnoUE/
    4rgUus6au3IeLgNa4=; b=ZA2w/7e/Cosv9dJn05nTxDYMmfawhETryKjbOf/Zsm
    U6F2xA7amxFSID9X3Aeg69krcGiV1C1fD77C5qMnPe2jQdfS9gnzn9JoSDLRH9zt
    CywvLOYFQeDlV5mJsgsRSMlZDhXP/H0AACAM6DrzP4zRdqWzeKofJbWmsdgnC+Ar
    Z4TczTyM5jw8Yw82NC1edDd9/SGALIqaff+bMW726qGo2Kc/JOzV4Lp8LQZ9WZ6R
    WIzxz+BLd/fEoiPnS3x6QJKu34Ygnq4f+NWRxZ0BFRtI7QS9mClShLAl7nnw1r8e
    t8plnXV22r1xj1nJTyn9uGoiG6zm7Uz7wx8mhmLbTCVQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefieejieenucevlhhushhtvghrufhiiigvpeelvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefieejieenucevlhhushhtvghrufhiiigvpeelvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032217AbeCSSd0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:33:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032208AbeCSSdX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edmund Nadolski <enadolski@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 33/52] btrfs: add missing initialization in btrfs_check_shared
Date: Mon, 19 Mar 2018 19:08:31 +0100
Message-Id: <20180319180736.877316375@linuxfoundation.org>
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

From: Edmund Nadolski <enadolski@suse.com>

commit 18bf591ba9753e3e5ba91f38f756a800693408f4 upstream.

This patch addresses an issue that causes fiemap to falsely
report a shared extent.  The test case is as follows:

xfs_io -f -d -c "pwrite -b 16k 0 64k" -c "fiemap -v" /media/scratch/file5
sync
xfs_io  -c "fiemap -v" /media/scratch/file5

which gives the resulting output:

wrote 65536/65536 bytes at offset 0
64 KiB, 4 ops; 0.0000 sec (121.359 MiB/sec and 7766.9903 ops/sec)
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128 0x2001
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128   0x1

This is because btrfs_check_shared calls find_parent_nodes
repeatedly in a loop, passing a share_check struct to report
the count of shared extent. But btrfs_check_shared does not
re-initialize the count value to zero for subsequent calls
from the loop, resulting in a false share count value. This
is a regressive behavior from 4.13.

With proper re-initialization the test result is as follows:

wrote 65536/65536 bytes at offset 0
64 KiB, 4 ops; 0.0000 sec (110.035 MiB/sec and 7042.2535 ops/sec)
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128   0x1
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128   0x1

which corrects the regression.

Fixes: 3ec4d3238ab ("btrfs: allow backref search checks for shared extents")
Signed-off-by: Edmund Nadolski <enadolski@suse.com>
[ add text from cover letter to changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/backref.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1509,6 +1509,7 @@ int btrfs_check_shared(struct btrfs_root
 		if (!node)
 			break;
 		bytenr = node->val;
+		shared.share_count = 0;
 		cond_resched();
 	}
 
