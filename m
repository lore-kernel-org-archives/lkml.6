Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3455337-1526627339-2-13936589949737704438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526627339; b=KfXDq7RUTlZ4ntIBAwryiDIUOb9J+B5jRI+CCsIFcoM/RqMPxY
    s7ZK1DNp71pldyH4mwgYm2ECinQ4n1lZ+LAJUzcnT11QsiDgHvbHcyFGkDyOiqwM
    Uww9K5kX3A+rUzGYSMkTkB6+UYeM6UWlPkJ963XMH904+atqLYjg+2Dx4Fn5MUgV
    egaD0xiSd9eKgJwYG2Tf/2NJuDt/JDJhCvkWLZ68uCf/OBdFKB74ORRSS5E2vRzV
    HM4EycEBljo4dJ16Q4wl/ZnLtu8vh1TxhUZdOTFSf9qbNwhg9OB+AC1NK0lHNNru
    cUfQ+VRhnCEQr3RQoYkUCHjQLf9TdsprYPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526627339;
    bh=j234j9UBbr+2M0L/rjHGiJe9umNPerDHlEKcezgMISU=; b=eqaMxBl8620P
    qHOGoWJi9mwzau2rHiZP3ZYuNbL0fgcKcqruO7M/vSBL/BlpuZcNVC/YvgoKP3n1
    eJ+UoX8SLpBAa2+PBExcm0w37oEBRE/SINfa2XDmJWJv86PheHbAXfIZMop8HpWp
    0Lb/x0PerVHHgK2P0aK6yfXbK3msMGIv94imp9MbSFH4hZOhGcnBEgKqGOSZ06yx
    6WHrfMUtg69yaRU/GF7BYYXKirHuyLLYw+CxY1euTR3ymGCRoyclUtH152EvRSCd
    81csTKC3SQNsLRYEZI05R5KbuFOljN6o8/frbEjRaeY8OQBNEza/tByA83W3EbQ2
    NqrX99/+2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE6tMrWflUBdowQoEYL2HOoZyhQH2vOUQBSvHmlBhKQW356ZYlDrw9UTRS3fm/uVIN/MZP2ldnHzQ8ruHKJygNbBjHMwRiB0kfy1KEnhMC0Wo3MuOUPd
    Qa45l3HhKJeSqwMhFX1snuA8JxiBMSNLH+qBtysw1Yxai4jPs4fkX0uWc5k4kbj27IkU+EYIHbTOEX3joDdB+HJgINhLVV1bkP9ohUMOdfMlqvzxb2ZCGDCd
    aaZNi4r/lDL7makgFSdR+w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=y6ZjemeqickuwuxARSAA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeERHI4 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 03:08:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:16780 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeERHIz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 May 2018 03:08:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="200418858"
Date: Fri, 18 May 2018 10:08:51 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: jmorris@namei.org
Cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for v4.18
Message-ID: <20180518070851.GA11123@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 5859cdf55063943192f316b3d6c673fd6fcbee46:

  smack: provide socketpair callback (2018-05-04 12:48:54 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180518

for you to fetch changes up to 424eaf910c329ab06ad03a527ef45dcf6a328f00:

  tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)

----------------------------------------------------------------
tpmdd updates for Linux 4.18

----------------------------------------------------------------
Colin Ian King (2):
      tpm: st33zp24: remove redundant null check on chip
      tpm/st33zp24: Fix spelling mistake in macro ST33ZP24_TISREGISTER_UKNOWN

Jerry Snitselaar (1):
      tpm_tis: verify locality released before returning from release_locality

Ji-Hun Kim (2):
      tpm: replace kmalloc() + memcpy() with kmemdup()
      tpm: replace kmalloc() + memcpy() with kmemdup()

Nayna Jain (3):
      tpm: move the delay_msec increment after sleep in tpm_transmit()
      tpm: reduce poll sleep time in tpm_transmit()
      tpm: reduce polling time to usecs for even finer granularity

Tadeusz Struk (1):
      tpm: fix use after free in tpm2_load_context()

Thiebaud Weksteen (4):
      tpm: Add explicit endianness cast
      tpm: Move eventlog files to a subdirectory
      tpm: Move shared eventlog functions to common.c
      tpm: Move eventlog declarations to its own header

Winkler, Tomas (1):
      tpm: tpm_crb: relinquish locality on error path.

 drivers/char/tpm/Makefile                          |  10 +-
 .../tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c}   |   3 +-
 drivers/char/tpm/eventlog/common.c                 | 195 ++++++++++++++++++++
 drivers/char/tpm/eventlog/common.h                 |  35 ++++
 .../tpm/{tpm_eventlog_efi.c => eventlog/efi.c}     |   6 +-
 .../char/tpm/{tpm_eventlog_of.c => eventlog/of.c}  |  11 +-
 .../char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c}  | 200 ++-------------------
 .../char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c}  |   3 +-
 drivers/char/tpm/st33zp24/spi.c                    |   4 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   2 -
 drivers/char/tpm/tpm-interface.c                   |   5 +-
 drivers/char/tpm/tpm.h                             |  32 +---
 drivers/char/tpm/tpm2-space.c                      |   3 +-
 drivers/char/tpm/tpm_crb.c                         |  10 +-
 drivers/char/tpm/tpm_tis_core.c                    |  58 +++++-
 15 files changed, 331 insertions(+), 246 deletions(-)
 rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (98%)
 create mode 100644 drivers/char/tpm/eventlog/common.c
 create mode 100644 drivers/char/tpm/eventlog/common.h
 rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (91%)
 rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (91%)
 rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (58%)
 rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)
