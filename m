Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156509-2-13291200128636304942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156508; b=dHb0OV7CyUkl50rVjAXdgVHvhrwEysd+kww0dzlTLep0JyW5lZ
    Q6gndsMj5DRRq7E13YiqAIk+LNOB0IRz/61pTE8QKzWYd8kVrYdWBeqMRAPLFiQA
    LlTaPQUKMXiMXqgJLVxchz1y1zzn5rglUBUMlv89/O5PtuboC+81Rlad/dp3E14S
    HJbb4NSZb+iPQurhWNDTBE9puRGiUmudU69zi6pukdjzGYToo5ZoYUvaxSZdeuGi
    EhY+ZI5oC4SIIGjzVENqFvAxY0sIZrvipcV5VaqHNnPk5N5gq/hqvPOogbSHHOUJ
    SlRVnesHQrGmdVMyTVpFQHQL+ZWIk0smk21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156508; bh=GDkFr7qcNeHc1QxQDAPeCKPIxqZm7O
    yD7806VUY75ME=; b=cmsDml9u6Z1jTxIbAY/ywxUzcwbajTSdGJl54mhVoH/pEJ
    VGlPOJrS7eP1ZeS6dpJvjLsMu/8V8peDyibFAX5f2foqzsQxCTIgWAMYuLLecTN7
    +avwBLCzq8GK+OpcKIeBw+oMbovQIy8kr5DT9ESTzklb5uBPcCoBjBsTTHMAMXaB
    T9HOPXgQ2kZuqPBCN2oUUljnTCe3k7F5cBHVtPfj+sXdbLmH8odoPkJw7sQ7qDrI
    JKWcd7plF8qAeIVmXHy9f7GZnRnikGeB5iWniNvC0iJnB8VynUTrsUQgnNZBddy/
    415YrYXoXjC+fRhNSyCYMvh8lfw4zPPpfG0JvKwA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=z5yHFVmV x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=z5yHFVmV x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJvzgzwpsf+7bgTzzFBZGKenmhd6nR6UhW/hoHPNjO/DbCvi47/i/0ERisGf2H9JaoFxx3j0BiOTY9PY9hQMgC9Ygm+l4bdJcmV61h0WDfDF7wWH9zf
    6nvqTZCO9bVZ9otm1kFftW28fQ4YRia9V9U3vWVzkfedNgtmijOOsT6vcG9VhE1RKRgAf/ZfcAworHnQpgOM3RDN5lSk+PTXk11OXcmEXm3npH+EXFt1BQr+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=uP1ucDPQAAAA:8 a=P-IC7800AAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=jjfiZMD5hr0tgOtWbhUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22 a=9a9ggB8z3XFZH39hjkD6:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031492AbeEXKIM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031682AbeEXKGI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 161/161] rtc: goldfish: Add missing MODULE_LICENSE
Date: Thu, 24 May 2018 11:39:46 +0200
Message-Id: <20180524093037.531987302@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 82d632b85eb89f97051530f556cb49ee1c04bde7 ]

Fix the following warning in MIPS allmodconfig by adding a
MODULE_LICENSE() at the end of rtc-goldfish.c, based on the file header
comment which says GNU General Public License version 2:

WARNING: modpost: missing MODULE_LICENSE() in drivers/rtc/rtc-goldfish.o

Fixes: f22d9cdcb5eb ("rtc: goldfish: Add RTC driver for Android emulator")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-goldfish.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -235,3 +235,5 @@ static struct platform_driver goldfish_r
 };
 
 module_platform_driver(goldfish_rtc);
+
+MODULE_LICENSE("GPL v2");
