Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6539C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AAA218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548418984;
	bh=GOf2KfC+SGmgZAy1zMnc+WFtih0CfsC/UvOMLQdlJls=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WeJ9+aO9YZzj5G/umdCAmUpfQTKndY5C7RshC64mkptvP/zNqhJmUE6c16ZaPkhPS
	 OJL2YyYW+hP7UwBsKUQ1lJDUcLjZR4rxR2lNoMQaA3Sh8RDXhbWUe78g6IPgOYI2sm
	 dYUJvluO8QDMix5u7Z8+Cf0hgzVMLF3r8EZCBn3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfAYMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAYMXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E963218D9;
        Fri, 25 Jan 2019 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548418981;
        bh=GOf2KfC+SGmgZAy1zMnc+WFtih0CfsC/UvOMLQdlJls=;
        h=Date:From:To:Cc:Subject:From;
        b=fCzb5xtE/ShlpwH84Nc7kDqbeHDzhqobi6kC4gTDA87blcRhNNMvNSZCmR+6UZUxw
         LZDO89AOKVBXGzyo+rGlIUEtvz0o9WCTY6vwqq9yFthgveJEN0Ye9NR6yLfRRNGc6f
         N27C0vSZIeE8cr0s0B8gRiMwninNu0VyAY80ZEKY=
Date:   Fri, 25 Jan 2019 13:22:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.0-rc4
Message-ID: <20190125122259.GA7652@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.0-rc4

for you to fetch changes up to 31eb79db420a3f94c4c45a8c0a05cd30e333f981:

  staging: android: ion: Support cpu access during dma_buf_detach (2019-01-22 11:38:09 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.0-rc4

Here are some small staging driver fixes for 5.0-rc4.

They resolve some reported bugs and add a new device id for one driver.
Nothing major at all, but all good to have.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      Staging: wilc1000: unlock on error in init_chip()

Gustavo A. R. Silva (1):
      staging: wilc1000: fix memory leak in wilc_add_rx_gtk

Július Milan (1):
      staging: wilc1000: fix registration frame size

Liam Mark (1):
      staging: android: ion: Support cpu access during dma_buf_detach

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Nathan Chancellor (1):
      staging: rtl8723bs: Fix build error with Clang when inlining is disabled

Phil Elwell (1):
      staging: vchiq: Fix local event signalling

 drivers/staging/android/ion/ion.c                              | 2 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c                    | 1 +
 drivers/staging/rtl8723bs/include/ieee80211.h                  | 6 +++---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 1 +
 drivers/staging/wilc1000/host_interface.c                      | 5 ++---
 drivers/staging/wilc1000/wilc_wlan.c                           | 7 ++++---
 6 files changed, 12 insertions(+), 10 deletions(-)
