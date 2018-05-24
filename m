Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159215-2-13848477957943360709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159214; b=m0r49BttC1z5hSd2TiroylgiFdC2KpPat+jJtos/CkUyL3kbXG
    cILYbptCwLnVBl+jw0I6X5J+ZXNM+FyqI9orlwc/pcPOjqLHoQSh8kHgMza49uMo
    2o8hdzw88CTp6uGriVPtOfzvX15KUG32WsPKa7tEVxpHxzbLgaCt01VjuebsgCht
    WQhc+AJQmG6TWIhIOOFpwMZRNgorLZpo+pKXxlEIKZS6Ow3D0zv6/we490DceqA/
    GCZI8eOwJfy/SJ2pwdXunB8aJ7sgHxO0r4uMcIGsavapBDRuKuf5Tm+RzwaYvjZw
    Y8cXkDWguoSmYwYzL6FJFZGtIYXV1IlTMnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159214; bh=FUMsyJfyY+YGgMgky/4opNbkOmfl/V
    EhUvkqGKFx9Zs=; b=CepJb2DIqM5pQR/Ojl7ANeqvXGm7ugNoxMJQIrwbIJdKvF
    B63Nl4wvZmFyBxHIDY1wFCA8Jjn1y8r4s7YHWkeUoTUhGH7mJMOfcX81neq2mlKg
    e4+NS48APn8Eow2qxQKlXEAYVUgPoA2ob8lhjWRAfOVoDFoURhS4+zfZ3dYhH2au
    CWi59ilcV/gqGbr6B+pzzdzl2zFs4MBCK+UwUq8e01K4F9KFJvuaJd9/DxF7NbL7
    YH1TVXiPqvw/2O8BI+bjWtKH/2ELhu4Mb0L40mhuYiRWYDL6r7yo/KNCSHlRLFWC
    UJtUOwIPE7cTN5Jzsl71h2x7ZhL+dBDsqHqxw7hQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Wenwfvsl x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Wenwfvsl x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfH4cCSBs6qzM1b+2rQfAGgah6oFyCOI+D2i7zd4L8AdUC0/O8s/Du+2Up/YXHpKJwglOhAFq/EOpRdFpKkrXkeCn6sBqMGjOblCET7JIG/wXwukNcD5b
    Sa3dkqamDK5Nb5ALS4aP7kuAmsVCwuiWwouQzcqbZR0x/rZY62EQA2VDzixoDspEW8LsCmp7UkMz+LeMbu0nZdhVLOIB0w3nITp8F/COt3JUiAZAQ1/rtPNm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-RuleGSg_AdYtJgukIIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030405AbeEXJ5J (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030393AbeEXJ5F (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 131/165] clk: samsung: s3c2410: Fix PLL rates
Date: Thu, 24 May 2018 11:38:57 +0200
Message-Id: <20180524093627.303040157@linuxfoundation.org>
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

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 179db533c08431f509a3823077549773d519358b ]

Rates declared in PLL rate tables should match exactly rates calculated from
the PLL coefficients. If that is not the case, rate of the PLL's child clock
might be set not as expected. For instance, if in the PLL rates table we have
a 393216000 Hz entry and the real value as returned by the PLL's recalc_rate
callback is 393216003, after setting PLL's clk rate to 393216000 clk_get_rate
will return 393216003. If we now attempt to set rate of a PLL's child divider
clock to 393216000/2 its rate will be 131072001, rather than 196608000.
That is, the divider will be set to 3 instead of 2, because 393216003/2 is
greater than 196608000.

To fix this issue declared rates are changed to exactly match rates generated
by the PLL, as calculated from the P, M, S, K coefficients.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-s3c2410.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -168,7 +168,7 @@ static struct samsung_pll_rate_table pll
 	PLL_35XX_RATE(226000000, 105, 1, 1),
 	PLL_35XX_RATE(210000000, 132, 2, 1),
 	/* 2410 common */
-	PLL_35XX_RATE(203000000, 161, 3, 1),
+	PLL_35XX_RATE(202800000, 161, 3, 1),
 	PLL_35XX_RATE(192000000, 88, 1, 1),
 	PLL_35XX_RATE(186000000, 85, 1, 1),
 	PLL_35XX_RATE(180000000, 82, 1, 1),
@@ -178,18 +178,18 @@ static struct samsung_pll_rate_table pll
 	PLL_35XX_RATE(147000000, 90, 2, 1),
 	PLL_35XX_RATE(135000000, 82, 2, 1),
 	PLL_35XX_RATE(124000000, 116, 1, 2),
-	PLL_35XX_RATE(118000000, 150, 2, 2),
+	PLL_35XX_RATE(118500000, 150, 2, 2),
 	PLL_35XX_RATE(113000000, 105, 1, 2),
-	PLL_35XX_RATE(101000000, 127, 2, 2),
+	PLL_35XX_RATE(101250000, 127, 2, 2),
 	PLL_35XX_RATE(90000000, 112, 2, 2),
-	PLL_35XX_RATE(85000000, 105, 2, 2),
+	PLL_35XX_RATE(84750000, 105, 2, 2),
 	PLL_35XX_RATE(79000000, 71, 1, 2),
-	PLL_35XX_RATE(68000000, 82, 2, 2),
-	PLL_35XX_RATE(56000000, 142, 2, 3),
+	PLL_35XX_RATE(67500000, 82, 2, 2),
+	PLL_35XX_RATE(56250000, 142, 2, 3),
 	PLL_35XX_RATE(48000000, 120, 2, 3),
-	PLL_35XX_RATE(51000000, 161, 3, 3),
+	PLL_35XX_RATE(50700000, 161, 3, 3),
 	PLL_35XX_RATE(45000000, 82, 1, 3),
-	PLL_35XX_RATE(34000000, 82, 2, 3),
+	PLL_35XX_RATE(33750000, 82, 2, 3),
 	{ /* sentinel */ },
 };
 
