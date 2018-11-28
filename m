Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D951A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb9/h0zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D951A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeK2GlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:41:10 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56255 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbeK2GlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:41:08 -0500
Received: by mail-qt1-f201.google.com with SMTP id b16so24624953qtc.22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZXeVKB3z4xYEMo//ei2CNGIhvC0pSeK1m9ZjHQ2diMw=;
        b=Rb9/h0zVwkkHN++1m58koJGyJMM2Qj3zSthOhQpGBZZ/uJowc3xBQITml1f4/xyZJa
         B3DhIiwi2xrFoi7Lg1DCPrR7jql0Y5iiGW96UAdIv/l7a72tOaIu/2RUTYsVhdx+iX4R
         oQTLd2T63dQ5oa12uvSnjG9zKS1z6OdomrilynAIPtjXmcHqnpGxebSh6XpLGu/l3GAs
         ylLroOjj6q8fZ3fFnQzEjEyoaI8rLhh6rTtvDOqiMTzpL9bPKHMnD6jP9jkDdxo3USg+
         v3DuICgLArR4aAaeTCE1kY5NXdiff1auhDnsM8/YzuuEHTJRs7rDohz5swcips2xZ6Ov
         CFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZXeVKB3z4xYEMo//ei2CNGIhvC0pSeK1m9ZjHQ2diMw=;
        b=PGf0m6K1TUYKqcqUXW7dVCJwUe9NA9WDA+QdZRI4YKZvjNlTQpNAmTDIsJO3vUuOiW
         8AXrOCmhxGnMQgPq08rZiXgPmd0xMkXs4m51MK565PQqbGcoP/BjepJ0SD8MV2iiU3W8
         8WyF45O7gyeeBIO4iFVGrnLoVx8gBaedrN7UDG5Zyo+Zt/GqCWXlRbfc2QZFBJGYtnx2
         ReSZah/zEYtA0KUaUUcteLySZr88Ynx1k/5QrRSdXAAWVIFbo8jLUrMoOBo4r2VtuiZ9
         111KZ2NDOk1Veb2nR3SOsxdpIhaNFz7tNBCEYQVph/GGPo+1NvfNYEef738i/4KsJaUK
         Aoeg==
X-Gm-Message-State: AA+aEWZIlFsu1DnkGh479GcP3wlM9AQH4P8aztps/UrcdaX5i7UB8LGU
        ePmvgWFNx+ZlcPMGbuGb/piwgOrxQjaIoiVpdH70CA==
X-Google-Smtp-Source: AFSGD/WNRv4uLe4qzapo7byn71/CSO8pn+dusHGBhoYU/dteolVxh/z9q17isRjU/4o3tgV/+62KxUnN0F0B3WRn+xp75A==
X-Received: by 2002:a37:4916:: with SMTP id w22mr4361663qka.6.1543433903147;
 Wed, 28 Nov 2018 11:38:23 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:33 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 16/19] arch: um: make UML unflatten device tree when testing
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make UML unflatten any present device trees when running KUnit tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/kernel/um_arch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a818ccef30ca2..bd58ae3bf4148 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/kmsg_dump.h>
+#include <linux/of_fdt.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
 	read_initrd();
 
 	paging_init();
+#if IS_ENABLED(CONFIG_OF_UNITTEST)
+	unflatten_device_tree();
+#endif
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

