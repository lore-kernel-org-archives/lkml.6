Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158534-2-9410909779729227428
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
    1527158533; b=Ws6kiCHBislunrEtRaBIW3vZ1iWj75alTvQkA3RL4DFYgGpvMx
    L2gUN3CAHDNeuKMa6kGjnxcej47x2U+4As4r6dMaL0bmeLq2ygFkFEYi6WeBcP+s
    oLyL+jiJEuJSrFvt+4JXQ44h+koaeGFYL7CDW5EfoCY8Q3ddOnl8B8ngRK7U5U7i
    k6BlT5CC9BSqZHJo4xvnSQaxwjFKvUGzzL9ROsEd/fPJ8BF/1TLBmGnr2QBnmd1+
    BcSBrERcMwQSzvoEGjU/LvsOexgH7lzGE+uTd2cFJqzI4kR5Bcyvoqhv8E0sjR73
    NaDYkAoUGQMD78pOkyJ4doqngMMDf7hiJcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158533; bh=M+xCG8pwq8EbLAKkEXBaLhe+lJ5A4c
    EM9KXWOE/iZwA=; b=Ki91MGc+TUJBJt4IY3fhD1DHIKGtnxZyA1jeVBryAqbg29
    RtGOmoJNcLbqZpKpbm4SxfJ06aS/+XaS6h2yMt5FN/zOKE1l8g6+/PUkGMrvFmRs
    okPIbvkYnUxfSRgxA3w2O8Dhi7iQ5L4R1m4oajnXnobbl2LNNH+iRl0Fl23tYx00
    Fw8q80BqCM1gpKGJAuPcKgj9Y/eQx/AOjY2r7lMLG5Dbp6LuspP8MBFqYG3jscv8
    Ns7mWGUbEeadB8ce1pI1RDMWvhOn2J6hq62bL9L2fV5VS0Mm/xR/5QNDPpT7XoN6
    m8S6W0ylLZSaqWrCBsXjT9cE8qCsXYsXanvKIxhQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=z0nIzYJY x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=z0nIzYJY x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMvXOC25/RhLzCXhGU7RypZvZh8Vh0NCFDgkFwLBdoSoWLAzj+t0Q93k+b+w++byjpD2ExlI5TshjgU2qqG5GABOeirB4v/DeEG/exXS15sza4aa718G
    I8i7JSqBkOJvOHUG718L6ZKWTc0zDHbrA/V5ManNxT2+ABsp+bM0yysvwslbOM1DO1YtzFPMEs92ByyozVAVTGheI4/zanJW9RnnM9ftkU/qtGcwUtp+36sf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=uP1ucDPQAAAA:8 a=P-IC7800AAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=jjfiZMD5hr0tgOtWbhUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22 a=9a9ggB8z3XFZH39hjkD6:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030812AbeEXKmA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030648AbeEXJ6j (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:39 -0400
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
Subject: [PATCH 4.14 165/165] rtc: goldfish: Add missing MODULE_LICENSE
Date: Thu, 24 May 2018 11:39:31 +0200
Message-Id: <20180524093628.757071922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
