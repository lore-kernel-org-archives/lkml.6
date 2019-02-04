Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9455C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFBA2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276943;
	bh=HmnBRyH0Q9TgyEYARVrrIRpmZCh2WTf50SmoJ0dpTvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUSdZE/kQh5uRdfy64ndGn7Wzkn45BYjrnMazMhJoYNiKLKTpVVWjBg0F/PfIehSZ
	 4jTKzYVo+XFIDxOFcaPebY86yXv4HNtkn/hYe1w5J7r63ZI8zLPvI2BLIakXNChIid
	 Uu1rBguEQO+HoutQSR+1e4ho2ZKNq+KMpVHNH2MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfBDKmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbfBDKmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:42:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722622070C;
        Mon,  4 Feb 2019 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276937;
        bh=HmnBRyH0Q9TgyEYARVrrIRpmZCh2WTf50SmoJ0dpTvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2vfuW5iF9UNJ5s4qBz7RJ1hFpOoi4aTOnP5S9RJzLHgVkJcXZxHSScu6viShPB3m
         Gh0l0/2XFw6AcKC0+3Kes8iuNYLmuCuDBnBvjM+Uj9qBgs+jtffps4Fy8W3MKVQBoc
         kS0gb/ew6ImuzCfoWdzuEdfZOPZTIy/WFJLSYeWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 47/65] platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
Date:   Mon,  4 Feb 2019 11:36:40 +0100
Message-Id: <20190204103618.488299774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b3f2f3799a972d3863d0fdc2ab6287aef6ca631f ]

When the OS registers to handle events from the display off hotkey the
EC will send a notification with 0x35 for every key press, independent
of the backlight state.

The behavior of this key on Windows, with the ATKACPI driver from Asus
installed, is turning off the backlight of all connected displays with a
fading effect, and any cursor input or key press turning the backlight
back on. The key press or cursor input that wakes up the display is also
passed through to the application under the cursor or under focus.

The key that matches this behavior the closest is KEY_SCREENLOCK.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -341,6 +341,7 @@ static const struct key_entry asus_nb_wm
 	{ KE_KEY, 0x32, { KEY_MUTE } },
 	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
 	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
+	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
 	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */


