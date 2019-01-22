Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7154BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A28D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548150393;
	bh=ENTerBkqZ/8SJ3nK/RYkXeo+0UDy42eNzQf1dC5VGpU=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=aVKEkb5G4uxEKB/VJUdbifDC5bynlI0Tc5e4zgG+NNoMSt6m5o9sXgkW5Bbs9tYGp
	 esqJieLZUyzraMzvGlQcCg4ZC8tc0zfe3Vml9DjPQT+/CeySTSItzhI9d/NSSbKer7
	 woBV/648iO5DbLTpyyZtboOvHdDWC/9SoiWTisHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfAVJqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:46:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:35240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727684AbfAVJq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:46:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CEA0ADE3;
        Tue, 22 Jan 2019 09:46:25 +0000 (UTC)
Date:   Tue, 22 Jan 2019 10:46:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1901221043400.6626@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID fixes:

=====
- descriptor parsing regression fix for devices that have more than 16 
  collections, from Peter Hutterer (and followup cleanup from Philipp 
  Zabel)
- quirk for Goodix touchpad
=====

Thanks.

----------------------------------------------------------------
Kai-Heng Feng (1):
      HID: i2c-hid: Disable runtime PM on Goodix touchpad

Peter Hutterer (1):
      HID: core: replace the collection tree pointers with indices

Philipp Zabel (1):
      HID: core: simplify active collection tracking

 drivers/hid/hid-core.c             | 23 ++++++++++++-----------
 drivers/hid/hid-ids.h              |  3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c |  2 ++
 include/linux/hid.h                |  3 +--
 4 files changed, 18 insertions(+), 13 deletions(-)

-- 
Jiri Kosina
SUSE Labs

