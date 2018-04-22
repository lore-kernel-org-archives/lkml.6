Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406203-2-4301714921619921717
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
    1524406203; b=McX/2bxJoIn5Rq0ZfgjWVZV0BF6q5etUy6BwYOkFhBgc613e6w
    0ssdRpuYiDbUwXyBf2BD2WuvLnUtSv9uhFnrbtCT2dZBd6AaPtI3R3DzeAB29mG1
    ozZYSE4DLXFjIXgyGBbhke4fdfXelUfVWlEd4enViobxVeFcYrcN1uyAGftN/UGf
    Dva2Yj38t+1fdaI/SR7Mcr2r02zGEs8vCXiKt3Cko2j7bNIZHu94liOv7bMZsj7j
    FCOr+0N/e5HUQwosZwOpfsYwQfxCN30It0dJSVLfyI3eGLtN0BueOvioSeIkBOfw
    mkcMnw+pKcfAIc60/zC5UsnGP1Rv/WPMWDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406203; bh=HpIzQ2VBQ+ONMXaGbUaZmXpLuW+KTF
    53wlKQqy6C4Kc=; b=kWlSWQODVfuroInvE+XbgAOuJ40EZncY3FTAqS/FmmDD4L
    suXv3zvoO5wPQO0IMU0EQkgn7YHLgkGB79AjZ58dNJbItc7pfwMP1jjZimR88mbd
    X9VPpWGCoEaJExEniOGen5kykRmUPF2U3HrERnjx7VvFak8+Vgun0nCfnaoamYHO
    ig45zjqQ6IkE4ZQTmnQUZNoFiuSq2CClpXc42R1AA2dgJ05TNuLlkEPNixBSF8tu
    7cjcD/grfYUyYs4fV0FFbHU1GW3Qz4/PuqTnX4bm+SJP6qw7zACgrMz12cZhNX5l
    KMVpHu/2+4Dy/h4awRA97TVeou7LCCZEfwmhvKTQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfDQN8knjZd1rJaT2YxKHgMDKWrpiKS41O+HemSuN1aMtgeMfPbsQsRx8f/EzeL38i301MGZTSezahBHxW8juOFjZsvxH8g9ti89ABhiV7m4yGtZ9Cb9A
    XOUa2asmVnfFgadNBYopcl5BEFyKms6CDpKmSn58RE7cMJ6enmaA6Ljb7arFZvzI6BcYyQOj6FEBFINviGQhbAcq3nwi/UBOS0YGE8o5N0oh9GNIj2pRb91c
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=-VAfIpHNAAAA:8 a=ag1SF4gXAAAA:8
    a=jolQjp5mQmBZKmoSEyMA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=AjGcO6oz07-iQ99wixmX:22 a=srlwD-8ojaedGGhPAyx8:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756172AbeDVOJu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:09:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756152AbeDVOJr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:09:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.14 109/164] clk: bcm2835: De-assert/assert PLL reset signal when appropriate
Date: Sun, 22 Apr 2018 15:52:56 +0200
Message-Id: <20180422135139.882024456@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 753872373b599384ac7df809aa61ea12d1c4d5d1 upstream.

In order to enable a PLL, not only the PLL has to be powered up and
locked, but you also have to de-assert the reset signal. The last part
was missing. Add it so PLLs that were not enabled by the FW/bootloader
can be enabled from Linux.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/bcm/clk-bcm2835.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -632,9 +632,7 @@ static void bcm2835_pll_off(struct clk_h
 	const struct bcm2835_pll_data *data = pll->data;
 
 	spin_lock(&cprman->regs_lock);
-	cprman_write(cprman, data->cm_ctrl_reg,
-		     cprman_read(cprman, data->cm_ctrl_reg) |
-		     CM_PLL_ANARST);
+	cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
 	cprman_write(cprman, data->a2w_ctrl_reg,
 		     cprman_read(cprman, data->a2w_ctrl_reg) |
 		     A2W_PLL_CTRL_PWRDN);
@@ -670,6 +668,10 @@ static int bcm2835_pll_on(struct clk_hw
 		cpu_relax();
 	}
 
+	cprman_write(cprman, data->a2w_ctrl_reg,
+		     cprman_read(cprman, data->a2w_ctrl_reg) |
+		     A2W_PLL_CTRL_PRST_DISABLE);
+
 	return 0;
 }
 
