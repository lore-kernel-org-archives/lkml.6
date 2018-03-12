Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824114-2-15011037352797304960
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
    t=1520824113; b=pouxckK+QKMnrgx9xg8ngwHNleVx6H4GgnqFwCNUaUA+5w7
    jCbw9Rr+p2XJnxzLsdYjhX1qwwjHskLb/htD8cmGgoOXpwKGn2FW7tk/KZ6t4fzr
    Q+PsQD2McRY4U3F1ce5IV78TdsY/ggnUSx6xaC7rJZ9KFTtqJ1jcVzOkcixtqPog
    9br7Z9RmHMflDSdSglpwOh3a0MnMuLHoua9hyGc74vbsHDXWFrOnPvR0Q5PF4XWj
    9I/3A6BBgsP1nM68kgBnIG2c4JvT9jIfTA9hh+hRvTnefWFfjocc/VJFyU2RpMf8
    lhSAb2ust+ri9zFhmWcu59rS391qaE72YZ7vGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824113; bh=O07N5fYf6deJGjSDcMe
    6+GUS5OmV8/zk+K/Leuh8/UQ=; b=nh6wWYqdvClTVjmVWSz/ZGz54VPOI+UANsn
    iIB9KbYHs+QBpcVoCigZUsXwKlQm2dRvP7OjQ3pCiOD2Ymxq0Ad+qySdRMsRWyBT
    kQYqMHsTd3dRsdgghLw1/MQchBfglM+FqMvacV6ibAnErd6FPimQV7Pk5D5VnQT3
    i3C7w+0+TruCztboJ81j0XwA0MaqwCMEFDPZKW085EnJsk6+gkkCG5ZITn5xPj1N
    ymNzBG9MI0+6fLc+vjM9KV6W0l3W1IcL7UNA2xDM7PmYeceLGBjuvtIt3ZOk4YKQ
    laCCJKqwdq4UXIUg1Catr9D/q9tI3pDax2RwSAo9VXnYLMRmKJw==
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
        id S932837AbeCLDIE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:08:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41514 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932780AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.742604983@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 12/76] sysfs/cpu: Fix typos in vulnerability
 documentation
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
@@ -229,7 +229,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
-Date:		Januar 2018
+Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
 
@@ -239,4 +239,4 @@ Description:	Information about CPU vulne
 
 		"Not affected"	  CPU is not affected by the vulnerability
 		"Vulnerable"	  CPU is affected and no mitigation in effect
-		"Mitigation: $M"  CPU is affetcted and mitigation $M is in effect
+		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
