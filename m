Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834968-2-3503655454315112261
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
    t=1519834967; b=D3d2BsdIR55eCkChwx01bPWT5J5d+6wbB1g+BgVbCEVG8xw
    P5mDaCTihbeR60DmzPgNw7LQi3gnqT9jKFDeSTf9awmO4MewLPNewY1ztrw+ysEk
    s0jrEnOImuqudYoZ5EfCjPnm5Jd4uEi7JlNJG9VlonA2wxT6xRdLIpmiz0gIwmnp
    X8iNaEEWNiVUYpF+SSvaaN2i0wIl5tYkDHUi1ikz1KmKph1QwBWV6TRtxCEL/d6v
    mN2NvVvWRgIrG8cP6qJugo/U4ursv9TzkpTkAXScG1J4Y4lVBqc56Rc81CmC6Z07
    OscD7/81hNcO+/ASa1moIyBYxt/IXZK9q26WS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834967; bh=ttgBjnoHVg8FuV4V0M7
    QgLpPHjWkhZFP3Rd3qcfTpJY=; b=el4y782wc1oA/acJVU1Yb6u4zDI1fOB69NL
    cc97wrt2M27fbcjDiUpRZNndBOHiV7JRofdDdqfnMvCabsff7DzTTqrSj1PhBRYU
    TrlD33sS22h5CoJNjVN4JBDR9ZJrcurHr6PZr/igTP4b6XekALXAteUdTaBn9BW3
    hoK4ejBZMg+c+HJWSThPVjl16Kz3NNyeIB8VQvQcEk/tMueRndLaJ80j9VyUdAbL
    it3h9ab19bsYrTiyqHCqjbGdfic8Y/hpET6ZxUMU/KGjYhiv+PPwynHl+ZqRZu7b
    TQ84118HTVRJU6ABvQwh3Bk6zVPTwOEeU0Aoxd0YEfE5f68ZhdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935030AbeB1QWg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:22:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35399 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934946AbeB1QUx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:53 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Chunyan Zhang" <chunyan.zhang@spreadtrum.com>,
        "Jing Xia" <jing.xia@spreadtrum.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.419844661@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 146/254] tracing: Fix possible double free on failure
 of allocating trace buffer
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 4397f04575c44e1440ec2e49b6302785c95fd2f8 upstream.

Jing Xia and Chunyan Zhang reported that on failing to allocate part of the
tracing buffer, memory is freed, but the pointers that point to them are not
initialized back to NULL, and later paths may try to free the freed memory
again. Jing and Chunyan fixed one of the locations that does this, but
missed a spot.

Link: http://lkml.kernel.org/r/20171226071253.8968-1-chunyan.zhang@spreadtrum.com

Fixes: 737223fbca3b1 ("tracing: Consolidate buffer allocation code")
Reported-by: Jing Xia <jing.xia@spreadtrum.com>
Reported-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6220,6 +6220,7 @@ allocate_trace_buffer(struct trace_array
 	buf->data = alloc_percpu(struct trace_array_cpu);
 	if (!buf->data) {
 		ring_buffer_free(buf->buffer);
+		buf->buffer = NULL;
 		return -ENOMEM;
 	}
 
