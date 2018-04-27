Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524811209-2-11571729096504604941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811209; b=ID4SD9vsHIURPiYUxiUGOjSKT5H3rOct/MtBd9PJqeAMv9EQot
    kZJZRYM50kNfCoK1mwA9TDJfS+3w3vvsFTxXXcGymO1XC5Ad+qA0WGnKprPS38kx
    wdEkjI7Gn+cHIBrY0BnjXhNQJ12/CPiRWwMwgqhnhvYKKj6qL/LREndoMv/hd2Tr
    SjRVtKIvsIqcTWP7nB7Y+d+iIIb6RfP26KOHRIZ4YPnpuOy/8glKxxBlTvf5nna1
    du4AaP6YeptLhcQGvbrsXzRjro/dly/zwd/f9ShTRULuERy3sVwWNQa6LWYONL1B
    /IynvwEbqz8WUoIxCVDaHSQCxc7mn8AP7KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524811209; bh=rI21f2tUW1Pza77lZ7hHWVjmFCencr
    wbj1iLn5vpipU=; b=Kv26LwoceGyMVaBV4WrW573VHzvQnfeQw3ZNvB/yZndRPT
    /2nTAkYJq3YOWAMmc3WNF4dCzkvMkq0fe1t9fRqvPm403QQOXwLNitrpCEW8h8Ew
    jswt9pKf/dJE/rDPmDCTeDtooaF9yDyxDT91HsIotpzG5rpHl2mfhZHIsnmhG7uE
    oAocpuedv0zvaMo2xg06ArZ2YNQlP6nAObLA5FaAMaFMTb9QifWHLZstjf1NkZFL
    4wS0c2waAhtgBHPChV3EDJNg5+fys1CahySfPdVNnlQey4dRNc1SHl9grYszzQpV
    MnfyQtpPqOsmVYt0hggzLzzuDRtCzeWJwZ56wPTg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKFqksYZWFBWBsl8MMEsbbxQtU32C4u1NXPndYRH1/zoZ52v+cnTob39Un1HbMxxeb+/ZsTkCBAOFqnJYRWDS9EsMelH632RyV1PXiULICN3KGvrp2qg
    xIzf4o7A0kBpLzkhAMi/vT2r7fOpAAMGJfO5K20+yOILOr/zIe68dm7HjpRjJMPcJJT3fEEaIZPnMGBsSFLjnQXsvLzq4c2V7PiAE2J3IvG1ZB2Gq6f8Kqyo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=9GDUa4YPqo1ZmkaR_88A:9 a=Gop9Tc8rnUgHYxlE:21
    a=ctd-uHBTfv-gdWjT:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbeD0GkF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeD0GkE (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:40:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45C52168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v3 0/7] kprobes: Fix %p in kprobes
Date: Fri, 27 Apr 2018 15:39:38 +0900
Message-Id: <152481117776.22588.1210388093668905564.stgit@devbox>
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

This 3rd version of the series which fixes %p uses in kprobes.
Some by replacing with %pS, some by replacing with %px but
masking with kallsyms_show_value().

I've read the thread about %pK and if I understand correctly
we shouldn't print kernel addresses. However, kprobes debugfs
interface can not stop to show the actual probe address because
it should be compared with addresses in kallsyms for debugging.
So, it depends on that kallsyms_show_value() allows to show
address to user, because if it returns true, anyway that user
can dump /proc/kallsyms.
Other error messages are replaced it with %pS or just removed.

This series also including some fixes for arch ports too.

Changes in this version;
 - [2/7]: Updated for the latest linus tree.
 - [4/7][5/7]: Do not use %px.

Thank you,

---

Masami Hiramatsu (7):
      kprobes: Make blacklist root user read only
      kprobes: Show blacklist addresses as same as kallsyms does
      kprobes: Show address of kprobes if kallsyms does
      kprobes: Replace %p with other pointer types
      kprobes/x86: Fix %p uses in error messages
      kprobes/arm: Fix %p uses in error messages
      kprobes/arm64: Fix %p uses in error messages


 arch/arm/probes/kprobes/core.c      |   10 ++++---
 arch/arm/probes/kprobes/test-core.c |    1 -
 arch/arm64/kernel/probes/kprobes.c  |    4 +--
 arch/x86/kernel/kprobes/core.c      |   12 +++------
 kernel/kprobes.c                    |   48 ++++++++++++++++++++++-------------
 5 files changed, 41 insertions(+), 34 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
