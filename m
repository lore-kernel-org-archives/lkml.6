Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F4ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE75421508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCxp3MXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE75421508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeIRWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:30:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40588 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbeIRWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207-v6so3630825wme.5;
        Tue, 18 Sep 2018 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vQPkzBW7ZOGHJMcA5i4M2NXjdVktza/5ZHjO7sL3MqU=;
        b=OCxp3MXYalh0eHrhc9ZLs13Me/1zaegV8dXRpkNxzlnVjPH3Al0DCc/MZSuLWV8sfw
         WRMBm8+LNq+TLhkFxYgt2cwJj3A4OgfTea5rJCwdHIGR0ZHlPyy4xr8HQSWSdv4S2HCD
         fG28Ue+vz5HjH0sPD7Kcmm5mLpot/2SIhF4uqJ/FDruxK08Z/BxdEpUACKI3sjBxfdH9
         dp5LsnC7sY6wz7poCQiFclxcQZtlsSxuc+6n2UPYzchqDxuKiwS33lcvxW0ulw5YGQU6
         HmMjJY02PdBHdAAqPFOwW1/f0kzmY6XD0F0PwYagjH8RNzKGaXPjmlbfHXIlwAz4DvYz
         8yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vQPkzBW7ZOGHJMcA5i4M2NXjdVktza/5ZHjO7sL3MqU=;
        b=AcYvbMcUjyIjQecNUN4MSvdidYMLtJYykwpbT7OcsyH35JK5Qle44AOp6zMT7ISYUk
         A901TvppX+x32Va0lJbqyxJr8zK2oxbItKCpi4PGQfFNQEjizcQF/0DhdfoPURuoSxgX
         pte+xWpEh5ywJ98Kcqss5ma8taflZDsoz/3wyHa3anD0KZkjl/EhPKK5LVpWRwDqKSmx
         Lf1EWCxkKPUUJHmxG4otTkeycwfkKnwh6ZdbhbgbxPyewuD/LeC94SjjW3PLexwdZm7k
         WGkQHyjv8IfN3K9AS0dGxl/yRRAA7hVM6TMRAWMPkMRfXHipbfgJzpHedh+8dvGeEGqY
         NApA==
X-Gm-Message-State: APzg51DoYCJMqKY1zIdeogVldrtRSxvCUysEC0h2zx29EgoDsu7UGxH5
        kzZJDNOPhJyNsxK/jrH64FA=
X-Google-Smtp-Source: ANB0VdaT0HPovz3fvR+x5m2D96EGDTIaqy9vQXZn6qgPvFwNz8ukgYJPljdYOKCZj4E3SJNxctMO9A==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr16708152wmi.35.1537289811602;
        Tue, 18 Sep 2018 09:56:51 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2934768wme.20.2018.09.18.09.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:56:51 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v2 0/2] Compiler Attributes: (naked only, for v4.19)
Date:   Tue, 18 Sep 2018 18:55:40 +0200
Message-Id: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are the 5th and 6th of the Compiler Attributes series,
which Stefan and Nick requested to go into v4.19 so that the clang ARM32
build is fixed. The v5 of Compiler Attributes will have these two removed
if this goes in.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Miguel Ojeda (2):
  Compiler Attributes: naked was fixed in gcc 4.6
  Compiler Attributes: naked can be shared

 include/linux/compiler-gcc.h   | 14 --------------
 include/linux/compiler_types.h |  8 ++++++++
 2 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.17.1

