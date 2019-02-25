Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76666C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4700320842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131722;
	bh=ogWa4ls5frD8lRwgvqYbv45f6x0YkogDiLVLJvkIvPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhH/pXDw/pSKaf3QQhTRhmSMaxAfwhZrPPQYHg2REa9Q0d4JAzYCFM4DWIOF4biBb
	 zf2VjjthNBq3s04EywLyQYdqCb28xIJbY2+HgQS70h3lZAb0d6BYohdE4NWrmZ9yIr
	 Rj0ge4LrBti5AUzkL+/kdz2wXokOVe9riLFM1zMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfBYVzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfBYVVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C5F2186A;
        Mon, 25 Feb 2019 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129711;
        bh=ogWa4ls5frD8lRwgvqYbv45f6x0YkogDiLVLJvkIvPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WixSHPe+WhWnY8CuGc1ABD2QkLvHkDSjCBiza7tb68ZkUewenhfnFiPUM60lzG7Kp
         VP5U5i9fwOAgri9iWnwCyt14QqKpsZQhAE+SjdeWP+qVabijQMloudYkCSa5fMgW1Q
         a5sWT0Gu4mC3D7MtKIi7rOFU9gDg+5tROaNjlRVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/152] MIPS: ath79: Enable OF serial ports in the default config
Date:   Mon, 25 Feb 2019 22:10:35 +0100
Message-Id: <20190225195046.753706097@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 565dc8a4f55e491935bfb04866068d21784ea9a4 ]

CONFIG_SERIAL_OF_PLATFORM is needed to get a working console on the OF
boards, enable it in the default config to get a working setup out of
the box.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/configs/ath79_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 951c4231bdb85..4c47b3fd958b6 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -71,6 +71,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AR933X=y
 CONFIG_SERIAL_AR933X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-- 
2.19.1



