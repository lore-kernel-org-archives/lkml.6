Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC6BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCD82070C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549956623;
	bh=VkjIGW1ndGK0G6h3re8+lD4IW+9MML32Do/g8pRJ+X0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jQUICMY9iDTXMn3RRXRhNytPGjLSrqscV/pC9ndXIaen8uCTNmsXXkEOn49FsfloF
	 yQjU036ifnm1Bh2YDqv/EdBJ1yeKT1uN2vVnOtmJwhLeETZB+PgkuJNuJQeJsfixzR
	 OrQJuyFgtUJoDAP5U0k6I2LuThgh6fgVc3BHEWlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfBLHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:30:22 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58007 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbfBLHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:30:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7538E231BB;
        Tue, 12 Feb 2019 02:30:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Feb 2019 02:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wrJoYBO97LlCKkoip
        juoC/+8a4eB+DEm6P5r7lEfh4k=; b=C+nUTRMs5xJcTWDTuihsSpFY2/U9x+D/F
        bRQk86XyodKJg84SECJSaWxNnPvSeDsxa7JIvCxMj7QBoIFhxl/28zxmP1zL0k1P
        kJKUDNQkdPeorLVNUWGHkyCbL2y0CYzi3JGpQHLcDF1aWHXzcDeKBxvFJcrpNHZC
        COc678TvnVkYaeby/7IkQ1/wP1EhyoN4rZcUMF35PAZlsyGA37/SPqhgPZN5iXDt
        yoeesvha4wGqLUZltAB58SEjCDMigw6CyiLUatzmjlKTnfemPi3hr8tDZC0FTkpk
        nBnLTWpU4Y6eYJic1NkFmxStr6EyMeZrXjynvrlspGMRinJxcutXQ==
X-ME-Sender: <xms:C3ZiXEu8CRAv8tXqKOY60TUJ79fGSXZ05V9SFGVkOhFEe8cE9lCAWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfd
    fvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhg
    qeenucfkphepuddvgedrudejuddrvdefrdduheenucfrrghrrghmpehmrghilhhfrhhomh
    epthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:C3ZiXPEYKk9fioYjs1EQjO6G-a9OoYq562vpz-3iK6N1UYznYCQoVw>
    <xmx:C3ZiXFXq99olg93aRXWeATYMamt8Aok7wFkTePAHOD532n7vyM0AaQ>
    <xmx:C3ZiXK03UGtjcgEdRBfM5ZuBWNoEcmixtCb4cG8t40rQA0I1Xy1zgg>
    <xmx:DHZiXC7pVmjjDnSQRjbGCEHi81wEOHTOIOib9IQ_qkJvrbSPRuE1Yg>
Received: from eros.localdomain (124-171-23-15.dyn.iinet.net.au [124.171.23.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0137CE4597;
        Tue, 12 Feb 2019 02:30:17 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xarray: Document erasing entries during iteration
Date:   Tue, 12 Feb 2019 18:29:58 +1100
Message-Id: <20190212072958.17373-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XArray is, in a way, a replacement data structure for linked lists,
as such, on first use developers may wonder if it is safe to remove
items while iterating over the array.

For example, this is fine:

	DEFINE_XARRAY(things);

	void cleanup()
	{
		struct thing *thing;
		unsigned long index;

		xa_for_each(&things, index, thing)
			xa_erase(&things, index);
	}

Document this feature explicitly in the docs and also for the macro
definition.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

Hi Willy,

I had my first go using the XArray today and during that I wondered if
it was safe to remove items during iteration.  Conceptually it seems
fine and it seemed to work just fine in code - is this something people
should not be doing for any reason?  Is this the best way to traverse
the tree and get every thing just to erase it?  Are we even supposed to
be thinking this is a tree or should we just be thinking it is an array?

(As you might have guessed I _still_ don't know exactly how a radix tree
works :)

Oh, and FTR the XArray is hot - good effort man.

thanks,
Tobin.


 Documentation/core-api/xarray.rst | 3 ++-
 include/linux/xarray.h            | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 5d54b27c6eba..2578e0bdaa17 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -97,7 +97,8 @@ You can copy entries out of the XArray into a plain array by calling
 :c:func:`xa_extract`.  Or you can iterate over the present entries in
 the XArray by calling :c:func:`xa_for_each`.  You may prefer to use
 :c:func:`xa_find` or :c:func:`xa_find_after` to move to the next present
-entry in the XArray.
+entry in the XArray.  It is safe to call :c:func:`xa_release` on entries
+as you iterate over the array using :c:func:`xa_for_each`.
 
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

