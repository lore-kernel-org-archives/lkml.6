Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1581203-1522761500-3-6939946588980951159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522761500; b=AhgMllv5U4GxqvCk4nk5wbg7VCV45O9LstW3qmw5vnAmauF79e
    lab5NUoRvKlbg7EeHQxvynU+yC51ODIhtTWPGmyK1lMw3ux6VOOczCH8v8IzO0aq
    5i9SvaCLTEmuvPH6jJE29YDgFuJwA+lSQfHhp10nXyiN9+rfBQp65si0uynH4Ngd
    jjBBbSQiPZyds4yws0PXFibrM+gcSQEVsitsyw91TKMbX/snEk2DbMgM1KdQB8WG
    xf7o+/hnLvXd9/EA9kT5DjwhuQ0TlRbE0SjWopwtp58Cpvn9AlKUHp6fcOH+u7dt
    psptQXh161Re40l7c64CDEX+QZOy5fq5h3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522761500; bh=x+0KlvRhj3pzKr2vDJUdJh58OY7isq
    t8gKw7dSvNlpk=; b=NjliBzUieHNxjMQ7t9Ywzjs6oxKAO538fUNrxg5u5aL/v4
    IV/vcYrCSIfuu20hK0Jl88UHazr3LlehiCMHYygMp4ZF1bouB/MzOdqiiL0Zzynu
    vuWZKSm0jhcC+3gk1+MUmzBCoGu6CJkhNdA9quI73me6BRhglfpXnaduKHJDiUp0
    tTDbHko4JS4vy7VrvDfM1F4rVptfo4u3N1VsrBzHTSt5aHjxfHACuWwlItfndCK7
    jyEy2tzu6qsjfPrSyNfiH+4mkMabZOWqk5i83cUFg/OsIJM7DsQevUbh6pM6rAuZ
    j/h+oklV/EVKIYLQZY+fsRCw2MSA9Yk5qD0+8RrQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=163.com header.i=@163.com header.b=FAgzILla x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=s110527;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=163.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=163.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=163.com header.i=@163.com header.b=FAgzILla x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=s110527;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=163.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=163.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDpyzyeM4S34pv/V/v7CFlsvVkmOzpPHjGeikopxypusOHnUgZrgubQfUdNF5uW0qGncciGxR4dDQiUwLkX3ysT/L4+3e0RzZl3nfu7oHhMaQ0oBr+ML
    WpGOJSRLYtRCZT0QKIa6tjUXKx36ZtjhSLF41jQOdhNFQu5Yetzf87SexBN3hiaoj06VaG3JyqjXNl5KOZ4AVXm6b18Fc5avdKsWVEVE2SFHbS+pv1SSkhQY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q2uQqsSm_kQA:10 a=x7bEGLp0ZPQA:10
    a=DkO5AxQyKTsA:10 a=Kd1tUaAdevIA:10 a=dZbOZ2KzAAAA:8 a=jOMowyQMv3pyrqMPvo8A:9
    a=KMTR2xLX7hPRLViO:21 a=kiBWNWRWcjAsQYcB:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeDCNSR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 09:18:17 -0400
Received: from m12-17.163.com ([220.181.12.17]:55740 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932151AbeDCNSR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 3 Apr 2018 09:18:17 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: Xidong Wang <wangxidong_97@163.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Xidong Wang <2711406067@qq.com>
Subject: [PATCH 1/1] taging: fbtft: fix memory leak
Date: Tue,  3 Apr 2018 21:14:28 +0800
Message-Id: <1522761268-7176-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowADHZovnfsNa2UPmBw--.43186S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UJr18Zr48Aw1UJFWkWFg_yoWkArb_W3
        9293srJrW0kr1xtr18CF9xZFyIgr1fAr4vkasxta9xJa9xWa1rJ3y8Xwn8tw4jqa17Za48
        CrZ5Jr4aqw10gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5uwZ7UUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/xtbBFQMd81Xla+EBZQAAsm
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xidong Wang <2711406067@qq.com>

In function fbtft_framebuffer_alloc(), the memory allocated by
framebuffer_alloc() is not released on the error path that txbuflen > 0
and txbuf, which holds the return value of devm_kzalloc(), is NULL.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <2711406067@qq.com>
---
 drivers/staging/fbtft/fbtft-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 0e36b66..169e9dc 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -819,7 +819,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par,
 			par->gamma.curves, gamma, strlen(gamma)))
-			goto alloc_fail;
+			goto err_info;
 	}
 
 	/* Transmit buffer */
@@ -872,6 +872,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+err_info:
+	framebuffer_release(info);
+
 alloc_fail:
 	vfree(vmem);
 
-- 
2.7.4
