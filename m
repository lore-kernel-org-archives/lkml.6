Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832864-2-18118943177410209587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832863; b=Tc9b5kwD9A2Ywly2SJOLGPAsRKoDCNh4ixHqcmms4KX9UeA
    d88Qoz0xw6NOWWO6L7B9otvMG/cYtxWOUQ2UrjUGSu3NNWvXi/CrG7QfjltTqEB8
    dZcY9O1qTrw0wz5bcPQbyvy+2fUP/n/zdq581bW3QS+02PPXamXEC+pw0cMKPVU3
    ZupnN/WvgbEgG94gbnYQ9ZQv2rjNdq5p7p+2aZj9XGlk5xaTKs4R9rBKdH9LmQkg
    enxK6rAXPnBRg/6J7I/SqvtevR22VjVGSturk6y7nERyXDCB2nQ6z5q1DN7S7Wkn
    A63AG8L4oP3ajCrXAEgi0gVwxs389Idv1XtK9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832863; bh=LTA1ujFP6fHQ9iDNiNR
    QlzqyNqgnw5oIGeaW9Eff1jo=; b=L27r9sr7bqpY/WUGYjkMjOcgilPaYy0sk1R
    4s4oaA4EvBJA7um6VfNcqVn/wEh28Yu467RhSCri7V0aYb2VZNj4Sj4nDd7XaAW1
    mXArsgUn57JJ7ftkMER5k3L0dgwraAd81cBWnuQo/ipe2MG9Psfej8Fe/1FcfZR2
    URmbBoq6XuO9Qc/C4v9sYEldRFbEBVWnrxUahxabV8FajvnXk8xn8aQ34eBJEYuI
    l9PxnVCeYP83knoBfFP8vZuW4MwbDL3xHCDv9yNamVXwbA8l/VSDCAkx7SDWBT1U
    REU6UrdC7sWHcPaX8S9XN3Sa9EiPg/laOAlh8DnuJj6sqFSKvOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeB1Prj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:47:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33352 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932635AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.789903846@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 068/140] ring-buffer: Mask out the info bits when
 returning buffer page length
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 45d8b80c2ac5d21cd1e2954431fb676bc2b1e099 upstream.

Two info bits were added to the "commit" part of the ring buffer data page
when returned to be consumed. This was to inform the user space readers that
events have been missed, and that the count may be stored at the end of the
page.

What wasn't handled, was the splice code that actually called a function to
return the length of the data in order to zero out the rest of the page
before sending it up to user space. These data bits were returned with the
length making the value negative, and that negative value was not checked.
It was compared to PAGE_SIZE, and only used if the size was less than
PAGE_SIZE. Luckily PAGE_SIZE is unsigned long which made the compare an
unsigned compare, meaning the negative size value did not end up causing a
large portion of memory to be randomly zeroed out.

Fixes: 66a8cb95ed040 ("ring-buffer: Add place holder recording of dropped events")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/ring_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -360,6 +360,8 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data
 /* Missed count stored at end */
 #define RB_MISSED_STORED	(1 << 30)
 
+#define RB_MISSED_FLAGS		(RB_MISSED_EVENTS|RB_MISSED_STORED)
+
 struct buffer_data_page {
 	u64		 time_stamp;	/* page time stamp */
 	local_t		 commit;	/* write committed index */
@@ -411,7 +413,9 @@ static void rb_init_page(struct buffer_d
  */
 size_t ring_buffer_page_len(void *page)
 {
-	return local_read(&((struct buffer_data_page *)page)->commit)
+	struct buffer_data_page *bpage = page;
+
+	return (local_read(&bpage->commit) & ~RB_MISSED_FLAGS)
 		+ BUF_PAGE_HDR_SIZE;
 }
 
