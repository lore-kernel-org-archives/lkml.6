Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826445-2-2706569977321964323
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
    t=1520826445; b=GO4SXj7qVYXR5cKYADlj6Et/h2+qMj/exXxcfPBzrsF063f
    7S6Jm4pJFtDmWKuv9ZZNd9lwJyeZtvCaI6uo1TGQdcKwXy/qwTGgkWCWT2lTNwAY
    UTMRti97GEMsLzr9uHMKh0/WLpZ8+DdU1rNrz170OX3oLnB7uXeqSlZUpZ5VFbul
    6hMSHk/5cyjxUZ0GV6Ei6oKo8ebbeFK50shi8UWc9zrMU1jMx2MHUEZwzGiaa/wz
    F1RSgOPM4is9LglRHxiOA/JIZKHBO3K1H3VIj/v+qkApduFzOdrGA910JybhBu7d
    3l6Wusq+Qp+8sWK8Brq9ld/6EQvMmLcq0k3ROVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826445; bh=gfXAZ5PYmrL2VEBVck9
    JSBiAHoOPmt2s6lXDorR9mcs=; b=qBjzmZNgX8IPbZyL0tUQ+3pMQqb/cn7AGzi
    YtEMbwkqu+wCGae/umhrFIZNLb4Aofv6c+YAsIRvuwK2Sm54BNs+BURox67maaFD
    ASxFAqncDtO7Yb9or/9AHie2su58gy87ri+HtqZyhkQHcwds57t5N+wvZ6Ns3BtV
    cn2tXIOEUWdkk0EkeIggruMx6oqKgKwRlTjV7SdKsIv0BXITma+kO9XKolNcBf7Y
    qnTsBUsUgIkRfHYLzAveg918hl/Nl6A1/SeXUg3PlSfOfNXsTpah1anGlaJyX+If
    oMFIn3uc3vqE6jL9nqfGWdmpPRzqiScVFK/RiQSIcBQZ7sSDEEQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeCLDqm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:46:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41084 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932618AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jesper Nilsson" <jesper.nilsson@axis.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.116991696@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 104/104] cris: Remove old legacy "-traditional" flag
 from arch-v10/lib/Makefile
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

From: Paul Gortmaker <paul.gortmaker@windriver.com>

commit 7b91747d42a1012e3781dd09fa638d113809e3fd upstream.

Most of these have been purged years ago.  This one silently lived
on until commit 69349c2dc01c489eccaa4c472542c08e370c6d7e

    "kconfig: fix IS_ENABLED to not require all options to be defined"

In the above, we use some macro trickery to create a conditional that
is valid in CPP and in C usage.  However that trickery doesn't sit
well if you have the legacy "-traditional" flag enabled.  You'll get:

  AS      arch/cris/arch-v10/lib/checksum.o
In file included from <command-line>:4:0:
include/linux/kconfig.h:23:0: error: syntax error in macro parameter list
make[2]: *** [arch/cris/arch-v10/lib/checksum.o] Error 1

Everything builds fine w/o "-traditional" so simply drop it from this
location as well.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/cris/arch-v10/lib/Makefile | 3 ---
 1 file changed, 3 deletions(-)

--- a/arch/cris/arch-v10/lib/Makefile
+++ b/arch/cris/arch-v10/lib/Makefile
@@ -2,8 +2,5 @@
 # Makefile for Etrax-specific library files..
 #
 
-
-EXTRA_AFLAGS := -traditional
-
 lib-y  = checksum.o checksumcopy.o string.o usercopy.o memset.o csumcpfruser.o
 
