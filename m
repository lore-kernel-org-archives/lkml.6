Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1965609-1523039434-2-6952337331994417807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039434; b=PufqZKf95yu3ckaAqkuV6QsV0LlO3stbEi8nGKIGDuH/h1DPbY
    uwbNcsHEnlMrU1maCyW8Wvdu9xq58Oiikd0Bi76J193cHZeZmI2d4eVCOO5kFQlH
    fmupAehTTS8iTPBoiP99z8HLAvFUSM+BO+ay8W6OkXvAzBb5yUaR+fvMQXgWnTSE
    mf8QDqVEzu+3iZc53OWg8hqRVnLB1ZkyOxPOodLgxt+RIU3is82iOUV/cxk1xsiJ
    +U9XkYMDx9Jp1eWOyTr5tliFT9DUySxM5gTqShT79fUqdKUIPh2t/G+q/6MhtMUr
    o/v0/YAJrpXwTpOI5neIT7EltQ8WSdUpxuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523039434; bh=lhvjgCHmMo9CklFtxJ9fDqw+Yi01Zl
    WDhSJh5cPnBck=; b=sDCyGeYsZA/6atAQYPSzS64021pxWshA7t17fsCPiuAwIv
    hJl6d0cN5pnsYQharbVdHlRIx9YTekRjpTj+tg4h9ZrRc/ijlYqFIaf+TPFz9Qdf
    Y6FlIMEVibicJ7YrQhvPMHdsPem32jaT0sNqWRuTtmsInJSE/FcBWVh+cyHLH9PC
    IhZDGvlym5h0oHYTTXGWCuBAih3OTKkqiclySGT6OH1/H3mKbF2dJvvZhMVHEVlL
    3NSwsZlFKeYEbc5MvR+/rg8SHuk6yNZjPS6qYhzC/4hZTcBC3KThloywYftmp9j+
    h6L+qi08RVBbMcNVrm8mnkK+1AqQ1imNRFzY555Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMFEu9IjMVzbrG4IGX0jispILibiABKpXPaEBKPTHdBMy1XI/upC0xlTqXMB2tDCvZ9iJ4BM/Sh6Pn/9OehKWs3NAVcecXGo4NooG7MaOud5QXFnQQer
    /b759RahtxLlsL4WqqFKtsobW4kih18g0LmCsaASnpC7EiTNKq5+1H/JULmKVg1/XWNCfFdMzAKeS8yFCk3eSpx9hDCPY6UdI6ZOICN+re8283AmjVpPCU5h
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=0NYMQCpvxrS267GqGYoA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeDFSab (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:30:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:26196 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeDFSaa (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611430"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bp@suse.de, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 00/12] Series to update microcode loading.
Date: Fri,  6 Apr 2018 11:30:14 -0700
Message-Id: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg

Here is a series that addresses microcode loading stability issues post
Spectre. All of them are simply cherry-picked and the patches themselves
have the upstream commit ID's. 

I checked this for Intel platforms and thanks to Boris for checking
on AMD platforms. 

I'm still working on a 4.9 backport, will send those once i get them to 
work. stop_machine differences seem big enough that i might choose a 
different approach for the 4.9 backport.

Cheers,
Ashok

Ashok Raj (4):
  x86/microcode/intel: Check microcode revision before updating sibling
    threads
  x86/microcode/intel: Writeback and invalidate caches before updating
    microcode
  x86/microcode: Do not upload microcode if CPUs are offline
  x86/microcode: Synchronize late microcode loading

Borislav Petkov (8):
  x86/microcode: Propagate return value from updating functions
  x86/CPU: Add a microcode loader callback
  x86/CPU: Check CPU feature bits after microcode upgrade
  x86/microcode: Get rid of struct apply_microcode_ctx
  x86/microcode/intel: Look into the patch cache first
  x86/microcode: Request microcode on the BSP
  x86/microcode: Attempt late loading only when new microcode is present
  x86/microcode: Fix CPU synchronization routine

 arch/x86/include/asm/microcode.h      |  10 +-
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/kernel/cpu/common.c          |  30 ++++++
 arch/x86/kernel/cpu/microcode/amd.c   |  44 +++++----
 arch/x86/kernel/cpu/microcode/core.c  | 181 ++++++++++++++++++++++++++--------
 arch/x86/kernel/cpu/microcode/intel.c |  62 +++++++++---
 6 files changed, 252 insertions(+), 76 deletions(-)

-- 
2.7.4
