Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184724-2-2642463190430991868
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
    t=1518184724; b=hn4tsNdA6Z5qKjtamJfQ8mYqAaXiJxKapPWjdSou/CHdnuQ
    2ymdfN6rFho13/9Zja6NFtUkFDX/I0ikTQS0WZ6pE59MSmQ0ZjY9E+MT2SEW5LVt
    4vXlRBu7Bde7l9ED6eZ0Qjii/s0AacOfDXTuWeRigep3EBHGexKDhZMdfk9oBLO2
    gKuDdC9BOGlfYYE7eelTu5DN20Q0FKawB4Inykg1T0ZBssYhun5OugdVZxflfvD9
    o8QS2vX4u6Wa6H8w3xxnQZlIHlY+0uObZ7ktikjmiq6vCC+4IWMnvJs0i01e85gD
    JkBeRn047nSLRH7cx36WkJX3yujqiPV03YK1uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184724; bh=znVcafL9Z8oMtRGLrmPgLlO5/R
    nExYLZf29mpLbE65A=; b=ntDZ8KQY+ITVO4XhowDEkfSNWJwAL/IczgmFcATNVw
    3ZOd+MkPAI849Ge2UYlak8YVjvaHU0xIJpZ086kpP1sWJab/E5JpBejXFuET6BUh
    lf4gQ73bs2np5wLsf4R26vgFR0/crxu05XNVzGjDXM+/8WuNPubYFHRVYSZYMdpt
    KXwvTZMqHO9u34/vhK0XDqVZuev+VCqFLzRll074ehmU8goJ2j7Cs8h8/b/lk0tQ
    FR+f1G0gslcrOBsYMdbfHjuaBe/p8v6+xElpZPwi3YyPKNmeeH/2WHnCMc9akMVe
    7IPqZCNyoBuwZSkq5RBFedDVBo9MuFLhXvDXNYByJaZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeBINol (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINoj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Scheel <julian@jusst.de>,
        Mark Brown <broonie@kernel.org>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.9 87/92] ASoC: simple-card: Fix misleading error message
Date: Fri,  9 Feb 2018 14:39:56 +0100
Message-Id: <20180209133937.367621168@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -232,13 +232,19 @@ static int asoc_simple_card_dai_link_of(
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
