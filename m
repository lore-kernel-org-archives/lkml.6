Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406865-2-14580330291987306563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406865; b=xDomOVPLHlcfkWrDFZ8zjtqkrRDNjsdrKkHWwBNoz4JDfspQwt
    7s7KAif6BV4P+h/RCaMaa0zJ6ea41kUbQh/LlLYdNy6uwrRo8REo0A6GRsvkMJgo
    nAWD2xAO28XSceJ7JCDTTDMsOGG2hFkJRXeuNx6Z04pGjiL6kI6ea1CZmnD5VTpw
    e2olCa5c0NbiVffgsH+ohUIf7ZR47Fq4wrKk94LEmr6FDXRBi7NuZAF21H1xf3nG
    tSqIatjHX9sLHtyAt6F1FbVx903XQpfLoFY4onkqZ3nwCxJb5kQiHHzJoS8JB7nV
    ToRrFZCJU2LLb4i7xdJqaAmJS10cSzjLUYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406865; bh=MFAn0M0UZlmNY6ZV1RcOk4QZpy9Kbf
    R1ATWnCXBiRVI=; b=t5fji7MvZyod/y0VhqhlL9fJeShwfaDF1OhCu/fRCX6026
    cpVFQ/EA8iQ8LEnBe5ctInftqqFXe9EsEy5L78qiQ91k93OhGVa6rY2/5XYg+1eD
    mClZmAItpXlHnLmm5o0XjTReHKwmvfMlA1mBuOBsgUZ+tm8XM+9F6ms9KexzP50n
    CdLlOysUKzI1MCYfuLGkgOfBiwz9XMJ3Ick+OijHmiwF+E1E8CgiX7YkkX8mNjL1
    3vylCZqCye7zX8cwjpAc7Ht7EOYVtoEcuo17AkB7FQB/gRZoTInbWT7+qC8wH+g/
    bFFO0Vzf7BhmQDDhoZtds+dPOnOPmlq3wENLkXPg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH4Gtc1XLU3VGoKpCCJDv6Nrlb5hsGb5J7PavWCtUv+7szmea9A4c5DqaTwZL5+gbDrwZ4tmCc6L+yDXgruIJLqBLMewDYRDpwxkN3UPPb9RrgWI6+EG
    yyBkVlcZ9zhDY8fAz618mX1TFzjlBHcZHU1VQc3bJynK4ATt8Dkq5dbPJ6HVgNYzGxUmf4Z01IYAfjMUl6Ool+lxVwqJx/2bK6EGMUmXLx54AFP0NTEKDHAp
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=0kvPPiCzGbLKPBPm_VkA:9 a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbeDVOVB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:21:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbeDVOU4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:20:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Pylypiv <igor.pylypiv@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 3.18 30/52] watchdog: f71808e_wdt: Fix WD_EN register read
Date: Sun, 22 Apr 2018 15:54:03 +0200
Message-Id: <20180422135316.840012565@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Pylypiv <igor.pylypiv@gmail.com>

commit 977f6f68331f94bb72ad84ee96b7b87ce737d89d upstream.

F71808FG_FLAG_WD_EN defines bit position, not a bitmask

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/f71808e_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -450,7 +450,7 @@ static bool watchdog_is_running(void)
 
 	is_running = (superio_inb(watchdog.sioaddr, SIO_REG_ENABLE) & BIT(0))
 		&& (superio_inb(watchdog.sioaddr, F71808FG_REG_WDT_CONF)
-			& F71808FG_FLAG_WD_EN);
+			& BIT(F71808FG_FLAG_WD_EN));
 
 	superio_exit(watchdog.sioaddr);
 
