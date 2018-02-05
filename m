Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855171-2-12610624531151040467
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
    t=1517855171; b=W/TmqFO9cmPDarVYdNllqCHCwZghU66aS4+2qJJqoCXuyYZ
    AOaLkSbvl4m0BF18eux1zQs7u05Q/Z1EVF0/z64q6flhKCRbybk1tXmH5gTx8TYl
    Bqi/HjBbxBC+6yYfeFqIJTSR87ZuAGGCTKFUU3FlM5F96496V50MBXnhrxbPybKI
    o0Cc7OOEi0nw2gvRhZ27oceJDBpzh73MJrSMF9Zo5dP7eeuI0/6nTVCqiORIMa9b
    lVdc8ZHB3F7ztLj8Z4cwRPv2NrHZpgHhOMVW+dq60SQVlXhNTSt/ot/4oXBXFVwc
    uQRjAuvbqAYxXh7JlNKFrikmhHUQjhyAdvruFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855171; bh=kJWLpgn1U7bvZ5sb/7fWf0XDQk
    3OlLfsrSouiuQOsOs=; b=uC7tBWXsKNEb01QxxZTsvOGy+P55XJxPno2RhCIoKz
    i0mgS+Bh3kC2BTsKrLYdY5b96etjuLUM1ipRa+SSVCm8kUnG6bbHMSWSmHd95jq9
    JKvA5jqb7gxE+eEG0FAOgcIwxLqk7N2qyTnCF6xpkNQQdo7hKuUKPecKmFdU/re6
    A0nGiHHeO3gJzMRN6hUeSn6L+xgHBFS4XTIdKWOzIBvZCGZ6Hd9DGTygQKpXaK5r
    Ktz+I9BuR6N0J6MohomE+6YVaE+b4gRPfR8N+cQBX505hhFgSdC/HqJB6BgS1WMZ
    XRjYHTrQlbvgR4xIpRBb74KJ5XJ6cGFA0flrzmHGoqXA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeBES0B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:26:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeBESZ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:25:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 18/60] auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:22:51 -0800
Message-Id: <20180205182214.672318759@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -441,3 +441,7 @@ static struct platform_driver img_ascii_
 	.remove	= img_ascii_lcd_remove,
 };
 module_platform_driver(img_ascii_lcd_driver);
+
+MODULE_DESCRIPTION("Imagination Technologies ASCII LCD Display");
+MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
+MODULE_LICENSE("GPL");
