Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D1DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E33220651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865421;
	bh=HIOX1dVLytz81z/2C6xcugfvQWL2ZWy0PH4ZozReS48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iLhWQmRlOouS8Q7NYLxCYofWqHeWJkVug5K0NeQ7UU7wMbpHhnKsUGKt/KQRjVjfv
	 +nrXv66zSUXgQX85uHdr+BOkcUfJz/OveDcgDExmhtsqprmaXNyJU9E9vWKTMvNnQf
	 tTyzd6I+OwmjEecQ1fmhDEj1QsTHUMcXAPO7hybs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfAGMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfAGMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D1C121736;
        Mon,  7 Jan 2019 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865377;
        bh=HIOX1dVLytz81z/2C6xcugfvQWL2ZWy0PH4ZozReS48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPiSksYqD7SXWoR+SdOdCQ0LnCV8+R6SGBhL2LNV5l3k1OoMHugp5vPe9eSut/6i7
         A3a/9zEJrRI22LhakoOB09RJIMF1SLnpHxFLqR5OBuZYBezhqhmqb+K/zCvMerBQgB
         5vse6wCFjaqj1xdTe9vawh1+2SDQU0kf46Cp9yj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 072/170] ALSA: firewire-lib: fix wrong assignment for out_packet_without_header tracepoint
Date:   Mon,  7 Jan 2019 13:31:39 +0100
Message-Id: <20190107104501.517203872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit aa9a9e39b4f65733bf19d90cbd026e85a74efb99 upstream.

An initial commit to add tracepoints for packets without CIP headers
introduces a wrong assignment to 'data_blocks' value of
'out_packet_without_header' tracepoint.

This commit fixes the bug.

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
@@ -169,7 +169,7 @@ TRACE_EVENT(out_packet_without_header,
 		__entry->dest = fw_parent_device(s->unit)->node_id;
 		__entry->payload_quadlets = payload_length / 4;
 		__entry->data_blocks = data_blocks,
-		__entry->data_blocks = s->data_block_counter,
+		__entry->data_block_counter = s->data_block_counter,
 		__entry->packet_index = s->packet_index;
 		__entry->irq = !!in_interrupt();
 		__entry->index = index;


