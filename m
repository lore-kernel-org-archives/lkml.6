Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1376423-1526531699-2-772809287213848309
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526531698; b=OiXwllK4ke22OBMDZUxQA6RPxBYEdanoDH7xlxNw5/OIYJsWGU
    xpVBqJEbWm3sDCfkWVbz5ase3peL/r7TzGz9XsIfM1eOqiPhTPd8T4gn73UTy/UX
    OwMfefgaf0HCcVRFpxq1Ya+/tCcfEtn2rZLVD9Hmlf05huSfkhnkpZd3rmg2bWHa
    xJ0jhqXeHhVbRpkIhKTMbm1TRC6h+9rM/JF56WjmEXg2SC3wbpwvQhgOyUcH9w2A
    qJswmovg7IJRRFXqLJ/BtgnFb7uypZg1zPx3qoB7RhFC8PN2r1ysMs1ZSjGZSJq1
    2bBZKjqxqXy8o4OBgdHd65sbil4Rhko7/qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526531698; bh=y/sOzhmUCakpWB45y4hWTaWNv3KAYC
    i06CZZTVldsOo=; b=H0mQiMnfSrgTGWzj8RcXuRTAqRbfARqa68fSScNgqbuibP
    zuLQdbNWzTnPmLq6e2gDgAWxuZ/qOqZRuxDgyIrjjxBS0LWuYDyy3HtHGkI1tbjq
    YfUWUw0wnN+VgwDmCkQpafVASQQIIfSKQOwSl+GJLiu1/Uh9JlTVOAvXSGvH/FKt
    JNpbtNaiu/VQEKmE17Ozhlt66DxqzJujPt5hdeFAc+qesKSzWLb9U2UOwlDTaxTS
    MxnypDOgkoeY617kXfvUqVp7X8eL1cb6zVRBtoz+0pxKW5v94G4VIiVzmtsYuEMO
    rlYJ7BiJvEEQSFRfW9em2Mpd2OcgFLLZbcenigdA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=MQwfOehx x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=d/2lcfwK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=MQwfOehx x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=d/2lcfwK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4NRdWETTdD+LmVshvG/OYiX7i2dnB0QONv1v916FZC8xZMKP+DIkoGokdpyNO4wEqrKn1ivywpyVhC1/KT69Vf9oTfy6uHFNymhk+bUaZhlY7j0dhs
    sT8sJL+gp+sZjxVaukf8JBGiPXFcF3BELhU8ObHGXQ016gogSiFdIBP4tJweo7sAnVU0d5UnGqiBly2dWvH1WCIhs390TPy+Q9l16F3b8A15JtTRc14TcHXy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=3j4BkbkPAAAA:8 a=S2bl7dCyTycZogkFfaUA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbeEQEe4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:34:56 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42663 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQEe4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:34:56 -0400
X-Google-Smtp-Source: AB8JxZpg0Omp4yC0Y7t/kxBlWDJqg3itNHEmDdg6wxJKr6YL17kOJpYZPd9qr/SfM4Geose3keqLNw==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au
Subject: [PATCHSET] workqueue: Show the latest workqueue name in /proc/PID/{comm,stat,status}
Date: Wed, 16 May 2018 21:34:42 -0700
Message-Id: <20180517043448.3152269-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There can be a lot of workqueue workers and they all show up with the
cryptic kworker/* names making it difficult to understand which is
doing what and how they came to be.

 # ps -ef | grep kworker
 root           4       2  0 Feb25 ?        00:00:00 [kworker/0:0H]
 root           6       2  0 Feb25 ?        00:00:00 [kworker/u112:0]
 root          19       2  0 Feb25 ?        00:00:00 [kworker/1:0H]
 root          25       2  0 Feb25 ?        00:00:00 [kworker/2:0H]
 root          31       2  0 Feb25 ?        00:00:00 [kworker/3:0H]
 ...

This patchset makes workqueue workers report the latest workqueue it
was executing for through /proc/PID/{comm,stat,status}.  The extra
information is appended to the kthread name with intervening '+' if
currently executing, otherwise '-'.

 # cat /proc/25/comm
 kworker/2:0-events_power_efficient
 # cat /proc/25/stat
 25 (kworker/2:0-events_power_efficient) I 2 0 0 0 -1 69238880 0 0...
 # grep Name /proc/25/status
 Name:   kworker/2:0-events_power_efficient

For details on the design decisions, please refer to the following
thread.

 http://lkml.kernel.org/r/20180516153939.GH2368884@devbig577.frc2.facebook.com

This patchset contains the following six patches.

 0001-proc-Don-t-allow-empty-proc-PID-cmdline-for-user-tas.patch
 0002-workqueue-Replace-pool-attach_mutex-with-global-wq_p.patch
 0003-workqueue-Make-worker_attach-detach_pool-update-work.patch
 0004-workqueue-Set-worker-desc-to-workqueue-name-by-defau.patch
 0005-proc-Consolidate-task-comm-formatting-into-proc_task.patch
 0006-workqueue-Show-the-latest-workqueue-name-in-proc-PID.patch

I'm applying the patches to wq/for-4.18.  Please let me know if the
patchset need updates (the branch doesn't have any other changes
anyway).  diffstat follows.  Thanks.

 fs/proc/array.c             |   33 +++++++-----
 fs/proc/base.c              |   27 +++++++---
 fs/proc/internal.h          |    2 
 include/linux/workqueue.h   |    1 
 kernel/workqueue.c          |  117 ++++++++++++++++++++++++++++----------------
 kernel/workqueue_internal.h |    3 -
 6 files changed, 122 insertions(+), 61 deletions(-)

--
tejun
