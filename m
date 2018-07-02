Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30656C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D5525D8D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G53VXD8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D5525D8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeGBOMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:12:49 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:41089 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeGBOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:12:47 -0400
Received: by mail-pf0-f173.google.com with SMTP id a11-v6so7583513pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XRorDVad4CJojPHvP49dl5YJ7sJYIYc9I3ro6kABKV8=;
        b=G53VXD8B3IO+chzB8iYvTeug1dUpD/SHls2/r5adbeG7+kpOvkk6SW1h+pZC+/ex62
         s58H61h9NhkQUCbBPs+n/e2w/qu6uw/Mka7irdjzlWy3HvdmMyADyouA6IiTD0VxB0UC
         WJ5q1OTqY1WrxCbxsusBeJfDE3oxQtTjd7ItXXhpVlWfOo21Q80WH5f0OuCkO0RRUkEy
         IHjCuoBua7tAPtcvRq9DKWxO8tBX0jGZBiYGBtV2wZwgxgBoXZPTz66GLc/4aY1RoJDo
         4Ag7Ge3a/QY9gs39OVtmWL0HSFkHy1xKJxFbuJJ+8Xrp7CcycvdbrYkfDMDrsHPW8DJL
         +PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XRorDVad4CJojPHvP49dl5YJ7sJYIYc9I3ro6kABKV8=;
        b=r5oBDgSKMIfA0a2aLE5WIkZ3Uj4sMMnvtrY52TkV8JGKNVgWRw6ccDDEY4pjBjKRk1
         N5LZgh5sFZqis6+/9MxvafVZhx2zhdVL/skOdCO8FnqARWjM9Rck+o+O2gp3wff4P3bb
         XWzQbMDisIRYSDebMW9g+Vo6ugXxyWLzYuhI8Fjxknt6TRlmG0USUPdn4aofBH/7QiAu
         9UyIw/BTAPUPHIACwYU5uQt3dGmVBTexZ3LLXcbahRNfzFZPeWzeme6WDR9hd7f9oRUT
         NlivE5gMinFCEsemRcEJM85gDYGZca7oDJ4fAHg6BCwgr2zYproQq1E0SnTEEBXZY+z5
         A/1w==
X-Gm-Message-State: APt69E1E1Q7OlCVwxOj+Kb5Rrkcmwaroc0no+wyS5+b6uEEwsL/nQgRa
        PY9Op84un1Ue+8nYjP4xE06lZDCe
X-Google-Smtp-Source: ADUXVKKX4DEhNyJWS2QIDctt9lCdDAZMqT6YAf70A2ZJ7C6d8ldShMpOXjgQMiC/BbZvn1AiB8BrGg==
X-Received: by 2002:a65:40ca:: with SMTP id u10-v6mr21506054pgp.2.1530540766974;
        Mon, 02 Jul 2018 07:12:46 -0700 (PDT)
Received: from localhost (g90.124-44-6.ppp.wakwak.ne.jp. [124.44.6.90])
        by smtp.gmail.com with ESMTPSA id h8-v6sm21787452pgq.35.2018.07.02.07.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 07:12:46 -0700 (PDT)
Date:   Mon, 2 Jul 2018 23:12:44 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC fixes for 4.18
Message-ID: <20180702141244.GQ24595@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I hope you enjoyed yourself in Japan, please consider for pull,


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://github.com/stffrdhrn/linux.git tags/for-linus

for you to fetch changes up to ae15a41a641449f536578b0d9ec0e4ade130deb5:

  openrisc: entry: Fix delay slot exception detection (2018-07-01 16:48:24 +0900)

----------------------------------------------------------------
OpenRISC fixes for 4.18

Two fixes here which were breaking OpenRISC boot.
 - Fix bug in __pte_free_tlb() exposed in 4.18 by Matthew Wilcox's page
   table flag addition.
 - Fix issue booting on real hardware if delay slot detection emulation
   is disabled.

----------------------------------------------------------------
Stafford Horne (2):
      openrisc: Call destructor during __pte_free_tlb
      openrisc: entry: Fix delay slot exception detection

 arch/openrisc/include/asm/pgalloc.h | 6 +++++-
 arch/openrisc/kernel/entry.S        | 8 +-------
 arch/openrisc/kernel/head.S         | 9 ++++++---
 arch/openrisc/kernel/traps.c        | 2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

-Stafford
