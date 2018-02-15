Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709629-2-9211412713001462536
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
    t=1518709629; b=aklPZGCtWny/i7/+nFyx25dKjj3Yx3NxaLE5IG2D4sKlnjz
    tVBWHxGQ0+3JUTS1PsiFmHsVGM+ljLPn4hAz70bPC2jc8K7v9V9GK5phcToM3paL
    h+9hgxETmxjdiv/WMgHBA8XujfsYPGV7m7rYpaDL3W8ksTwxKN2yC92jpSN8rpX9
    vdZppr86XsCezptjOxlMckbG5K+DNg1RFcWixiSWlgf7H0bLmmGKxCVFjFvDYIpL
    25MozhLdVnjG3JAEjebkNfB3l8CCeg3CYHVEl0G5AAlgAi2BVFgg5RPvGvv4xLuT
    dGSS+sBqPVaYbYl9y9/n9uCadUhoL05ihrsoA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709629; bh=Od+v9tEeTBHG4b3iqwcLZmZvlc
    hG/t/4B3SQI8sjGxw=; b=OQKCnO0T8npl3uoKvnzc3wPt4rHrf7860OZPx3p8A4
    mrYR9PopLLq6zCP/FSTyUbUcmOFa2NCp6jp98GU8FAVRYWFhiM2fu1bRag580MAa
    2gNOJU16ML3GWqqwBoP7CsqAfHNsRmD179RmbrLCAtR6T/GGQh9npZZld83lr11C
    9zCcga6n49hm1EA1yEkb7Y3eqw8KpQj/yiBm8Lr/y2FdoeJw9Y2Axf3eMcBdRoyT
    qYr42/TaQebGLmbHpnj8vTC2aNJV9gBD4N8PcKQJWhIAOANQzFuorPzVRR8KZkRo
    zqFJXlgkDNAFLAjMfihS4BmTINpIlsscps+9oLaRCB4g==
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
        id S1424820AbeBOPrF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424796AbeBOPrE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 184/202] clocksource/drivers/stm32: Fix kernel panic with multiple timers
Date: Thu, 15 Feb 2018 16:18:04 +0100
Message-Id: <20180215151722.461571222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit e0aeca3d8cbaea514eb98df1149faa918f9ec42d upstream.

The current code hides a couple of bugs:

 - The global variable 'clock_event_ddata' is overwritten each time the
   init function is invoked.

This is fixed with a kmemdup() instead of assigning the global variable. That
prevents a memory corruption when several timers are defined in the DT.

 - The clockevent's event_handler is NULL if the time framework does
   not select the clockevent when registering it, this is fine but the init
   code generates in any case an interrupt leading to dereference this
   NULL pointer.

The stm32 timer works with shadow registers, a mechanism to cache the
registers. When a change is done in one buffered register, we need to
artificially generate an event to force the timer to copy the content
of the register to the shadowed register.

The auto-reload register (ARR) is one of the shadowed register as well as
the prescaler register (PSC), so in order to force the copy, we issue an
event which in turn leads to an interrupt and the NULL dereference.

This is fixed by inverting two lines where we clear the status register
before enabling the update event interrupt.

As this kernel crash is resulting from the combination of these two bugs,
the fixes are grouped into a single patch.

Tested-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1515418139-23276-11-git-send-email-daniel.lezcano@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-stm32.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -106,6 +106,10 @@ static int __init stm32_clockevent_init(
 	unsigned long rate, max_delta;
 	int irq, ret, bits, prescaler = 1;
 
+	data = kmemdup(&clock_event_ddata, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
@@ -156,8 +160,8 @@ static int __init stm32_clockevent_init(
 
 	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
 	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
 	writel_relaxed(0, data->base + TIM_SR);
+	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
 
 	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
 
@@ -184,6 +188,7 @@ err_iomap:
 err_clk_enable:
 	clk_put(clk);
 err_clk_get:
+	kfree(data);
 	return ret;
 }
 
