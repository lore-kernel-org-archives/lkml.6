Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0407C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793182084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544240;
	bh=rxibG9zt2Hc7Bo/Btd+n1wZHPxqD3SW4ctwPdGhnY+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S0eXme+n8KdyP9jjUGrMtsj3RmhG95RotyQkmnxQH66PFG9dIRTjCKkaq3px2uSOs
	 FlwIywBgHPbKSRusRRvQDS9q9fFBBGtJ3jooPv36o1DVcsAyamH2lH6yVO/Uq2dk0z
	 jkNgDJjjlceN4lNHnapk9bM80vpdRv4n59db6yQQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793182084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeLKQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbeLKP4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F338A205C9;
        Tue, 11 Dec 2018 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543778;
        bh=rxibG9zt2Hc7Bo/Btd+n1wZHPxqD3SW4ctwPdGhnY+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdkflOgoHeiiPkXao5+el3hY7UicouPS7O9ZuQjhVHPzdllFmcy6rferSkvxyTk5y
         qtsSCV2qeW+1UFR1KrCxVFNvgs0E87/85qyOFqIwzXJ+K8drIq1OsQDdPMj7YE0hq8
         XNWFfAigmO0OjdzKUCdoik4F3auqIDUmJNU/F19M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Das <tdas444@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 060/118] ALSA: usb-audio: Add SMSL D1 to quirks for native DSD support
Date:   Tue, 11 Dec 2018 16:41:19 +0100
Message-Id: <20181211151646.661904383@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Tony Das <tdas444@gmail.com>

commit 44ff57e685f96d0cb9540004cc9d1d880e7a4315 upstream.

This patch adds quirk VID/PID IDs for the SMSL D1 in order to enable
Native DSD support.

[ Moved the added entry in numerical order -- tiwai ]

Signed-off-by: Tony Das <tdas444@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1373,6 +1373,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
+	case USB_ID(0x152a, 0x85de): /* SMSL D1 DAC */
 	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */


