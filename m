Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3619796-1525407300-3-236362532932342014
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525407300; b=ZJuIwbWSR0CQjDHZE1GGhvCcYU/e4S+xpX7fwFAgF7s028OIQA
    fsvpqD1s99fKHHKgB+y7qXq/7R1NeFlIJd7u2c4l38wHBRhEQ57f/J8l05SOVita
    4E9UYd+MWzk6iP9GHJW5cqaG8C4odP6eCIwR1+7v19kHbkI0tSFHxCW9bJUy0J/8
    Bk70E1RW3ohxnE8tLtkkwTeVUq3oUkDz/PWxnXTiPJABlWZ2RaU6qsdLW1ey/D3j
    hu4mKD83KRqNReHHfzGOSc9lVOY8UmFLfS+z5qyMd6nALo3F2ey5pyZXKQU628Kn
    8kL9jGq5yAOws+HzOlFxXTllLF2V8BnlzjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525407300; bh=JM8orJ32XmuvAuS0B2KEWhCuKSjiZL
    53P9lbgcC0wXE=; b=gOpWynrdo+yg+63pm0lEu7dKNHlBRwsWUZDSyhLyBO20r7
    pGobtyu4Zp6lJSKxOLhwA/5cr22S2Di4ew68B/0Z1VfodduonOY0ehkinHfJwbUP
    loxG7rzdDwvICl6HLEbql67miu2OvHxiNwvNObei7jWezK3NPxPjloSqmJYNpXEh
    NsXs6prOJEc9P4B1cYkmIjAEzORlJQw2fWRd+BzbfWC3KmzHP2hqimglwDMP/Msf
    ldqIOhiugGUqQkZWaz+qYpjOVptVDDyFqbfIAKsFRS952pwsnSm56hKyOWyBLQGr
    6wjEs5gSLzGo/Qjgw3t2K9+BCDIaQRRkWX/pVrww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VLLiWuP3 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VLLiWuP3 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK7eA0aYLkoa28BQZIFgMRNpkbEi6Y2QHtU5AY2Qsw3yIcpN8JBcvXv54bPuTuYGHYb0nG4w1KLmrbrhmPfURmSXkRVC0OxG4b6XUn/s3Nyvv3DNqOZn
    u6aH7j+dBPuvxIY5j/vY5s0oc8cyBGDRNr3cdNK1S2w9iC+oZPJ5g9qPjeSqAMz1rqWoM+IQnXNd0tb4o+9rTsci5wW4ZeSHJjuEQnV66lY3ybI7YorRP/3L
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=b97_WyIe7AKiTRb-nbkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750753AbeEDEO4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 00:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDEO4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 00:14:56 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, David Long <dave.long@linaro.org>,
        stable@vger.kernel.org
Subject: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on unsafe functions
Date: Fri,  4 May 2018 13:14:31 +0900
Message-Id: <152540727123.29650.13679359124038587629.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is the 3rd version of bugfix series for kprobes on arm.
This series fixes 4 different issues which I found.

 - Fix to use smp_processor_id() after disabling preemption.
 - Prohibit probing on optimized_callback() for avoiding
   recursive probe.
 - Prohibit kprobes on do_undefinstr() by same reason.
 - Prohibit kprobes on get_user() by same reason.

>From v2, I included another 2 bugfixes (1/4 and 2/4)
which are not merged yet, and added "Cc: stable@vger.kernel.org",
since there are obvious bugs.

Thanks,

---

Masami Hiramatsu (4):
      arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
      arm: kprobes: Prohibit probing on optimized_callback
      arm: kprobes: Prohibit kprobes on do_undefinstr
      arm: kprobes: Prohibit kprobes on get_user functions


 arch/arm/include/asm/assembler.h  |   10 ++++++++++
 arch/arm/kernel/traps.c           |    5 ++++-
 arch/arm/lib/getuser.S            |   10 ++++++++++
 arch/arm/probes/kprobes/opt-arm.c |    4 +++-
 4 files changed, 27 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
