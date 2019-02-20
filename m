Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C233B206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L4wpNhlE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L4wpNhlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfBTCjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:39:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfBTCjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:39:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EFC3607DD; Wed, 20 Feb 2019 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550630344;
        bh=3CGBwsaI7EFppSp/kRLYnynci5AF/Rc/sr92ZLqSvHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L4wpNhlEt4b2ryBg2s5oesqUeU5vUkYt1XP3YEVTjIv/dTAZhrUYxSa1+a6r2bMa+
         IZ8sep/b0NfjFn/fUJSCjsafk+6G3tIwQUxhBb4HHBzxmUNeFNkb4sVQf2lOfAYMVY
         Rqv+5fIm0F2EOSGRrcA2J49E3MzN77cOYgJBuimQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 09D4260559;
        Wed, 20 Feb 2019 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550630344;
        bh=3CGBwsaI7EFppSp/kRLYnynci5AF/Rc/sr92ZLqSvHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L4wpNhlEt4b2ryBg2s5oesqUeU5vUkYt1XP3YEVTjIv/dTAZhrUYxSa1+a6r2bMa+
         IZ8sep/b0NfjFn/fUJSCjsafk+6G3tIwQUxhBb4HHBzxmUNeFNkb4sVQf2lOfAYMVY
         Rqv+5fIm0F2EOSGRrcA2J49E3MzN77cOYgJBuimQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Feb 2019 10:39:04 +0800
From:   yuankuiz@codeaurora.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] firmware: hardcode the debug message for -ENOENT
In-Reply-To: <20190219163810.GI11489@garbanzo.do-not-panic.com>
References: <7e752055f72d67a4b963436d67965123@codeaurora.org>
 <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
 <20190204233047.GT11489@garbanzo.do-not-panic.com>
 <d2f930db664d8433894a7bf20db32748@codeaurora.org>
 <20190219163810.GI11489@garbanzo.do-not-panic.com>
Message-ID: <96bbc0d0f3c76b91752db07f0f5287e4@codeaurora.org>
X-Sender: yuankuiz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From: John Zhao <yuankuiz@codeaurora.org>

When no file /path was found, the error code of -ENOENT
enumerated in errno-base.h, is returned. Stating clearly that
the file was not found is much more useful for debugging, So
let's be explicit about that.

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
  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
  						msize, id);
  		if (rc) {
-			if (rc == -ENOENT)
-				dev_dbg(device, "loading %s failed with error %d\n",
-					 path, rc);
-			else
+			if (rc != -ENOENT)
  				dev_warn(device, "loading %s failed with error %d\n",
  					 path, rc);
+			else
+				dev_dbg(device, "loading %s failed for no such file or 
directory.\n",
+					 path);
  			continue;
  		}
  		dev_dbg(device, "direct-loading %s\n", fw_priv->fw_name);
-- 
