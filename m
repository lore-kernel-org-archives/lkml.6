Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1984963-1525122186-2-1131942904750110359
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525122185; b=NGju1fqnq30FFaMy8QARJqEfKFB64i48vVvZzCZDs1mF6bTMxH
    DhOaSCh7e5Olsf3CPetZQUueSrQ27JPqhBcfEehkeCRZlFBihSQMGQbBEzzH82N7
    g9kgyj6CiTx8yShIduCMQIKNQH7DpGrtzQjjDrf2IWknu67l+o5AKHU1oQnr5Ji7
    FmcI7b/8QvGKA9auPSQ5H6is/dgdnEH2fnX+DSvi3KTJ7QtdZ6fUZexGlKixrTN2
    cmnVY4uhkGQoKrw8rpXprceWnwzcTKwARZbBOuH4JAm9mooGo5TE+cML8DjZcWFq
    d69oww4ekeJYTtPEr0Ecz3uVA51BiTNnw+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:in-reply-to:references
    :content-type:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525122185; bh=I1R6Ri1fztw5rYvo5Mp1WQEyZ6vTzo08ga9GnsJgW4w=; b=
    O6zMnbSpmJcKV87WBAwvkpqggaFlvxn4XykTyJ8F4PUDqFJZni0qmyZuJR+fhu4J
    IRL/BO9zkA6y0rwe7xwK7MKik7D9ui/xQkUszCc//5etiNsrMO98+eMKMZiEpiQT
    Y4+ctzvOGZM0l5DCkXpkRA8/itJy+ZUjrpfuGilHthpMVT5iuSFX8ZJPGHUSzt2W
    w37IYAGpP5QPKpXcjxmkrrxw3/NG9r/p8OtALfVDHlvoGR9TbAKJA1Vt4SDBotVv
    SN3mYS1kj8t0ynt5w5Anf5KZrY0wjPXs3U5KrWR9YUkvR0bkow9inIexcVtIFRFw
    1zuhLRaqxQO3VIXEix/HYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgqDQsqH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgqDQsqH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9gmjdJSqkPTURoX4RX6Ouyp6VOzcCh2fIRc7oBZ/HbIJAT0kWxQHfzG11YDkY2qXBOUXmEHDqmS79b+GhpdVZTASfYvPp4QE4ftEb57NsK4a98jmK9
    7GabuWBUSaqhz0pKW2Va4GD94L+ztbqgaK3xaiTgm5cAdIyGG21HXxYJf4Q3t6nTQHmeLJ8aMwXJbMr58sGS7L3pHjR/tdsukeCfg7YcsgEPbsyFmffHsxVU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=mDV3o1hIAAAA:8 a=Z9tRPZRVYTCA_L0aSM4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
    a=_FVE-zBwftR9WsbkzFJk:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755200AbeD3VDB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:03:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60649 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755182AbeD3VC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:02:59 -0400
X-ME-Sender: <xms:goTnWsaM5e1RUpbu44qzNvrQFYg0Pbm8qI_0BN7Wby-N_QijW2QP5g>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/6] xen: Add RING_COPY_RESPONSE()
Date: Mon, 30 Apr 2018 23:01:45 +0200
Message-Id: <ba8ed01b01a81d79f6d1c59e08a318dc0309a95d.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using RING_GET_RESPONSE() on a shared ring is easy to use incorrectly
(i.e., by not considering that the other end may alter the data in the
shared ring while it is being inspected).  Safe usage of a response
generally requires taking a local copy.

Provide a RING_COPY_RESPONSE() macro to use instead of
RING_GET_RESPONSE() and an open-coded memcpy().  This takes care of
ensuring that the copy is done correctly regardless of any possible
compiler optimizations.

Use a volatile source to prevent the compiler from reordering or
omitting the copy.

This is complementary to XSA155.

CC: stable@vger.kernel.org
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 include/xen/interface/io/ring.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 3f40501..03702f6 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -201,6 +201,20 @@ struct __name##_back_ring {						\
 #define RING_GET_RESPONSE(_r, _idx)					\
     (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].rsp))
 
+/*
+ * Get a local copy of a response.
+ *
+ * Use this in preference to RING_GET_RESPONSE() so all processing is
+ * done on a local copy that cannot be modified by the other end.
+ *
+ * Note that https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 may cause this
+ * to be ineffective where _rsp is a struct which consists of only bitfields.
+ */
+#define RING_COPY_RESPONSE(_r, _idx, _rsp) do {				\
+	/* Use volatile to force the copy into _rsp. */			\
+	*(_rsp) = *(volatile typeof(_rsp))RING_GET_RESPONSE(_r, _idx);	\
+} while (0)
+
 /* Loop termination condition: Would the specified index overflow the ring? */
 #define RING_REQUEST_CONS_OVERFLOW(_r, _cons)				\
     (((_cons) - (_r)->rsp_prod_pvt) >= RING_SIZE(_r))
-- 
git-series 0.9.1
