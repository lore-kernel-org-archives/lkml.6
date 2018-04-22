Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406682-2-5608735092430815919
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
    1524406681; b=NoEQsZbhjOgmPtlaQxXQeaNxIwbOK1XgX16Jo94TjUONt1PS1Q
    wkZuquxHhNisWQ9QM/G3dSk9NX8bRQIo0abajBYnTNaq+a+m0iZHM2qb+OpbX1Pq
    soakbD+nFS9YmqREdTWuYsnVPJ7WreFPgBkzjui2RgYpgH3GtnXPcHAgg1TgcOmI
    bFlN9yunLjBA007QX7apVqi9mCP32VBg3BUiZJECqhm8FHwP/hDytl9hcefVh+EU
    TelN/bQXCXh3Nd73zUh4xBbb1EuJeuwFTFHiqWA+FPfsZz2Ta0hV++trzNf+vaJL
    DTt9ss6nEW/OQB7bhhi4NKqZ7ed+lLwmnlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406681; bh=Z6ePdZMP8LKJFwvjnb8r9KjsnneuEG
    dnddgCLMTIm78=; b=U05o2ljyvsvug4A4DosWXEvjFl2ha1YnYiL4xGMiuaYdSh
    p21UI0TSFcNq/fyompN1h0j1bmxaR6xLW6ALRxw+39o0nP5T+VOssf+n+hnf8cpI
    xGYjGrCI1ezLlG1zw40MvAy5j2kdnwxlQ8MoOpRLp6zHtiXmJVJ/lbC3qzgR7a0Z
    3v7msAqTmexf5TkAVtIqfxVLdvpoY92LxMzyIo7cn3pdGr/4QU+i+xlysBoFrlo9
    QvdleuJblWItd/LC2lM0r+668V1DGz/mpQwo5Z6cNt1gwrjTElPsR+q5K2XHU8jB
    5z7eAfOgmIDM/lidFAgzCjqw/tUWzrDyOa5Yev5A==
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
X-CM-Envelope: MS4wfN35cTmPyRJRDMvSGiTtGFh7iktyk+tszQyYOjkutXSsrlk0krpQ31kPEDrSmcIlfFnuh680dVY7heF3hWPdq2xzrWm7KD0kX1cjXC6DL2nxp32tkkKB
    kJ9VYar2+rq9Mtin4b21fiqQGzy3wO9lfEn1KJlJaezxvSTgn7h7iWpj6v0VxB1WQmykdSr8Y6/CHMsTZJWuDn9CZJTQojkXOg1RueHkyiCMnqkezkx6C6Gt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
    a=WvqcMzvPMsQaiyE9X10A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757130AbeDVOR5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757146AbeDVORx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.4 61/97] clk: mvebu: armada-38x: add support for missing clocks
Date: Sun, 22 Apr 2018 15:53:39 +0200
Message-Id: <20180422135308.641539726@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Genoud <richard.genoud@gmail.com>

commit 6a4a4595804548e173f0763a0e7274a3521c59a9 upstream.

Clearfog boards can come with a CPU clocked at 1600MHz (commercial)
or 1333MHz (industrial).

They have also some dip-switches to select a different clock (666, 800,
1066, 1200).

The funny thing is that the recovery button is on the MPP34 fq selector.
So, when booting an industrial board with this button down, the frequency
666MHz is selected (and the kernel didn't boot).

This patch add all the missing clocks.

The only mode I didn't test is 2GHz (uboot found 4294MHz instead :/ ).

Fixes: 0e85aeced4d6 ("clk: mvebu: add clock support for Armada 380/385")
Cc: <stable@vger.kernel.org> # 3.16.x: 9593f4f56cf5: clk: mvebu: armada-38x: add support for 1866MHz variants
Cc: <stable@vger.kernel.org> # 3.16.x

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/armada-38x.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -46,11 +46,11 @@ static u32 __init armada_38x_get_tclk_fr
 }
 
 static const u32 armada_38x_cpu_frequencies[] __initconst = {
-	0, 0, 0, 0,
-	1066 * 1000 * 1000, 0, 0, 0,
+	666 * 1000 * 1000,  0, 800 * 1000 * 1000, 0,
+	1066 * 1000 * 1000, 0, 1200 * 1000 * 1000, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
 	1600 * 1000 * 1000, 0, 0, 0,
-	1866 * 1000 * 1000,
+	1866 * 1000 * 1000, 0, 0, 2000 * 1000 * 1000,
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
@@ -76,11 +76,11 @@ static const struct coreclk_ratio armada
 };
 
 static const int armada_38x_cpu_l2_ratios[32][2] __initconst = {
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {1, 2}, {0, 1},
+	{1, 2}, {0, 1}, {1, 2}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {1, 2},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
@@ -91,7 +91,7 @@ static const int armada_38x_cpu_ddr_rati
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {7, 15},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
