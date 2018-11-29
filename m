Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C92C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9945420989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pXD3e70U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9945420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeK3Dyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:54:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34589 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3Dyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:54:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so2375294ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z7NkhbXTc1ivPOR52lD0OcjTo+PnwVcSBCzvDEYdl4k=;
        b=pXD3e70UTsvoSco1d3tPG1O0u9HOW/rlQ5xL2Qm7vIohQKsmZknTZaIwZ7zrGxROZj
         O0Ul0IC7kzW9ITtxBh03YsvZsAYG6cIYtr2M7KrqeSGKY+s8xlnQSpT7NFfLrKViw4bh
         D/tHxiVzMkJZd+Xw27WiVtOBCiGhxfs09OJuKtq7cTdWMjfauWWe3smsdyJYkl1MrnlL
         OfYkpVn5Udh96djRo0LCTWHeCTcSJPQcRv9qebYu0TN9GDgnbaZpZzs9f7IBGkN+N8v0
         KZiPbmbXiKrl/wEFNDHyeOX9SkGGNwPXti9Q+sZvDXQVOPGdinJssKm5kBVtbHJmxw1n
         E3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z7NkhbXTc1ivPOR52lD0OcjTo+PnwVcSBCzvDEYdl4k=;
        b=eTV7IbGZ0SEDqV1qy86W+vIon8N2lBbu4k7kZgC5BwB3IR0x64tnNNNRSWs8aTEKql
         MPt04zRHspr2ML8+XpZ7zvHBR3pVMSsfNQVXcu2lsGxwuVtVKq47Z+eksbD7NiN7PSCp
         aRZTUiQP+sOu1Ovgq9KbUpthpqfxBxxv1b/q6rWZmSFOnnXX2MNscBeqX21+/i+NZdCh
         XWIFoCmI33lHrhkZLT6x4IU15qBQMTU4rqzrRqRalqr4chVkz5MW/KVtGAQc6kwxTrvw
         Gfr+L5G1cYCS4+rW9CPoIoMg81HVwuQp5NOtTEAbzUp/TgaP87/KUmcJwXLTmN9SKDfF
         XghQ==
X-Gm-Message-State: AA+aEWb96GsGfrCGeSL1fOb3ugmDVYMIIjiD2+Gvtk0Q7yUwWkxDq74H
        bQWz1u7Qtyb5RgPWWqSzylkjqZFGDVeS2gwVb1xw
X-Google-Smtp-Source: AFSGD/VUlzMJ5prSH+4ApZtG6Ylphq8/4yQay+0tXQwJLJAvysv1Qw4uLTGr97JPMFmWtgtZkJtBciEI1I0I8RXyr+s=
X-Received: by 2002:a2e:93ce:: with SMTP id p14-v6mr1578379ljh.42.1543510131933;
 Thu, 29 Nov 2018 08:48:51 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Nov 2018 11:48:40 -0500
Message-ID: <CAHC9VhTvN5iQkqDXsKuqwr73_eHwi6-0khVRb-pWQa439rN+3g@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.20 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One more SELinux fix for v4.20: add some missing netlink message to
SELinux permission mappings.  The netlink messages were added in
v4.19, but unfortunately we didn't catch it then because the mechanism
to catch these things was bypassed.  In addition to adding the
mappings, we're adding some comments to the code to hopefully prevent
bypasses in the future.

Please merge for the next v4.20-rc release, thanks.
-Paul

--
The following changes since commit 877181a8d9dc663f7a73f77f50af714d7888ec3b:

 selinux: fix non-MLS handling in mls_context_to_sid()
          (2018-11-13 21:44:33 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
       tags/selinux-pr-20181129

for you to fetch changes up to 598e1a42e9626213565d3b22ea948ce78556512a:

 selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN, and RTM_GETCHAIN
         (2018-11-29 11:32:02 -0500)

----------------------------------------------------------------
selinux/stable-4.20 PR 20181129

----------------------------------------------------------------
Paul Moore (1):
     selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN, and RTM_GETCHAIN

security/selinux/nlmsgtab.c | 13 ++++++++++++-
1 file changed, 12 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
