Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D319C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CBD223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JjJGa1cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CBD223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbeKOXKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:10:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46326 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbeKOXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:10:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so14058538lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 05:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fU0bSahDOVLphCMLSHPEdDcSEo/lWX0hmnXsSE8SHtE=;
        b=JjJGa1cVNvAjxasjq32pTy2r7G6/zLKQWghQAftoNiR7KSNvcEacIq4aAaCVWiQ9z2
         Xmoz3waCssQ9WSvN4QIRBGWeYm+bMIapBEIl8Ayfer+yeOCP92SemG9iaNcLrEK406Lk
         64T2l9V6+KHkwViSWdAL7T8JNXW+GMKRKPEcu7kB2CxpQPjyS2McnbasbzeAw9ELCRjF
         IKzWgy/STZO+VJWu5lde5lf4TirVF3G0Iz58ZiGsu6CtaHzFT+FhXPkezXYmMw3AtsNK
         NnZgb3iBAoX+rvqaDo5smvdguTUzQuFzv0cn3NqjfpwUI6FZEDKuQpPndPbvr2dLfd1K
         RmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fU0bSahDOVLphCMLSHPEdDcSEo/lWX0hmnXsSE8SHtE=;
        b=Lh0v0WFGInT6+ixBjWxXu2WW47jqr8rgGobRoMO/CW/8LzgluqFg7VvI2Nq/T/6Gzw
         nD62jKBhC4jo/gzAJbAwnS9MLhesIb4sDXVh27pLIcyDoNmk+kG+lVSjGvlfY85JSi/4
         xf+zK/5alP0FbZivW5IyWPPKZwPO31Gv5WBumA9hSjaoGEKB5nmFBfhutthoAahEWGlY
         IiPrxz5Sjz4jZgANNTWDyxOAhwB6+U3+aVClOR68zhjU0a9Yn+OgF0HrpP0InT1lLbKx
         wC1LI7a05G7Z3iaOuEBqfFH0nYPayPuEXDXhQD1L2hy+KxHa20hVqwnXA8sFQMglLfu6
         uWag==
X-Gm-Message-State: AGRZ1gLR2Lthrkftlt+jnUCuLFjGw+L9YgoAYXB7C/DWm6j84VPWAoFP
        vGhmyQsvrnVtt8ZfCKEEG0Byw5vbNQAuAyJT6dR+
X-Google-Smtp-Source: AJdET5c5LRJPfYcCYNAtxewzKAyacBPE0MRcxhDW3MUowdf8MCl5aC/vDgvI6kXI4KpA7KwiDjkf6Z1FYtN6VmLL/sA=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr3255399lfe.4.1542286978330;
 Thu, 15 Nov 2018 05:02:58 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 15 Nov 2018 08:02:47 -0500
Message-ID: <CAHC9VhRWJ2s+z3TYazcgb6e2mkYuvD4Hy5W-N8i4Qo9Rn_8SeA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.20 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two small SELinux fixes for v4.20; Ondrej's patch adds a check on user
input, and my patch ensures we don't look past the end of a buffer.
Both patches are quite small and pass the selinux-testsuite, please
merge them into the next v4.20-rc.

Thanks,
-Paul

--
The following changes since commit 4458bba09788e70e8fb39ad003f087cd9dfbd6ac:

 selinux: Add __GFP_NOWARN to allocation at str_read()
   (2018-09-13 15:36:25 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20181115

for you to fetch changes up to 877181a8d9dc663f7a73f77f50af714d7888ec3b:

 selinux: fix non-MLS handling in mls_context_to_sid()
   (2018-11-13 21:44:33 -0500)

----------------------------------------------------------------
selinux/stable-4.20 PR 20181115

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: check length properly in SCTP bind hook

Paul Moore (1):
     selinux: fix non-MLS handling in mls_context_to_sid()

security/selinux/hooks.c  |  3 +++
security/selinux/ss/mls.c | 10 +++++++---
2 files changed, 10 insertions(+), 3 deletions(-)

-- 
paul moore
www.paul-moore.com
