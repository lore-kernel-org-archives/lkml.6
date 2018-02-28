Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836057-2-17338111603659637892
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
    t=1519836057; b=ea3GPI0r+r9KThlX5vSgTxcCFJ5Rjawpv5bl/3VsyxsJpNm
    f7RKh6UC7b0iiwVSvxfSqjtkqtLYRMoTB8/ot4SputJjInr1KVAZFTmJp3Xkn+1X
    CJjsl4hha82zu6gzXx8L3XvoqGyjvPaJxJKvaTR8o6rW+lUlBHuUoLoMLpnMf33q
    UZJOcY6abWhLuQ9xVndzvgUhGrcRDSoq3fqWm4JY5Wl72NhBXWebqQEYxtxvXhn3
    OnF8rgej5nSR5/7/A7AZun3ZeDN/5MuZ0ijr3dEZteLavTgJSgsp2HUVblGYlci5
    WK34N+TQ/u9C7/5lfiSVdPbE3heL2cAAk7OTyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836057; bh=JzjxjsB8YlyBGNoynh+
    0lRYf863tx5IsNRfySBpykqY=; b=U0pWuMIHZR7KuovgmVHUC0CviKCZHVu8Tg4
    0aghANIcG/Pc79xoovf0bg2Qhb97oLTfQUyYWSYsNFBNapAxqKXPWYgUaowu7Nd+
    fI3iKNGv44C19ZbzdmAV8/GKDWLfr2VmL+mLUzZI4i9Xlz5xtiD+MGSLczT75xev
    kZG127KGkl6EKcqoUiOrwT8qS8ZA3yAtcZRewug7tOQq+KGzwnOBgX8N9SgAILWv
    Gc0VKpuqsQwD3J4U17AuZaLx6FkYH5oiUzikwZVV8OiaXKTxie8VJWnMrh8fEd4m
    1oPSbkAXZ3KKfdgfK3GTIDTydP/vHvcmpv6QY1hS4NvDn/48zCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeB1QD5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34793 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932290AbeB1QD4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.648993350@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 002/254] ASoC: twl4030: fix child-node lookup
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

commit 15f8c5f2415bfac73f33a14bcd83422bcbfb5298 upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent codec node was also prematurely freed,
while the child node was leaked.

Fixes: 2d6d649a2e0f ("ASoC: twl4030: Support for DT booted kernel")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/codecs/twl4030.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -232,7 +232,7 @@ static struct twl4030_codec_data *twl403
 	struct twl4030_codec_data *pdata = dev_get_platdata(codec->dev);
 	struct device_node *twl4030_codec_node = NULL;
 
-	twl4030_codec_node = of_find_node_by_name(codec->dev->parent->of_node,
+	twl4030_codec_node = of_get_child_by_name(codec->dev->parent->of_node,
 						  "codec");
 
 	if (!pdata && twl4030_codec_node) {
@@ -241,9 +241,11 @@ static struct twl4030_codec_data *twl403
 				     GFP_KERNEL);
 		if (!pdata) {
 			dev_err(codec->dev, "Can not allocate memory\n");
+			of_node_put(twl4030_codec_node);
 			return NULL;
 		}
 		twl4030_setup_pdata_of(pdata, twl4030_codec_node);
+		of_node_put(twl4030_codec_node);
 	}
 
 	return pdata;
