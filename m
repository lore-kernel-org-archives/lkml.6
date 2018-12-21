Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45AD21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXqbHXBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbeLUH2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45265 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbeLUH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:28:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so2097375plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2sssIdNOcTZyXQnEG11Y391NPHY8SZYJOxlrGc/9ns=;
        b=TXqbHXBpcA0DiZ/AdfieSuoyH1xrm31KlblzHWJxfDBCauG15aFuU6NfcZy0/2JC8+
         2I6j9YH9F7+7XheEn6sJ8+LUacw77dkYWIhzAanH3qkNVs7xTvczDoYyHnqVvYulXtrQ
         18/3Xfy+O+iX6Lenb3N+vQ3dGazrOoGlNb79YwAV/fxAjN+0mJF2A81hoV2lvsRaADaN
         t4LeBUZSvwGoxhN8AEFBN7uA/Vop0w+vsQE1ub9Irzm0hF0xSJYQRQq4KNoHR67Q7Jk7
         oek9h2q/niGthUdDaHnXdLmcysN9uq0YJfwHCmBO9fOP8Qpt6uyI3Y5nYAyav25WXjwj
         pzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2sssIdNOcTZyXQnEG11Y391NPHY8SZYJOxlrGc/9ns=;
        b=HBUcg2ozUST1b5uNizQkcYemXT/a6bh205ukj7p4dacBdGcHV3Wdlb70Xk5EH+xnwO
         tT/eI0QEK8o5JJEN+8C1l2dE0Vzc9zgIT/qk2XRoWf5uTvAWX9klJQNgpP/AUA++Ge3o
         bmVtybkTuq7JsfiqREwixw4HY2srmclNPCHMp1JzLrOJtbW6isKJcCEXVXkRVk6E9d6z
         uvDtrcjap8gIgM6zjQywhceXZzUbKbKHMvDtI2pWFXZrE7hpFASj0NaZeW8WKwXJDWW2
         i5mp2Fr7c/05toxZ8YqqxdolQVCHHZGK3Ubgl+eRZ7b/BbLDHWvj03q9QBncy8inSBXV
         Tu+Q==
X-Gm-Message-State: AJcUukdCi30/eoOGlGmAgJwfxOHtqdQK+6TGBaJBPAbdPFdsHXG+Y+fC
        kQnF/swMf9oUDYgvxB13PWqRYdUq
X-Google-Smtp-Source: ALg8bN6Kb+0YAg4+uYwE21MRJT/aFSsuLdLGcElKyLfJTfIQwgTS/IXcQVHl7HKLcYZLfKEkPA4iQw==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr1454518plb.254.1545377330522;
        Thu, 20 Dec 2018 23:28:50 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f20sm27688275pfn.177.2018.12.20.23.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:49 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/5] IHEX bug fix and some improvements
Date:   Thu, 20 Dec 2018 23:28:36 -0800
Message-Id: <20181221072841.30199-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series is a big-fix to a problem I encountered while using code
in <linux/ihex.h> bundled with a number of small improvmements. The
bug fix is in commit:

[PATCH 2/5] ihex: Check if zero-length record is at the end of the

Small improvmentes are in the rest and all of them are purely
optional. Hopefully each commit is self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

NOTE: This series is expected to be applied on top of [fimrware-patch]

[firmware-patch] lkml.kernel.org/r/20181017182718.32740-1-andrew.smirnov@gmail.com

Andrey Smirnov (5):
  ihex: Share code between ihex_validate_fw() and ihex_next_binrec()
  ihex: Check if zero-length record is at the end of the blob
  ihex: Simplify next record offset calculation
  tools/firmware/ihex2fw: Simplify next record offset calculation
  tools/firmware/ihex2fw: Replace explicit alignment with ALIGN

 include/linux/ihex.h     | 29 +++++++++++++++++++----------
 tools/firmware/ihex2fw.c | 17 ++++++++++++++---
 2 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.19.1

