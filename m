Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523399732-2-13704663191671972006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399731; b=NSZiG16/pZxQy1HiTSMY1Vlb0qOMTw3a6laQQysY9aqdQMQpzU
    o1Amtr0EEhAsefkRjz3jIqrAkJNN/pFq0d82+oeD8p5ktAROvKdAMn1pEbR/1DFz
    Mw7MlJKEOUSZ/q0CuQOLr0BkliAvy6LWgTz394FH//xAvYgpguVkoSrSnu4gZjB+
    A5W4GVZb5Hm8C7Yu3IKwBazD023QcuU+PtnGO1hAsuDYXEDzmiAcgPFBUdG2K9qv
    SGG9HDHDkQcT5NmFS1T0ME7PWk6umT3QlxraG+xxXUlDXGou7roHtvMyuGAAEmR8
    /wH81XFYAxIR+B/YM6CD+SH9nL5PijZA8RnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399731; bh=KSmIgeTpkok6D+M3ajgV9WubFemeig
    m07R+nON2xIzk=; b=Ide3VoD/g83KiLtvZvZeD3cr8nTZjImS72XAwkl2T3yc4C
    PSs+6HieVuAWvfFGSoxROgzqBKihpaIb3N3GjMScI8lYvHpAKdqzTgtOibvZQUBw
    YCMKoaKQURJ2TlWNYERv0c8iSxIoR+GbC3VTDDCCw4Kv/e+0LphamK0HnyHxQGsA
    EGeT+PxcMolgEkAtx0IdeQYikJyEH+d7Sm7t2hY6bYrM6qbzk0S0qTxSgJhAbfnZ
    rw/b6v07Qc6X5Zr6R/l/7Dyzxts25do6cw9JkXm71kOLeS82uZRMa1wjXsJQcA+q
    DRTsDhV2HGg/URVBYtFIw2YU4AI7KL9qufQA+Ozw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfFin3YHnphrQdhQT6MtKVjxOSoltyA6SLo4K5FpPe6d25/fjPfkfmUbkJhmNgxIU4b+CDYF5fen5Lp//GR2atnnI+1vhoZIOWonnEeli3kNOV2j19cuY
    4mBlZyq4mLwYDcHLpRZdHtU9j+80wp5ccOMks3KQ9mU8ih7eiwBMQF1pSIfcnRxscg13QXELe7MMJz7E9ChD0By7m5lWP/wFapAv7NXxmXjMYGN/Y+GcAaOX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=aZAfa15Jk5teG4y3V6kA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755547AbeDJWf1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:35:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755543AbeDJWf0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:35:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 042/138] pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts
Date: Wed, 11 Apr 2018 00:23:52 +0200
Message-Id: <20180410212906.987897709@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 9291c65b01d1c67ebd56644cb19317ad665c44b3 ]

On some systems, some PCB traces attached to GpioInts are routed in such
a way that they pick up enough interference to constantly (many times per
second) trigger.

Enabling glitch-filtering fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -46,6 +46,9 @@
 #define BYT_TRIG_POS		BIT(25)
 #define BYT_TRIG_LVL		BIT(24)
 #define BYT_DEBOUNCE_EN		BIT(20)
+#define BYT_GLITCH_FILTER_EN	BIT(19)
+#define BYT_GLITCH_F_SLOW_CLK	BIT(17)
+#define BYT_GLITCH_F_FAST_CLK	BIT(16)
 #define BYT_PULL_STR_SHIFT	9
 #define BYT_PULL_STR_MASK	(3 << BYT_PULL_STR_SHIFT)
 #define BYT_PULL_STR_2K		(0 << BYT_PULL_STR_SHIFT)
@@ -1579,6 +1582,9 @@ static int byt_irq_type(struct irq_data
 	 */
 	value &= ~(BYT_DIRECT_IRQ_EN | BYT_TRIG_POS | BYT_TRIG_NEG |
 		   BYT_TRIG_LVL);
+	/* Enable glitch filtering */
+	value |= BYT_GLITCH_FILTER_EN | BYT_GLITCH_F_SLOW_CLK |
+		 BYT_GLITCH_F_FAST_CLK;
 
 	writel(value, reg);
 
