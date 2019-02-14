Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB5D21904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550116934;
	bh=dEwqHnyy90smbqzUdJLqrXRIFh8lZZ5Z5jKG6C0SXao=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VP2HayGdHHk4598Bk/S7E2hPD7lt/DgZZ+MWPyJTxMqfvQMlC13QZ9zOrYguYczUd
	 cUTctc0By5K/Ov6Dt2ElWuT3/12utLzb8I7ccnALMl+oxWAzdykxr4RfDKu3sDCZr+
	 qjqF0rbvjIhkPUTtSDl6N975m0a39prYLB/wF0bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfBNECN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:02:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45431 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfBNECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:02:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E17A2013C;
        Wed, 13 Feb 2019 23:02:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Feb 2019 23:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=D+7MB6dFRLYmcwGRT
        /XpdnpFG4hKZIkheatDVpx76sw=; b=ZnKgT5c3WiJoqc5S7NJiUNVirFbQEf4CC
        04VMdNj5EkHYqubH/ulvdrK3MLLXMZLIf+7Q6O93fRqQYb0Z39jEFLfYcICBf2z4
        DoWG9xcB+s1F3oQyHubIqrZfaK41ABjujkAqeX2vxmOIMKuHbWuXkNil2YotJCQe
        d+xsTvmJbEn6OnFVJ+je/6AAVT3Ob9jmAxAcEVT/2cp2ksFNT/m6ZTtC4Ms54EJ7
        /tHx7/Ig9VDY1gQl+ZsW6kWR2F/V0cVAdJlyrQ/sQIyrR1s2L9jHxcqBZ1x5yxUM
        j4NfGogtylHMYGBC3rNTYm77Vinm2Nhi5PEfL13nLQ3O+qZ9yyFVA==
X-ME-Sender: <xms:QOhkXMIUTWgPcTjbM5KWjhNN64dnNofozK8MvqcmGQn7sEYG48oUEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvf
    hosghinhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheq
    necukfhppeduudekrddvuddurdduleelrddutdegnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QOhkXKq3sEYUi08ybh2H7MMOmhurzSHk7sJkuYszn8gSOzmF8rSprQ>
    <xmx:QOhkXC4o6jbPzMLg1mSUQcBufuakHD9L8MTo0cvmLp_9Rcr-wJ-5aA>
    <xmx:QOhkXOIbea1WL843ieYEPsW42Nn-qrcdDv6DQTluOVxsUWcA41z0aA>
    <xmx:QehkXOXLqVOW4Ssrhr18oWMWHX5takgz5JmC_z0JlrQYMMGIXC3Peg>
Received: from eros.localdomain (ppp118-211-199-104.bras1.syd2.internode.on.net [118.211.199.104])
        by mail.messagingengine.com (Postfix) with ESMTPA id 143F2E412F;
        Wed, 13 Feb 2019 23:02:06 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] xarray: Document erasing entries during iteration
Date:   Thu, 14 Feb 2019 15:01:33 +1100
Message-Id: <20190214040133.23467-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XArray is, in a way, a replacement data structure for linked lists,
as such, on first use developers may wonder if it is safe to remove
items while iterating over the array.  Calling xa_erase() while
looping with xa_for_each() is fine, let's document it.

Document explicitly in the docs and also for the macro definition.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

v2 -> v3:
 - Put document comment in a better place, tie together current
   discussion of xa_for_each(), xa_erase(), and xa_destroy().
 - Improve commit message.
 - Actually build the docs and verify the patched file renders in HTML.

v1 -> v2:
 - Use the correct function name

thanks,
Tobin.

 Documentation/core-api/xarray.rst | 4 +++-
 include/linux/xarray.h            | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 5d54b27c6eba..77a93e3e0e4f 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -97,7 +97,9 @@ You can copy entries out of the XArray into a plain array by calling
 :c:func:`xa_extract`.  Or you can iterate over the present entries in
 the XArray by calling :c:func:`xa_for_each`.  You may prefer to use
 :c:func:`xa_find` or :c:func:`xa_find_after` to move to the next present
-entry in the XArray.
+entry in the XArray.  It is safe to call :c:func:`xa_erase` while iterating
+the array.  If you are clearing the whole array you may prefer to use
+:c:func:`xa_destroy` (documented below).
 
 Calling :c:func:`xa_store_range` stores the same entry in a range
 of indices.  If you do this, some of the other operations will behave
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 5d9d318bcf7a..1f8974281a0a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -407,6 +407,8 @@ static inline bool xa_marked(const struct xarray *xa, xa_mark_t mark)
  * you should use the xas_for_each() iterator instead.  The xas_for_each()
  * iterator will expand into more inline code than xa_for_each().
  *
+ * It is safe to erase entries from the XArray as you iterate over it.
+ *
  * Context: Any context.  Takes and releases the RCU lock.
  */
 #define xa_for_each(xa, index, entry) \
-- 
2.20.1

