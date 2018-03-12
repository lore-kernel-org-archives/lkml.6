Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520825702-2-10953165602393410911
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825701; b=JYjnQOBpwb0OMc6rsE3iF5r4IX+DS1Zqmg1udtqxiOG8CU1
    7svVXMiGBaO453dW1Fk9JMKswO9gjIzNF4jS/RyFdAQz0/riBv72jQxNK8RKpmgz
    ZRvCjVR9bEsYhicWIeThxv2YO1M5B4Yt21a/G0PsQaX6vov21zFRVDrVm9mnKEuA
    SRZ7yHDOr/OL9m6n9P1JQRs125TEfBPCM0uHK4WwbMpUT6pcN0cCGIb+Q7CbX7Kz
    M5AjZrsutLkYnvApcPKnI7r938L1b0hn+Aoodi6c5huUKTyUib9oETzyABZzGbbT
    rV94uuNoVvDlOE909jpyC2jASbbEnOxBs9NqjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825701; bh=KM1R+fm4QBvcADFHIwp
    5BfMogm+MzQFLwaXdp864wGk=; b=e8ZHvy9qo8icAKEwZroMaiDzim2feOiRvvw
    ThVdK0u6Ie3d3BCuu2LuEqu/0U85THRkFXDPeYJd1YSVvuMkvW2qbz4AvM0mFQbC
    w5JWT5VUXXeU6oYd/W9K5n6xzhSQDwpmNsQV9l4ZKB6WGaAU3ktyQmfP5+zgC87w
    l/1tdS86MOG7F6aTPHUTLkRhuSEHTa9rLc3YSlRmW03lm+T7DtpGzoyRcCpaPNoz
    vLRR2/O/vKq2TvZf34dGUMmBwpYUhTn/gTIBrhqjYUjWYG1V5VcMNgRPGIij28FF
    2L1jguujM8mzI/7hj+HUi5b02GeQfdkXtESvVV+gcNlo2xEcVOA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933495AbeCLDeS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:34:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42910 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932710AbeCLDeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:34:17 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "zhenwei.pi" <zhenwei.pi@youruncloud.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.792886866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 38/76] x86/pti: Document fix wrong index
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "zhenwei.pi" <zhenwei.pi@youruncloud.com>

commit 98f0fceec7f84d80bc053e49e596088573086421 upstream.

In section <2. Runtime Cost>, fix wrong index.

Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Link: https://lkml.kernel.org/r/1516237492-27739-1-git-send-email-zhenwei.pi@youruncloud.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/x86/pti.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.txt
@@ -78,7 +78,7 @@ this protection comes at a cost:
      non-PTI SYSCALL entry code, so requires mapping fewer
      things into the userspace page tables.  The downside is
      that stacks must be switched at entry time.
-  d. Global pages are disabled for all kernel structures not
+  c. Global pages are disabled for all kernel structures not
      mapped into both kernel and userspace page tables.  This
      feature of the MMU allows different processes to share TLB
      entries mapping the kernel.  Losing the feature means more
