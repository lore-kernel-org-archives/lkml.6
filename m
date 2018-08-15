Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAC32152B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q+m7HbUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAC32152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeHOV1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:27:04 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:41061 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeHOV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:27:04 -0400
Received: by mail-vk0-f47.google.com with SMTP id o82-v6so128584vko.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3IoX/X/15FA+0SE0MCV1DTWdFudATiHqbiblbZnFesY=;
        b=q+m7HbUUgu3kI6ZDoTaYIhGxRHkyONB0hsSkhrr0EUXaZabuxTMIx3rmSUflR+R234
         hvYcX4JIs+oxX4WSSXR+QjuNiDlfsgG3/Ulx8x6gkR8IpO2xonyM+s/Gje4KbHxzxvkW
         MAJsH6jU8oP1H4U7Nxv9oE6OqcFOv/6WKIrLKRbWG9Ka+Z3psDNfpI5lchBfCYnE/y22
         UvpP+zF8Y2ANvFV+OXiNdF201yRzV9PDSTe+roRWItCeZolltFNZ26MxskvSF5JXWxMu
         Naw7gts05NLz0WXTKHuzzD0uk5wzHiBTb8h615FzaWqb64QQwbnXlq11v1E6awEhlMsO
         f6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3IoX/X/15FA+0SE0MCV1DTWdFudATiHqbiblbZnFesY=;
        b=kM3p/Y0wvwmHGBUqEZ8o+jvR+x3Az4rTGgdsDja/1/A6ha+orqWzD8zW5y9q7EpxH0
         XeDI4AvwKOhwAJItcs8lQj+CZQ6BBQRpLKOcGomZHvKB+v84PMXpyxANePZmpyYzGnQ9
         QJDGn86KJQNlkRpOxqScWmv/qr9GKN7hck12ag54QICutu94F/C4tPFP5CA10+F9yT19
         qEmmLQe0RBhSCR68xpmZgAgvCkVIqqFkA7CDUtvzijBmDQSWrGjYu8xrQgD4D7XkV/Z1
         LsSCgHMf4XUGPWS9tUW7mfUgVKVBABBlCXsjQITdvCN2JqmrlHugw5RhUy0zG+Qpn21G
         82vQ==
X-Gm-Message-State: AOUpUlFi30YYTevaPbCkxdWG45SmwBbEJuMGTNw618kgsib2OnAFal8T
        tqvaQgIdqWOiJoyh3N225vjBXnzgwShUQ92E8myg+1Ai
X-Google-Smtp-Source: AA+uWPw7cEepttxRbfs21bJZFiKUX2B1/zkyjABC7AvF/EgVZL1/sWD8dWq1G/FZa4ByqabSMQWtCbMI9Ixw8e4ugek=
X-Received: by 2002:a1f:b60f:: with SMTP id g15-v6mr17415732vkf.27.1534358027742;
 Wed, 15 Aug 2018 11:33:47 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Schroeder <mkschreder.uk@googlemail.com>
Date:   Wed, 15 Aug 2018 20:33:36 +0200
Message-ID: <CAGmj6qs6tPvVMsxSLPgkNkmfUYSuqvTR+sqpuR+k5cEoUo9hww@mail.gmail.com>
Subject: A far fetched goal to clean up code quality
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I propose using following set of GCC flags to enforce code quality in
the long run.

    -Wall -Wextra -Werror\
    -std=gnu11\
    -pedantic \
    -Wchar-subscripts\
    -Wformat\
    -Wformat-nonliteral\
    -Wformat-security\
    -Wmissing-braces\
    -Wparentheses\
    -Wsequence-point\
    -Wswitch\
    -Wtrigraphs\
    -Wno-unused-function\
    -Wunused-label\
    -Wno-unused-parameter\
    -Wunused-variable\
    -Wunused-value\
    -Wuninitialized\
    -Wdiv-by-zero\
    -Wfloat-equal\
    -Wdouble-promotion\
    -fsingle-precision-constant\
    -Wshadow\
    -Wpointer-arith\
    -Wwrite-strings\
    -Wconversion\
    -Wredundant-decls\
    -Wunreachable-code\
    -Winline\
    -Wenum-compare \
    -Wlong-long\
    -Wchar-subscripts
