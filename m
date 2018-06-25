Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4FFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B420525828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky7mTrnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B420525828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbeFYLjn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:39:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38769 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbeFYLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:39:42 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so12229013ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=49IqDfV432skoJRUaBMJVjFXKb1AvICMN2c7U0e0wow=;
        b=Ky7mTrnjdDWoWYrAywVSes7ysGuSDJdrnWiSYTNQOWsH5PAbMoWN48RNdHvIvTjEFP
         3oniG/L1heVbaDMKoe9oF3m0vFdqoIPFQ34IonFamy6z8tZeoRQilC2INGSxfuaSWa8R
         eeyyGmTHOJLgA/GQKmcBHncXdwGSfjrF38KkJ/Tev9ZD6naT0F7UsnsrLap+HfcxOBg2
         2gh93Ffv3u1zTxc7qGXYhVZ8AWKgQxK3FVggd2SuwKpR6LpS8UurITVJu5NF1R8FeYGe
         /G+hxBbfGVbCyqghWdh6J7w+VUs7JfUMCKH4uo8GGDEEyZXR7UjeKXFccJN1iSFDSMxm
         fVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=49IqDfV432skoJRUaBMJVjFXKb1AvICMN2c7U0e0wow=;
        b=Sjsddu9EPJq3G+4Nl3wKAbFueJylQRvz/k5iRK1WphYjAE18ah6a53X216j34L6d8y
         aHNeTnfrfK7fcNLXQUHykdl5SwCpXG3ldCEAdSR0EjwwyPEUZV3H8F5XF6EqGENrAQ+B
         QQtq4YzyVAxVxpYNzMJ6Z2cMvq7Xq7d+5u/Sq8IlTa9IWqJPehXCVFwpY4O6gUwZJDNS
         8t994evz+/qdqeeQajQbunCTw9anf70C4shR245AEBgGRI5sKNrL/mTX07MAlbdEQya4
         vCFwa9UrEWmrQkx3M+NNEvckcmRWyRDyomuvB9hmFms+XUftY2+nUTDgvjKuY1rMY5sm
         FcqQ==
X-Gm-Message-State: APt69E1KSAjr1NJyEftL9DDXBsnAijECwiIuY9eefvaQXpPljVS/b/QD
        agkszI8E0c2A2sE3bOOtCLQ=
X-Google-Smtp-Source: ADUXVKKy4FbqDQkf8VxjGYNXOHLc4jsKOypR+/yWctWKgEaruW1DSsVi/poWUtNH2iRMCiutsyfqmg==
X-Received: by 2002:a6b:9c95:: with SMTP id f143-v6mr9396173ioe.22.1529926781823;
        Mon, 25 Jun 2018 04:39:41 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id 200-v6sm3719207itw.4.2018.06.25.04.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 04:39:41 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v2 0/2] Move {tramp_pg_dir,swapper_pg_dir} to .rodata
Date:   Mon, 25 Jun 2018 19:39:19 +0800
Message-Id: <20180625113921.21854-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 changes:

	As James Morse suggested[1], we introduce init_pg_dir, which
	is a reserved area of __initdata section. We setup initial
	page tables in it and then we setup final page tables in
	swapper_pg_dir directly. In this way, we can avoid using
	temporary top level.

	To defend 'KSMA', we need to handle page table configurations
	which we can write a block-mapping into swapper_pg_dir. These
	configurations are:

	CONFIG_ARM64_VA_BITS_39(4KB granule, 1GB block)
	CONFIG_ARM64_VA_BITS_36(16KB granule, 32MB block)
	CONFIG_ARM64_VA_BITS_42(64KB granule, 512MB block)

	If these configurations are selected, we move {tramp_pg_dir,
	swapper_pg_dir} to .rodata section. And we update
	swapper_pg_dir by fixmap.

[1] https://patchwork.kernel.org/patch/10476597/

Jun Yao (2):
  arm64/mm: Introduce init_pg_dir
  arm64/mm: Move {tramp_pg_dir, swapper_pg_dir} to .rodata section

 arch/arm64/include/asm/fixmap.h   |  2 +-
 arch/arm64/include/asm/pgalloc.h  | 33 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h  |  8 +++--
 arch/arm64/kernel/head.S          | 52 ++++++++++++++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S   | 26 +++++++++++++++-
 arch/arm64/mm/mmu.c               | 36 +++++++--------------
 include/asm-generic/vmlinux.lds.h |  5 +++
 mm/init-mm.c                      |  2 +-
 8 files changed, 119 insertions(+), 45 deletions(-)

-- 
2.17.1

