Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD12FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F26820657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBIJexrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfANMSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:18:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42509 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfANMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:18:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so10262163pfr.9;
        Mon, 14 Jan 2019 04:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=a8+6JY66E1nkzEzBg5JSINfS6WfECrlVOQMGq6zQCuE=;
        b=BBIJexrbTFBSotmZIwaUF285x3gASjr8iIf+yLVerub318Hz5twSbdn5525fbGQtGO
         n/ikEpsFjsGhZHomheokktLDfZNZmkHEhpNahOWVLrmVHbRbbeCb49viluy2ZEBqeLrJ
         gV8t039NDDCuY+OeRwixWeCzA61/y9vq08cV8FZjyJWxx85KobL7KzuMp3FQlH2drxYu
         Nxl2/LAdzQJRBEcvQ/UC3JLM+x3y0xhDHpfTNEsOzsYniye/WlA01NkYRwi+8t6AAOy2
         QutGQ0kwY+PWufir1w0WQr2i43/cFq8tSm5oblSpzGsQN4ntPiJ5aY87B0vEGjZqinEX
         CPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=a8+6JY66E1nkzEzBg5JSINfS6WfECrlVOQMGq6zQCuE=;
        b=OujL+kx40HVkJwbFeEwAt0ItvCVVdX+8TfrzcXuZz9/EAOjNr9GIwJl6Iq/XXAwJDl
         YpYqDgYxQWLQxMYg6MHBnDixGGcF+3jakQv1KVYCY13nh9WY92pxDijJ4QaY+XSR86NU
         hrPCGipj9Qr900qx9KnhJSbxUl7ttekOP0nGgaWnJMB0Yy3RN7DFtnUFWyCVgCyHaR1W
         lai7XxHtlTeMpBgGUD8CU60RW9Szsbz6mwbpMNiYZM8Dp6KJP055clzRXGf/zgS5LZVY
         1XEzR4jbWbWxF5Aa5TmkL0u29/XP78Fgr2vzvOxg7pc7JbvtaxVm7nrbWOeAOkU46mqo
         cgvA==
X-Gm-Message-State: AJcUukfAiy36f3OlbcloTkd4XZP9Qjv7iktXU+1T8osqEfXa7NMFYjlX
        Pn5vfMYaIwaZR3nsltcn7gw=
X-Google-Smtp-Source: ALg8bN4Bs47hrTod28lMtIRygKEwDBTEvtkeWWhGGmbaqitI/5jaZMPiluO3DcY84YYtymlH8YqtaA==
X-Received: by 2002:a63:200e:: with SMTP id g14mr22694181pgg.235.1547468287781;
        Mon, 14 Jan 2019 04:18:07 -0800 (PST)
Received: from sabyasachi ([45.116.191.203])
        by smtp.gmail.com with ESMTPSA id c13sm419145pfo.121.2019.01.14.04.18.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 04:18:06 -0800 (PST)
Message-ID: <5c3c7dfe.1c69fb81.7c853.0be7@mx.google.com>
X-Google-Original-Message-ID: <20190114121802.GA3459@sabyasachi.linux@gmail.com>
Date:   Mon, 14 Jan 2019 17:48:02 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     shuah@kernel.org
Cc:     jrdr.linux@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] tools/testing/selftests/x86/unwind_vdso.c: Remove duplicate
 header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sys/ucontext.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 tools/testing/selftests/x86/unwind_vdso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 00a26a8..9731133 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -44,7 +44,6 @@ int main()
 #include <stdbool.h>
 #include <sys/ptrace.h>
 #include <sys/user.h>
-#include <sys/ucontext.h>
 #include <link.h>
 #include <sys/auxv.h>
 #include <dlfcn.h>
-- 
2.7.4

