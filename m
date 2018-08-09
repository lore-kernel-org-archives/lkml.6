Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6A7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1CC2239B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PcfbcDG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1CC2239B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHJBB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:26 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42199 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeHJBBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:01:25 -0400
Received: by mail-pg1-f170.google.com with SMTP id y4-v6so3404353pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=5N25SMgBC8EJI5nEEXohnNDCp+jwSHKeSOhSfFT0jsI=;
        b=PcfbcDG6pUVpLSTJ95k5J3L+QmUpFan/FY3yMGXSK/2FC5Sl5rIUha830gJcnm6Y8l
         4qLcGzmU6UwSfTtaqVc2LruuGEqUOnXKEd4MFvTEW1mM1Di5oSEEYK7afN1LUmQped/q
         F/FvBnm0AC5qIl4wm66yLagrGfxzV2SAI5rs4ngRGVCKjQQusWj4MnuT8iaVTeSolOb7
         uOlTjrOIMHs0AnD1xudQKdKfDuKLoYAk7Nu4uGMQ6o3Z39OEHBnlZdnUnHb8VgNFo8yZ
         JAmzT5SovfqCLPRL2IE/u9iXceUutwcBp1XPyemAcMhsYLwfIEo2OxzcI9EMk0izWKno
         JjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=5N25SMgBC8EJI5nEEXohnNDCp+jwSHKeSOhSfFT0jsI=;
        b=iz1fOMc2XHvNYzEs8HtvgDZ4ZFykefn1abTOZZAg7VXCdXfMaZypcb4xqIqQmIlYbm
         3/OSO6Uks4psZshAUkTqMZNKuX+sPjX0BuovsNVLnq1lEGR49tlbelJe0JWh3FpfyX2w
         azfWrcOPwFIbHspXLWM5PeTzzlxv1RR0zJKymT1aW3A4sffj+4KkAcjX7PfpbhBStne+
         IVuoTYR+wKhv0hdi4zBK/CH/9VYE7j1RztTb+Su5o074TxwbtmL5tkBDo/kXqf/Rgzxa
         x/WJI95ClL4m4JDAsUsIjuECUb9EeNlJ1J3e94GDNfkgfHE0KcxUrBohWExDUgn+Cxoq
         Gpww==
X-Gm-Message-State: AOUpUlHUZ+QpsIQO/djvrn4qwvm5cZ/bwUXS8Aq+r7+zZMt8PDKSwymX
        /oCuIBQpTGFdtSsmKiMXYAIvuQ==
X-Google-Smtp-Source: AA+uWPx3tRFqtbpf/nLX+HunYOql+exZXZ69mYTNKhUp40LoP5oZxhDQFtmzFiu0WVHexwQ7gwa+GA==
X-Received: by 2002:a62:3a5b:: with SMTP id h88-v6mr4213788pfa.61.1533854069052;
        Thu, 09 Aug 2018 15:34:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t21-v6sm13395731pfi.73.2018.08.09.15.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 15:34:27 -0700 (PDT)
Subject: RISC-V: Don't use a global include guard for uapi/asm/syscalls.
Date:   Thu,  9 Aug 2018 15:19:50 -0700
Message-Id: <20180809221952.24260-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        tklauser@distanz.ch, Arnd Bergmann <arnd@arndb.de>,
        Andrew Waterman <andrew@sifive.com>,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that we weren't actually hooking sys_riscv_flush_icache
into the syscall table, which results in any flush_icache() call that
escapes the vDSO to silently do nothing.

Changes since v2:

* sys_riscv_flush_icache actually flushes the icache when SMP=n.  Thanks
  to Andrew for pointing out the I screwed it up!

Changes since v1:

* sys_riscv_flush_icache is now defined even when SMP=n, which allows
  this patch set to build against SMP=n and SMP=y.

