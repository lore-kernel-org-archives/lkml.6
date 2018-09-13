Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CAFC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B05A2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dwHicm1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B05A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeIMGbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:31:47 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56084 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeIMGbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:31:47 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8D1OGnR003610
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 10:24:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8D1OGnR003610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536801856;
        bh=cBI5B6G1kvENvJCc7v9kT8EYjv0POuIfvDoEWdWs/3g=;
        h=From:Date:Subject:To:Cc:From;
        b=dwHicm1NY7Z2L7xi7ySHGP2Bjn9IO9OCPJYoVeVEROq1znR9kEpPyAoQTCdlj0Xpg
         s8MTnRmBgtuNz4Qa+rjzL+XE1IpCegBjElLbGtDJH7PiI9iNND/dZtac9jBZLdYq9H
         AA+Bf/ZcUkC2PKfnL1uOUq98o24ZcdotkOumgsT6LXuyvvp5nSKepMUg85kvRQ0KGr
         lM51G7g3066q1XSU4OQdR3PGrJEaKia9tddQU0W2mqC+V1p+w2QDXHyWD+fLRRMEa9
         7jSUevgA6NI2VRENKvjFCLFEwxzrOCsDwGI1AD6kyefP9cU0s1+SJ1GEYCZGPTvi2e
         i+J4XF3mGtcJg==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id m26-v6so3407911uap.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 18:24:16 -0700 (PDT)
X-Gm-Message-State: APzg51CDoZ9F72zPNmisYrPDguZbs7Rh8XLBzxLGrsDGEpOSWQH8xwCs
        XpgH0eYSesdA4+HrqyzWkAPWgSVYbS5cCZ9YTpI=
X-Google-Smtp-Source: ANB0Vdag95A2428Y64EsVjCII3uN3Ol8uLg43ThSytlhjyaiKAoM3klAWrtVQttmQh92623sLoVVM+7R4naQV++rsiM=
X-Received: by 2002:a67:4e92:: with SMTP id j18-v6mr1793327vsg.91.1536801855464;
 Wed, 12 Sep 2018 18:24:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 18:23:35
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 13 Sep 2018 10:23:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWfncdHRkRs=tq=TRaM+KUbb8bcMHMs8LiCgZzuFKCAg@mail.gmail.com>
Message-ID: <CAK7LNASWfncdHRkRs=tq=TRaM+KUbb8bcMHMs8LiCgZzuFKCAg@mail.gmail.com>
Subject: [Question] vendor-specific cpu enable-method
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.


Sorry if I am asking a stupid question.


For arm64, there are only 2 cpu methods, psci and spin-table.

Why do we still allow vendor-specific methods upstreamed
for arm 32bit ports?

To me, it looks like SoC vendors continue inventing
different (but similar) ways to do the same thing.

It is a historical reason for old platforms.

However, if I look at Documentation/devicetree/bindings/arm/cpus.txt
enable-method properties are still increasing.


psci is available in arch/arm/kernel/psci_smp.c,
but not all SoCs support the security extension.
Is there a simpler one like spin-table available for arm32?

If we force generic methods like psci or spin-table
for new platforms, we can stop proliferated smp code.
(Of course, we are just shifting the complexity
from the kernel to firmware.)

Am I missing something?


-- 
Best Regards
Masahiro Yamada
