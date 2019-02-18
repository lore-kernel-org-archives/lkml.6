Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174921900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532275;
	bh=/dngFaf9St9/60AJniU4xluhCoeu+2cqf3XaY6vN/Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pRrB8DzzsttD46MdLoO9EQMcW68gRnh6Ho/PyeSLTruc8dw+bGGDYR8hLVtAtyYgP
	 k13km5iIJwsxnGhrlZF8d8hybDfIsmgVrb94ecoPIIq9RK7KIG8KGnzUk3EJuFe5Jl
	 jalZxM3M+VL9RazwNC/5EpphD4+d9awhaSc1sLSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfBRXYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:17 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56557 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfBRXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 48AAB3483;
        Mon, 18 Feb 2019 18:24:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0kNq+XPK5XlADe3A/eDfvto4Zt4XV904TM2s0F96Fgc=; b=ZpjCC5o1
        OsB4/6bSqwim4cdVUAGoqN1xYEUJPAIR/yHtyLqL17nsELYX8phMATzlRuGAzXTa
        UABi5ATr7nwYi90w2l0byrMSxGeuyBHhHpCH1SG8rAw6a3TMfH2O/Vbjls7MThi2
        pzvBy5J7JTvTwQAym/IVPuBpZ/CH5Des4M0EI6FtwGi1ylhzKDz+YYlVMdeCeKlt
        UAJL2lWRcQuWR7Kdtczwk1ikY2alrsCZOlRp0WmGPiabySczHqurjCtJpIu9tinq
        shnRZ/RptdGoTqyvFiQG0W2JU1wIOeSRZRVvqzB24WvgrAbxSp5S92CLAzPJU7lV
        0V8GZ9rw874k9w==
X-ME-Sender: <xms:mT5rXGok7gAZdGtUVaTjkE066pPJW6gAL4OxIGzBaKv3iqO9SMq5mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:mT5rXN8swrvQcJ1dHW8pTkZkYrjIdKdFT6tVZE7RxRPD4A0Cq72o-g>
    <xmx:mT5rXCdEB4xU-wMADmFRvkZVIGAg7xg_1kVba0Ontc0gqQorK4pN1A>
    <xmx:mT5rXHItd1uGR-mFo70OeyFkkVxZ0NRcqhV5Y21A-8MAxTmHXhk0BA>
    <xmx:mT5rXNBnwULi4SNvaU2N0nWkFXxGBC2i_uGv_8E4FcIVsw5zU7xWkg>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02D301030F;
        Mon, 18 Feb 2019 18:24:06 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] lib/string: Use correct docstring format
Date:   Tue, 19 Feb 2019 10:23:05 +1100
Message-Id: <20190218232308.11241-4-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the docstring comments for strscpy() are not in the correct
format.  Prior to working on this file fix up the docstring.

Use correct docstring format for strscpy().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/string.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 7f1d72db53c5..65969cf32f5d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
  * @src: Where to copy the string from
  * @count: Size of destination buffer
  *
- * Copy the string, or as much of it as fits, into the dest buffer.
- * The routine returns the number of characters copied (not including
- * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
- * The behavior is undefined if the string buffers overlap.
- * The destination buffer is always NUL terminated, unless it's zero-sized.
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always NUL terminated, unless it's zero-sized.
  *
  * Preferred to strlcpy() since the API doesn't require reading memory
  * from the src string beyond the specified "count" bytes, and since
@@ -175,6 +173,9 @@ EXPORT_SYMBOL(strlcpy);
  * doesn't unnecessarily force the tail of the destination buffer to be
  * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
  * check the return size, then just memset() the tail of the dest buffer.
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         NUL) or -E2BIG if the destination buffer wasn't big enough.
  */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
-- 
2.20.1

