Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunOKRWmcREHyV5d28kFFc0Hz/cpKlwTdrf3MCXUgFCFPk2ehwBikwHAJoVo6mfUtpUyuK1
ARC-Seal: i=1; a=rsa-sha256; t=1520955051; cv=none;
        d=google.com; s=arc-20160816;
        b=wf30zNt/5JQCzYO3NwjYh+j04a2xE+531JmXCzfWeH4XYMM43tBDq4m6bgRVJlbVO0
         1ECmbFtgIGX09SvTy2C07gZt+aX81uJk/7DqprListbCs99rh3tgIGACbdnWX0Bo1qm6
         L3kMg571Y6frxU3uKQ05EvO1V4Xuuw/8GIOQLjFup9CqZyZf5XK+uQCGyZ179kj7bb+B
         a3A74VSS0ajCYZyKgT1nwCJMCJLSBBTQNm4fYT16YM5LugC4z8MoG6HPsHcnmDBp5Dzn
         Dta4CIjmA1oL0KrR0TxA/+vXlPRNwDQZ76RMH7YmI/AUZVOp5qP2/DTTbIUtHNnGv/SR
         3E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LxTEVpO5m9yjoZSHR+Xj2lX8FRSRezcdW1Qeb7fMYU4=;
        b=IuvcJhUjBqJbF6Jla8AG1SeOzTSTAYzy+PnF42SA6rTH6ZOSAaENASdC4UUcR6dG2Y
         VY1K2QTubNHY5sQtIzIQxtmwuzbKTbtrb3HHx2ptK59Z2g1zrC/ReJGhKp2dJqNvUNaq
         V2/dod3oHjiki0prGajvco55FjdZKSYozCfhXKm+B4CFIBPN7IQqQLmR4zrC/X5s+dQw
         MNPS1Zte8ZE+SJkE5n1WfLtFIw+kwu2AcA3Xcgo1OTiNr9XzgHdLCX3Kg47Wq1UikDrc
         Zm/9OWtyX53G5O5OIGiZ8u4a3qzXxDn5yg5HaNZMHQxEO+Lc/O6VKjzVyvJnGo+yAezf
         Rk/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Vacek <neelx@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Paul Burton <paul.burton@imgtec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 048/146] mm/memblock.c: hardcode the end_pfn being -1
Date: Tue, 13 Mar 2018 16:23:35 +0100
Message-Id: <20180313152324.348371381@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836963578294574?=
X-GMAIL-MSGID: =?utf-8?q?1594836963578294574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vacek <neelx@redhat.com>

commit 379b03b7fa05f7db521b7732a52692448a3c34fe upstream.

This is just a cleanup.  It aids handling the special end case in the
next commit.

[akpm@linux-foundation.org: make it work against current -linus, not against -mm]
[akpm@linux-foundation.org: make it work against current -linus, not against -mm some more]
Link: http://lkml.kernel.org/r/1ca478d4269125a99bcfb1ca04d7b88ac1aee924.1520011944.git.neelx@redhat.com
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memblock.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1107,7 +1107,7 @@ unsigned long __init_memblock memblock_n
 	struct memblock_type *type = &memblock.memory;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
-	phys_addr_t addr = PFN_PHYS(pfn + 1);
+	phys_addr_t addr = PFN_PHYS(++pfn);
 
 	do {
 		mid = (right + left) / 2;
@@ -1118,15 +1118,15 @@ unsigned long __init_memblock memblock_n
 				  type->regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn + 1 is valid */
-			return min(pfn + 1, max_pfn);
+			/* addr is within the region, so pfn is valid */
+			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
-		return max_pfn;
+		return -1UL;
 	else
-		return min(PHYS_PFN(type->regions[right].base), max_pfn);
+		return PHYS_PFN(type->regions[right].base);
 }
 
 /**
