Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF772082B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHz7zQhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF772082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJWTWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:22:07 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35822 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:22:07 -0400
Received: by mail-wr1-f44.google.com with SMTP id w5-v6so1192408wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ErWu61sb1xOHIb1LjODtHP08oVKe26KDhwqplYnks7o=;
        b=pHz7zQhHpcgMhuhmFyXd52bgMpao5UYwaZoTcflcJzzYuwW1R3r/qKIi+ewP71THN2
         DOoWCFzAFIDVvF+e7xge/Ak5nYFmDoM0nMwg+cCH92ADfZFkOXxE8ua1FTl3i6my16NW
         JTSmI07DT/zFh2fF/UbUzs/PDf338g4pQHlhHaAdNVFG323Frjl4mysOzPHkkH73pOho
         EWrxN5bEhzIV6mdhu5+UUOxGyLWk5xTPgPUDg/T7zG8xUi34lgFMZ8yuCgTmxzrNWM4X
         jHHN06PLZeUeyqV+Lh9UAIDWJIBgyf2t10evek/ZDtxPIjsxqUFyZibQJ5p/ug07ytE4
         jk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ErWu61sb1xOHIb1LjODtHP08oVKe26KDhwqplYnks7o=;
        b=YzKrmzpEfKR9L4p9oxXx0zhLTmeT1QF1eKL3hW0FsP9mz7ZkFvsq8Jka7CDwL5ZZbF
         qTjs98Pgmw0i4ecdBtN6FKKmgtrjq7jRkJYl1CO2Hv9N5zeEgnW2W7EDYiRHZDvz4dfA
         ymwPE1EiyKBV+nN1mgiFURTJNgbFZpkDBno2TlR5Uaf0jSqfdZkc3tju5fz+svYqLclc
         stdaAK0PaYMcMWM9+n3ncNZ8ALMlP7bu03rKUoHtPDd/vqXeQomdDJSxYD4R26urbkLl
         vogLpaAS905uZe/Wgu385DW5MAHP0s3pGpis/4uyCXrvAAzNOxgewxJmAEqdiTuHyygV
         9dhw==
X-Gm-Message-State: ABuFfohgnTMrWxHn/w73/7n50Kwhk3pawsaQ2j6vS9XJwoKeDSxgMupz
        Et1EGxNpPWR3aE3ez87SCT0=
X-Google-Smtp-Source: ACcGV61Yjq5uKvk+ycm2EJu6LJxrYT+fM9zh7+YhFiq4kziHMY9x0VlcZodljEWpJBykz7q0S2RsSA==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr51761840wrh.72.1540292349450;
        Tue, 23 Oct 2018 03:59:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g8-v6sm1423446wmf.45.2018.10.23.03.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:59:08 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:59:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] RAS changes for v4.20
Message-ID: <20181023105906.GA22356@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest ras-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

   # HEAD: 711f76a328cbe5b49164bb14bcb593fa52102051 x86/mcelog: Remove one mce_helper definition

Misc smaller fixes and cleanups.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/mce-inject: Reset injection struct after injection

Qiuxu Zhuo (2):
      x86/mce: Use BIT_ULL(x) for bit mask definitions
      x86/mce: Add macros for the corrected error count bit field

Sebastian Andrzej Siewior (1):
      x86/mcelog: Remove one mce_helper definition


 arch/x86/include/asm/mce.h              | 53 +++++++++++++++++----------------
 arch/x86/kernel/cpu/mcheck/dev-mcelog.c |  3 --
 arch/x86/kernel/cpu/mcheck/mce-inject.c |  6 ++++
 3 files changed, 34 insertions(+), 28 deletions(-)

