Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF762C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4013205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4013205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeKBAQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:16:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40354 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeKBAQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:16:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id k12so15584183qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MRTyIDNRoMdAczWXUIreHBzFk06AIDB0izzsMKo2FCs=;
        b=g/r/UkFbMU82wQbWu7S40moWjUwQr2ob8T3LpLPzaviuSgayrNYkI0JZIqHkTEiNdW
         h8n/yb8NuVo3BTt+6Lx2Ix/nYs5mBB1kHZ/tF1YT3Lqi/boJVtfbb+PJFCiSCJ947uue
         MnYFBAnIoSUu1HbKVnnBpWbb9cPbef8YeXnOCiSD7j/OPqu7xs64GLgK6nulTPzLtzsf
         Ers2eyyoah5UvxixQGdhxdezGdV8tO9n6BeGJmnO674iquE+XiceQidiwgC40sp8J7s+
         f2KCVIOnEPXRg3tvC+mIHn0Yt26NRe8nICKpoUjEepDh+d6CPxYL7g+mS5HXXxJU6tOY
         +IEA==
X-Gm-Message-State: AGRZ1gI3bjV84QePozD96cGyAOtwWsIWqCpBD5YHKu0njyEolLtwg7u7
        3iKZVSJp93aD9/l493hTJp3LvKvQ
X-Google-Smtp-Source: AJdET5eEfucuHPsPh6ZH9YzUGyqzhtPNHXcI68bn/cgM/m1EAM9PUX6bNI8EOcNX3+bRQSrnLJg/og==
X-Received: by 2002:ac8:1b82:: with SMTP id z2mr3335526qtj.321.1541085163793;
        Thu, 01 Nov 2018 08:12:43 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::4:4892])
        by smtp.gmail.com with ESMTPSA id q14-v6sm2337682qtl.65.2018.11.01.08.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:12:42 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:12:40 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v4.20-rc1
Message-ID: <20181101151240.GA48711@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two small things for v4.20. The first fixes a clang uninitialized
variable warning for arm64 in the default path calls BUILD_BUG(). The
second removes an unnecessary unlikely() in a WARN_ON() use.

Thanks,
Dennis

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-4.20

for you to fetch changes up to b5bb425871186303e6936fa2581521bdd1964a58:

  arm64: percpu: Initialize ret in the default case (2018-09-25 13:26:48 -0700)

----------------------------------------------------------------
Igor Stoppa (1):
      mm: percpu: remove unnecessary unlikely()

Nathan Chancellor (1):
      arm64: percpu: Initialize ret in the default case

 arch/arm64/include/asm/percpu.h | 3 +++
 mm/percpu.c                     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
