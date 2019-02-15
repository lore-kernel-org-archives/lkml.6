Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1232C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D0621B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljGpbt6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfBOTWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:22:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36435 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:22:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so11506047wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lqb6nRJrwlyTEBFb65Am9VtOduAPAAeqPhxGsklg2aI=;
        b=ljGpbt6W2NRiHRNgp1P8l3irKEM5c1CH9bbrmF1HdXqTWRJ7easGY7OnvEdlJt5SLP
         FCCsAFe9CTQ0K8fgSfWfF8SPtaQ3KNFZ+gOPW9INarKmGkzyBHCYmX0KQ9kAc2Hze+Dd
         qWFeq5dwlMGq8MTOLc9HUmzN6rzaZYhvS7Ppv2h2uNVoWIZaY/szuB8bbMKA7b9+G+DY
         16ZSK76NtG1cD14EeM3kjdUL29qTrGaSn7ebuNuqztu8RTtEXd5LgGBaIDJ9/CfnPJlq
         +xTBFpEqusuoyojZBVbrFkvQpBAlAPS7mO5+mDnM/oxpDR0nSyTD0GSHHBCG92l/3geS
         IXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lqb6nRJrwlyTEBFb65Am9VtOduAPAAeqPhxGsklg2aI=;
        b=E3Pvgaoo+PGsPnJEaeRFKHtStml38rLiuBAMYFZWhWNI95+cFwoJiOdMYG29G0y7WG
         TwolXkMbyDwYwQkyx6eS1/SfJV6hnsDSN9POxBGqTmLUzNCxOw4S9RnYA0iX+iFy0JbH
         WV3iAgA4iq6JKzCVq/l6SAwTvj+mWnOF4UMNk+/4IoMe9DLhy7znhoKa2B+dABNz3tWx
         SJ9klb7ioXcYsOFoslnzsMBaqoEh73aLdXSyd7wWkGcOBTcIOR0Jbs8IzFif4WkA5AmC
         mfDl7CCXpRgBj267iA0gOSIoAto5cGp4o8OAbiPMYKCzBShsgTLBa/D3VdvQb2hbVaNK
         mcgQ==
X-Gm-Message-State: AHQUAuZLBH4ndzy9JIjhqyOhyonWn6ETpGX+Z6AoH7ifPkG0nS9yWn+I
        Y1z6xaV9TjByXVX6Rh4XJaY=
X-Google-Smtp-Source: AHgI3IaN2CyYpqAqSD5n/AD5AGCFCBrIGALshMdwu5K/dm/DHVcenl+huVIf2WsrtpX714x5/c5sOA==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr8332499wrm.302.1550258549986;
        Fri, 15 Feb 2019 11:22:29 -0800 (PST)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id e6sm8696497wrt.14.2019.02.15.11.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 11:22:29 -0800 (PST)
Date:   Fri, 15 Feb 2019 20:22:26 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] auxdisplay for v5.0-rc7
Message-ID: <20190215192226.GA24834@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small fix for a potential user-after-free on module
unload.

It has been sitting in -next for some days.

Cheers,
Miguel

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.0-rc7

for you to fetch changes up to 69ef9bc54715fb1cb7786ada15774e469e822209:

  auxdisplay: ht16k33: fix potential user-after-free on module unload (2019-02-15 19:48:39 +0100)

----------------------------------------------------------------
auxdisplay:

  - ht16k33: fix potential user-after-free on module unload
    Reported by Sven Van Asbroeck

----------------------------------------------------------------
Miguel Ojeda (1):
      auxdisplay: ht16k33: fix potential user-after-free on module unload

 drivers/auxdisplay/ht16k33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
