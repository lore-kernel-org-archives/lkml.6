Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A197C21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AJRBGyrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbeLTUAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:00:12 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:60006 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLTUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:00:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1F828C43
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 20:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E2YPc2te3hPm for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 14:00:10 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E78AB272
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 14:00:09 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id i11so1016425iog.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b8dgIikx7Ts1HlioLdKrv+YP/Ltg6pMHyP2ZQv2bWlw=;
        b=AJRBGyrGAnWvvulxNEbiYMdVgJ36R29SfWK4s/YuNDCo8pkJX2OOhfZLv1UJzJc1la
         08136Eqv4nRLrgyXe7wlgxemlqRRLY/qOiLLzp9VYOpeeMOTdQvMVR0xaz9/ntMGd/Nn
         I46LX68XxT154fqv02gQloU3AMZ/pXH+KhyHDgaSK09bODVeCBoPhoRvMjVdelJWWejM
         rBQENId1Jro55DL/7IOVPvacqIvRhmSV3nupqJTYLj9phZyG/IsazCQLsaquCp/tU68+
         lvLoymo+Rah0k/rIv5TPuMQC8HYhKyBgrgBxPLBpiXQLKf6lmO6syt9KYSkpNANgCwiP
         vo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b8dgIikx7Ts1HlioLdKrv+YP/Ltg6pMHyP2ZQv2bWlw=;
        b=iHkRC6km2RqtF8+d97tl63OrwHKAamqYpXDjZwc/YflmhfPvGvC9kGyix4f16VJdGk
         cNiMUIt/7AjVYn0NWHmMNqNv6iosO8KirgkVjSu6ymE56lcd8CeJfqSMDDEYkObmyUyj
         JEdz4Rt+94cSnPGLOyPsWGSRd6yR4xDck6W0GkyagBs7mlcokascD7BjOuidV1khcaVS
         g7CGjjb3/8GcIxKS6YeDBPi1hV+wJONq9u6Zn7AJ9sOgqFkS1JGdIr9aOLBpok/RPbEv
         D/GXMWc06Oep0kGHfMO1L6TtzmE422g1HQX71pynmpH4FI776HvbJP6HrcbAEQKo27JH
         c4vQ==
X-Gm-Message-State: AA+aEWaYCtFWDLYPoC5SUk48IHsVCpmQrA+eV1Wsu5XRXKSgxJoXVQFx
        c9oJkQjjK6wlUpclBhA9r+mfPX+OE6lHiPE52twTaGSEzNBbV+wXoVTgicrycYQV/W2URhauPu4
        oxSvNSdhMWTG3o6XnXL8dN0yufUk2
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr23042387iod.290.1545336009143;
        Thu, 20 Dec 2018 12:00:09 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V+lYSWOq+FdpYJoTxHwqJqjO2vjyKtGSaW/lDg5AGID0GeOw3fwgJ4tHR5dQ1wuP8B/vNyVA==
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr23042369iod.290.1545336008873;
        Thu, 20 Dec 2018 12:00:08 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id w3sm338804ior.28.2018.12.20.12.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 12:00:08 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Aymen Qader <qader.aymen@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rts5208: fix a missing check of ms read
Date:   Thu, 20 Dec 2018 14:00:01 -0600
Message-Id: <20181220200002.29685-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ms_read_extra_data fails, the data read in "extra" buffer is
just incorrect and thus should be used. However, "extra" is used
in multiple places no matter ms_read_extra_data() fails or not.
The fix checks the status of ms_read_extra_data() and returns with
an error code upon its failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rts5208/ms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index f53adf15c685..03b359ec69e6 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -1676,7 +1676,9 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			return STATUS_FAIL;
 		}
 
-		ms_read_extra_data(chip, old_blk, i, extra, MS_EXTRA_SIZE);
+		retval = ms_read_extra_data(chip, old_blk, i, extra, MS_EXTRA_SIZE);
+		if (retval != STATUS_SUCCESS)
+			return STATUS_FAIL;
 
 		retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
 					    MS_EXTRA_SIZE, SystemParm, 6);
-- 
2.17.1

