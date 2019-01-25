Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C58C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5421934
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548403153;
	bh=noo+TMKh4IPcuNsrlcqfA4qYUJKzjx8yjBqT/coTq2k=;
	h=Subject:To:From:Date:List-ID:From;
	b=AZJovL4HobESk/YfijQsCT0WgkR++jUy0ee17N4FtSj7u0C2b52Awk8zcH/rlSQX5
	 kp85tfDHXB7GW0WL+RSlavpjRXjGkAGnEBZxjzjBG0KeuclrvTy2zq1hF9xWWW0FYS
	 RZwqKhluofAFAet9VpJxcsKFkMyUPEWd82WXDfZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfAYH7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfAYH7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:59:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020FA20820;
        Fri, 25 Jan 2019 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548403150;
        bh=noo+TMKh4IPcuNsrlcqfA4qYUJKzjx8yjBqT/coTq2k=;
        h=Subject:To:From:Date:From;
        b=Ci0wd2k/7DcfaWT0WOKllkaQdBRM/cdheJmaQWl4w8AnBo0MxvjmNgisBWck8AnHe
         KTJb5uiWdyOevToyjZ6P635YayOeL8m4QHEqMNReGYQUD7tB43Kzq8Pw992mGpvNfv
         Gy7Pe3j+qbbqf6+BP5FsF8RRHii04S5YidliD2/I=
Subject: patch "ihex: Check if zero-length record is at the end of the blob" added to driver-core-next
To:     andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        cphealy@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org,
        kyle@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 25 Jan 2019 08:58:41 +0100
Message-ID: <15484031212414@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    ihex: Check if zero-length record is at the end of the blob

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 5158c36ec9d0b3343f58987cec7ebfd866331fd0 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 20 Dec 2018 23:28:38 -0800
Subject: ihex: Check if zero-length record is at the end of the blob

When verifying the validity of IHEX file we need to make sure that
zero-length record we found is located at the end of the file. Not
doing that could result in an invalid file with a bogus zero-length in
the middle short-circuiting the check and being reported as valid.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ihex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index 9c701521176b..9130f307a420 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -49,7 +49,7 @@ static inline int ihex_validate_fw(const struct firmware *fw)
 
 	for (; rec <= end; rec = __ihex_next_binrec(rec)) {
 		/* Zero length marks end of records */
-		if (!be16_to_cpu(rec->len))
+		if (rec == end && !be16_to_cpu(rec->len))
 			return 0;
 	}
 	return -EINVAL;
-- 
2.20.1


