Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39897C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45FF26B0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45FF26B0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934410AbeF0AFu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:05:50 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:33942 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932978AbeF0AFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:05:49 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 19F2A1A402B3; Tue, 26 Jun 2018 17:05:49 -0700 (PDT)
Date:   Tue, 26 Jun 2018 17:05:48 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: [REGRESSION] 4.18-rc2: X61s thinkpad display unusable after xlock &
 lid close
Message-ID: <20180627000548.jdhzpgnrdebzmlsd@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Beginning with 4.18, when I lock my X server using the `xlock` command,
and close the lid, upon reopening the lid I am not presented with the
xlock UI.

The system is not hung.  If I blindly enter the password, I get an
intact and functional pointer but none of the desktop is displayed.  I
can move the pointer, and cycling window focus generates some random
noise occasionally, but it's all nonsensical.  No windows are
discernable, it's just blackness with ephemeral noise on window cycles,
and a movable pointer.

The system does not suspend on lid close, with "HandleLidSwitch=ignore"
in logind.conf.  So this is a bit odd, since I don't observe this when I
just run `xlock` but don't close/open the lid before unlocking.

This is on Debian 9.4 amd64, the hardware is a 1.8Ghz X61s ThinkPad,
kernel config attached.  I'm using the modesetting Xorg driver on i915
KMS.

Regards,
Vito Caputo
