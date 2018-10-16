Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBEEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E832087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXegup74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E832087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJQHrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:52 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:41500 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:51 -0400
Received: by mail-qk1-f201.google.com with SMTP id a28-v6so3518309qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YSc+DXfgHSn0UTc27tWo8tZWoS60tFcG57Z6QARVOU=;
        b=IXegup746F+BLsmZfImNKweB07my/EWdOCH/1Wjfs3qOq/zcf8e1r9QnXsIpsb9Wv6
         zHFtH2/RxzSaI7uFdgeoA263N337cYscszf038ZukK/6q76pQn8pkPuT7inrucWhqLb4
         uPwDKuA43p7EgX1TrtHesRa9n1OS6z7HEbkSItpEEkkDemYV92jxEnCXRhj+ISiytXcg
         LM8oKFXN4P5KeElTHfuzQm8yAvTr5CXuClJSrCz941ymoxiMSM++ZTo82fxmXJTmESMO
         P7mSWjMhBuJ4L0svYNLnxlinWC/BbFPM+ycZxUoGE6bLpAcmafMKAHJa+kPwhsgYz6F2
         Tpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YSc+DXfgHSn0UTc27tWo8tZWoS60tFcG57Z6QARVOU=;
        b=XyP9TU+JtS7ksuaWHKeouNyMbaKy+55Civ115FLF4tTLpAz9kbCkBzSagRN6rfoDAm
         T/owRzoB1XQf61KNLu0pFbLb/lRn0Ni7xzkd+a6mvFjNXRTGhU68S7Hw7O35sFjIjFaL
         dh7gKNQtaAr0RZQPN2/fv3M9EpRfSw8JqPiNbETF1UaCTsS1j2gebIlyKCuaL8ixpEsl
         7CtINqLg7jQ/D/ShTcrG0bL1S+dwPuyO7rSGX0f6ZQVJfm2II/ofpl6oKLLSDD1YsVY8
         21+U5XC5YSxzJPLNiCpP4PSFgcGIs5+j1iDdIED5CcttDsXyuWkbkq/5+vPvkc1IvTct
         I4Bw==
X-Gm-Message-State: ABuFfohYa17F+gr69fz4YL+vpwRnr153tpmwxtiady+N/rdGlo2oHNW3
        fEf5RMCz6QZMy9vgYLqYfFfyebPWQowdP6Cp+Kaknw==
X-Google-Smtp-Source: ACcGV61fMJ2XqYGxE2Gqd2wOEa7O3zdmwDvctW8XJpGQG7JMwP95EidIc+b0X7pqhvUYBVjt4z4h9wDHwKfgxXMrHSwQ6Q==
X-Received: by 2002:ac8:362c:: with SMTP id m41-v6mr15972638qtb.21.1539734102061;
 Tue, 16 Oct 2018 16:55:02 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:20 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-32-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 31/31] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf44..9c3d34f0062ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7801,6 +7801,21 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	arch/um/include/asm/io-mock-shared.h
+F:	arch/um/include/asm/io-mock.h
+F:	arch/um/kernel/io-mock.c
+F:	drivers/base/platform-mock.c
+F:	include/linux/platform_device_mock.h
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.19.1.331.ge82ca0e54c-goog

