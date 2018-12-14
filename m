Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB481206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMveJwuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeLNQZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:25:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeLNQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:25:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so1411826pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=auJ2MTk7EZKLOsUnsyjRa1m7vXiPuPt8P7ZcyYGGGBA=;
        b=fMveJwuQs9VhWJDkjORyvxaDHiZ4BJmO0xxfE+FtU7vQLyvDImy4NX/AupGrr9ZTEF
         m6nz0zDh46oe11DkYOrpiaLYdC0XZpFsRTA/g9E0892UfB9PFo0CxsJszfKqUpX1VK2g
         YofevDhQdogCFEoNPcuQG9zA5uY67n8WrtK8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=auJ2MTk7EZKLOsUnsyjRa1m7vXiPuPt8P7ZcyYGGGBA=;
        b=edxZrlC0f9McNtdgCyH8fmSetHMNBs2bZY/+ubL4QztwiUfLGsJ71vEd4Bwbm+lfRm
         wq5Dfgx9txeYJgnhQGlqjGacTQIqda6W9FoFdSVFOkPGGui7evotHWJyb3yWV8bUG7um
         yvq+vG/KckwhQaiSqrStNOV9aJN0dfWkJX5e4t7ja+LERgybNwTZ/OiEwGi3tqFriDE/
         VWBVu+BMletiHW1jpO5rM8E45Rog2x+qYgrYBvoG3FScpfQA/SyM9fldTRNS8wp+0NlV
         Ix48Cq0iJrOPnaXWY9HVc1LbFRo6Qs1qGNFHhfxH9xGe6R3LHcZDIrE9izD9bvCcbDHm
         EgLQ==
X-Gm-Message-State: AA+aEWZ9jvnEeSRNTkI8AZtixHV74oiznFf7mMQ5xjMv+IYfJ5trtXPw
        3coV7qFV3xLItF7iaATSzLdpqw==
X-Google-Smtp-Source: AFSGD/UX2DpXKzjtY3ZBSIIFBgFRV7STb5/B5J3Gs1kAfuJPfLUm9P3GcRhsI/pgCyD4IdQbZkqPEQ==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr3311037pgp.263.1544804758702;
        Fri, 14 Dec 2018 08:25:58 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o8sm11180693pfa.42.2018.12.14.08.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 08:25:57 -0800 (PST)
Date:   Fri, 14 Dec 2018 08:25:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] seccomp updates for next (part2)
Message-ID: <20181214162556.GA7944@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Please pull these seccomp fixes for -next.

Thanks!

-Kees

The following changes since commit fec7b6690541b8128663a13c9586b1daf42b0a6c:

  samples: add an example of seccomp user trap (2018-12-11 16:32:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next-part2

for you to fetch changes up to 4fc96ee9085d39ceeaa7b60cd475d0a474e7062f:

  seccomp, s390: fix build for syscall type change (2018-12-13 16:51:01 -0800)

----------------------------------------------------------------
seccomp fixes for sparse warnings and s390 build (Tycho)

----------------------------------------------------------------
Tycho Andersen (2):
      seccomp: fix poor type promotion
      seccomp, s390: fix build for syscall type change

 arch/s390/kernel/compat_wrapper.c | 2 +-
 kernel/seccomp.c                  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Kees Cook
