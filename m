Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADC6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C576D206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864637;
	bh=Kp7a/7uThTE4UJwnuzQwLEMLdOCF1/0ktQlOQ2/v0lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xSLrIcS2uhlS/tIdn3/IZgWJemrt5DLaDuv8NpVnmKqnLEA2ixWsItyGS6gTsFec0
	 FHk+aq9PjD79MH8lL0xVcsNZQRrLSD+nOQnSUxV6SxqXy4csuX+2nRmtBAvFf9RXAR
	 l0KOEm1qF45rS2aQbYP9mJ9cQhZy6t7ZElkiyieQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfAGMhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfAGMfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080D5206BB;
        Mon,  7 Jan 2019 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864509;
        bh=Kp7a/7uThTE4UJwnuzQwLEMLdOCF1/0ktQlOQ2/v0lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqk3h+mSVGJyUxA5qmIhmcbiJeUxhHdc1fXUkoYiGi2KMnc9qwhfs4Jz6LzVlBphf
         F/txzwL4w6EEh3O0W4NA1VHouIGuxMii7xaDpc/KTrfrgdXlthSWlzq87JGEJUgZoh
         8bruzZHeSGdMtu3QkzQSKeCK4rRta4SRdTwCkL2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 035/145] ALSA: firewire-lib: use the same print format for without_header tracepoints
Date:   Mon,  7 Jan 2019 13:31:12 +0100
Message-Id: <20190107104441.909475652@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 5ef108c53e6efd695e32aad969638ccbc35b4be9 upstream.

An initial commit to add tracepoints for packets without CIP headers
uses different print formats for added tracepoints. However this is not
convenient for users/developers to prepare debug tools.

This commit uses the same format for the two tracepoints.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: b164d2fd6e49 ('ALSA: firewire_lib: add tracepoints for packets without CIP headers')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/amdtp-stream-trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -131,7 +131,7 @@ TRACE_EVENT(in_packet_without_header,
 		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %03u %3u %3u %02u %01u %02u",
+		"%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,


