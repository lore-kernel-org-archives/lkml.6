Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F462081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGakynDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F462081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeKAAFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:05:08 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:42826 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeKAAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:05:07 -0400
Received: by mail-it1-f201.google.com with SMTP id v125-v6so17416712ita.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MdeA04nU+MLEKdLZHJb7KdahAUeTZ8VVAY1vZvjqjuU=;
        b=UGakynDllCqQPpustjzPu9CoqcvyfyKsrJKhS1bW0bo1OKHCPW4q8leNP00m6RN/57
         FSQoH9DtcASyC0uoBpGG/wQMR+5nupBbKkNrXRF2pXJHcTlpL869kr+0NhDXCK6V7yeT
         5rRPl50eI+uPOB4X9ZEWbVMWsDFy5wuF+Pf0cx4WLUlrNa0BPkv29Pdt/H86WTHP+8n5
         6oyAE3W87U02VkpK64D3tCewu/UlrYCcMIZZc9486HOEOn7BwXIH+RND9lrnTAnB2+IQ
         BeFnS93X1At5Ct006iLbazOTOotHIiz4LeQZkghQIuCJZYq88NA+drQIfN9iR4bKIqUt
         F3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MdeA04nU+MLEKdLZHJb7KdahAUeTZ8VVAY1vZvjqjuU=;
        b=ie8KBXVw1FQax+huMD+8hfbf0rDl4ELOGbyFWu4D7iv3+YfFdGr3b/Oglix/FzGxHU
         oMslYanCE863WTt8sk0rDEha/2M9Hk7Mlsf9lIvdgN8Kb2+4veWPOqbLnjNhvE+mWnOy
         fzh0yaAqkh2p+sIIC+Txe5IB52LV6DGT/zVDTANCLE/fGrHseE3pgIO1Y2Hlxsv9/Ag5
         Bwgyz7eHWgykjNYs2x7qV2Ele4xd0/4G/A9iNL5epBu1BYcGqRgyfXXeCTgnQvpbzauU
         8OLPB0Iw3jrRVTzSydhf6cSa8is8CHB+foM3uFkOuHIRPq0f+JUOmJdI0NHS1xwxgQYL
         1x/w==
X-Gm-Message-State: AGRZ1gLSKWg22dZNPqxi9OhA48YC2HSIedQlGW5oquH0DYgtxXoNCVaZ
        3Yb8EeySI9BpDBuR2I1HYtUkofOLBgMcqs4Y6ua/hNL1zv15xhYPNTfUsB2dl5oJopTNr1fO814
        2bgbAoYFASpZHulZn7d1z5aJ8bWsIzT1LDOcGCOait143shhu3nFm96IlvUj2ui182F/j7g==
X-Google-Smtp-Source: AJdET5fPR2tF3cHlGFKxr6nYlk0jOL3UbZd+NZYnYMrX78m2DPjieFB6AKY7mTtXpu/00BBWywDVeLsOj2k=
X-Received: by 2002:a24:1cd2:: with SMTP id c201-v6mr1953892itc.35.1540998403369;
 Wed, 31 Oct 2018 08:06:43 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:06:22 +0000
Message-Id: <20181031150625.147369-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] Document /proc/pid PID reuse behavior
From:   Daniel Colascione <dancol@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     timmurray@google.com, joelaf@google.com, surenb@google.com,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

State explicitly that holding a /proc/pid file descriptor open does
not reserve the PID. Also note that in the event of PID reuse, these
open file descriptors refer to the old, now-dead process, and not the
new one that happens to be named the same numeric PID.
---
 Documentation/filesystems/proc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 12a5e6e693b6..567f66a8a23c 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -214,6 +214,14 @@ asynchronous manner and the value may not be very precise. To see a precise
 snapshot of a moment, you can see /proc/<pid>/smaps file and scan page table.
 It's slow but very precise.
 
+Note that an open a file descriptor to /proc/<pid> or to any of its
+contained files or subdirectories does not prevent <pid> being reused
+for some other process in the event that <pid> exits. Operations on
+open /proc/<pid> file descriptors corresponding to dead processes
+never act on any new process that the kernel may, through chance, have
+also assigned the process ID <pid>. Instead, operations on these FDs
+usually fail with ESRCH.
+
 Table 1-2: Contents of the status files (as of 4.8)
 ..............................................................................
  Field                       Content
-- 
2.19.1.568.g152ad8e336-goog

