Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185276-2-5059075305206222839
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
    t=1518185276; b=h9WQrKSJcZerXmGbFQLGCDF+Bssup+aqZqHksK6bAaRsMMg
    TBJ9aALry1Ae26cvENU1IPsfp2cZ/5SYvmNzjysq0g1GPoOO2y895byEDeq+Ddfl
    gnmAGXhh1ddJ1N2Fcz+iqiJj5pmkmacH2kZ1STqf2XzglTltgIwXZF9X2ivaRzOL
    3xuqSaOKnG7POoKNCt4HvkYwRCEPctVCKnjR8nLN7LKwEhZInRaIOl+EOj4ND1/X
    LEo8X1QVWkRBRazj+zabp/VhRztum2//hJ9TABMBLOYe34ns+kTFe3p3rmB7XjRU
    S43/OTNA9Iqtqn97sHWiQcLw+9arAXyR8yk0Y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185276; bh=P0uTFN9SQ9mRer4suSe/aBxZ9c
    vH9s14itO79fI9R5c=; b=Le51+OjlX0drqYX9MtdjfZV2AxiFRNT1EJB220Im4m
    3Jt/b0kc7fk8x1NSh7n/a/9+MAY6wIGMv5UE7BI4FfQNnQrI7cXqB4WcO2918Hno
    +Ua4jmxj2KowLqflgG3k9RXipakFN/QAp324ecy72gyA/noCvxmAElf1ACJDnH55
    ih3z9X0FwEtjqWf8aNBTyNIr1aaTJ1izJKSm7vnU2cFOdx0d9ePFa796C3Ycfy1J
    LAlGVpjNWDZH2COcAZFmNjKnW+2EmYDRAaw2yY+jhe6v87TEh2Z19UD0Du0Zc+kP
    tqv0yJhI5oZ+ILbtAqL3jbVT4El1ZhEcslqBEwdF/qIg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeBINmf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeBINm2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 14/92] ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  9 Feb 2018 14:38:43 +0100
Message-Id: <20180209133932.303856473@linuxfoundation.org>
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
