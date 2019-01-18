Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A4EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADDC20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu+JMcHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfAROLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:11:21 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33182 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfAROLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:11:20 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so8491263vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hVmykJHQChvKguIJX/Gwop/mYEZRfQeuH+mUeWTmcuw=;
        b=pu+JMcHiK5IigWQXRDTQ+qK7lqxt4JGJnoC1gGKFNKaHfLFu1qeH0HsgST3l56R8Sj
         vWIP573D8yyTXeSIyncn+99DBt5RuiMVDf03nznMyI2paVBCQeWgpSlqHIecFdApyl8Q
         Eu8xVc/oWZK221dxeSLv/glGs1W22Y/8vi2psPYIajbGyjHbZWaDZlFq8iPJzN87Zty1
         tkwJHKnwE/eNyeYck6P8o9dKbm2QFZP9GsojNLTXMWUWLWi/NppI6/YlC1NejoYW8acO
         29ZpnfmerOvS/dlhC7aeHJHsSCeYG2zcSiTJHpxDyY50mZu5daORnUv3KgjvG3aoEupv
         DQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hVmykJHQChvKguIJX/Gwop/mYEZRfQeuH+mUeWTmcuw=;
        b=UBk/MIi93lfUNYGw7f3FPG3K9iiZPYG+BGG3RVSMVVdocNxu9fikOC7FSWD8IvXABn
         JdeBU8J64VeR2RvZhk+fW5jLXq5E/loa3F9GFlMWHU5KAlF2qyF1pO87t+xbg7975UeZ
         h213s+vls2zMXAgX1lrR6/F58f8x4HHnuCEHcWKd+vuOD6i6rv3XJCfJ1AJF8Yng7Hdz
         c5WasHBC1xfIImuI3ZLLrAgqTHRsfsjWxWVnQlHmYzdSW+m+QWQRaarJwBLUtAk7BqHi
         NKwL1x7CvhVbq88wmIKTpCO0epNcmiJ/84GkF5dFaDMnctFC8Wk4FqDnuy4QimLyK7P9
         9Ckw==
X-Gm-Message-State: AJcUukcHVQ7MuTdsVA8MdT7RC5E3hqsGxDjkGBFTofsq3oe+WKB2+Uvi
        irb8vQ2nrK8WLTR/HInFERBfhTAX0RkqyXSAqttFQ0Q=
X-Google-Smtp-Source: ALg8bN7yrTIbS7hkHdkpLn4b498e/UfGEpXm6XjzJd29RxpYzx3nFhFp0POPaZzWEKojCMjao3wulIMjrMlK4JPEODg=
X-Received: by 2002:a67:4541:: with SMTP id s62mr7883528vsa.25.1547820679277;
 Fri, 18 Jan 2019 06:11:19 -0800 (PST)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Fri, 18 Jan 2019 09:11:00 -0500
Message-ID: <CAP8WD_ZoF+C=R07D6uio1fdDVJD5XLS64g=Cgced7BHZ1GbXUQ@mail.gmail.com>
Subject: [PATCH 3.16] x86/eisa: Add missing include
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, please backport Thomas Gleixner's patch to the 3.16 series.

commit ef1d4deab953ecb1dfcf9f167043bda8b3f14a11
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Aug 31 20:08:16 2017 +0200

    x86/eisa: Add missing include

    The seperation of the EISA init missed to include linux/io.h which breaks
    the build with some special configurations.

    Reported-by: Ingo Molnar <mingo@kernel.org>
    Fixes: f7eaf6e00fd5 ("x86/boot: Move EISA setup to a separate file")
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index 881f9236ebff..f260e452e4f8 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -5,6 +5,7 @@
  */
 #include <linux/ioport.h>
 #include <linux/eisa.h>
+#include <linux/io.h>

  static __init int eisa_bus_probe(void)
 {
