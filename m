Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE3DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009CC218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217193;
	bh=lwSK//E1jDK0ja9/RSJ7OCfcRt65ii054QnhStMATKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7SmYJeKkmgiWyLr93JlFkw8Uu2PJftGAq85tNLuXnxNqyBh/LgPzb6hxsbQ4iqo7
	 n7PvVfbFtkVUPerM1UIdJ8sRt2H2Vx2mukugRY3Qu3t2YrfDfXYYJRO7unTlqAuPw4
	 Kdf5VvbVLKLuosTLd+H/zyOt+uvXbyPw+lpBNlkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfAKOdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389597AbfAKOdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5334D2063F;
        Fri, 11 Jan 2019 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217187;
        bh=lwSK//E1jDK0ja9/RSJ7OCfcRt65ii054QnhStMATKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/9rOZ84TMyl/RRxZH30F/2eQcP8VpiQDtNNP+erBp281bXhWyoLAhGRWCazGUByI
         DchHRHXB+9MkNQUFSXVZO4PAdoXy6OCuIicaoqC7bh7AFnt6mcGz/Izq1irMJ8OflR
         lP8Ci8p7y3g7MtVGf+cCkGqbkwSv7+fz5B5DsG0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 075/105] Makefile: Export clang toolchain variables
Date:   Fri, 11 Jan 2019 15:14:46 +0100
Message-Id: <20190111131109.264870241@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit 3bd9805090af843b25f97ffe5049f20ade1d86d6 upstream.

The powerpc makefile will use these in it's boot wrapper.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -490,6 +490,7 @@ endif
 CLANG_FLAGS	+= -no-integrated-as
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+export CLANG_FLAGS
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register


