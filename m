Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938447-2-8744844746552231632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938447; b=LietUjzccKxfSPhL2ynYU9WDVxsag9CAw50PZajOa6ILcrHmVb
    zVD4e8sECndDije0fUsJ2LNq7ZifjpyNHCAZp58QFLlQOPq8a6LC2XbaovfvEkLl
    VnCtyQsMkcZKrQo8scP3uUbwRzAx/zT71p69AsBePHsEnaJ7Dzh0zQ/b3CQ3Wn5q
    TgDfLwO3oZpuLGb8y2xwIfuD5vNw9uBZBuDUEdrrbzNbmRyjH2w+HJ/YUrnPDCum
    hzAqrbaJh+HoG1gbXEpbVy7l+k1qQ3v9w+Wzg1jxK0N7pC9JzT8MYjvKz88p5l6s
    ogcouzPoUrNcKqfQRQztKJRpGHT3nXCT0y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938447; bh=PU00tKD96jNs7gCwMIiUziDmv/Ddwk
    gVfBwBN+9tmHY=; b=NTR/sqrxqid8mOX0D9Kxz6dzpvUtXeMFBFsC6slBob60/s
    UbwlwNqY7k9KF2IB/27XJZ+ozkBywKfTTRfuW3RtbU6faeAb/9q91qFoUGscQmtZ
    rbECvBUviQbVVqu93Z12Td+dKHVE7rv1dyqbsMZlg2j6zoj+HzDiq5Tv5QIu/pdY
    dHNt/YPelErzRNDmR0LfbXtjiUQhp7YqAXFhM6joHvWIAuLY1o1nO7t+g9aQI0ni
    0tsKZt2oU635YfZwFwdGg0qnOb1glVLIt8Bw1HEaah+hbSgSmhWNgWzO39hsCp6c
    Dz6exJob+Rt56WasP+dN+aLtsMQ4Y0nUVmWfsuUg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IC0vaL0R x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IC0vaL0R x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNXbFzB72KPt0/0Sh3Pr96539otOU9Km+VHXlEqZcy/VhQSeFlkoKwyPaWLJ0WAddfqRgjvPIZA+GzhpwDfY0TffciirjCjhk9JVl8xkseEdHTVDWE4+
    yYm0ahFyCLzgOq3C404xeYZ96pihzVYxmDMsiUQv78m19ymrWKqaIbRdoGI51UE0PW/K1mz0OGUG6HH7c49ZRL2JIqGbH6lfDkhO/uYEkGvO9TK80hhwiGwB
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=v6wmjGlH48GyLB6tz60A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeEUVdv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbeEUV0J (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 092/110] x86/bugs: Fix the parameters alignment and missing void
Date: Mon, 21 May 2018 23:12:29 +0200
Message-Id: <20180521210514.050089933@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit ffed645e3be0e32f8e9ab068d257aee8d0fe8eec upstream

Fixes: 7bb4d366c ("x86/bugs: Make cpu_show_common() static")
Fixes: 24f7fc83b ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -531,7 +531,7 @@ static enum ssb_mitigation __init __ssb_
 	return mode;
 }
 
-static void ssb_select_mitigation()
+static void ssb_select_mitigation(void)
 {
 	ssb_mode = __ssb_select_mitigation();
 
@@ -641,7 +641,7 @@ void x86_spec_ctrl_setup_ap(void)
 #ifdef CONFIG_SYSFS
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
-			char *buf, unsigned int bug)
+			       char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");
