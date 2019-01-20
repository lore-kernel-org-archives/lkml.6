Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B7C676F4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FD32087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2SS2G7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfATPe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:34:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45711 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfATPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:34:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so20419243wrr.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=06jFO/gnyXW+qnndaDL1IkEsoLRsDvPbN5AOwsrqXC0=;
        b=M2SS2G7tDDgl5TDuqKGekNONsy7kCt8nQvBMUGr7vezciKDzJo+QWcxdC+imOx2XC6
         Ege91zWrTk7JptOxm77c+fub/6gkSDOeUCqACEU/y+R4g0XGx95cScC2RjY/DC8avk1e
         kc1GiIc9HOopCfMmySfk7a6GkCPzuihkoLQl1fH9YF0pXAWDM3D8vYtEXyACfu0WwxVO
         gyaK79TUjHNbbfO/JIVOs3ih97+fw97obPc5pFQJei3S/6C6IsyWNBcnEXDke156kcdU
         Ny+SAKNVr8KF0Q1ndN7ao1VlRG1Fne34H26h47KrasjoC3Gl7ekSkns+gL1VWjrngehw
         Xyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=06jFO/gnyXW+qnndaDL1IkEsoLRsDvPbN5AOwsrqXC0=;
        b=T7hhCffQbZK3b4R1Am3G9Vb7gEALz56VthzcgibnMoUbBvAz4K+DOW77XPS0FmWSoC
         xTC4aZzXHsV0eZbcZrIMwhIP4rjv/DfBL9nR4Rl8wY/usH3LXzi6bVasaMWyelc7PH/2
         uEQLgv1vf/2yq3wstdfHGDhC+Wt/JQYsTWyNIQbKN2bRNzu9OMBXHtqiep7xOQvlEf07
         Mvr4kt7l14NGz7tZq2OlQCNTbEBw4W7PphRNdQpdH55zAki5OmN27QWDMHsdgJkyTBet
         uWbQVdv4h1E+rxSE/PVvKg5dnhhYqoCljU5WsUKjYVUPErIkajWC7LI9Hd0fEHIdX0+k
         4H9g==
X-Gm-Message-State: AJcUukeL985AyFK7Zoh+BovDMNSWTmmJsxkzUW+x/4rR2rw0qWs2iUWO
        JoigkFaP++RvAQGrbnlIueM=
X-Google-Smtp-Source: ALg8bN67UeWaKLCAgWHakQGU15keq6cL3p4kXv9bVori3Eyx5Jl7FNjhcWAlwIEyir7K9m9umMQn7A==
X-Received: by 2002:adf:8484:: with SMTP id 4mr24183092wrg.249.1547998466790;
        Sun, 20 Jan 2019 07:34:26 -0800 (PST)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id m15sm78193750wrr.95.2019.01.20.07.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 07:34:26 -0800 (PST)
Date:   Sun, 20 Jan 2019 16:34:17 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] compiler-attributes for v5.0-rc3
Message-ID: <20190120153417.GA29879@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I picked up this include/linux/compiler*.h fix regarding
OPTIMIZER_HIDE_VAR for clang.

It has been in -next for around 10 days.

Cheers,
Miguel

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.0-rc3

for you to fetch changes up to 3e2ffd655cc6a694608d997738989ff5572a8266:

  include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR (2019-01-09 11:36:41 +0100)

----------------------------------------------------------------
include/linux/compiler*.h changes:

  - A fix for OPTIMIZER_HIDE_VAR
    From Michael S. Tsirkin

----------------------------------------------------------------
Michael S. Tsirkin (1):
      include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR

 include/linux/compiler-clang.h | 5 ++---
 include/linux/compiler-gcc.h   | 4 ----
 include/linux/compiler-intel.h | 4 +---
 include/linux/compiler.h       | 4 +++-
 4 files changed, 6 insertions(+), 11 deletions(-)
