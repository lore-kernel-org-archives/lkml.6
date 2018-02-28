Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833615-2-6225888040763895422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833614; b=DovTq6YDxQ25F8zajjcNtxQI7jleudMutRLBXqrQl3H57jN
    zzNfSrjUhxP9+ugnofyTglj7P0qy0gXzggbNsWczxTBoYdd8+X3GGvYM3FiaSFNl
    S0x/QTrJTepzUAeVpR5yvYT5UEBZ0bR0ZbfN7Bw9lzJS8T3lgISzB0AB+L7lBI7M
    CurwLtp7WLslt55LFGg/ojjLSa2DcXLNPo12CWozS/ynppfvxjbsh9j1zeUaq0UM
    j7On+kBOgia3HwrS2VnmqYiM9dloTRpOlMHXe5qLWxfb1uZuZ/DjbZoGHDP9UaBq
    hMeFzW9P3y4O6CVBdH9EZ0l8camrr2L1tvoCIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833614; bh=PEgN0OSaYEldb0uk+zH
    rHiUFiilw05Zv7Pf0Frnz+pw=; b=rDpLrYpUY6bcLwCNxy1+NDLuh/gdKPmO/Nn
    6lyDKr1FTZtEmlsMOPKHnoerZymeTWtc+AH+8RH1ldU9xLXRy7rAorSashYoFN0j
    oHyKzGXhBqi3MdJ8VUiuPozOfYEcox7k2RV9BiJex9Toq0zBStSsp9jjJwjxyQc+
    JxhzUnUguNWOvh03WQBwRfcAuHRbk1oatEr6oYv8pgUHtc0MgolViZHkfRnPOXNu
    pQgreJqVcR5u0lLuwvk6hgQv+nfLC50pJ7QJ1VZIfh4VUhGrath6Q78Bmi3hlddD
    b2aGt/Jm4u3H5l7clyFYqILUoeVlU9MHJqnTABfIeu+ToAyiZrA==
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
        id S1752565AbeB1QAK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34635 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753015AbeB1QAH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Richard Fitzgerald" <rf@opensource.wolfsonmicro.com>,
        "Mark Brown" <broonie@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.601854160@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 079/254] ASoC: wm_adsp: Don't overrun firmware file
 buffer when reading region data
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

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

commit 1cab2a84f470e15ecc8e5143bfe9398c6e888032 upstream.

Protect against corrupt firmware files by ensuring that the length we
get for the data in a region actually lies within the available firmware
file data buffer.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/codecs/wm_adsp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -532,7 +532,7 @@ static int wm_adsp_load(struct wm_adsp *
 	const struct wmfw_region *region;
 	const struct wm_adsp_region *mem;
 	const char *region_name;
-	char *file, *text;
+	char *file, *text = NULL;
 	struct wm_adsp_buf *buf;
 	unsigned int reg;
 	int regions = 0;
@@ -677,10 +677,21 @@ static int wm_adsp_load(struct wm_adsp *
 			 regions, le32_to_cpu(region->len), offset,
 			 region_name);
 
+		if ((pos + le32_to_cpu(region->len) + sizeof(*region)) >
+		    firmware->size) {
+			adsp_err(dsp,
+				 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
+				 file, regions, region_name,
+				 le32_to_cpu(region->len), firmware->size);
+			ret = -EINVAL;
+			goto out_fw;
+		}
+
 		if (text) {
 			memcpy(text, region->data, le32_to_cpu(region->len));
 			adsp_info(dsp, "%s: %s\n", file, text);
 			kfree(text);
+			text = NULL;
 		}
 
 		if (reg) {
@@ -737,6 +748,7 @@ out_fw:
 	regmap_async_complete(regmap);
 	wm_adsp_buf_free(&buf_list);
 	release_firmware(firmware);
+	kfree(text);
 out:
 	kfree(file);
 
@@ -1316,6 +1328,17 @@ static int wm_adsp_load_coeff(struct wm_
 		}
 
 		if (reg) {
+			if ((pos + le32_to_cpu(blk->len) + sizeof(*blk)) >
+			    firmware->size) {
+				adsp_err(dsp,
+					 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
+					 file, blocks, region_name,
+					 le32_to_cpu(blk->len),
+					 firmware->size);
+				ret = -EINVAL;
+				goto out_fw;
+			}
+
 			buf = wm_adsp_buf_alloc(blk->data,
 						le32_to_cpu(blk->len),
 						&buf_list);
