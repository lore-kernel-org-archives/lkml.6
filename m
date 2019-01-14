Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5987DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DDC20879
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BYszJ07h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BdOXKNX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfANJ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfANJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5CB2F61193; Mon, 14 Jan 2019 09:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547459924;
        bh=RlNPQrJ3EJ+myg10De+//B2pgBUzjuLDgUZiyrtCjA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BYszJ07hvEQChyJpMnLLoCgu4Q1kUGD0Q+nKMWU1p3f89zpgADO05AOB6yiXuPJNP
         sVpoO8aYJXl9tr+cxiTTMk5d6g5qK/rjrVZLvBimoO5JNTtpMz0uQ855enjUDpyDx+
         GTXjpIKKJZknLcJU7yxzD5yZZUfe50k+1ewjnfUo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 378B7611A8;
        Mon, 14 Jan 2019 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547459911;
        bh=RlNPQrJ3EJ+myg10De+//B2pgBUzjuLDgUZiyrtCjA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BdOXKNX+lK0PqypGRfKkot6dfbn8ihW7dKSO7Qntg4wMlWbZZC7eb9DVAgewG+o6N
         39djhIHm550auVlRrkvwQUMINW0kXZ85DyoLwXCDjitLr7tVHaTJweaIpneiuYd6eY
         rttZdwrBLPFxewUoVLTERgG5ofi4vGBjBCkLkquU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jan 2019 17:58:30 +0800
From:   yuankuiz@codeaurora.org
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: hardcode the debug message for -ENOENT
In-Reply-To: <7e752055f72d67a4b963436d67965123@codeaurora.org>
References: <7e752055f72d67a4b963436d67965123@codeaurora.org>
Message-ID: <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
X-Sender: yuankuiz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     Refined at below.

 From bbd0d9c8f28eb78ca34353347c3d4092e88f000c Mon Sep 17 00:00:00 2001

When the return code of "-ENOENT" was printed inside
of the debug message, which could be hardcoded meaningfully.

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
---
  drivers/base/firmware_loader/main.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c 
b/drivers/base/firmware_loader/main.c
index 8e9213b..7eaaf5e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -328,12 +328,12 @@ fw_get_filesystem_firmware(struct device *device, 
struct fw_priv *fw_priv)
                 rc = kernel_read_file_from_path(path, &fw_priv->data, 
&size,
                                                 msize, id);
                 if (rc) {
-                       if (rc == -ENOENT)
-                               dev_dbg(device, "loading %s failed with 
error %d\n",
-                                        path, rc);
-                       else
+                       if (rc != -ENOENT)
                                 dev_warn(device, "loading %s failed with 
error %d\n",
                                          path, rc);
+                       else
+                               dev_dbg(device, "loading %s failed for 
no such file or directory.\n",
+                                        path);
                         continue;
                 }
                 dev_dbg(device, "direct-loading %s\n", 
fw_priv->fw_name);
-- 
2.7.4


On 2019-01-14 03:19 PM, yuankuiz@codeaurora.org wrote:
> From d6892f54a81bf85ad011bfb8822567690713d575 Mon Sep 17 00:00:00 2001
> 
