Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522173756-2-4615988005852482695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173756; b=GvchyL+mr4friA9dn//dNb2UWYS88VcMMhFaFOlrL5oGNb2
    vPUC76KbQZG4eKZm8df/2+gLbFfnIhp+OpID1HlO921G9OE3QA1Q5WPKiP+Ri/Wi
    AAm49FFnObuBPT7gHzs5c1F+5bmQh1S5Wl7y+FB2H6iQkV4nQlEZOHmotOTNgst8
    QzsylfwziTpdKa91XF2O1257q4QK71hE6eQs//6wZ5udThE2HddheNvBRq+WG+6M
    kY//mZxsb26DMUS1hCGJEtT1p9qNXjRd6djwbc3asixvQqtU4vZp+xXgmombul+z
    Lh/UQdz3nmFfxQQPgz0sU+hHxLT+tVGdE/YQVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173756; bh=mgANRZNDVHh844OyEVTFAs5yQn
    BFO5j8bra+cCoBF0E=; b=Vrwa8JxOnR7W2KWXYaVmHDE732jRpOvCGEg1loiUIA
    g422I1OC0Gt86vYMFiwI9+68VOZekn8bGwAHRaZqDukCcPGn56oYC6CXXauQE2B8
    Q85g5AiSaVmV8UYB3gl8vJTIyvCFjgnIJJGV2KJeui160MZ86XTkrZM3OBnTIpDV
    rZR9xfdzUeO1ckAZzjpIgdUCs2BzsDqLrQ0dEcjvY5CsfjWw8ZkaiQSiIPiqq27F
    WPWWgJK5me8i6bl1g473H2sKUP3S5GRMZZBP66CkSJOuiUcIsd/N+gcGNLxFMmAI
    Z7OFqQWpDz9udYHLwy2sacmxtybTYCQ4bR2/X2gtfRmA==
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
X-CM-Envelope: MS4wfNyYP85IMBwCuFCAvB+Vbmrl6uUfXJ8NksPFY8e54MmSLxKkGDQpCpMeqllFWLyEiWXSZoBZ0JBKiQnGBkovY/BnSAp1evGW62ZJWmNtG/Oc/CTqMNqx
    p7ee0T9tNRgYe7/xsGFWI81srZBBZU3b9+4pTmRZ6Dxp2KKBQDWGrjettW9muWHjP3gNLBuFjSAM9aRPwZ8QSAzOeUx+g1V1sDgxD2cnc46ITce57B3d/nm7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=-VAfIpHNAAAA:8 a=ag1SF4gXAAAA:8
    a=jolQjp5mQmBZKmoSEyMA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=AjGcO6oz07-iQ99wixmX:22 a=srlwD-8ojaedGGhPAyx8:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeC0SCT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:02:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbeC0Q34 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.4 10/43] clk: bcm2835: Protect sections updating shared registers
Date: Tue, 27 Mar 2018 18:27:14 +0200
Message-Id: <20180327162716.939196093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 7997f3b2df751aab0b8e60149b226a32966c41ac upstream.

CM_PLLx and A2W_XOSC_CTRL registers are accessed by different clock
handlers and must be accessed with ->regs_lock held.
Update the sections where this protection is missing.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/bcm/clk-bcm2835.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -912,8 +912,10 @@ static int bcm2835_pll_on(struct clk_hw
 		     ~A2W_PLL_CTRL_PWRDN);
 
 	/* Take the PLL out of reset. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
+	spin_unlock(&cprman->regs_lock);
 
 	/* Wait for the PLL to lock. */
 	timeout = ktime_add_ns(ktime_get(), LOCK_TIMEOUT_NS);
@@ -997,9 +999,11 @@ static int bcm2835_pll_set_rate(struct c
 	}
 
 	/* Unmask the reference clock from the oscillator. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, A2W_XOSC_CTRL,
 		     cprman_read(cprman, A2W_XOSC_CTRL) |
 		     data->reference_enable_mask);
+	spin_unlock(&cprman->regs_lock);
 
 	if (do_ana_setup_first)
 		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
