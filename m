Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3904616-1526646955-2-12746849903046693830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526646954; b=OaIVMEgM3mouHIaXn+YlNBUMFg3ol6MKyoGXj78P2i9bNeCVbb
    S4byzbMFKPLRBENJhgkd4GVwYlt7JXReHxmgJjAyebFkWDz/JKl94FQwwTqLoX1y
    DAlMnQag6DYgIQGntLnqCfSguh99MCePzHB0FWnDcg4cLyr7/joCurn9FhEuvkvd
    8TBoBQsRshdvDjc/XOVzcqeGi+fu5RnDndxW+vBS81Npg8dGLHV48kuw5kJjLfQf
    +NqlpcPx7j0kYobZaP06BF+M8bb8OVwu5LYF3yRgg5R/uuF5HQENc7UisOolhKUo
    VtpDYxdDznvMtOhYeX88UDntEv8B9E5+JAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526646954; bh=
    9loxJXW8WvbYRac/cqaHixXtn456kdRUi1BnoIBtu0U=; b=FH5r+rVrA7rVA2Jn
    6jfHs9/dTgeaLmJ7mLXVi2D/uTs03W0Gm3HeHVW4bYQ57Tw+2zWs3l3Lvpp273o6
    Esgyhhs88YjeDuKb08egQKOrLwfKjAr1DKMHv/mlLGAVLT8ZK4R5DQO1ZlDCG/uV
    LKCk3r/CtGa2kn2wtHISmQMhcwUxO285pMgQk2ElStzsxN75JjcGEv/MxXX9z4TW
    EFJLxjaPeFxkLHVNYrQv7gYsk3hOgv9FTapYWM8PmBTbM9sy16L8CAr/21kRl7np
    KhWArA5NP2UznJ2uobqhCRgL/KZ1x3ziM2tB/kXCR/LGNDNe/ADKaQWy0MPk5i40
    CifDEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=bmZC863n x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=bmZC863n x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNt8ytoHDw734kFXJK/Y25HLdiCXnP9qC9t2iKqFY20sqzvzMlCinD9VSSPL5JIB2hV18v9l3T0VfTg+lW4GULu9Gn/bBkxvYkLuqiEhr6kavQsIszy
    tpxW+rQyTINE5OC/gQbNSANnqmwJ8ujlONzANqyXxKHJ5gB0VH643+WcujJ6Vtk61U5F+DfSbcnwcXOuZKjOoc5Cu+MwkB0xCn+B/19cgtPNxE5WNAZlPvlJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=cqVuzkrYcYAoY6c874QA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeERMfv (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 08:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeERMeY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:24 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 07/11] ext4: have sync_fs op report writeback errors when passed a since pointer
Date: Fri, 18 May 2018 08:34:11 -0400
Message-Id: <20180518123415.28181-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

When ext4_sync_fs gets a non-NULL since pointer, use it to report
errors vs. the errseq_t in the super_block. This allows us to
properly report an error to sync_fs when any inode has failed writeback
since we last checked for it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ext4/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 896ddf8c3421..a5f41d31611f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4898,6 +4898,8 @@ static int ext4_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 	}
 out:
 	ret2 = __sync_blockdev(sb->s_bdev, wait);
+	if (since)
+		ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
 	return ret ? ret : ret2;
 }
 
-- 
2.17.0
