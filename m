Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D92C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA54620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="q1u9ibXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA54620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeLMUKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:10:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43897 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeLMUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:10:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so1905253qkr.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGksc5dkleZautdnPF1eglxzeAr2TyOFjX0wqhtUuGE=;
        b=q1u9ibXOid8VWVqEWh2XU+eNW07no2fku7MPyB+DdZUSos9B4yoqDSCNoTbeiD8bpM
         ZdOYNts3pgAoPpnUP5n59pLEar6YeGENUJwuPNR55OixPw9j0N5HMCj1oskBoIrtyXqT
         F/an88jlBpq6THNQtjMRs4rCs5gXGcvX+PQz5eZ+4NwwVuBVbd5iHVfiQdlWwYJRBf5l
         XPDP6DpxHneX51ofRFJ67o2zyNyaVAjiyd29QsDel28FnF4DwbDVlQXw3X4LMASua8U+
         udrDfOclTUsqE2GCa7AiiZ/aKMOsc0KsZEjgAWpCnRn4TnW+JKEocSMDcIVCMk/4/Lc9
         yLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGksc5dkleZautdnPF1eglxzeAr2TyOFjX0wqhtUuGE=;
        b=h3WvXCGmDxO5inwJT/1A7QMk3gMhKUMkE03yi6BYqZ4yvMq1T6ktalV/kS9S6FgwTa
         uofRw0lpT01LqGUiqJIYQuUh8Hhg3/5jgVGYKH3BfjCrcnRhk1sZKRePN+WEDe5GSRu/
         edOD5XuQGxIZWGJTKha54PvCSyfvkJHwDIK67+YJ4k/+WXRJYoLe1JIu2/NRJCOjJxvG
         FgrSQI3kDC9B4fvY0tRG44QVVLUc12Ue6z1qyquqFLCfIbWwCjrPVavSQOzqzlTjaXF6
         bhTzqW3AN9tMm0OGFRLP/IWlZvgkWyJssXSy0NBZ2PvGlVmAPDesK+Kr7uEtmE03PgXw
         gTiw==
X-Gm-Message-State: AA+aEWZ1HYpk3Bk8I2b1AtGJ3gu2qmREh8VOAzvPhVdQe18ijEfqrxuf
        qCEgQYueXe4sS3wbyMZu+o3LQwp9byk=
X-Google-Smtp-Source: AFSGD/V4p3lBYjjUvjJoUrkd3r7pkpq9sDp/cSoey56/on7xRDBL8EUw/XCntqNgiTHG0zyzkZvZ8w==
X-Received: by 2002:a37:10d4:: with SMTP id 81mr170676qkq.19.1544731840879;
        Thu, 13 Dec 2018 12:10:40 -0800 (PST)
Received: from localhost.localdomain ([173.38.117.85])
        by smtp.gmail.com with ESMTPSA id 190sm1609072qkh.25.2018.12.13.12.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:10:40 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] seccomp, s390: fix build for syscall type change
Date:   Thu, 13 Dec 2018 13:10:30 -0700
Message-Id: <20181213201030.4072-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent patch landed in the security tree [1] that changed the type of the
seccomp syscall. Unfortunately, I didn't quite get every instance of the
forward declarations, and thus there is a build failure. Here's the last
one that I could find, for s390. It should go through the security tree,
although hopefully some s390 people can check and make sure it looks
reasonable?

The only oddity is the trailing semicolon; some lines around this patch
have it, and some lines don't. I've left this one as-is.

[1]: https://lore.kernel.org/lkml/20181212231630.GA31584@beast/T/#u

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 arch/s390/kernel/compat_wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index 2ce28bf0c5ec..48c4ce668244 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -164,7 +164,7 @@ COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, fla
 COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
 COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
 COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
+COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, void __user *, uargs)
 COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
 COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
 COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
-- 
2.19.1

