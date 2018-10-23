Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9603C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF5207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTAl8/qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFF5207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeJWTdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:33:36 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:34915 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:33:36 -0400
Received: by mail-wm1-f48.google.com with SMTP id w186-v6so1338538wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G1AdKc1K9nd6gGSiV/mBEuylZYkC+mQrkIRriXCHmfI=;
        b=jTAl8/qwc6OIG6bFDb7EjCp3yvouxuRfqy/2rqvlbx3UU9WdV5GdRpZVB0MkcVrtYe
         66+EYUuZpahj6kYXpz/50D6YAGM4frN4RVnat8bbX7iK8KaX5TMFGVV3SHey300fmUWS
         2ecUSBJLO0/6gr5t1rn0EjPy2ML2VPWrA70SX49/Re4R1Q6R7rllXR3/TR9GbKlDueHM
         6CH8jRqAf2+rmEB09P0rvUkFfzyG5LeBl29ooxOjBdyrM2Z1Tf01/pTP4glG+rK8LB1V
         aITMkj4w/gzLU096EBTniNNElk08CYDNGUmaql/fTmvbeZPXKtKsRK6gTLRRDBwUOesd
         o0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=G1AdKc1K9nd6gGSiV/mBEuylZYkC+mQrkIRriXCHmfI=;
        b=cw4H8WZ8ZiGtX4cyE78ebqMsIGib+/6njMSW7xslfbhD7chUa49YdpQeBrvRty8pwQ
         xW5ApymXuXlt18i2U33FfHoRHAaR6EJLlzvssoQ0FgSP4lYGBlFJyjEwlPu5IdtqxGQp
         W4qLpn5rAJqSuGkpg9gltg0watpR8cN++wDzRCqJ6QHx60zQyb6U0k8fw5o4YQxJgia4
         B6XJY0INFykPSkd1kPsFqrP1IwmgBV+Hi8PPowIiE5C+dRG9MrnrHPdhF7VFKcZquvWk
         KV5e5iTWASWR/wGKbm4w7zVccF12bVZfv/LOuOXb5u8qJo1laJ3wcc7EbOELR1yT5RRJ
         Bksw==
X-Gm-Message-State: ABuFfojNgV7O+KGxix4fR1bH3XJVEBSsmWPWj0p1uITvuCBsK3lpyS/B
        JY0TUUWUSArGTKFEbYiVHcOWWqFG
X-Google-Smtp-Source: ACcGV62wS+bj0wPcB+EjkAkn9JB8m4M1BMOkVdhl3RihcHTRMGAut3rkyRFTH1BNC1QvoqPmqUGh+A==
X-Received: by 2002:a1c:f417:: with SMTP id z23-v6mr7965549wma.80.1540293035157;
        Tue, 23 Oct 2018 04:10:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y65-v6sm1358947wmg.40.2018.10.23.04.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:10:34 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:10:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86/apic changes for v4.20
Message-ID: <20181023111032.GA113000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

   # HEAD: 76f99ae5b54d48430d1f0c5512a84da0ff9761e0 irq/matrix: Spread managed interrupts on allocation

Improve the spreading of managed IRQs at allocation time.

 Thanks,

	Ingo

------------------>
Dou Liyang (2):
      irq/matrix: Split out the CPU selection code into a helper
      irq/matrix: Spread managed interrupts on allocation


 arch/x86/kernel/apic/vector.c |  9 +++--
 include/linux/irq.h           |  3 +-
 kernel/irq/matrix.c           | 82 +++++++++++++++++++++++++++----------------
 3 files changed, 58 insertions(+), 36 deletions(-)

