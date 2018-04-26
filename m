Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524730114-2-3643730892389456861
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
    1524730113; b=ok2d2sv8/RFCXQreLpVx+vfgScswYOgu3a480fCHhRKOj298/q
    nLUiMqAYXmh281JlBPwrWl4QV222mnmXjocaTtHitAH0h2qAz+NLP4e+2CiYmHyo
    FY2FItq4ZAoq+Vz7PSB2iE0nBy8HHDRjRdPuN7dEsJ/GivbXwyah39Hy4GVvNuN8
    F6oSfhihT93MKaWywarsVQuHbyisst2g6ue2FaU0SQYsoBQejns6Vhpsz18k/RPP
    ua1hnZduGIcmhIMSA8vOzpsIYmAuGZrELpWX2ujrYuhKhZzhSxgrAbqExBONqidu
    OkC2QL6Y/5MOY3ejJhxsjuQ5AFcAMI+0jZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524730113; bh=nrl1WGCD3ug84kqLGvycenSQctyK4N
    nxVKBQOifw8MU=; b=JWMs/UURHnS3ww3SROwnn+UWPLF1myEKiGbMk6DjnxUKx7
    UIw45istyU2H/rpuzlpvXIAaZLfYsp0ZRxzF1ydD96qBB2gRJBYR8Q7pFhvPQXyF
    eRGC9PJBw+YtP77yogvxf759emWIAIvGJ+S8VMekYIOfK5wBrIsjmu9ruBi0yQDO
    7YS8iQZuVKuRc3oG6PtjeHYjosOleRLNbNlBonsjUalMQ8ZbDfnDUKShb24uuikt
    QtaiN9xcKRoE4vzoeTYRFWEG28eExGGBhe300pOID1HigFKd8wdik9K5Bf5v064H
    JJRYeJOSen5RAhgle09CElKNbVUOX8Y8Keq+Q4Rw==
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
X-CM-Envelope: MS4wfL9XzEVH+wONA2J8zOXFzVTC+jRyHJXiBdrsR4f1TYGjxK4JH0plSlm9v0rzD14SF+HUU0U4X8woe4JpPRVXE3XA0W44AAO6C6D+3mSo0IUGznphWnPK
    8oJhy7ERPMFmVCiJNu0mv5aqZe2rdz20gYhhAROIZi/9szNUyfWY/uJuTOpwq5RO57GRzpMmuztMJgoRy7we6HetbtjxEpI0vyTMeOE+DYinyL/nadoQJxT0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=9GDUa4YPqo1ZmkaR_88A:9
    a=Fm3BaJG9hg-GMdWk:21 a=ZD54nVZYQipy9oNs:21 a=QEXdDO2ut3YA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDZIIa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752419AbeDZII0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:08:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2539021781
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
Subject: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Date: Thu, 26 Apr 2018 17:08:00 +0900
Message-Id: <152473007907.8819.10449983839199591406.stgit@devbox>
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

This 2nd version of the series which fixes %p uses in kprobes.
Some by replacing with %pS, some by replacing with %px but
masking with kallsyms_show_value().

V1 series is here:
 https://lkml.org/lkml/2018/1/25/1

I've read the thread about %pK and if I understand correctly
we shouldn't print kernel addresses. However, kprobes debugfs
interface can not stop to show the actual probe address because
it should be compared with addresses in kallsyms for debugging.
So, it depends on that kallsyms_show_value() allows to show
address to user, because if it returns true, anyway that user
can dump /proc/kallsyms.

Other error messages are replaced it with %pS, and one critical
function uses %px which is called right before BUG().

Also, I tried to fix this issue on each arch port. I searched
it by

 # find arch/* | grep -e 'kprobe.*c' | xargs grep -w %p

And fixed all %p uses in those files.

Changes in this version;
 - [1/7] is newly added.
 - patches for MN10300(deleted) and s390(merged) are removed.

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


 arch/arm/probes/kprobes/core.c      |   10 ++++----
 arch/arm/probes/kprobes/test-core.c |    1 -
 arch/arm64/kernel/probes/kprobes.c  |    4 ++-
 arch/x86/kernel/kprobes/core.c      |   12 +++------
 kernel/kprobes.c                    |   46 ++++++++++++++++++++++-------------
 5 files changed, 40 insertions(+), 33 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
