Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B8920671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmDqGTpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B8920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeJWTp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:45:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeJWTp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:45:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so1271636wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6+T3lXlegShlQK7kBAQOA44jztensnzaUaWgrPQxZlU=;
        b=FmDqGTpHj9Zy5oK2PGWN0VoxNhIqksy3kUIS6J8NQ6TggEHqXXGIqLKPsQWBrqyX3Z
         89diyb4tbgyVMG3XmauMu4FfFsLRDu0Pw+SoagfCH4NaT4Urb9CiTFDgnh6LPTTT3xM8
         M4F9g0oTgLrBCdt5ffuIz8CZIx0x8/n70wO7/5U+lLZtUYMkdWcX0gvxY2S6A7t3+tHq
         mY/ZbUgTpvXldC5DwSNtxxBC6WDTrhHTOkPhu9s3uvdUYiZCJY+dkx6HK8TftqPFMQsp
         CiK+//1gg4maTqIkGHlgWGZATpyzKMphkrn3MZ2IEG96enJCQ/sbYdbDUXvunKvRubDW
         0joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6+T3lXlegShlQK7kBAQOA44jztensnzaUaWgrPQxZlU=;
        b=l+sV/qFrCm9k1R0Io/s5/JWRsFVDlI5Un0afxIprOObqdCLf+8D0IIcp4XJuyec1vs
         sqeGhsWwTmezZv4dXFzGlZaWhWyV86HWCvUAUhWmFUKWFhOrabxScHHsSggeadFJfYdD
         KhWhhLJp1y/wM1lZol3+4uvHpFePArJsW7VYOPZ36SoymNuYj+eAPbfH260b+K6jGEuQ
         nCWEmxYbX7ui9yaxn7udJZgMMglvsnWyEu6nX+spbO/oZ1m9tJmT/LfREgineRUCl0nx
         pNQzAPJ9d7yhTv4cd+4kj5kBFWOmmkK7qzNvOlIweYn1sWY23rUDrQLhz4j876rUh3hN
         75SQ==
X-Gm-Message-State: ABuFfojvtL8b1P6L3nzGCmAqqXf8vSyGmA4qwUrISfbllrkYJXaeynD6
        NhEmr6f+FEuhvv6JfUi53zU=
X-Google-Smtp-Source: ACcGV63C3RRoBhxN6NenPqIgQsJq4JcdJN6VcgMWiOKyo8pKXmsvNdgyrHv25wOngUD2oXnjdNd0yA==
X-Received: by 2002:adf:c6c7:: with SMTP id c7-v6mr52114209wrh.243.1540293774791;
        Tue, 23 Oct 2018 04:22:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p125-v6sm11818836wmp.2.2018.10.23.04.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:22:53 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:22:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86/boot changes for v4.20
Message-ID: <20181023112251.GA19030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: 44060e8a5189fd79220a94422b82cccc49a85e91 x86/boot/KASLR: Remove return value from handle_mem_options()

Two cleanups and a bugfix for a rare boot option combination.

 Thanks,

	Ingo

------------------>
Chao Fan (1):
      x86/boot/KASLR: Remove return value from handle_mem_options()

He Zhe (2):
      x86/corruption-check: Fix panic in memory_corruption_check() when boot option without value is provided
      x86/corruption-check: Use pr_*() instead of printk()


 arch/x86/boot/compressed/kaslr.c | 18 ++++++++----------
 arch/x86/kernel/check.c          | 28 +++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 15 deletions(-)

