Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C0CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEB82192D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BBaUI1b9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BBaUI1b9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBQIZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:25:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfBQIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:25:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A261607DD; Sun, 17 Feb 2019 08:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550391911;
        bh=TH5omesshtsgGxh1iAhmsoG+/e9gU+M1EhbjO2aEJxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBaUI1b9Lll14sXQOHxrcRd2HmFuFYGvVSGupJKAStmyqpWb0eUhEiye681KtX9p9
         nWeW7u5IOLsP3Lzet1XtInif4kOZuOl+OJ8iSgzxjasJxP1xl5LBM0/PWA5FNfeqSA
         PsEFyTedus/kJ7oeDoGZ+ef2Jn0w8Ut0CNQXuEfw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EDB8A60247;
        Sun, 17 Feb 2019 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550391911;
        bh=TH5omesshtsgGxh1iAhmsoG+/e9gU+M1EhbjO2aEJxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBaUI1b9Lll14sXQOHxrcRd2HmFuFYGvVSGupJKAStmyqpWb0eUhEiye681KtX9p9
         nWeW7u5IOLsP3Lzet1XtInif4kOZuOl+OJ8iSgzxjasJxP1xl5LBM0/PWA5FNfeqSA
         PsEFyTedus/kJ7oeDoGZ+ef2Jn0w8Ut0CNQXuEfw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Feb 2019 16:25:10 +0800
From:   yuankuiz@codeaurora.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: hardcode the debug message for -ENOENT
In-Reply-To: <20190204233047.GT11489@garbanzo.do-not-panic.com>
References: <7e752055f72d67a4b963436d67965123@codeaurora.org>
 <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
 <20190204233047.GT11489@garbanzo.do-not-panic.com>
Message-ID: <d2f930db664d8433894a7bf20db32748@codeaurora.org>
X-Sender: yuankuiz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-05 07:30 AM, Luis Chamberlain wrote:
> On Mon, Jan 14, 2019 at 05:58:30PM +0800, yuankuiz@codeaurora.org 
> wrote:
>> Hi,
>> 
>>     Refined at below.
>> 
>> From bbd0d9c8f28eb78ca34353347c3d4092e88f000c Mon Sep 17 00:00:00 2001
> 
> This is all garbled, not sure why your patch looks all messed up.
> 
> Are you using git sendemail or something manual?
> 
>   Luis
> 
Done. Update it with resend it as below.

 From: John Zhao <yuankuiz@codeaurora.org>

When the return code of "-ENOENT" was printed inside
of the debug message, which could be hardcoded meaningful.

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
2.7.4
