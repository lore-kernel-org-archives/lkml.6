Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826441-2-5543682240504840221
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
    t=1520826440; b=uO3WUX/fOAOUwkXs6DXcOkLr0pSquuP6GV8RRO8t3I28Rj4
    FKtVdZ2IM729C1bpv4qPIKPDphi4DKNBqaCaJom66XwfPzNfIyItw7pKaU3haK4O
    vdTVP2qWUaQ5cvhgzNTcARPetEXgLMIxUwBWUsi0km/KptN3OSw0HnMISuT3ts2M
    0jufmIKMRKv0zST5vQOtI+ImnaKEUzwR8iZG8o5A9BY8gS4k05g9CtXZctX0ZZDY
    eeKYj9/v1YNpOefo9gqZxc5rXM3LT79pXnvx0DT7gTWMb9SWRzrab5dZBobORmkw
    nMnC8QJdAKdCy9uVCGGMcF+Jx/Y/ee+RoLGYf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826440; bh=Vgg4rlqQEGydT1E/MrP
    GoMPrd9LEPKQv3kTZ07K4sWs=; b=EIuWc77HJRHHrZiq0mJY/w+zZLlfGoikzgA
    CCPdIKiUIhJMkP947jsuAZk8Kix1nIyFltm1FumBbtGVT/XATuP6cEoD7j+EoXs7
    JBJKWrZ6s2iXkJi0A8aKQC1SUoSdlAxXTELPv9ei1yrZ46bXh0OV1Y8CKMsvi56D
    Ze/XzeY5D18Lssb1NtzuqxKjoPHS9bTmqnEvZ/3LphpQR06086z3fmfoG+0wMsXv
    Bayzz+9SdDnYwo+slK6u+FvPc2VYU4fUzNZD25pL2sWFX02MssFYjRud0IpgM2b+
    2r/TAQc/EVBs9iaDR+Ck3PhaOwvc6rbR1N1yMFatBUTj6Aqv4gg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932854AbeCLDqn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:46:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41131 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932635AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.243383322@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 048/104] sysfs/cpu: Fix typos in vulnerability
 documentation
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 9ecccfaa7cb5249bd31bdceb93fcf5bedb8a24d8 upstream.

Fixes: 87590ce6e ("sysfs/cpu: Add vulnerability folder")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -206,7 +206,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
-Date:		Januar 2018
+Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
 
@@ -216,4 +216,4 @@ Description:	Information about CPU vulne
 
 		"Not affected"	  CPU is not affected by the vulnerability
 		"Vulnerable"	  CPU is affected and no mitigation in effect
-		"Mitigation: $M"  CPU is affetcted and mitigation $M is in effect
+		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
