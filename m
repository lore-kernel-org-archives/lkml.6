Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD59AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891752147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc7l7THG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891752147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJQIAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:00:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35019 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:00:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id d21-v6so15650935qtq.2;
        Tue, 16 Oct 2018 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=iK7JrRXQ4BzZv59cX0PNNSA+/mYdwzHsLtoaqmIVT+0=;
        b=sc7l7THGn0Adn/KdCZ7TCG5pyXcTfZSNmfwX6u7ehLZBVoeTHuvUEGknFMbxbjSRrD
         LzorrkNxor3sxqgnoFBeNxqsqxMcuSToisIEaM/C5eIDDINLmYEkOvBCm4IPpWKf/3eY
         C/hRiSzzaOIpZPhBEuAeBSliCo5HyWALyDLxL8bA7kfX2x69ouTkXss6EwtYRP7MboBv
         1EWBRttEssjgKnKcdHYGBcc9ziepJufvyZn3wGPlf9tb4vDoXHqVZASXtL8eYpRtZsbu
         ghjmipE1Q5N75U9K3FJ7k3E66xkxSUS789Al4h0LqSBQCv4Arxj9Nmocov2kHF99afMH
         bknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=iK7JrRXQ4BzZv59cX0PNNSA+/mYdwzHsLtoaqmIVT+0=;
        b=nvBeFAU5ZZ84UiGdphAlGDQkxdqfrRUSP3E+gOE/VjcmOZjVy5q37OJgq7aeeRJYSd
         blCUIxQae5iTVo3UGvva1SLT0xBjW/ioJETzxxYhu2hiHLYd8MDQvfKN4kgS7jUDbjSu
         +cY6iiFnfWYIHLXCzXPANyfrSmTqGmxtW4wchXCa+Fs0IYA8/A/zRwCpqNjlLVy2EzuZ
         cVns3hmSkdSZQ4aDMM9HPJ06n0XbyO+Blh3rqsRzMeLtGhaHXokiTRgXBNr4XoUpOkCi
         sgvuXFwixQp++HwOFPJg07nG3F1YXJ2+jOOTn8Hw6NbQY+CBZvhJE0a5bmsiCkrzdTcl
         ZgRA==
X-Gm-Message-State: ABuFfojPM8Cl1NbXp4BvR6wKVmdd7J5tBziA42/25DYUtVpHnGdGNcNX
        wAfWl91i/p1sKz/YZvy5ShIL4kdh
X-Google-Smtp-Source: ACcGV63QGOYF2i8Ea+47dPZKHG56Qya4fj/oDzcdit3TkkxLTCIeHKpgeD0XRQyOmNd4O9B+e0hdLQ==
X-Received: by 2002:ac8:7c6:: with SMTP id m6-v6mr23213726qth.365.1539734849095;
        Tue, 16 Oct 2018 17:07:29 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id g127-v6sm10067732qke.59.2018.10.16.17.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:07:28 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:07:22 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 0/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
Message-ID: <20181017000722.GA20892@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add -Wshadow=local on KBUILD_HOSTCFLAGS and fixes 
all code that show this warning.

The third patch was already submitted, but was not merged yet.
I like to think it's part of this patchset, but if it was 
already merged, please ignore it.

Leonardo Brás (4):
  Adds -Wshadow=local on KBUILD_HOSTCFLAGS
  Renames variable to fix shadow warning.
  kbuild: Removes unnecessary shadowed local variable and optimize
    testing.
  Changes macro usage to avoid shadowing a variable.

 Makefile                     |  2 +-
 arch/x86/entry/vdso/vdso2c.h |  4 ++--
 scripts/asn1_compiler.c      |  7 +++----
 scripts/mod/file2alias.c     | 14 ++++++++------
 4 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.19.1

