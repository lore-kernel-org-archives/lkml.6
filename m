Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C63C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39B520857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT2v5j20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfBHOGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:06:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37512 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:06:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so3487845wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1ddrRSay6IbVmIqryXJoBDwU25DS/Q11iYCCxc8XtdU=;
        b=bT2v5j20VgWjuYAnDH9yEZfkkJZAnTcBZ7b0W/EtBZhePrRP0TSjf3Ty9c5k0hxsn+
         yibg5u8soU6G8trDeOwteNnTkAVVP5yesYSRWzd2MNN1lvaY5a6C26ljedab3psHeVIM
         DjBd6gc9XuX8rTr9+9R8KPZ/Uzx2gibEyS5JVIVyiseNxn+QUMBvWKfnjesSJMOc129J
         paiByqsBXTJSx03Gz4REDOSPquxSzyzmqd3P0a+lIYwqkvpmEFKpU8yJVEbPnRhkYxUe
         eb/3gJjzVjVcmtnXy0UeNu1j7aVSKYHKL/z2bSq7QsR93rINs0kUR17ngRgICidXRIm6
         uoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1ddrRSay6IbVmIqryXJoBDwU25DS/Q11iYCCxc8XtdU=;
        b=Q03ZhW8R/0KGSTAWuLkzQ6UgO0o+Ub3je/AUBxm6jYfiPxxxctt9d2Tgba8+/02829
         kbA5QFm2zWJTF6do4OfoMXdcTFg7it/cEBrX8GcGHYf6Sj0ci7h29KP2zhhn6KWs+Weh
         DOicT5vf0vZPpIBqwUmfWRDTLfOpYAcL09VRvXIc/CxsKJrWimkWjWGAzdmy5z4Sger+
         gb8s0JYpb7VsLbybIx11ivxGIyTV4NzXguS660lu2xdYQuk3MCfLjBTTkP2kDHmr0FN6
         EnD+YODPU3dquHB44WVTg12dHeUqF4kBB7HWmqb3r5yXgJcPExy3jgffhMPluH+AW1tC
         aLOQ==
X-Gm-Message-State: AHQUAuZ5jLJjj8S46e/5SDSG8R5N9jmY588cn8GvP//VRpszyEAuW/YX
        wRFmFyH5vcAVoiAcKmcg4mN6UvXVPchv7Xz8XwjS0mZfKPE=
X-Google-Smtp-Source: AHgI3IaVRMoNfOJVKu11cLTszbulW7KcNTqwaq/y2DNjRNJs9ttgi7LQJjBxjh2BldJbEj3YsG0wjx1sr3OmBJ9asQs=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr6496965wmb.85.1549634797266;
 Fri, 08 Feb 2019 06:06:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 Feb 2019 15:06:25 +0100
Message-ID: <CA+icZUVURn5e0LyWrp3ukS3z16MeQP+V94rjCrb4yKveO2+8RQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] init/Kconfig: add config support for detecting linker
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feel free to add my...

Suggested-by: Sedat Dilek <sedat.dilek@gmail.com> (see my comment in [1])

[1] https://github.com/ClangBuiltLinux/linux/issues/341#issuecomment-459788558
