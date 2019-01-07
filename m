Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20747C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FC92173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864517;
	bh=yp0WnHn+TY+ovUJ6sj/Mv/hWGhNnwMbJV+DvhNwt2qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EyREY66npA+ROZ57YPlHGdFMKZoWLAX3wDAf4AzAEh3+cMUCTm6lH2HJdb8B5ApsC
	 ydaa0I9xiSdwrOeznYBJHeZf5qTiH6nsMRg7VTygeST+kIwJa2W1syMvEzdiWS/jCI
	 xLXKWm+VKWzm1EQWuKvncxgNmK94i0NHB2OGp6AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAGMfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfAGMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F472206BB;
        Mon,  7 Jan 2019 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864512;
        bh=yp0WnHn+TY+ovUJ6sj/Mv/hWGhNnwMbJV+DvhNwt2qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JR2LeqlvAZhj95U5dvJnilFYKorEWe+J0YJDLg9fCw484TOzSnPiyJ0lXmRZ50SzQ
         WxU+5e/vQQRlQUK8uPbLa6mS0w/ivOoRIDVI7b3bSnDJmoiSJzIE24/9Ykkj5felxJ
         tjgx8rRpy/aXmqDqtl0UfNLv9BkAZb2e5OE0hw8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 036/145] ALSA: hda/realtek: Enable the headset mic auto detection for ASUS laptops
Date:   Mon,  7 Jan 2019 13:31:13 +0100
Message-Id: <20190107104442.037221880@linuxfoundation.org>
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

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 82b01149ec94d746867d7f9156c44d775d4d2d67 upstream.

The headset mic of ASUS laptops like UX533FD, UX433FN and UX333FA, whose
CODEC is Realtek ALC294 has jack auto detection feature. This patch
enables the feature.

Fixes: 4e051106730d ("ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294")
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6424,7 +6424,7 @@ static const struct hda_fixup alc269_fix
 	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x19, 0x01a1113c }, /* use as headset mic, without its own jack detect */
+			{ 0x19, 0x01a1103c }, /* use as headset mic */
 			{ }
 		},
 		.chained = true,


