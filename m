Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5124C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3402173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quK21zVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3402173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeHCLbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:31:41 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:44413 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbeHCLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:31:41 -0400
Received: by mail-qk0-f201.google.com with SMTP id w126-v6so4678705qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gKam9WaYXvtGukQ1JMxYeC89hlAklM7RuKowpz4IWCY=;
        b=quK21zVntwsOGQrbPbPpyc/0lMQvpBVCDXVlBeGNW21FLAF1trai59UDBYPCE2GG/V
         DrQ7Wwp4WdeSOZ/jtyUQ/XymWPItKEwzjxI0gCqwTGxtnh8jvfx6ilpNHucV9x0LWmJU
         VzRhHCalGiCEL9tHGMtgd4YoPWmkXGtlXukYc/nM4QqkrmEJBu3vhSui9BXR+3TEYpQT
         gJHyPvgkqslr2PR8Em9VAaKoYO/sMGGIp5oNpDTmkI2XSdC/dZXKUetfY3x7vPdpDXZ4
         ouGKVPmjp1/2tPuZbJyOdiCRdcWWgY2GdZNGNk72BsqJFUWurqvr1RBvfNYwbtM5SppP
         xGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gKam9WaYXvtGukQ1JMxYeC89hlAklM7RuKowpz4IWCY=;
        b=mGJ/bYRYevE1JgNNhXqivSMlY5u8Y3SIIbNj/Kx6LaIZG8nG5UFahl8cCFUAHqnnID
         XiKw/Ok+2J4SNp1/QHc8WGaeMmzeQVmZvt3NdzGFSrNnMUFsUDm8XPcCfSVwO18yp5wz
         o2kWQlxj+yEdj3fXFHtJkDPUGPtr+xUPzRVb+wszns7mKGZPSxgvCo4uO/Zss2gp3q/K
         3vxzM+h5qAt36MEev2xtu3nvqgwMqun648MDaIkkWk/AMvwH2F9//EgBQVzPgDgQsPMx
         PpuUQ7cnF4ERkF5hO32/s2fJMmSFTinUFOzs8RlAqCGptmlkNwzX/QfIe3is5aii82+y
         U7ig==
X-Gm-Message-State: AOUpUlHHJbVRrPNB9kyFPROJ3Jjuaf6jaBOvJPkjjOgKYwvyj/z605xP
        pwnCeZBeN9yRbHFyCF8sSaYb9j3QcA==
X-Google-Smtp-Source: AAOMgpd1k5tas7kSjFbEj5zQSMmxweGcg5QVx7HyvV7lX36a+VEaslYsfPMUd807C87+qsfiIAif5sEZoQ==
X-Received: by 2002:ac8:1019:: with SMTP id z25-v6mr3481000qti.14.1533288971594;
 Fri, 03 Aug 2018 02:36:11 -0700 (PDT)
Date:   Fri,  3 Aug 2018 11:36:04 +0200
Message-Id: <20180803093604.38254-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] selinux: stricter parsing in mls_context_to_sid()
From:   Jann Horn <jannh@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        jannh@google.com
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mls_context_to_sid incorrectly accepted MLS context strings that are
followed by a dash and trailing garbage.

Before this change, the following command works:

# mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
none mount

After this change, it fails with the following error message in dmesg:

SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
failed for (dev tmpfs, type tmpfs) errno=-22

This is not an important bug; but it is a small quirk that was useful for
exploiting a vulnerability in fusermount.

This patch does not change the behavior when the policy does not have MLS
enabled.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/ss/mls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 39475fb455bc..2c73d612d2ee 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -344,7 +344,7 @@ int mls_context_to_sid(struct policydb *pol,
 					break;
 			}
 		}
-		if (delim == '-') {
+		if (delim == '-' && l == 0) {
 			/* Extract high sensitivity. */
 			scontextp = p;
 			while (*p && *p != ':')
-- 
2.18.0.597.ga71716f1ad-goog

