Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B7820864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my9gDdx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B7820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeK2HKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:10:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37257 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeK2HKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:10:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so24620864lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bNIJYswPErsQAgtVQWgGCCex4aW3h4csgUIiTkglZEY=;
        b=my9gDdx3PrbKJlaKXXDk/mhkxHwZim0I58TU0as1aZgbRv8hBFDJXZoB//6oksuDko
         h/CwNcnCHzkYIsYyxJLoVMQPQ8NHXGZIzfkAEnC/HC3J4fnBbTT6NCxhQFLi9M1Bdz3k
         db2SZFrb02DXtgTNGZJZxXm4xGECvT1SwVmgwOhnuGn3OtCcuDG7j7PXBpRrwOJPZLH/
         AP3OyomGktzxkQq+Fio/RG3EJp5xLbBhndOztHPaiouP/J8z+mhzx6KL5y15lhL7P42W
         W3IqrPuTcEgHVU/2QTPR8BE49C2RaGqMJHoBijwUlEwqaz2RJ3YufdOKTgOt8LDp1t6p
         YEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bNIJYswPErsQAgtVQWgGCCex4aW3h4csgUIiTkglZEY=;
        b=TkAa/U/XokHYVdassWTgBGZc0LmlhtTiGdFS0s7kG/nuRs8/TeTTVATy5+d/qXJ7IO
         upza2slFwHY/KRNYHXKrxCy098kO5ZxVQZXrFu4gU8QZaAqJ5Xz6iYnl6I1wFuwYi+1+
         iiBAa1DXNJQywx3v2OPvGsIADiAOrc+g3FbIyV7EEla02FUysUp1thuwmy9lq43nfIxX
         dbVkfCTtmf+j7pvak8hat0vDJqzLyBAnu0spAErUNj77+n0dfniw9Nl454DIbae1AgYW
         Wx+RAP17tgJtjtzU/6rqi/5MRXd3woNADyiePTgZztZrnl+1XH5SuV4CBfnQ/XKK5MZk
         Q+CA==
X-Gm-Message-State: AA+aEWbft/6kb3KrjcE1m9+ihhFu4khmDVDzmRTfkg3oTP247UodAYcx
        z31Qdmzts3iKDQFz/feAYOM=
X-Google-Smtp-Source: AFSGD/XPNOS6WWwgpjXlZfIYgB4I7wNfP+dauRzlgTyqMmComArzChju8ih5a+NgUNcxbMwdzhUo/g==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr610771ljj.95.1543435652256;
        Wed, 28 Nov 2018 12:07:32 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id q11sm1328775lfc.92.2018.11.28.12.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 12:07:31 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] Xtensa fixes for v4.20-rc5
Date:   Wed, 28 Nov 2018 12:07:16 -0800
Message-Id: <20181128200716.29346-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of fixes for coprocessors on Xtensa
architecture.

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20181128

for you to fetch changes up to 38a35a78c5e270cbe53c4fef6b0d3c2da90dd849:

  xtensa: fix coprocessor part of ptrace_{get,set}xregs (2018-11-26 18:37:51 -0800)

----------------------------------------------------------------
Xtensa fixes for v4.20-rc5

- Fix kernel exception on userspace access to a currently disabled
  coprocessor.
- Fix coprocessor data saving/restoring in configurations with multiple
  coprocessors.
- Fix ptrace access to coprocessor data on configurations with multiple
  coprocessors with high alignment requirements.

----------------------------------------------------------------
Max Filippov (3):
      xtensa: enable coprocessors that are being flushed
      xtensa: fix coprocessor context offset definitions
      xtensa: fix coprocessor part of ptrace_{get,set}xregs

 arch/xtensa/kernel/asm-offsets.c | 16 +++++++--------
 arch/xtensa/kernel/process.c     |  5 ++++-
 arch/xtensa/kernel/ptrace.c      | 42 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 13 deletions(-)

Thanks.
-- Max
