Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3113896-1524772755-2-1407970943122992443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, TVD_PH_BODY_ACCOUNTS_PRE 0.001,
  TVD_PH_BODY_META_ALL 1.799, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524772754; b=Oi+uy4xu2E39YwCe2FzhVEiiQS56ZawLMpuM8m8sWWXlqwygRu
    yVVLolovHfrHLm2vN58TbPsytDdgfHFNpot2gsbt0ndaH9IDlT5kcdhyYbFTzzHP
    EUoxoT3bKo+VTh04COgV8ONY5spt3zVN97n/fqBYyyWBeEJjsOt04MiNwUl/081u
    bhuyeJ16QtnO6uI0pA2TPrv5PiQAGF/JedlQQlIyaNaXgRsnOQTnEq18xq7Ykuit
    yz5EdOuaGt+FIDJEgcvHk2FbCyst3XWGqdOkYJS43CBkvdKyK1gAQ73kIloAUKd1
    hNFZwP6CmpHnGm6WDDxRGF6GlM57ZzZsCynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524772754; bh=YAvN9T8Tk528yA5+JExfVTTPPzz2Vj
    vRfzbqMgoB2ac=; b=K6+kQIHX705v615sEIYZGo2AVGR5Hgkdq02S/cGj1ON4O6
    4jcLIred1Msb632GEn5/+bGaxFL4QPly860I6yI+64UIjHJYNR/EhY629wWASsI8
    P3rpSExpgqtMLEQYZrW0ddKfjq26f+4swLo7iwS/3GDFmJRsQ3tQUqQJJ/5+iiT2
    Bs51+8Lh+Pb+Q0Z3YfmkXMYyp8KSnIkOVxlJFB83TIMYo+NjVKyuRNzevo06PvEa
    WBnfew0cJoS5XB1veSCCeUvV2DvXIFCk9gjLs/w65LB9MZd1kGWT1qNB5j6ZBeH4
    7CcrFAjXli34mtR07IYy0zkc3O9ZqCOeCODl+hyA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwhx8Mk6KD81syqO75GA8yK9aBx16T7bcwOhOslkD0g8GYZp4GQUU0Ki/rbQlCd9oaBhHGqNIaaE7m2qq7IHQq4Fwl08iU4PPJQp5CxwSweT20l1cHW
    cd6LngaLMSHRwihnHG3TY3EIt8B+GbdqjD4OX41fueio9hAAVfNFQxdXAYIJoK1aVsDesYpnduOTJ3dySfGlpe5yE+3laDDrTfJu/lZ9go+7Ngjho+AyPKAD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=v3UgtL88aCGILRJmFQwA:9 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDZT7N (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 15:59:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:52426 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeDZT7M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Apr 2018 15:59:12 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH manpages] clock_getres.2: document CLOCK_MONOTONIC suspend behavior
Date: Thu, 26 Apr 2018 15:44:19 -0400
Message-Id: <20180426194419.24854-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Considering that user-space expects CLOCK_MONOTONIC not to account time
during which system is suspended, explicitly document this behavior as
ABI.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: John Stultz <john.stultz@linaro.org>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
---
 man2/clock_getres.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
index 0812d159a..ca5ca87c8 100644
--- a/man2/clock_getres.2
+++ b/man2/clock_getres.2
@@ -144,7 +144,7 @@ This clock is not affected by discontinuous jumps in the system time
 (e.g., if the system administrator manually changes the clock),
 but is affected by the incremental adjustments performed by
 .BR adjtime (3)
-and NTP.
+and NTP. It does not include time during which the system is suspended.
 .TP
 .BR CLOCK_MONOTONIC_COARSE " (since Linux 2.6.32; Linux-specific)"
 .\" Added in commit da15cfdae03351c689736f8d142618592e3cebc3
-- 
2.11.0

