Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9802C6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871EE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544457910;
	bh=cQBDx6wlI+ZVedMbcJgkmfLtzG7klq6GCIuXHEQ+S74=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=dNDGEhmzRJfMbISXeIt/9kn1rkzBoLRlRzaU7BX7F4uEASIY85/NYjxoLmiv1csvf
	 xOLiBYtSl/ZWdjAcY8FM1aLzKU+64UWgAkTe/eX70MTj1MxOCwvbARF1NGyg3IAIyN
	 pPlD4eL2v6zyLS8vigAzwO71RErgeF8l3xHO44tA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871EE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeLJQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:05:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:40222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbeLJQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:05:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D681AD85;
        Mon, 10 Dec 2018 16:05:07 +0000 (UTC)
Date:   Mon, 10 Dec 2018 17:05:06 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1812101702120.17216@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes:

=====
- two device-specific quirks from Hans de Goede and Nic Soudée
- reintroduction of (mistakenly remocved) ABS_RESERVED from Peter Hutterer
=====

Thanks.

----------------------------------------------------------------
Hans de Goede (1):
      HID: ite: Add USB id match for another ITE based keyboard rfkill key quirk

Nic Soudée (1):
      HID: quirks: fix RetroUSB.com devices

Peter Hutterer (1):
      Input: restore EV_ABS ABS_RESERVED

 drivers/hid/hid-ids.h                  | 7 +++++++
 drivers/hid/hid-ite.c                  | 1 +
 drivers/hid/hid-quirks.c               | 2 ++
 include/uapi/linux/input-event-codes.h | 9 +++++++++
 4 files changed, 19 insertions(+)

-- 
Jiri Kosina
SUSE Labs

