Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832508-2-9773087254638701161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832507; b=gO8+U1d3BSbaGEbuzoL+qPUzwGeBXGUrinFuaKliF6l7cKb
    mgIwyWOnK7Rwz/kbKaI0S8BajTC1k9amI/wmzLPFtkFJbRqDKB4StAlgjwmlM/E2
    7G6Jd5gZtmWR+QkWEGiVN7Lc8WVcCg/1J4Aa40SQ2hKijZkEAh5saCPflA/mUflM
    ovxVT1bbomIAnlcseJE7GuID9Ub9jU0pyiQpSQ+9/U72dp/u271FM3IFfoDp3eh5
    ZXfJJ/VZyAAMWQXsbx6mrGfizys/8thfhYkIx89XEKaq6djDn3QUiNDqQ7EiylDs
    dqtLKziGaBEVN5iFsuXTWy3hATq2t2Fbx9h0OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832507; bh=ymQZN5BnJMuO8QMQRjb
    Ue7sQ0s90JxEUZrRD9a5QQyY=; b=rSP1AyvyQSS9q0M+YGUgk6WZZKiqfDpYoVy
    Nyj4WDJ8cJNXurGOj9K+i65mXdNqQSqwJ1nezfygnbg5w9pW5O9hgwbOhr7HfMmI
    Cu+bpvU9Z6q3Kjc2ANM96GkRc9IrlHwAaadzCNVg+CQaLjHYfd9LSB0SAP9VKwxI
    lGuYOu1Oyb6KHoTwiGZUe3lGyvtPcWXAcqk94e7qNcsXWuApZPQGdUvYhuftboD1
    /yRbKxu5gZwcVXad6x28/T/itKsucjez1Xn19EcihrdY4OdoknPFlUSm+4sZndxK
    YlgzoPLrC6E3SrGyYOqkh2j7eGWLLUZ8L0FoYqRQYyjY+941sHw==
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
        id S932968AbeB1Pi7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:38:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33230 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752720AbeB1PWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Johan Hovold" <johan@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.370755581@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 037/254] mfd: twl4030-audio: Fix sibling-node lookup
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

From: Johan Hovold <johan@kernel.org>

commit 0a423772de2f3d7b00899987884f62f63ae00dcb upstream.

A helper purported to look up a child node based on its name was using
the wrong of-helper and ended up prematurely freeing the parent of-node
while leaking any matching node.

To make things worse, any matching node would not even necessarily be a
child node as the whole device tree was searched depth-first starting at
the parent.

Fixes: 019a7e6b7b31 ("mfd: twl4030-audio: Add DT support")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mfd/twl4030-audio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -159,13 +159,18 @@ unsigned int twl4030_audio_get_mclk(void
 EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
 
 static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
-			      struct device_node *node)
+			      struct device_node *parent)
 {
+	struct device_node *node;
+
 	if (pdata && pdata->codec)
 		return true;
 
-	if (of_find_node_by_name(node, "codec"))
+	node = of_get_child_by_name(parent, "codec");
+	if (node) {
+		of_node_put(node);
 		return true;
+	}
 
 	return false;
 }
