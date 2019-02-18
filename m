Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFD5C00319
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35E421903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532252;
	bh=b/J+nEpPdlIDxobQarQoZbcNwWM9QE/ZCM2/IMXv+NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rtGiynLkfywjQjaeWcrbyMyxFd8muhdudfoMP11qCb910igIb9ophEX7/r1+8HP6R
	 zNCbVhNx8cHwaUi/MYxmk5+MoaX9mn3gczU4ijVkAlMcA+i2LP1O9WUL2MssYKOdmF
	 CM69zndbhYpBnwRD+OztCljBf0wIel5MbD1gKv5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfBRXYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54869 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfBRXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 269E7348E;
        Mon, 18 Feb 2019 18:24:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FNg57b3mZQ18XqGRkwxeXlfXTue/1VAjFPcRQ/di6iA=; b=HkFG0q7f
        Pu0O2WG+TdH1jEASZUAmFu1oOySZ7YTFPwGO/sywuOaU89tP18BFzlCaINLXDk1Z
        rQmyGGsE5acxTw4ANliQQ4FhEwqWhIvfyi55XOxZXdm3ryfBMSw0PEXXJ/+VeIcl
        95vAzRzSrD+C4C6ooGbxCjhLP5Fd0Wtl5syu+4bnF/aDdyL4EHZzu7yK973Q02Sm
        5eoiUjsBpPlNzU4Muy1t3f/FSwaDHliQ50YB5fuffy2Aw3TB2A3sh4OnxjIJrZyD
        bFJNKgAui4sW92LfSmzTKCvZDplh3etucmrYKgcJ9PqMlRKeYndVRbdBfk116WPU
        qWTrR67bBJDhQg==
X-ME-Sender: <xms:lj5rXO3ZaUgPIxqh_7aDPMFYIJ28_QvhPod7wI4LJvM3m0iJXJAA3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:lj5rXJoMIbit2828gV3-Ln-QPgIdio0Y29z1Ryon-BEI3sE4XZwKGA>
    <xmx:lj5rXN9dVt61DNwr0KSU5IIHBXl9FmNscxoYHvFjYsldr6E8IneYpQ>
    <xmx:lj5rXE6vg0tsttui3p_DBUB52QKbFdVZZMefm8ggbz2jSYSbqLQEbg>
    <xmx:lj5rXPu2lUvZuGkjGRmLaBkMyvS0VsLiahwSxQRRo-KTtLMV46zc3g>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB82110316;
        Mon, 18 Feb 2019 18:24:03 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] lib/string: Fix erroneous 'overflow' documentation
Date:   Tue, 19 Feb 2019 10:23:04 +1100
Message-Id: <20190218232308.11241-3-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current documentation uses 'overflow' to describe a situation where less
data is written to a buffer than buffer size not more.  'overflow' is
the wrong word here - since we don't typically say 'underflow' change
the whole sentence.

Fix erroneous 'overflow' documentation for under filled buffer.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/string.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..7f1d72db53c5 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -173,8 +173,8 @@ EXPORT_SYMBOL(strlcpy);
  *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
- * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
- * with an overflow test, then just memset() the tail of the dest buffer.
+ * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
+ * check the return size, then just memset() the tail of the dest buffer.
  */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
-- 
2.20.1

