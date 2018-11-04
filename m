Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86402C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A5E2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7KmUNoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A5E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeKEI2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:28:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeKEI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:28:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so2306591plo.1;
        Sun, 04 Nov 2018 15:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isUog0aOf/hqVTaDw9wDJKRzU+HRJFqdS884BjUzvdM=;
        b=n7KmUNoSIB3R+Kzy+fwdZNA0HQAQR9N/M3rMckuxxAs/k7QL+lOhJ4oOWM0UiENzZ+
         f4VIQOD5OtOC0m7EVEvc7baDVOOuNvZmaINu6LSl4F0XOrhxqD01/TyMl0pjZKVGkIJp
         gcvS7f2WEsDSje5etPX6Y3yLoDb77xpEKDRxOUJYKX5N4cPKwyt3EK8yDfdHbVqcnBJm
         HxG0H80zi74YoiCyUvuJMLytcgxoa1NYHcnK3fHmTxvDd5Q9eRXe5RemjONsDHLJnUCy
         rru8+CVvFCM5JIHDdR1anuKPI39uWCpa1TIjQKOODOt2yrf2w1TNm0QINwFwperzCJ+q
         Ujbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=isUog0aOf/hqVTaDw9wDJKRzU+HRJFqdS884BjUzvdM=;
        b=l+AIkEL96Eq05+v32DtmI08v6RW2pnUAtJZjC3VMuKwp4CmC7FrFKKF5e7uftpV7Lt
         pnu89pgfI/OWsJAlabiZaC97CdaU7W5X/ge9aN4SMAvaONkTrsXS6WbenuQmaoh553JL
         7k3XK7r2r4pY1XcwJG1VFNzgvFGRxDAeDNgkP3P2CpJ+xi7hJcCZX91ry+mUvWQ99oWe
         VSUsn0IZUDhjvuNz92LupgH/KA9Z/KWHXpMpNUTMmU3ql+XIuwnlaHXmfy65Rwz6l7ts
         fjXzvvuOGbAWzcY4wzeIxKRtyG46nQnq09AiHrBSVSNGKUdArmaQx9ESZd2vQAUc1BZL
         M3lQ==
X-Gm-Message-State: AGRZ1gK5IUk0ylDVhmlsJWOAELG3Ti6Fmqk72d+jZ2+U9bNlo84UFb+y
        UX2fws55HyWEQ6c0MChXYSI=
X-Google-Smtp-Source: AJdET5d04Fmp28MisJT5YH2XKIUUiMBJdW94MejxSqfUWmLvVoIre3gcfwDiVnWCOZfaZphM6mAQRQ==
X-Received: by 2002:a17:902:7784:: with SMTP id o4-v6mr13667048pll.292.1541373112030;
        Sun, 04 Nov 2018 15:11:52 -0800 (PST)
Received: from aurora.jms.id.au (pa49-178-43-40.pa.nsw.optusnet.com.au. [49.178.43.40])
        by smtp.gmail.com with ESMTPSA id e131-v6sm16390261pfc.122.2018.11.04.15.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 15:11:51 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 05 Nov 2018 09:41:40 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] poewrpc/Boot: Fix cross compiling with clang
Date:   Mon,  5 Nov 2018 09:41:31 +1030
Message-Id: <20181104231133.30848-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches allow clang to cross-compile the powerpc boot wrapper.
The boot wrapper constructs it's own compiler flags as it may not be
built for the same arch as the kernel.

The powerpc64le kernel builds natively with clang and with this patch it
can cross compile too.

Joel Stanley (2):
  Makefile: Export clang toolchain variables
  powerpc/boot: Set target when cross-compiling for clang

 Makefile                   | 3 +++
 arch/powerpc/boot/Makefile | 7 +++++++
 2 files changed, 10 insertions(+)

-- 
2.19.1

