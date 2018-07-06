Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82523EA9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jypCqXAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A82523EA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeGFPQ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:16:57 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:45584 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbeGFPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:16:56 -0400
Received: by mail-yw0-f202.google.com with SMTP id y126-v6so10189290ywe.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=MRaE8D/X/qaIGQSG+GECxYL3MgyJE3KC232lcqNYOtc=;
        b=jypCqXAzaocvxG9hwcwvfRfUW5IIel0WSV1jlshBeGm96DQzcCFEDvfcX99LIhjgg0
         RBkD3tP0lIvP7nfOoWQmbJLe9FFvv8D4hEckHXR67MQEo9DZeDEa90YnhHqme9sWc9Ul
         ym/xBLKrUWZrEy0Umbj0iy95SY3CTtgvN/CCUuWyE+y6Ja6OpKdcSaNb9TJH+Z+Eq1P7
         cN1UfRiO7N5PYGbVyDAkQ+dDjtRtws3Z6tB08zU46ZmqH4Y/AO6gvCvyvBFg7Ld2OM4G
         sbx1iUMchElDNzOe2FThd973aCKZj/T++HKCC0Rw0c1B5Lh6jx1zE9IUzlPeyYcIvkGa
         PkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=MRaE8D/X/qaIGQSG+GECxYL3MgyJE3KC232lcqNYOtc=;
        b=XO7hahMC7aNYFyMlxUF65cNTlPnPq3k5zEkwv6gcGE8I4r7ntbydXdxUAtlyxyHghf
         yBrgw37+P+Y/ER09zOHGcw+4+jgABrbkP3D0yEPQgfilFakS/5tJvM6ZWbQr020BQvcY
         BAnlp7drgIg5S4C4aRVb3DdA+2LnLT0zW2CcJ/NVYs8tzG79FC0QztUl+4E5eGUAkvJ/
         GVQaWAZFhxqsop+vikvco7/I1seb7q6SL9QE8I4XvfVL11gVEBg3oXnQKqZJJU4C7iLr
         15dYtX0UfdGTv9PdEAoK6kY7AWlEfkhNUw9YYO4dtOrgcO49DhrXcPW9BtPFmlhzGrVQ
         PuPg==
X-Gm-Message-State: APt69E0W5gf6E0kP9dGLCAXLvDwK3BYIWXf8DJ0c2UsSHN26h5KI8YQF
        s7xXoddiVTi10Wl8weXNeOfs7RHwiA==
X-Google-Smtp-Source: AAOMgpc+eX5BLEHCQOzzf+MuWoUIg2rGvLXPTESguHqYjdiFQCelsFgt/JrDBmSDS0RAj5GYmBcHYVr+yg==
MIME-Version: 1.0
X-Received: by 2002:a25:9b02:: with SMTP id y2-v6mr3185004ybn.11.1530890215341;
 Fri, 06 Jul 2018 08:16:55 -0700 (PDT)
Date:   Fri,  6 Jul 2018 17:16:49 +0200
Message-Id: <20180706151649.31119-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] firewire: nosy: don't read packets bigger than requested
From:   Jann Horn <jannh@google.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>, jannh@google.com
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, accessing userspace memory beyond the length of the supplied
buffer in VFS read/write handlers can lead to both kernel memory corruption
(via kernel_read()/kernel_write(), which can e.g. be triggered via
sys_splice()) and privilege escalation inside userspace.

Fixes: 286468210d83 ("firewire: new driver: nosy - IEEE 1394 traffic sniffer")
Signed-off-by: Jann Horn <jannh@google.com>
---
No CC stable because this device shouldn't be available to unprivileged
code by default and should be pretty rare.

 drivers/firewire/nosy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index a128dd1126ae..732075fc312e 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -161,11 +161,12 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
 	if (atomic_read(&buffer->size) == 0)
 		return -ENODEV;
 
-	/* FIXME: Check length <= user_length. */
-
 	end = buffer->data + buffer->capacity;
 	length = buffer->head->length;
 
+	if (length > user_length)
+		return -EINVAL;
+
 	if (&buffer->head->data[length] < end) {
 		if (copy_to_user(data, buffer->head->data, length))
 			return -EFAULT;
-- 
2.18.0.399.gad0ab374a1-goog

