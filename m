Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA7920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrL/TBan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA7920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbeJQBNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F7E12089E;
        Tue, 16 Oct 2018 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710547;
        bh=CGgyD4NGKBQyQ9GBVgQfM2aLwfcRMqMvk6COgwZkUaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrL/TBanLkSVXLcSgN0BPCCJJqv10Br34rGzHYlsVvOk15u4G1cn00v62acQSITdW
         W9xxchmvP3TKbDZaQcj/4IT6YtPIWVTW5Or4graToK+cDdMTSqkSOfweZeOcieziwW
         WXirLrc4z5o7A4DKT9/8BfeOxfUx90JLIX5i8YvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 084/109] mm: dont show nr_indirectly_reclaimable in /proc/vmstat
Date:   Tue, 16 Oct 2018 19:05:52 +0200
Message-Id: <20181016170529.586074819@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

commit 7aaf7727235870f497eb928f728f7773d6df3b40 upstream.

Don't show nr_indirectly_reclaimable in /proc/vmstat, because there is
no need to export this vm counter to userspace, and some changes are
expected in reclaimable object accounting, which can alter this counter.

Link: http://lkml.kernel.org/r/20180425191422.9159-1-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1090,7 +1090,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
-	"nr_indirectly_reclaimable",
+	"", /* nr_indirectly_reclaimable */
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
@@ -1673,6 +1673,10 @@ static int vmstat_show(struct seq_file *
 	unsigned long *l = arg;
 	unsigned long off = l - (unsigned long *)m->private;
 
+	/* Skip hidden vmstat items. */
+	if (*vmstat_text[off] == '\0')
+		return 0;
+
 	seq_puts(m, vmstat_text[off]);
 	seq_put_decimal_ull(m, " ", *l);
 	seq_putc(m, '\n');


