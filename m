Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5459AC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B882083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762856;
	bh=pwPK9HQfQMMGQCtLBVeB8TvowvS1QK/odkZKhQ3TFC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgP1NFyAsO3LX4eLBjPgpl+LOK5edrZx0Qi1VnkzE2bxwRVgsOzTBo2KWutt1Mnem
	 jNGpkT72f9O+8JdYOUdayMKf50WC27ByPEZXnP1Rhp8piAV6JqeT8Txwk76wXe13MZ
	 /mI3QNZBLvLLzW8dvVdeolswuLIDOUduk/cnnt9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfA2Lvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731402AbfA2Lvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F30F2148E;
        Tue, 29 Jan 2019 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762710;
        bh=pwPK9HQfQMMGQCtLBVeB8TvowvS1QK/odkZKhQ3TFC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UbyxzCKSTHam6KuuQF5+ypctnHY1jSdy/DqK5lZoQBEbYFVD6qlZ6DD7M2cAbwyH
         zkO6RtqAZxsOLWrgPrxIHJ2dv0gbv8tpEZDgXwGRoIlbtwIWgE9t8n9cWzDsGKOckK
         8IgY2B8V79KCQ07ol5CFs8L2Jo5jDyDkyqwfqejw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, linux@endlessm.com
Subject: [PATCH 4.9 32/44] x86/kaslr: Fix incorrect i8254 outb() parameters
Date:   Tue, 29 Jan 2019 12:36:27 +0100
Message-Id: <20190129113142.517091836@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

From: Daniel Drake <drake@endlessm.com>

commit 7e6fc2f50a3197d0e82d1c0e86282976c9e6c8a4 upstream.

The outb() function takes parameters value and port, in that order.  Fix
the parameters used in the kalsr i8254 fallback code.

Fixes: 5bfce5ef55cb ("x86, kaslr: Provide randomness functions")
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: linux@endlessm.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190107034024.15005-1-drake@endlessm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/lib/kaslr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -35,8 +35,8 @@ static inline u16 i8254(void)
 	u16 status, timer;
 
 	do {
-		outb(I8254_PORT_CONTROL,
-		     I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
+		outb(I8254_CMD_READBACK | I8254_SELECT_COUNTER0,
+		     I8254_PORT_CONTROL);
 		status = inb(I8254_PORT_COUNTER0);
 		timer  = inb(I8254_PORT_COUNTER0);
 		timer |= inb(I8254_PORT_COUNTER0) << 8;


