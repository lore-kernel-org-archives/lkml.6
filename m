Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A4C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78964205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZIMHjul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78964205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeK2GlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:41:07 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:54433 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbeK2GlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:41:05 -0500
Received: by mail-oi1-f202.google.com with SMTP id g204-v6so14910688oia.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IPwn7FlEmz0efrEk7wG8vLjYbOsIRixs+AynyGzluZM=;
        b=SZIMHjultMMoNkAU+NKm0Q/ykcqSV2wcCdCQ2/vMQt+uulpgrJjk8EqZBX6ub16Pkg
         g19cOLdVJnDX7oj/Z2BNZq5PMX2UISleHlzGJt+wcmKsjSWLb+8TtMCB0niSO4kUPM4u
         cvMzohh2ZhXecljQz/jKbTnc7fiXoRRy/ogLy9AbfvnNPpHav5rFSdnwusdBA4k5Dv4z
         Qk1vMW7yHhp36jqMNQRAxA3svSQMrwWAuXMGgL3l/RGRHx4N/xcZmruMTa+/ia4CSdl8
         WDofrifRzKNIZVBAeupm4HF9GKnYhNXj9nMDxQkm7w8E1JwqLlU5BjT3yESYO4cnUHcp
         O/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IPwn7FlEmz0efrEk7wG8vLjYbOsIRixs+AynyGzluZM=;
        b=MvXpvQW1119HjUAk/1TWK6v4mM2P0j7TGvMXvhnTsoLAZ2t8YFMmze74oN/rDEXBQ0
         hOiAJRzBc3pK0VbAHnkDlDCgwQuIG+QCJGcsOt3GalcNdq6xL0ggN+AIU51kIe3FbR4t
         BEirErMWeS2hCWbcM//5VElJh3KibgyKZZA4A/LGFs4D7+x16x6WkD2L6unnXiMMei2I
         GYwTc472r7JpBDfuJEaZf60byO7Q6xuCNw1dO4KZ0f0aHjJqy8lyXWcRxyrEmhnZ1ONG
         7qDPFfRgdddIT9TC2eWYhqSqN70heTVeLatr5rWSK66pj4hG2AD25+tCbKWTsb0p+r/B
         zPiw==
X-Gm-Message-State: AA+aEWbLBogAk0fIJhdDIJoI7wGNi8jgo+IVNpD0SKjKzHFvkVkzKB9J
        qK6dOrbHnh5fU2sX3/W4jv8k5cq5kGwKR4XqERC4/w==
X-Google-Smtp-Source: AFSGD/W8Jg0VQrn7yYtZe3lCCeAX7fGs42GSml3tuX/P4bPrDJzlWEQT/Bl579BoWG5KdP/hqVUw56fSKeMorjuCc3P6KQ==
X-Received: by 2002:a05:6830:1554:: with SMTP id l20mr4281073otp.21.1543433900445;
 Wed, 28 Nov 2018 11:38:20 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:32 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-16-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 15/19] MAINTAINERS: add entry for KUnit the unit testing framework
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

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2f710eee67a7..8c9b56dbc9645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7988,6 +7988,16 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

