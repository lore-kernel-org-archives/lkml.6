Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4B21871
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132151;
	bh=wiyqt7/DWDS6YrBBHFK1s0hfnSK7tffPV+r5W8XO3+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zeYQDCRfNUCLdzGpwsZgq+Gt+C+ci9rguDEqvvqkyavArfg8RmdkbtTfL2hdW3qWJ
	 gFmyKq0za7Io7LOsTUIkacQ1WvE0ddL7Fcf+/R84Kqt39oqWBvygRs39dnkrp4o2Po
	 F12KPx5UpJa50PO8sRgTFptnqokl3XL+lAZ/SENU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfBYWCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbfBYVPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C8321734;
        Mon, 25 Feb 2019 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129342;
        bh=wiyqt7/DWDS6YrBBHFK1s0hfnSK7tffPV+r5W8XO3+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP3Go2GwgYa/5fzS3xLeIGlogAKoNxaLTl3hJ74OuI/f75D/jPodX6SnrpjFGJBZs
         Wou+1BQ9vrvWUQRibp0TCzW8O6IdAA05kDDExyvtQM7Wo7PNBKbLgIGp54ovRJpKID
         RYXx3wVmhR9MIKBKQ6VT37USElhD99ePSiRtI9JM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 53/63] kbuild: set no-integrated-as before incl. arch Makefile
Date:   Mon, 25 Feb 2019 22:11:53 +0100
Message-Id: <20190225195039.885387724@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit 0f0e8de334c54c38818a4a5390a39aa09deff5bf upstream.

In order to make sure compiler flag detection for ARM works
correctly the no-integrated-as flags need to be set before
including the arch specific Makefile.

Fixes: cfe17c9bbe6a ("kbuild: move cc-option and cc-disable-warning after incl. arch Makefile")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Backport to 4.9; adjust context due to a previous backport]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -516,6 +516,8 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TO
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
 
@@ -726,8 +728,6 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 else
 
 # These warnings generated too much noise in a regular build.


