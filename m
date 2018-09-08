Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A65C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF81D2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF81D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeIHTRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:17:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34378 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIHTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:17:39 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1HuU-1g0IAC2sPq-002m0e; Sat, 08 Sep 2018 16:31:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] compat_ioctl: remove joystick ioctl translation
Date:   Sat,  8 Sep 2018 16:28:13 +0200
Message-Id: <20180908142837.2819693-7-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:wzPDog2sf4LNWniMkNTBPh+9VsaUDQDMSz61f4KlH9gIoo3lROa
 ZWAcpZN+1qFk+2NazzedX63oqEE/GGGabgVlemlfNwj+yClqpb/SFcSxx51eziD6ugrVhpQ
 RbsCG8MNGr+vHax24qVphlSvVKh8CKCxTFYrgvRmoma7BSP71E80ZRJLt3N1rMxGhLH+kov
 edox9FFrWg0GH9nfMjPKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5zUYGzFksIY=:QXLXW/sNKeSUfKwP9Stk2J
 316Iiawm1j/ia7aCcbhk6/ygop1+q44gPy4aWRx3mad3O1oG+Wr5OlFjh9/ra6OU/oNDQoa/K
 ZaRpsHPqigN3w8bcZ1ugkO1XjLmIL7Jzq24CzA2zU+qvAluwuRnsjTb/+BeP4pHNGQcNi1IvW
 7FW4X1WHEa3ikyD1OzduxqzU0+zYuyfUOQOHepB1ofv8L7hXt1kOSRBwNgo8lDFE5m92lA+1M
 rq5dC8DUIaQijgBya25QJTY5pogpAuhM8SMx34SOKt6eZKM9k2JECyrVeK+BtDwgTmfxqqFtS
 wu3LPnyyo0qJhV+CygQj/hGF5KCwhNu9U48xczTwHmE+w9PfkuPKZeSoBQ/vu9YtidFPKwnnd
 1sZQvSOWG78uzuFbS/R/8rhrTIU9mxG6Y5Si97MVwf4nJGtUXJDauFMXzUa8zgTQEaC/j19q3
 8E5lc9Y8ZtBYqmUy/j0K7AcqqU4ij2FUVZJtCRIGSab4FQD006+I27MNzQDD+V8XuF23+xmSZ
 M31m8GodBlsmQ1U05XcigFRyyYJvImCwmNkAAFo6MVk5bcEtwoECG6IXhhY21vQmF9pvLnHM3
 C5IWvu6EC3KnMgKTbVN1fGkekUJG9PUZlYSihgCkxEFf/x4GbkBK2eLYXbtfLB0fIc/aopMb1
 hToOxAwPoPpHbslnJt/EzXcZABztbZsJgigl1Skxn1Q8Ys9Ym6WFW3oCljqdWndwd7dM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The joystick driver already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index eb29188d1dbb..23c0406d8b30 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -11,8 +11,6 @@
  * ioctls.
  */
 
-#include <linux/joystick.h>
-
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
@@ -646,12 +644,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* joystick */
-COMPATIBLE_IOCTL(JSIOCGVERSION)
-COMPATIBLE_IOCTL(JSIOCGAXES)
-COMPATIBLE_IOCTL(JSIOCGBUTTONS)
-COMPATIBLE_IOCTL(JSIOCGNAME(0))
-
 #ifdef TIOCGLTC
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
-- 
2.18.0

