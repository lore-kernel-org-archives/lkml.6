Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720273-2-4604954846694627485
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
    t=1518720273; b=G0hq06ek8Ur/GWGuMYBMGV4u8mWCqVyDjCYvhY4jtzw1+/A
    9DMzEVETEuAtXYxHx9Dj9A9dMXVkwVlCvNwjqAI+hCodXhdruwzNe7OIhmVQCX4Z
    B73qZWdzsPPL8TcveKb1D+y6Ghq2prrWUxx5mw2wObbn0R/Hle3XimAuNRtNRyZH
    AtT6fWdEx9Fqb6ucPrK7P/LYU0Fn2THcbFDXISXSSMnyaXnpc7Ybk36MmgeHH2IX
    VQajGQPv+fqeOQkobxh0xKgWmHtUZuBwXVOAINnc24XJhRtGgPNz0PQweIsTe5Pt
    YRQHo0h/EiFUZcCOp3QxtH6nN/sBoOpuL+sJ0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720273; bh=A5BBLVF+Vc9hZxPJA9CTh0egou
    pCU5gU9pLpegXf44M=; b=AGP1AMxzjTlldWGvweaBD6tpmi51bHifLScDgQj6co
    wqhZ+HkYtnFcpxf6iTq4QyoXF0qkvlTNnAWRBUYJRaMITsCxeWogMHRbsU5FyFah
    Fwc9CPOxcnc9KLm7bC05RqSezSkOC5AVoR4AKWC13bUas8Egqa627sELRaySYYyh
    N4rnLHCrIuog81rM1qSVUlEjJH1gOWdtZXilg5vRkCB9ZVJGpy5L6G0ZQBpu3lkp
    6tVntSc1QdWC3l7l63AaI8WNN+I979R41IdIq+51MAhrMZ2YVuXy9aekPEFi9qPA
    lbM2KScVjB4x22ozD7hpBLb9H267gxPrGZ2YeC2C9btw==
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
        id S1166713AbeBOSoU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:44:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162580AbeBOPXM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 017/108] ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Thu, 15 Feb 2018 16:16:14 +0100
Message-Id: <20180215151224.976749285@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 0cab20cec0b663b7be8e2be5998d5a4113647f86 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/pcm512x-spi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -70,3 +70,7 @@ static struct spi_driver pcm512x_spi_dri
 };
 
 module_spi_driver(pcm512x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC PCM512x codec driver - SPI");
+MODULE_AUTHOR("Mark Brown <broonie@kernel.org>");
+MODULE_LICENSE("GPL v2");
