Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F38EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6271208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bON4sXBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeLNW2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:28:01 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49639 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeLNW2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:28:00 -0500
Received: by mail-pl1-f202.google.com with SMTP id v12so4557201plp.16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tGr/AvNqZYrxR+PNUnY05GvPnHu3UCKdieTjlb/DctM=;
        b=bON4sXBVnTvGWw8qEtmOQ/jIrf/I7NdD2OfSdoF9Rya8kTrRmIztwYRfAb0GZPWAY2
         HL29lhjJD2DshUPw1s1uzo2XYcv8/qJF9SnE4qhJBj6yrhEAtVUYNw/dVGHgC7wa14Hw
         xaRYTW3igrjd1Svlk7XBKJcWDwf4f0o6n68+0daId8Um01CqjNUaGvzsfoEAwe4FGT6D
         7uRqaTgDTjRX0hWfhFu6MYnOh3wh1VvIbPnfkM8dTuSH2iufGyj4Lq8XBU70TibzrF8b
         KmPHjxp67iDIHnriCanvdkJD7OwYR5U3SeXhbhJF31/U0nj4pVqiq0PZQC3o0YFoAD5v
         /O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tGr/AvNqZYrxR+PNUnY05GvPnHu3UCKdieTjlb/DctM=;
        b=uahBP49W+n+1UqAor+nqeHM4o3EnJh0TP3AAaetRE2gDMxow3ATbwJkVsHpmDJoxPy
         7AWEn3ElbuWqBV6t/7RKV+62lIRAhMJCg2+yjCTYLCgOPiWKqW/bH7CEr4mm8h84ZFtQ
         7G0xCnVQx7fpBRQc7A9hTajsHiGhIV3abTbDiao7EQITrze8OfGiiSh+S0oa4/P8kv40
         rMfI8+QlVL62Sr2NiCM+FBQ8fuWn/rFV60yKi/Wq0fETjZevsG1T1MzxnTFJm/LIbSxp
         5GO0Msb+CRC/GEHxlJ+sS4A8SsMBAqrBA8wVVa2HdfRiAxWU5x+R50znGvW8KIAy5FaG
         8/lA==
X-Gm-Message-State: AA+aEWY0r/arTnUO/PWMjs9MYWRBrnxbEMKCGEHIhmIiq56L/LOR9qjy
        /KHt7+NxON5yKDs7nAGlK/mZafPgY+41jQzKb+rNLO+Bg/pblvvOgB61Pr0BjGHkVkFtr753nWw
        eYr7XT7r2PC8JOguPomzFUfya8mQSjx7ooLtifxAM4fQGQbLNkEHihbTkeKNdKzjrEJtPZqWdbH
        dBGw==
X-Google-Smtp-Source: AFSGD/XxwzckIem+ABm6K9oMzcVEvuJpSZb4jYIt2ZLFJim9fOOX5WRh8lQ57FvUc4VEWyt3HkHSisnq43B/cU0=
X-Received: by 2002:a63:3756:: with SMTP id g22mr2803940pgn.138.1544826479977;
 Fri, 14 Dec 2018 14:27:59 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:27:57 -0800
Message-Id: <20181214222757.31280-1-astrachan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH] x86: vdso: Pass --eh-frame-hdr to ld
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
accidentally broke unwinding from userspace, because ld would strip the
.eh_frame sections when linking.

Originally, the compiler would implicitly add --eh-frame-hdr when
invoking the linker, but when this Makefile was converted from invoking
ld via the compiler, to invoking it directly (like vmlinux does),
the flag was missed. (The EH_FRAME section is important for the VDSO
shared libraries, but not for vmlinux.)

Fix the problem by explicitly specifying --eh-frame-hdr, which restores
parity with the old method.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201741
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1659295
Reported-by: Laura Abbott <labbott@redhat.com>
Fixes: 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
Cc: stable@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 ML <x86@kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>,
Cc: Carlos O'Donell <carlos@redhat.com>,
Cc: "H. J. Lu" <hjl.tools@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: kernel-team@android.com
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415a8c80..c3d7ccd25381 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -171,7 +171,8 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
-	$(call ld-option, --build-id) -Bsymbolic
+	$(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
+	-Bsymbolic
 GCOV_PROFILE := n
 
 #
-- 
2.20.0.405.gbc1bbc6f85-goog

