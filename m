Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeERHuI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:50:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40920 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeERHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:03 -0400
X-Google-Smtp-Source: AB8JxZoGI0caiupmgS8081tJlkRFxw4GiDliYkgUG0z8KzRp86onPrkXzqp4dm9Rok5baYgNWOPwtQ==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 04/10] locking: export osq_lock()/osq_unlock()
Date: Fri, 18 May 2018 03:49:06 -0400
Message-Id: <20180518074918.13816-9-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 kernel/locking/osq_lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f..dfa71347b0 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -202,6 +202,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(osq_lock);
 
 void osq_unlock(struct optimistic_spin_queue *lock)
 {
@@ -229,3 +230,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	if (next)
 		WRITE_ONCE(next->locked, 1);
 }
+EXPORT_SYMBOL_GPL(osq_unlock);
-- 
2.17.0
