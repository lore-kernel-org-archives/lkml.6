Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D1C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6672177D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RwmihIiS";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RwmihIiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6672177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeHMJdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:33:20 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:44113 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbeHMJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:33:20 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 0C07721868;
        Mon, 13 Aug 2018 09:52:24 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id dohBVjFfAv-qNUaCBYH;
        Mon, 13 Aug 2018 09:52:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534143143; bh=Zsy6MVmdsrlI+ry9hz+L6M09LOn5pjqI4UZ2oezC3Pk=;
        h=Subject:From:To:Date:Message-ID;
        b=RwmihIiSTl4oNzQ2HAc7O6MwVS6nZYUJLdnz1xVJZJQ4OlhoDGov5DNJhGMeiwiav
         Pm1yBVnMwNjV0EOtVsJfO//FwqVhGsEzxGLw5gEOkAv5fwtkTaVZNwld0bTkahZ5L9
         XdfnK/UYzXZ+MBv9wHDtuSSIHnNn3dRoOGnUBngI=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xYmOh8QZk0-qN8SqMQL;
        Mon, 13 Aug 2018 09:52:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534143143; bh=Zsy6MVmdsrlI+ry9hz+L6M09LOn5pjqI4UZ2oezC3Pk=;
        h=Subject:From:To:Date:Message-ID;
        b=RwmihIiSTl4oNzQ2HAc7O6MwVS6nZYUJLdnz1xVJZJQ4OlhoDGov5DNJhGMeiwiav
         Pm1yBVnMwNjV0EOtVsJfO//FwqVhGsEzxGLw5gEOkAv5fwtkTaVZNwld0bTkahZ5L9
         XdfnK/UYzXZ+MBv9wHDtuSSIHnNn3dRoOGnUBngI=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] kernfs: update comment about kernfs_path() return value
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 13 Aug 2018 09:52:09 +0300
Message-ID: <153414312926.736358.10338941831174422783.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it returns the length of the full path or error code.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 3abb1d90f5d9 ("kernfs: make kernfs_path*() behave in the style of strlcpy()")
---
 include/linux/kernfs.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index ab25c8b6d9e3..0174ec25950e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -472,10 +472,11 @@ static inline void kernfs_init(void) { }
  * @buf: buffer to copy @kn's name into
  * @buflen: size of @buf
  *
- * Builds and returns the full path of @kn in @buf of @buflen bytes.  The
- * path is built from the end of @buf so the returned pointer usually
- * doesn't match @buf.  If @buf isn't long enough, @buf is nul terminated
- * and %NULL is returned.
+ * If @kn is NULL result will be "(null)".
+ *
+ * Returns the length of the full path.  If the full length is equal to or
+ * greater than @buflen, @buf contains the truncated path with the trailing
+ * '\0'.  On error, -errno is returned.
  */
 static inline int kernfs_path(struct kernfs_node *kn, char *buf, size_t buflen)
 {

