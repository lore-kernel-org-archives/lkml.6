Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1897398-1524918901-2-7422978205266338128
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
    1524918901; b=UCZVL8xiy6T76h1qua0wH7R/0NmM7OzwnMNXnS9HCYeg5CR3Qg
    ECwzj4QqgsUnLbEHoJMdC4NLo4SzjaQq8h2lKUbfcA61WpOR68y+6Iwi9SeFG+8q
    2PGmjShU9VqwN9P3AfRNdj9tC9G8dyuENnJ3gqU6ueTPJjeSzgirid7ab6RFf6yX
    jkpI69SfoO2qVw4Z3qp7j4OF4QaHVS+m3peNWM4AZkn2P+/7+Ov9vnRQ9JnEvFhT
    mOFATcIU/ZTzEFt0IelC126SZ3tZ3zyfcUt4Y6fHDyp23mhwDtNoi8Or+4srO/x1
    2nhqLS/rnFm/tZTEaVenHrdpMZoJfmhWsgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524918901; bh=DSzGJNL7KFi4v0fmu3Su38fX1BpNBj
    nCycDOumduXGM=; b=LAyEF7ZwzRM6jU4T78cQypUiAgcJ97ssNQCIzjHg7DQFHy
    dQbGDvwr9GFq3MBajbBT7DYx3JdWCfOC0EpW0eH4a7zg2d5ba3Efcn5uQyWQyn1m
    9ceN68yvq/f3eCvSU2fek1ODhy8LCxe411X1r/GWbw31mzQDsU6AvlHuL4jqciIg
    o5I3NsOn5f5tsDVHhQbzRX6u9K+OeumjuHLDtg0OgBJzt5xIK+IU3hTSOn5NP0YY
    VtRO0cp/mFx0TPXrSqu1CM8APE3gFGjdht2suEBCcDUz2h4iiGU6lysZuvD6ZtKw
    KmYMwk+3KC98CJslpA7vR+8h32P6DD+DQDLiiOZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfHDpcUh+ehy9VMSxSZUbltrStR9exxXCGMX8dtcLsKw6xuDG9ATPPNqk3au9qWpDVLSXnb1opv2pgDE4eONXQnFn2TDuJHW1PHD4sOBEeZqm4pakehw5
    qrpw68fxxh+pOFfHMQSpoHVTYFb1cAnjCgBYQI3pp9/gvt0Oz/SOCFAhx/DilGE1gjFecvG3K5cAi1YngQoO1FgYLqByt0HPdFlSdTKwFhLPKOELUrjSTJxt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=7HTw5qNjFICyrjSqi0kA:9 a=YX7VmZAZ6HkmtB_A:21
    a=v_x1RpOncQ5JE6Xe:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759829AbeD1Me5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1Me4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:34:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA3721A96
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
Subject: [PATCH v4 0/7] kprobes: Fix %p in kprobes
Date: Sat, 28 Apr 2018 21:34:30 +0900
Message-Id: <152491886943.9916.18051658590418236184.stgit@devbox>
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

This 4th version of the series which fixes %p uses in kprobes.
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

This series also including fixes for arch ports too.

Changes in this version;
  [1/7] Fix "list" file's mode too.
  [2/7] Do not use local variables and fix comment.
  [4/7] Use WARN_ONCE() for single bug.
  [5/7] Just remove %p.

Thank you,

---

Masami Hiramatsu (7):
      kprobes: Make list and blacklist root user read only
      kprobes: Show blacklist addresses as same as kallsyms does
      kprobes: Show address of kprobes if kallsyms does
      kprobes: Replace %p with other pointer types
      kprobes/x86: Fix %p uses in error messages
      kprobes/arm: Fix %p uses in error messages
      kprobes/arm64: Fix %p uses in error messages


 arch/arm/probes/kprobes/core.c      |   10 +++----
 arch/arm/probes/kprobes/test-core.c |    1 -
 arch/arm64/kernel/probes/kprobes.c  |    4 +--
 arch/x86/kernel/kprobes/core.c      |   13 +++------
 kernel/kprobes.c                    |   52 +++++++++++++++++++++--------------
 5 files changed, 42 insertions(+), 38 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
