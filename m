Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF92C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DEB20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vcajbvgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfACVsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:48:07 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:54098 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfACVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:48:06 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 732655C06D3;
        Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546552084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=WsYMm3ZrStNJ4NCsVUrIhpsOcyvSyKdRlYNdiA0CERg=;
        b=vcajbvgLeH0PBDk5Pu/uiawz8ShgSGNxJp0snSThGbAy8h12bn/GyClrSnICvtW8UyUU8U
        vo7XJbZmGIan6ZRCSxubxKGoyq03wU+eA1ciUv0eqkLZ2e+qb7JklvDlEJt7T5p+ocXTGl
        oqS5Gh+OBgY6WNQPLKudJMVcpZD9u9Q=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/3] ARM: trivial assembly fixes to enable LLVM as
Date:   Thu,  3 Jan 2019 22:48:12 +0100
Message-Id: <cover.1546551693.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a starting point to enable LLVM integrated assembler and
contains some trivial changes. With this patchset the LLVM integrated
assembler can be used to assemble almost all C files.

Changes since v1:
- Explicitly use unified syntax for inline assembly where necessary

Stefan Agner (3):
  ARM: fix argument count to match macro definition
  ARM: uaccess: use unified assembler language syntax
  ARM: spinlock: use unified assembler language syntax

 arch/arm/include/asm/spinlock.h | 3 ++-
 arch/arm/include/asm/uaccess.h  | 3 ++-
 arch/arm/lib/copy_template.S    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.20.1

