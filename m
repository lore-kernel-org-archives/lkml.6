Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C2FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D83222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550007643;
	bh=MYXG49ylspArrnXeP4qD9wYFysMxTF5+VA1VJtmN0Ps=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=d77s42R2ZurgBR4b4fsG5yO/GZHUiOoTzuomrtsxctloEBZnZgZMpGi921pmD1hBN
	 JMd8a66pMxb7wbZtEkqBG4pvO3cDN8U4RLZdiPdqz51CVT8wBpy8YanRKq7PTDF7cF
	 Pyr0/7qI9Mva6iqCKZax4Ahj8FFiWrYCTMxKt6R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfBLVkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:40:41 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37049 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728269AbfBLVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:40:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FB6D225B9;
        Tue, 12 Feb 2019 16:40:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Feb 2019 16:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=A3740+5CYspSw3/TP
        fwn5vSeevSx2FKxkHwjI+Pu9uI=; b=wX2LkR+hSkOD0k5WI0XcJJMZJHTC0Kf1Q
        V6GcieoZH//QJkRgZvTgw6RT+DtMWoipnxJCugcaAda5tdMMeSiK9jNJG+v+7lWE
        Cswp9dYhwS1aZ25njRWS5TUcasugDt5YOso+Um7HVd93uYWp24Zm/uU3yBeyMHXV
        /i/QGpdFryc/zpfHbBV1dOibSvbUmNp/6IgeIjS49hDnMbLmmsiiMb1hte6sJeYV
        c+BTU7uAEdPbBGrI8kOXh+KfXb8CenZh3teJHFNDVBdUS6/wMi3teMLGrD3mWFbw
        Q1GbIhJYBE2xRymyqiJhaSRB3O7hmDKA/7Y/klUCabFotGfVjIWwA==
X-ME-Sender: <xms:Vz1jXFL89HXlqsXHH7QIGDEtlXWx5xe_WokZAIZhDC2xbrpRRaZluQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfd
    fvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhg
    qeenucfkphepuddukedrvdduuddrudelledruddtgeenucfrrghrrghmpehmrghilhhfrh
    homhepthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Vz1jXI4OH7tkSDtgd7NAkAfe1cudHSe6mGYAwjM3E9pkf4DCUy_7vA>
    <xmx:Vz1jXMTspgXHYnDK6AdApZ1_JfnbCn_RyqTQM8ODTQmRUsjuUpK9HA>
    <xmx:Vz1jXAvpDZdgsYmtjNaWjvj1sbT9xPEOK5jM2zwRYvz6B9H48JPAuA>
    <xmx:WD1jXN8G_tCtaq81LYuMsVl4boWtdOA8uxbDEPxUc3lnxszpCeuDIQ>
Received: from eros.localdomain (ppp118-211-199-104.bras1.syd2.internode.on.net [118.211.199.104])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42A751031F;
        Tue, 12 Feb 2019 16:40:36 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] xarray: Document erasing entries during iteration
Date:   Wed, 13 Feb 2019 08:40:20 +1100
Message-Id: <20190212214020.1995-1-tobin@kernel.org>
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

Changes since v1:

 - Use the correct function name (its hard to get good help ;)

 Documentation/core-api/xarray.rst | 3 ++-
 include/linux/xarray.h            | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 5d54b27c6eba..814187c43401 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -97,7 +97,8 @@ You can copy entries out of the XArray into a plain array by calling
 :c:func:`xa_extract`.  Or you can iterate over the present entries in
 the XArray by calling :c:func:`xa_for_each`.  You may prefer to use
 :c:func:`xa_find` or :c:func:`xa_find_after` to move to the next present
-entry in the XArray.
+entry in the XArray.  It is safe to call :c:func:`xa_erase` on entries
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

