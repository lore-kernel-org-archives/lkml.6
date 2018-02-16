Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1110653-1518816587-2-13315660829077263607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518816586; b=OJt+9LWeKkJIR0rkLwZmrH+m9YdFxKXMdKgWntw5ZdWYOtc
    QdDeXuK/D7wWrfflGghEL9tu5aJXdlNLeGLOk3LC2xungDKIIAmWv9kB+a4gZxjn
    lynSWmSk7imRUOdix9UeQivVjzk8TVqt68ATumXxdPG8exhTtExhUG4Jb8Wqr4Mk
    QZJgtCVrgSumcLifjdVxvz2T4ReLwqlWZnEJj4CtEb/bWGnf0D+GB1EG0FxAuDAp
    2UpEyNTJK5cMP1WKlRgtS+2cqNRUkaGu0DZEWcpXDc5Sr/LVDgTwR01u0P+UVt6B
    of+WV6aXREuvLm+rNQItFBREfvehMud4DutXrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1518816586; bh=wwRi0iHHinWl18N3WGBZs+4Gxx
    kaEbx/p/lA8Dpjrfs=; b=cNyIz+z57SpWBiLOmG2M/YRgkAClHQe0uwJQ2Y+Bb/
    6sBCjQVuE5+UbrtiUGmUGUJOh+72/LZXKa4XSBNPgombyPtfNLmFn7YBkkHQbNok
    UPuQCjvhlYedCrh2qoqxG8u80KQFegOv5X0h/Sx6XP2EYai/tA+SzFbcuY/Zx9dU
    eGYoaUUTz8cYyhamsqoGwbmQxVsg2PF24CiX6Av4IvxWqhhppUCie64V6hTNXoHj
    b+RSGHIA/7JtOjJCspUIyUNxmaM5SbIUR2tCjkKM//uD9ERD5qPORS+3lmC9416f
    nUfLNQ8PIRseVsfWPba8jQy4WEkDHOroLMUWGIU7qc7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750730AbeBPV3n (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 16:29:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:40080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeBPV3n (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 16:29:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="20783037"
Subject: [PATCH 0/3] nospec: Various fix-ups for include/linux/nospec.h
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org
Cc: linux-arch@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 13:20:37 -0800
Message-ID: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ingo,

Here is a small pile of cleanups and fixes for nospec.h after inspection
from Linus, Rasmus, and Christian. Full changelogs below:

These have received a build success notification from 0day across 126
configs.

---

Dan Williams (2):
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include asm/barrier.h dependency

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type


 include/linux/nospec.h |   26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

--
    nospec: Kill array_index_nospec_mask_check()
    
    There are multiple problems with the dynamic sanity checking in
    array_index_nospec_mask_check():
    
    * It causes unnecessary overhead in the 32-bit case since integer sized
      @index values will no longer cause the check to be compiled away like
      in the 64-bit case.
    
    * In the 32-bit case it may trigger with user controllable input when
      the expectation is that should only trigger during development of new
      kernel enabling.
    
    * The macro reuses the input parameter in multiple locations which is
      broken if someone passes an expression like 'index++' to
      array_index_nospec().


    
    nospec: Allow index argument to have const-qualified type
    
    The last expression in a statement expression need not be a bare
    variable, quoting gcc docs
    
      The last thing in the compound statement should be an expression
      followed by a semicolon; the value of this subexpression serves as the
      value of the entire construct.
    
    and we already use that in e.g. the min/max macros which end with a
    ternary expression.
    
    This way, we can allow index to have const-qualified type, which will in
    some cases avoid the need for introducing a local copy of index of
    non-const qualified type. That, in turn, can prevent readers not
    familiar with the internals of array_index_nospec from wondering about
    the seemingly redundant extra variable, and I think that's worthwhile
    considering how confusing the whole _nospec business is.
    
    The expression _i&_mask has type unsigned long (since that is the type
    of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
    that), so in order not to change the type of the whole expression, add
    a cast back to typeof(_i).

    
    nospec: Include asm/barrier.h dependency
    
    The nospec.h header expects the per-architecture header file
    asm/barrier.h to optionally define array_index_mask_nospec(). Include
    that dependency to prevent inadvertent fallback to the default
    array_index_mask_nospec() implementation. The default implementation may
    not provide a full mitigation on architectures that perform data value
    speculation.
