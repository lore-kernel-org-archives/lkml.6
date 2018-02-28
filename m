Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836617-3-1810200385127664902
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
    t=1519836617; b=EhAa079bqBgLgPpOeRXQjLvO0icy4mD5wmA/mu7qEPXUG9N
    UlI/RPngROck8AI/oSG/qzCDrvV4MCX4h3zAA3OkJ0iU+Wp1stml25KAd9mr6mAG
    kdTYvwFvqRdUTGlS+icHHZE78rLDWIe4MfSmdkp1phSbi0wO0cdQtCuG33CJ/3V7
    JDGh6v/W2s5hIxCNZwQCE8cl3Xm009hlOQ8bmFLX1TR7MuDmE2D/WV6j9rLUw9DU
    eOAzYnURvvqysd4DSZW7hoRFQu6lNatHUvMX8n7z96MG4Dwp7D42/YaE43xyVY8f
    e0MFqVZskRFfz8y8rGVob+/+6uNhQxDzYNax/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836617; bh=amq2vLA7DMoKklg0xa/
    eQNbk5g2zBUgoJrk2yd2QWmU=; b=Yhe2Ie7WjPnDu2Gsv1u+RD92bEmo8BUIobn
    kMZSq8Ld5jYjovilZT15nAvpUhTmzF3S4xMl8YLINoH+RDeEL2dKGwBEWntKmqhC
    A0OqKNT4Wi+GrI+NsouAW9rcokbuZ2/R3eWPqeZzQoqm7QJLvbKuaXrCq6JdPuFH
    WUNwXmGxdO1kEzyz3WfvCRaO9PLBrrHRCnhPGxkZDeU/Urexd7CgU6Q3oOu655Mb
    8c53zBrS4hgE0l8X6Ew1t4znnCYBAMP/RqgAGWrPVf5eAqJelWciNSmNiW9DwOVL
    QDeuJTODJLj0yWtEVIeCmOU4Xi7WU8u4UGbeIMKLBZLOrXFYwlA==
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
        id S932105AbeB1Qtq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:49:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34573 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933999AbeB1P6k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>,
        "Mark Brown" <broonie@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.898207216@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 080/254] ASoC: wm_adsp: Fix validation of firmware
 and coeff lengths
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 50dd2ea8ef67a1617e0c0658bcbec4b9fb03b936 upstream.

The checks for whether another region/block header could be present
are subtracting the size from the current offset.  Obviously we should
instead subtract the offset from the size.

The checks for whether the region/block data fit in the file are
adding the data size to the current offset and header size, without
checking for integer overflow.  Rearrange these so that overflow is
impossible.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -622,7 +622,7 @@ static int wm_adsp_load(struct wm_adsp *
 		 le64_to_cpu(footer->timestamp));
 
 	while (pos < firmware->size &&
-	       pos - firmware->size > sizeof(*region)) {
+	       sizeof(*region) < firmware->size - pos) {
 		region = (void *)&(firmware->data[pos]);
 		region_name = "Unknown";
 		reg = 0;
@@ -677,8 +677,8 @@ static int wm_adsp_load(struct wm_adsp *
 			 regions, le32_to_cpu(region->len), offset,
 			 region_name);
 
-		if ((pos + le32_to_cpu(region->len) + sizeof(*region)) >
-		    firmware->size) {
+		if (le32_to_cpu(region->len) >
+		    firmware->size - pos - sizeof(*region)) {
 			adsp_err(dsp,
 				 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
 				 file, regions, region_name,
@@ -1248,7 +1248,7 @@ static int wm_adsp_load_coeff(struct wm_
 
 	blocks = 0;
 	while (pos < firmware->size &&
-	       pos - firmware->size > sizeof(*blk)) {
+	       sizeof(*blk) < firmware->size - pos) {
 		blk = (void*)(&firmware->data[pos]);
 
 		type = le16_to_cpu(blk->type);
@@ -1328,8 +1328,8 @@ static int wm_adsp_load_coeff(struct wm_
 		}
 
 		if (reg) {
-			if ((pos + le32_to_cpu(blk->len) + sizeof(*blk)) >
-			    firmware->size) {
+			if (le32_to_cpu(blk->len) >
+			    firmware->size - pos - sizeof(*blk)) {
 				adsp_err(dsp,
 					 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
 					 file, blocks, region_name,
