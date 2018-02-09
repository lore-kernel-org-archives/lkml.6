Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185522-2-12677279916368706190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185521; b=doPUgCqwAgcKwkPJzgg6tTwPVQq9eUS7NSCCpmfT52KK7jh
    htj0BRd40X7UjTdKeWHJz5hU4x6IsoQxk4BG1A5Gp6SEwH44gx12pHBF7AayoDrk
    8OMGgb3QBfIbBMik1DAm+lRcMyEyslPL0jJZdjmBqMOqQeH+NKBhhwnXckzj7zaA
    p4n1WAQAxmu15SmN3vxn3ppgLxZ0IcE4B9falQiEGmNI/gACsw5ZtXuhyfmeadgB
    7qglM5XDNyN6o4UX6SUaheoAgjlAhIXH9JUQWX3xwH/tte5WYYTdNaye81cpSETs
    aMw5uIbZzxiT1RFGi9y8YxclLoWwqAWOG+f2sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185521; bh=g2xOzO0PVRl1TkRKcP18a08df3
    fdNCwKz3u+kdp3SYo=; b=uIgn463OiCNA+kzY0NFsVjeCtAcwKShsO3VYc9/rfn
    AXpmLvO1iJf8gPeATXbgdBdq8u0HOTAScm4xf/E/jZKsgS3RkB/HLG5lHZoUWQKH
    X/xqErFL1fmWvECm3UiAKKuYFIOYaG4Bylskowt/T0LhTO2S+YUCvj+T/0JAlSAa
    Lmdk7oxUWgNFaOMqqM13PLSyY5YniVfHaTH2TQm9ZDYs851GAMuz3Y57+OOdLBaY
    4naX0iF4aPq7s8UXUHwtFdL4ZpYiKVoSyzZGhArMumZyTuKrGCXhwu7iwyLYIDAm
    lg8H3+vW7UN9JV4ZnqAxxvq5kChYZ2AT0l7RvimCnZfQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeBIOLb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:11:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeBINmC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 12/92] auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  9 Feb 2018 14:38:41 +0100
Message-Id: <20180209133932.175396296@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 09c479f7f1fbfaf848e5813996793966cd50be81 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
see include/linux/module.h for more information

This adds the license as "GPL", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/auxdisplay/img-ascii-lcd.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -442,3 +442,7 @@ static struct platform_driver img_ascii_
 	.remove	= img_ascii_lcd_remove,
 };
 module_platform_driver(img_ascii_lcd_driver);
+
+MODULE_DESCRIPTION("Imagination Technologies ASCII LCD Display");
+MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
+MODULE_LICENSE("GPL");
