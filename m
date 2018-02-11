Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326214-2-9398907032390108680
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
    t=1518326213; b=UibSTthIn8DdNbDTot+dmfdKVelqXu50k48JVYCJumxXqhG
    zlSqveVCUC4LRuMu1g7rqZOheUQC8mhcjQcRw47sJhFRFmQCM0nQk8UKLuWN0VYa
    nRzP7X8d6aGMYq/3nW4xScCayGrtpVRszz1mwv3GfF7PSNYRX8rKEEUNXHjeID8B
    +GvNjEPQ2QayUU5NLzFGxND+AmEhwoLVp1tA4jq68FMu8tUmqsvplsxtdDsRWOld
    eFVz5tBKVEB6ExCzz8aLDKOQNquUZknFndvZuHzMBF9fgjCIkQzfce2QuF7gAOgu
    mshrFJaiv2BZYGwNyE16ZE4zEt7jPg/oVDjMSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326213; bh=23IuacyE36IKhSjZ6bl
    bAIF4COFxBgZLsP4HVh3rmrI=; b=HU8ZEdbxO3zC64rD8K76yF3M96HVU82pis6
    8vi9aPrBKww7Oi4oZ2aJ8f8/NyyDsVEhL30dfDE2xs3EILyVisqTIn6yikYaQ33U
    Pwf0TROU27QJeK+v/gjeAuQZwDBHBvJ0VOGnIuBfz+7X6iRjveJNuIihQVU+Ctwb
    cv0EZx1sUMH9fzMsw+BK/3rm8+kJGqXhcaa7Px4wlNOnePb76nbGVvBKG3xPV9Wz
    weaDSIg1klC/DgQmfn+0OcyCZQpaq0+Yrg5b9BKlh86tNDIvS0yxdNMhKofhzESZ
    rAUnigU62GhkZT3hVClum3O6pmv6N7jNrb1dzMhbP/vBjYm0sFw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeBKEdl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:33:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41322 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752436AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sean Young" <sean@mess.org>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.549326819@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 07/79] media: rc: check for integer overflow
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

commit 3e45067f94bbd61dec0619b1c32744eb0de480c8 upstream.

The ioctl LIRC_SET_REC_TIMEOUT would set a timeout of 704ns if called
with a timeout of 4294968us.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Backported to 3.2: open-code U32_MAX]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/rc/ir-lirc-codec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/media/rc/ir-lirc-codec.c
+++ b/drivers/media/rc/ir-lirc-codec.c
@@ -255,11 +255,14 @@ static long ir_lirc_ioctl(struct file *f
 		if (!dev->max_timeout)
 			return -ENOSYS;
 
+		/* Check for multiply overflow */
+		if (val > (u32)(-1) / 1000)
+			return -EINVAL;
+
 		tmp = val * 1000;
 
-		if (tmp < dev->min_timeout ||
-		    tmp > dev->max_timeout)
-				return -EINVAL;
+		if (tmp < dev->min_timeout || tmp > dev->max_timeout)
+			return -EINVAL;
 
 		dev->timeout = tmp;
 		break;
