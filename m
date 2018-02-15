Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720760-2-7707952136549409566
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720760; b=O2Lr+iv3FaUj6ytMpa4gcWxc59t4Hz8m2Nda4bAxGsbwXYi
    1owwTC9MbhJFxdAVQNh0uZ1cYjoJs75K7CrYsdt8jneRjj+SyrrgEHrE/AnjK8Iy
    XRIp9GiI+nFcWL5Zrz4RlkXmonpo6o4149CoZcKUJJMtvpDWaO2RsLxzwy847O5p
    G7sRYmDl9FyFCSsKGVloxjTVJfodD7tozKmzqtb2JxPOSkPRck6z8cEaAD1IzTvy
    lqffFxFmbkZrJi2sCCxGhIhsdMAMCqf8uB1NELC5yfquBUk1GSuydzoeDIwCmjk3
    JqIMGJIe49cDC/sm7kUe7+PoBryWyMr5v5180kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720760; bh=JqmJgETXkXEh1dpILLuHgintXG
    Hnf8TO6nLTQSCXJUY=; b=DE6jhfJC0lwDNxEzylXLA8VwxYkJiVQMqEaQ5HnDlj
    6uBeqJ+8+VluiDhvEm4VLI72gTrGUtyAubKsJ3CKVARpNHoZv/Ksr4oRHeeFe1yf
    HxG3fkBRA2c8lGUvVNPpvUdmHiraZOSIDGHJNRIFjAtQnJAeJcqEvHcqNVnKdtTP
    y1nC+APIEVx/Sp9Er1Q/YAVhzyPHp6i7+Wi3I98i/7HZpfTXfoOa/h0usk9yWRnf
    9OF8RTnqQj1zTS17IbPs6uGWL4PV/Zsm/i38jznBuNFl0GVkxhY4aiLq3HfAtHta
    t3/NG+mUHzVBHuDVQoJy7EzmdobsQycWZe883gaFpuTQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030902AbeBOSwD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:52:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162019AbeBOPVS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Scheel <julian@jusst.de>,
        Mark Brown <broonie@kernel.org>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.4 021/108] ASoC: simple-card: Fix misleading error message
Date: Thu, 15 Feb 2018 16:16:18 +0100
Message-Id: <20180215151225.505752528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Scheel <julian@jusst.de>

commit 7ac45d1635a4cd2e99a4b11903d4a2815ca1b27b upstream.

In case cpu could not be found the error message would always refer to
/codec/ not being found in DT. Fix this by catching the cpu node not found
case explicitly.

Signed-off-by: Julian Scheel <julian@jusst.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: thongsyho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/generic/simple-card.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -343,13 +343,19 @@ static int asoc_simple_card_dai_link_of(
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
 	cpu = of_get_child_by_name(node, prop);
 
+	if (!cpu) {
+		ret = -EINVAL;
+		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
+		goto dai_link_of_err;
+	}
+
 	snprintf(prop, sizeof(prop), "%splat", prefix);
 	plat = of_get_child_by_name(node, prop);
 
 	snprintf(prop, sizeof(prop), "%scodec", prefix);
 	codec = of_get_child_by_name(node, prop);
 
-	if (!cpu || !codec) {
+	if (!codec) {
 		ret = -EINVAL;
 		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
 		goto dai_link_of_err;
