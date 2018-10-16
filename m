Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41368C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63BA208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkYAGmJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63BA208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeJPKKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:10:23 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41806 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:10:23 -0400
Received: by mail-pg1-f181.google.com with SMTP id 23-v6so10054306pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iTL/dMtCM0hufMxgMiDZ5naPO/ZZr/9ewDdMvso5U+E=;
        b=jkYAGmJxiHHcdriTMubr4N+Gq6NiItXe22ez6MjlY7q2nZQ3m/cVHlv0Vno1h10Xkq
         hgvE7lVmRUJ1dV1TNkaQ3MUHPFIV6079knxdm/UNQacGTRQk0POTryleE6zG+j4R+M5w
         dybGiKkSLCJoZ/PkQ63lc3j+qjTbaZEs2NncWmTE2KS6RfliNTMaAcoVMDrzgeF3rDgK
         LKfXN2TXFM6DgqLprpO6e1+k9L42TsGPNroGzFjFL4M4CqkPGgNb/Dw2UJwgoaXUAzkQ
         tY/8JMdSB2TKnSYtJReUiVlWGKnJ3/nytg+b2XJ04lxVAEakTzl3yxSTzgWhZkvpLgs6
         mQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iTL/dMtCM0hufMxgMiDZ5naPO/ZZr/9ewDdMvso5U+E=;
        b=uJVV+cn1TSidz6+tZNsgbjs86ULDyIY3NULj07fUU6a2227cSAepQYbqWAbv7hSh2P
         CCogfVCH1DtcWUqRkpujop9ST00m6vih3sQodk72p5GpJRZUCygxrmf3qTMxJUSY96Px
         FSwINA7U+SL/cGuGWOdTntV+eNUzbBhqIzHreLFHM5W5PWi5BNqcw4c3yKnYYGNLcyyC
         HatsJJRAJJQDz53cTExKXSFrffMsIlRY3y+Cy04xs92sUtRBvGFXczdhQousstbTokf2
         ePepyHPzes5O91ceEwaVL/tBeVKZog9EUaZg+exXqus+ano+x+8Ggoah2NmzjvDBKzeY
         lc8g==
X-Gm-Message-State: ABuFfoiw8o8plaNukvsfc/DfmfOyNSPmWGDIlmrfi+iKWMWc12Qn8JLR
        eQkZ7R/VwmwkiUEuZG5E4sH7GjiM3IjdgrICs1Amsg==
X-Google-Smtp-Source: ACcGV63WwaMxLOrd+nVI9PtQmKX2ikcgaxTMJe5C/C7kNStZPUrIhoHuK9CoyJrJlhw7Niluc/7J7PUZwEH2c3gbenU=
X-Received: by 2002:a62:174e:: with SMTP id 75-v6mr11854656pfx.117.1539656542303;
 Mon, 15 Oct 2018 19:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAES_P+8_H_by1_Fk2pwn6ymJcuwf66wiarFXsm7_=uPZnnCMDw@mail.gmail.com>
In-Reply-To: <CAES_P+8_H_by1_Fk2pwn6ymJcuwf66wiarFXsm7_=uPZnnCMDw@mail.gmail.com>
From:   noman pouigt <variksla@gmail.com>
Date:   Mon, 15 Oct 2018 19:22:11 -0700
Message-ID: <CAES_P+_Aoufy-2JcE+h2U6KNgRkCjdeZDUNZyeFm=-eWhxdfpw@mail.gmail.com>
Subject: config EXTRA_FIRMWARE not compiling muliple files
To:     linux-kernel@vger.kernel.org, dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Folks,

CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE="first_image" "second_image"

request_firmware for "first_image" is passing but for "second_image"
the loading is not happening. Is this a known scripting issue?

I get "Request firmware defered -11". Please advice.

Kernel version:
 VERSION = 4
 PATCHLEVEL = 4
 SUBLEVEL = 21
 EXTRAVERSION =

Thanks,
Variksla
