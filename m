Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD02C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBFC2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866820;
	bh=+HRhI5ZBsLD00uK3klo5ygXBbbge2L2a/USxS+yQw3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dMcRfO3tgRhIFpM08vU0pSt/AARAhCOv9sMAQWZE98aUdE2o9VHyHGWiEFO3q86C2
	 kMQnAIYLSdv5puVbfYcxoC9vKTarhpR/CICzWY4O+FVIWoz+A3Tnstsb+HS/LmmGr+
	 aszME9AwakyNX9jooPucq4I4pm125XJe31xOD7aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfAGNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbfAGNDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA52D21736;
        Mon,  7 Jan 2019 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866212;
        bh=+HRhI5ZBsLD00uK3klo5ygXBbbge2L2a/USxS+yQw3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIwX85MH0j/ROySqVaO52B8E6Wgi5uLXnm8i3KLEp5LsgUlLwMHhY9seuLudR+++/
         1uYBlHJQynhbf7kwrGqFuV98joWKSXMDqV0Eqrd5WrkgWLmDJDJElDoribGJee2BJT
         f07SENQXZ6f9a5qdqKCQN/oks6Ejm5cWiyZeViIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 046/101] ALSA: firewire-lib: fix wrong assignment for out_packet_without_header tracepoint
Date:   Mon,  7 Jan 2019 13:32:34 +0100
Message-Id: <20190107105335.425048347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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


