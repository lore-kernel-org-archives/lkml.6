Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF72C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCE520647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBQEb/hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCE520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbeGZPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:30:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36070 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:30:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id n21-v6so3189740oig.3;
        Thu, 26 Jul 2018 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=CGu+Y4mbflGjhZHtG6eiKdIh0yUHT1kmAAZF61PEAUg=;
        b=JBQEb/hzyzqhLg1mayTs8DcTGx1AtDWq5/q8F8deW7vo3peihYg1GktSQD92j0xS8L
         j4orz3douLSyavXEGliqxBBa9FIxVugCanRQYWBjIJFSSxtOCVa3//C4EUiFOyXkioGY
         D2HCthAQ2Su3ixwaIyG2a7hNevTnoVCUqMMj03y/dTm//6dI6zUjLMQBwZH1qRHnkZjR
         D2IihmhHiESKuLlAnrF95rS6aY21xIWYSLVlzJmXyOtYqn7cnlgo9Hy9O2fbG3/Jryse
         Fgcg3jTgPRuQWCG5s+XML356C7bGZq9K6m9lTQ/kqwGPycbGDPsJjftS/l7OcaJjcMmc
         neXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=CGu+Y4mbflGjhZHtG6eiKdIh0yUHT1kmAAZF61PEAUg=;
        b=cxxLEFrNv56F+MlJsUbIQE4wSm+mQUeJZ5FH9bcWYd1nf+TrYOsS8IVlwPkGwza8zH
         f0BdLyIhR8xCy6kv9kxGuVA8eb0E6JuyG/fLl529cr9gE4VQ0ExtLahKSL0BTJybWSou
         r8335N5v2K2YCO99WFmZfR4CuXgOObZpmwMuK5zxigOa7s7qtZDNS9F2zwzgM95Jxsf8
         vHH5ypcjvyGzh1Jzjz+fagqus08TFev53OgS8MjCcBZ43NIdZbKquuSZUTUFO1ovQySw
         krJUvwEoUXov9+RS1KuqFBqVIHn7HN1ClFuHUtIbGQzVL0Ek1XOqF7F6aeIqXeWN7vXj
         0KUg==
X-Gm-Message-State: AOUpUlGdMuhr3DVMNG6gwIE573gpvMjFN64Bk/bVPNYQapBJ/LxApuaG
        W4W5NIYEeiGmhWg/yQEfDDa4+JrN0KJWzLU1WZU=
X-Google-Smtp-Source: AAOMgpfF1AwmBID2WbEQWdTb7JD2kVntPaUms0p3wPdcDg+UCtwy01/VIu5mBQ4cNqve4VopCEYc78HRsgL0LacZxuw=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr2255581oih.227.1532614404963;
 Thu, 26 Jul 2018 07:13:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 07:13:24
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jul 2018 16:13:24 +0200
X-Google-Sender-Auth: ZPD1LeIjU3RLaMqlIy1Xo1mtalo
Message-ID: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.18-rc7

with top-most commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000

 ACPICA: AML Parser: ignore dispatcher error status during table load

on top of commit d72e90f33aa4709ebecc5005562f52335e106a60

 Linux 4.18-rc6

to receive an ACPI fix for 4.18-rc7.

This fixes a recent ACPICA regression causing the AML parser to get
confused and fail in some situations involving incorrect AML in an
ACPI table (Erik Schmauss).

Thanks!


---------------

Schmauss, Erik (1):
      ACPICA: AML Parser: ignore dispatcher error status during table load

---------------

 drivers/acpi/acpica/psloop.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
