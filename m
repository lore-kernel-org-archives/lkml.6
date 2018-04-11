Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479810-2-13831759941735028042
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
    1523479809; b=rdJsX0TDzFVUlXbNoD+NVSfrb2sgFUIQTEauUmcIwzwfZxc7IL
    qOzJ+UidsxZjhf6TlHKlLYS00J41irIBzU7pH6jaWgu2NODIOvrrx8fC+7C/WTDe
    SPg7VB9TSnHF9sPnZQ06498s65v2ndqj+N8NvO9BW4PpQB4Kb6Ql4xW0lfbMYt52
    BnFo0O+cj9uMLxaZeOF62L0wq1Psy2o46YoR0Qebt2CRECtfZivcjYKxOs5LFhTa
    vAN7L3uLgAL/n/ubhRDpJDjZOC+RdkGCp2sDOl8vpbrf00LhxsbQzlMMEFOea99f
    wjLp2LnWwbfebOMfK9J1XEUPVxq3/nKB+shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479809; bh=icEpjjEKdOYYZ5KHGQyAxHf4sgFbS+
    qSvOUQaTqYMH4=; b=b6qyjuvVvoMF0Y7dnPKGFsfMbJF0Iz5y94OuH3Of/54sHY
    eEVnwc8RWkj55dfSji5H0gdSwKOGYGu2vhHaVhCHyL8kcLY08W+ItQh08Ru4T5gj
    6upLtWhcKE3KzNTqnbBP7gK2RNte5Xy72+C7MEY1yi5jikSlv1NdkNU3K7CquYZE
    /pap0C8sdimeOWJJyPBBA61I+Pt6kGm4tRIOAZ1mCDvFApWbDfI13RRfyacEvdiV
    798qMQvy/BhIQXeeWJAnz/ZjbvF+FtQ8SNcGj58qafyOjCfcfEoqdfZebG79yxGP
    iRegELjsic6YxnsJ+9jtDUfnBPLZ4d8hzBCYFO2g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfBVkYrXllWhAppq+GqgvE+EKelEj3U52xjAK38hwYbqxySpfj+YxqsxHUBxNPV2gI+CViKXwpHrb/S4romA55rfgCu1KAC0v9rx9xlvijONbOIixMpjm
    pvXaVSE6w1A+4BIUWDgEFzE2RgCOIlcX7S9qD/fySWgBMnG0yVabDJDg6LQ0CkHCFgwwj6yDPPrQgJkHbLG9OroomvarzPUlxQ490HWJLGjaw/48OlUWHAhq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AMTvMMonAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=IoLR7627HhPfafYgmrEA:9 a=QEXdDO2ut3YA:10 a=p5oU-coMHzOM5oT1KbOf:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755640AbeDKSp6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755631AbeDKSpx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 055/190] iio: hi8435: avoid garbage event at first enable
Date: Wed, 11 Apr 2018 20:35:01 +0200
Message-Id: <20180411183553.570751720@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>


[ Upstream commit ee19ac340c5fdfd89c6348be4563453c61ab54a9 ]

Currently, driver generates events for channels if new reading differs
from previous one. This "previous value" is initialized to zero, which
results into event if value is constant-one.

Fix that by initializing "previous value" by reading at event enable
time.

This provides reliable sequence for userspace:
- enable event,
- AFTER THAT read current value,
- AFTER THAT each event will correspond to change.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/hi8435.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -121,10 +121,21 @@ static int hi8435_write_event_config(str
 				     enum iio_event_direction dir, int state)
 {
 	struct hi8435_priv *priv = iio_priv(idev);
+	int ret;
+	u32 tmp;
+
+	if (state) {
+		ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
+		if (ret < 0)
+			return ret;
+		if (tmp & BIT(chan->channel))
+			priv->event_prev_val |= BIT(chan->channel);
+		else
+			priv->event_prev_val &= ~BIT(chan->channel);
 
-	priv->event_scan_mask &= ~BIT(chan->channel);
-	if (state)
 		priv->event_scan_mask |= BIT(chan->channel);
+	} else
+		priv->event_scan_mask &= ~BIT(chan->channel);
 
 	return 0;
 }
