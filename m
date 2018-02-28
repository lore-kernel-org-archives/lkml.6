Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834251-2-10799107164801654831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834250; b=C6fEEpVOpmNixZJmQ359uyzrM26+tf3FshWfc8sdy8jOgkE
    Ps5AfP8KtXhbdCyKIjkFX4A1Z7kvsi47+SDDE2iBoCgm06b9gAPFL9idlvxhus12
    7upimhTIS53ESFxpgUjNxI6stRQbaJux9hDnmuZ7lLTtylgljkd/UcgsbYODO3Mw
    uKLpFKxog09cLwbjAi34nTdZSfc8zjpcneGjyHq6ct8EuAT9A9eTjHj4J4JMEXws
    Hx+dr/4nTGRu4d2IZHW5M7zVVRtNW3GlX5iKi9bFXh5AgzomO4RztgoiYiQa7yo4
    DivxHfbqOy+6yeZYQY0frV6ZbLMNyfIMjhwPhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834250; bh=rDHd1aDNNdojKZBc35G
    XoNUgPRPr11PgjXxzaqUdesU=; b=FiWjxNJ8W/XeK2iyASGbTZKbkdms/Fm+Hmn
    LTT/nmYnoiySsPIdGTx9SrT5rZ3ZXWrm3RGVU4UTjG8RgADRbdLXoaPUuqPR/Ixi
    8OiRcqlXr/jQX8tH1oB6bpmX97701FzOi6URwzCb/ronqAvPm+IadQ/M7y10NNCi
    FVWWlJFRQfMrTM0RFGj/k1rvF2IPYlb7zUj14RdvPQIsOd7gU2aLZBEAM3UAN0RR
    3bwfv2GzUkpCw/YEXETpCb0oi6XHnAyPEs3QY3au+ObcU6hnhEglJzu8aUI3KvOS
    XO8C9U7MzZ1fkLLCPxyc1U05cs1KJmBgYWmrkFEL/goj5eENhvA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeB1QKd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:10:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34972 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932871AbeB1QIz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:55 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hans Verkuil" <hans.verkuil@cisco.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.743806271@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 239/254] adv7604: use correct drive strength defines
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

The prefix is ADV7604_, not ADV76XX.

Fixes: f31b62e14a ("adv7604: add hdmi driver strength adjustment")
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/i2c/adv7604.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index af8a99716de5..9e0e592f50ab 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2735,9 +2735,9 @@ static int adv7604_parse_dt(struct adv7604_state *state)
 	state->pdata.alt_data_sat = 1;
 	state->pdata.op_format_mode_sel = ADV7604_OP_FORMAT_MODE0;
 	state->pdata.bus_order = ADV7604_BUS_ORDER_RGB;
-	state->pdata.dr_str_data = ADV76XX_DR_STR_MEDIUM_HIGH;
-	state->pdata.dr_str_clk = ADV76XX_DR_STR_MEDIUM_HIGH;
-	state->pdata.dr_str_sync = ADV76XX_DR_STR_MEDIUM_HIGH;
+	state->pdata.dr_str_data = ADV7604_DR_STR_MEDIUM_HIGH;
+	state->pdata.dr_str_clk = ADV7604_DR_STR_MEDIUM_HIGH;
+	state->pdata.dr_str_sync = ADV7604_DR_STR_MEDIUM_HIGH;
 
 	return 0;
 }
