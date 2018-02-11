Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324476-2-7831207457478860315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324475; b=Ka1XtMVuVz+tlqmeBfP4i5D95dfd/wFx2w01sY6S1wDk78o
    XHBIbvyLmzRpWfNr4wRWeF57UFdD2mkf/h9iXxEc9HONUZvD6yUe7YE3uxE3zcS9
    Mlt1tVmxnG9sPs744JxZDwwCYxOoUGwOzKkTP0GLzW4qKSljE97v31ljfiHk/7CN
    PdnMZcI01bwDzzRSW4He5OVj4YSSKoB+dGq8AsUofNeYaMtT8CoIffL3Wi4zK8NO
    hcDNR1OvZKcavc+krhnu5p7EaWB00z8p09dVnQR6sgskIucT4m5vO1qR8U+wXSaK
    eg4ZLPVpbmBFHN2ZVLXYpOnGgy18pb4sS0Q+g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324475; bh=0ZIH2tzpwhwRS9YIvH0
    YCmMDnmFoHhnBmW3Uf3lEeMU=; b=TOTy7OhPfmQ9lQ4W1yM6EilydpLOEa6pZzd
    HvNp7oVo89InSSbWPObdGJNp+wXihtgg5FqBMPGZY47oHLbnWLHN0T73S6TztvXX
    P5AT7pBeRqa9/riWUscaWgSUioXdOipUf3EavZ2a/Qfc6QxCtPd6z9s6pLW5ldav
    kg50MAfD2TQl2BQrqwqXN4y43ADynMOYROHOChSzwyXO9kISXgX9gDOMmoyw3QsE
    MrW8ikTBk0bbK/GwQHNE+fEk0EIhTGN750pWFfR8UGUYIt1mb7vAD0m4sUDP3kn5
    ULRPRMgt8p0ZG67Igs48tlkUwmhZ9eHnP+x9YXTcTCwl3MJ8znQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeBKEru (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41815 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752839AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Joshua Watt" <JPEWhacker@gmail.com>,
        "Joshua Watt" <jpewhacker@gmail.com>,
        "Anna Schumaker" <Anna.Schumaker@Netapp.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.194051607@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 093/136] NFS: Fix typo in nomigration mount option
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Watt <jpewhacker@gmail.com>

commit f02fee227e5f21981152850744a6084ff3fa94ee upstream.

The option was incorrectly masking off all other options.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1319,7 +1319,7 @@ static int nfs_parse_mount_options(char
 			mnt->options |= NFS_OPTION_MIGRATION;
 			break;
 		case Opt_nomigration:
-			mnt->options &= NFS_OPTION_MIGRATION;
+			mnt->options &= ~NFS_OPTION_MIGRATION;
 			break;
 
 		/*
