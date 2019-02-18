Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350D218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532265;
	bh=PGQymkIHXY8eegL/Zf46e2AQ8E5CaQy++c8RGGqpB3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAd0TbMHPkLvJAbYcSWNYntB56W0tgYMbxPrXQJQ64gvyAcDRp8CzOHNjdaTSnCMh
	 MAK05OHMG4q806Edwe5WoHPSSfgStU9QDQc3bUrxKT1Efci/e1Ej2Bwzntb1GgZijF
	 U5JoTuu3c8Fxy5GiooQxNzMMDXHjOTkfVsYQWPFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfBRXYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59873 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731119AbfBRXYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 868913489;
        Mon, 18 Feb 2019 18:24:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=gQ2Czs+WwskYJcjsHIvDj3HILOy3Yi9CMACq5Mkjk6M=; b=s3SkqYzK
        qoYIQ+tXK2mW/fEbmxAeKKHiSiwVU30gDfQwFTycwqsktR4zjxTOAX2D7Ay9T5/0
        DIumXjLBvx0VMPAQaprY3m9DKOP2zX02ZZyMVi0SknSzE+qFn+JC9kHsEZ3HrQKO
        o+No+KC0jl0qNVl4JRm0pu/xobIK1xbmORjdHMqEOyctnumbuwLVESyk0tyvHJG6
        gBfuwFybx2ucLLI9bDhiP6HgDMdFZd5Dnu4vacSFs2lho433lxgo7wGr6hqiWugD
        G14ZqZxy6l92NNiY0PEaXsxPL6ak8iLeHr85LcHuuM4Wnoabm6vlT/7EFdtV21n9
        xeEn0QaaPV2ziQ==
X-ME-Sender: <xms:oT5rXDrAQTgnVPOsbjtRiZaEgQTCEl9x92cluK6VVFyqLdm7xUWheg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:oT5rXIxXlQ-JNlAvlCTvIaZrTCrOdv9iFmpfM78v8U48NdbcS_BJnw>
    <xmx:oT5rXPlSJ0HYMWqa_T8-cxSffl6UGAJn5ubekj-59N3F7ia4XrAdRQ>
    <xmx:oT5rXGL4Z3S3iKqO85_vb2oIC7LgYjSDgsWpDlLP21g4vYlY0xUGPw>
    <xmx:oT5rXBhZEwbB4owyoS_27bqGpSsujZR1sUZFnMNTAwh_A5nuBm0KAg>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38BBF10318;
        Mon, 18 Feb 2019 18:24:13 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
Date:   Tue, 19 Feb 2019 10:23:07 +1100
Message-Id: <20190218232308.11241-6-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current function documentation for strncpy_from_user() is incorrect.  If
@count (size of destination buffer) is less than the length of the user
string the function does _not_ return @count but rather returns -EFAULT.

Document correctly the function return value, also add note that string
may be left non-null terminated.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/strncpy_from_user.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 58eacd41526c..11fe9a4a00fd 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -82,22 +82,19 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 }
 
 /**
- * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * strncpy_from_user() - Copy a NUL terminated string from userspace.
  * @dst:   Destination address, in kernel space.  This buffer must be at
  *         least @count bytes long.
  * @src:   Source address, in user space.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * @count: Maximum number of bytes to copy, including the trailing %NUL.
  *
  * Copies a NUL-terminated string from userspace to kernel space.
  *
- * On success, returns the length of the string (not including the trailing
- * NUL).
- *
- * If access to userspace fails, returns -EFAULT (some data may have been
- * copied).
- *
- * If @count is smaller than the length of the string, copies @count bytes
- * and returns @count.
+ * Return: If access to userspace fails, returns -EFAULT.  Otherwise,
+ *         return the number of characters copied excluding the trailing
+ *         %NUL, if the length of the user string exceeds @count return
+ *         -EFAULT (in which case @dst will be left without a %NUL
+ *         terminator).
  */
 long strncpy_from_user(char *dst, const char __user *src, long count)
 {
-- 
2.20.1

