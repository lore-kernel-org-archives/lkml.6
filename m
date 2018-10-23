Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1259C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E5120652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktbxrfxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E5120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJWUGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:06:10 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53491 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:06:09 -0400
Received: by mail-wm1-f51.google.com with SMTP id y11-v6so1430141wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BmIdwt0XcqYW6CWB0m6+C6v2JSZu1w3bXnlkYhtlGk8=;
        b=ktbxrfxxjZnZkroaavO8gZvKd4l8tVOh0eEIbLda1Eh/T1zTrPHZeL1bGsKS4xM9fv
         g8oG/nQ8W7XPdZ7945CGIPtuWDdGUk8ypcCqYH7u985m8PE7G55yk6rxrUkcTyTxAiZz
         BUZeqH6VrQaOltXEGYVzbuLbopwiorqYQ2KUDv+kW7VwTsunYR0fHeVN9ICAieJwPPeR
         3VwRRHSIi5NJbRnHotwpGLe4i85YIuhUSmIlGtiRlKuDtsjUk05QxydwZn+FcF858yHl
         QKWLgS63tmzsxy+EoQ/c+/oHdXiedWS6jY2gPEdqjP9/7Cf/l7Crtu082jH5i2wbYJZ3
         phkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BmIdwt0XcqYW6CWB0m6+C6v2JSZu1w3bXnlkYhtlGk8=;
        b=BcnuQJV9ibLVRHSp+WeCv3HJGSMC+4fQa4y4fxQRhFWMZ4TpeIKt87ZCDmqsi+AvM/
         0TUhxzTFd5Qpi2L3lJxXfHN+LJboV8nAkFxzHa8VAa6ZgM3I6LXNQEmh30jutOb6Hw9a
         uuBhkLqUUjwoFT8xsedhFTZB7npLZGdePXHRrv28pGXDceZwBq33odFYOOqAlOrEvq+g
         YU8+Clsp54ZCDaWjSAIbbJq4K4lwuNdx2OpGEI8WIqCTHclDmwcwHY5salT3nW+6ECvN
         s0K0y2+bAb+o9yne2F60tdU37UU3ucu/aoy9Y1kjV/NhXkx4EcjNWUiIAlL2t2o1HhpS
         9HPw==
X-Gm-Message-State: ABuFfogEoqxh0nKO0qETCUlzB/m7iYGaQeBaboGyVIFPQiXkMJ86srJa
        wk51GmLS1wia9XOH9sn/e/1QU5E6
X-Google-Smtp-Source: ACcGV63iTFDfyPM7JmWXnxZua4R4AwZZYcZxOEgG0GP1UwFyjrywAZGBhHz0l0/rBYrsh6oQSIlPfw==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr19356181wmd.3.1540294981088;
        Tue, 23 Oct 2018 04:43:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m143-v6sm1576835wmd.29.2018.10.23.04.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:43:00 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:42:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/hyperv changes for v4.20
Message-ID: <20181023114257.GA16909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-hyperv-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-for-linus

   # HEAD: 5140a6f471137205687428b0b8f12f7187bffd18 x86/hyperv: Remove unused include

Two small changes: a boot warning removal and a minor cleanup.

 Thanks,

	Ingo

------------------>
Dexuan Cui (1):
      x86/hyperv: Suppress "PCI: Fatal: No config space access function found"

YueHaibing (1):
      x86/hyperv: Remove unused include


 arch/x86/hyperv/hv_apic.c |  1 -
 arch/x86/hyperv/hv_init.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
