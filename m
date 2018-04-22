Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406511-2-16848544330170389168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406511; b=WPqoaGlAMnxer/7L6KqhGk8Yy6vDPWLVzfaYyEYnwUhCuMqmmo
    2rqssTOPYG3UnKb8ktWFlV4zBwi3z1C3kJIXYet7D6ym8hNDcf5zwS2qFs6u1x/u
    kXmyx09FAIY9o8NizGmllzewmq/EPHGohZgG69RAFnzoyCrcvqcLlZXJYfBLsj7d
    /3rVdhUYnUGyu0YzV8oWZzsnjygrqACE+FvzqgdqqSD/fM+1oNnD0KmX6KmPWPMw
    F5ksfGwpcasFIctdWGr/VCPqhGlqfwoQOIXElTCghgJwctCc856D/AIfulMulMdL
    0xD34qv9MOTzD+hwRxJL9OwhR4IcGmnWxgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406511; bh=TGHKnFseE7l4MBHBjky0J9JTHadh9M
    rPChET3j68PQc=; b=Y0nyP5Lhj+CdgffszU01v8r4iD6xYdhqrLea69aB/F/gn4
    W3FyFnHG/bcjDmkPip/rSujejxYq1zIhuXE9Zrq3NXpxEMqWlHdDs9xd5Tgxz1Ja
    E3aPM5mAL1ZDC0nWD0BMwwqkfuDvyy0LDre2OZhItogw6GIa5UiFC0qvbI0V5GrP
    gWdrjJIdK4+pX6OOAuUnuj9rbNKbyJzS1u3IuW5r0zTAjyqCvSZ4DBGBsgWntn9X
    70T+d1w7RiKh4c1eNHO1oP5N84R6xpNjg1wCR94izbpEumwAJ8zbsA1JBHgAW7HR
    LrlOh9ov/oCw9WAOhhdbReUTgkxAQti2PlmLSARg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEfxSWXJo70kNgJ8lnuLAgkAO7jRwtlqypaeIPRma1SYpWVBI+5G93/xy1M3vjwgWXDnGw8YMz9L41E/kGaw/sor8ROlS2KQunj6YFezWIncGi7AgcEb
    QO7VlcA2akKb91lu3HVYPQPswCp1WsXXsxlKkN1JpT1ROMN+OqD9rbR4rjEK908GzCmQ+HBYmOgb7Mc6juDF2lTZudPXI2zVynWiVSgdD354eOmXzEHOjrEe
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=RzkCPbG2nWqKWaSwnvMA:9
    a=vVanrsHwGZdIcQen:21 a=OpNlmf4WbKlEMxjJ:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeDVOPF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeDVOPA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 93/95] fanotify: fix logic of events on child
Date: Sun, 22 Apr 2018 15:54:02 +0200
Message-Id: <20180422135214.220892293@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 54a307ba8d3cd00a3902337ffaae28f436eeb1a4 upstream.

When event on child inodes are sent to the parent inode mark and
parent inode mark was not marked with FAN_EVENT_ON_CHILD, the event
will not be delivered to the listener process. However, if the same
process also has a mount mark, the event to the parent inode will be
delivered regadless of the mount mark mask.

This behavior is incorrect in the case where the mount mark mask does
not contain the specific event type. For example, the process adds
a mark on a directory with mask FAN_MODIFY (without FAN_EVENT_ON_CHILD)
and a mount mark with mask FAN_CLOSE_NOWRITE (without FAN_ONDIR).

A modify event on a file inside that directory (and inside that mount)
should not create a FAN_MODIFY event, because neither of the marks
requested to get that event on the file.

Fixes: 1968f5eed54c ("fanotify: use both marks when possible")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[natechancellor: Fix small conflict due to lack of 3cd5eca8d7a2f]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fanotify/fanotify.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -92,7 +92,7 @@ static bool fanotify_should_send_event(s
 				       u32 event_mask,
 				       void *data, int data_type)
 {
-	__u32 marks_mask, marks_ignored_mask;
+	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	struct path *path = data;
 
 	pr_debug("%s: inode_mark=%p vfsmnt_mark=%p mask=%x data=%p"
@@ -108,24 +108,20 @@ static bool fanotify_should_send_event(s
 	    !d_can_lookup(path->dentry))
 		return false;
 
-	if (inode_mark && vfsmnt_mark) {
-		marks_mask = (vfsmnt_mark->mask | inode_mark->mask);
-		marks_ignored_mask = (vfsmnt_mark->ignored_mask | inode_mark->ignored_mask);
-	} else if (inode_mark) {
-		/*
-		 * if the event is for a child and this inode doesn't care about
-		 * events on the child, don't send it!
-		 */
-		if ((event_mask & FS_EVENT_ON_CHILD) &&
-		    !(inode_mark->mask & FS_EVENT_ON_CHILD))
-			return false;
-		marks_mask = inode_mark->mask;
-		marks_ignored_mask = inode_mark->ignored_mask;
-	} else if (vfsmnt_mark) {
-		marks_mask = vfsmnt_mark->mask;
-		marks_ignored_mask = vfsmnt_mark->ignored_mask;
-	} else {
-		BUG();
+	/*
+	 * if the event is for a child and this inode doesn't care about
+	 * events on the child, don't send it!
+	 */
+	if (inode_mark &&
+	    (!(event_mask & FS_EVENT_ON_CHILD) ||
+	     (inode_mark->mask & FS_EVENT_ON_CHILD))) {
+		marks_mask |= inode_mark->mask;
+		marks_ignored_mask |= inode_mark->ignored_mask;
+	}
+
+	if (vfsmnt_mark) {
+		marks_mask |= vfsmnt_mark->mask;
+		marks_ignored_mask |= vfsmnt_mark->ignored_mask;
 	}
 
 	if (d_is_dir(path->dentry) &&
