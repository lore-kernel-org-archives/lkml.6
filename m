Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA45C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96682081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abyAlB6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96682081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbeKEWm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:42:26 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49187 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKEWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:42:25 -0500
Received: by mail-pg1-f201.google.com with SMTP id m21-v6so8434764pgl.16
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qyG6RYi1emRCFoDSrD4q/5RjzFPWwqnJtaEW3lGdNsE=;
        b=abyAlB6c4bpgQTwEdCaE9mURdL2mYzyZKfZw/4xccG5X3cTmgZo74XL7t3rUgC8H41
         +Y2YZbjYConfAyVAOYCi3rG1hwNRAmQpCQ7xSCUKP3PAUv5dzuRIPOn37307UP2zZFxm
         iz2zCkemuSvMgIuy2hWQd7fKCFOAiJCUvzlHHqCwB3A/dszwgN+HFYtJ5nXV/pIObKKn
         gwGYZWFwLwuX8J2bPbZOyPURIA8m6e12PR2ZT0r1a2+peIvbs7Thx2iLUhMIHTrfenOZ
         wvh8e/5u2gW8uhSRKLzYoo+z2xU9GEWXbfb7FsmJkwJatS0shzQ7hOVgQHsLUp79sgAS
         uXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qyG6RYi1emRCFoDSrD4q/5RjzFPWwqnJtaEW3lGdNsE=;
        b=d4ifDzGpiPK0eW/wErYFP6YPVWv2q834YeYUkiGagiIzs9wjNYU+IDqijmqWB/hfkF
         NVorThIOdQ8kBbkJANCTgQ7gN0ckrGr/KfjJ7tqQ+ykIy65xpoZW/lImixBwSVhCvzo2
         EeF0e6PnY9qjuequAt7gxPfn7pVHUBikff3NRqcTu1mB96niBQsJVt+yf5Rwi6o+3+iq
         I9WzCCv1KYjE1UqMfDVR1bdSEHDhppgxI4io2Pi/jiK1wg05p7O5j+cXVWU7sHaV6Mgp
         y1efUExy2O1VbdBtz1+6vErehScRpKvvr5u17ZeShRcOtJzJgnFIjDDeZ9b49q8Lueup
         aqMA==
X-Gm-Message-State: AGRZ1gJfpseflA/KNRfZAusBDv/chokMr922KjibMdIcGLJBk/yuZarL
        YauSK9vfl+x6vzXFQOg2OFXvEILPKaximoY8fmvKyifMVxF+MwXu70dWGcOqz4JG2Yz46neu5jo
        juJfyb2QhdUxEvRyjwXcOZ+VT0HpwIUf3euiz9Ps/qs2uwKUNmp3/D7cSdLy/YKhKTxtLBQ==
X-Google-Smtp-Source: AJdET5crInab6qKFtj+ozd9PKIQew+qXmIyuelKTMYfr4CbYOLv7YW+5obHTB4N1twteh304A6QuMssWOh8=
X-Received: by 2002:a17:902:7245:: with SMTP id c5-v6mr752690pll.4.1541424160960;
 Mon, 05 Nov 2018 05:22:40 -0800 (PST)
Date:   Mon,  5 Nov 2018 13:22:05 +0000
In-Reply-To: <20181031150625.147369-1-dancol@google.com>
Message-Id: <20181105132205.138695-1-dancol@google.com>
Mime-Version: 1.0
References: <20181031150625.147369-1-dancol@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH v2] Document /proc/pid PID reuse behavior
From:   Daniel Colascione <dancol@google.com>
To:     linux-kernel@vger.kernel.org, rppt@linux.ibm.com
Cc:     timmurray@google.com, joelaf@google.com, surenb@google.com,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
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

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 Documentation/filesystems/proc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

Moved paragraphed to start of /proc/pid section; added signed-off-by.

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 12a5e6e693b6..0b14460f721d 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -125,6 +125,13 @@ process running on the system, which is named after the process ID (PID).
 The link  self  points  to  the  process reading the file system. Each process
 subdirectory has the entries listed in Table 1-1.
 
+Note that an open a file descriptor to /proc/<pid> or to any of its
+contained files or subdirectories does not prevent <pid> being reused
+for some other process in the event that <pid> exits. Operations on
+open /proc/<pid> file descriptors corresponding to dead processes
+never act on any new process that the kernel may, through chance, have
+also assigned the process ID <pid>. Instead, operations on these FDs
+usually fail with ESRCH.
 
 Table 1-1: Process specific entries in /proc
 ..............................................................................
-- 
2.19.1.930.g4563a0d9d0-goog

