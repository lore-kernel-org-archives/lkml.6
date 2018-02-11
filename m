Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324168-2-17865186330022417127
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324167; b=FoD7vp0JWfI2FsTL0hbryBSrhXD9hK7c/cXQGreOlmXxL+/
    A4xsaeGi+fvhuptcGb+ptTL5LM6Y2S0083C3HUvq5GcihkEVPLvNSAvghvAbDGaz
    OGJ/BgMiP88FxRoYlX+C0s/7WyiipqgVu8kb21Ee9nIa1UKTVIdaRH6UyErsgXEU
    3zI8Loo4an7dtxgSVUv1PkDZzeSkobwYHQMV83zyHi3SrFzlwoHtFIFnF1Mf2gkN
    pmvU+HyCA97pz3P/t4ck2l5VFHWy8+1gH88dekqddfLvPVjKJs8u+cvUZm/3ow+P
    LYyUVLTlflHsLqHQDh7VxDiOqL39Fy5yIe+ipVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324167; bh=ewfUGqbHfPnZn2Cw4yR
    66W9+dNkDgIFtnLQsXsVv7Ss=; b=oqq1tSglTVV+WXUwF3G45VJLYGM33lLXBuA
    ZCKl4x+IaCfWdI7tBYIE9aDadRrsTMGSjDtJHuV/7R0IKdwJ+KABtRdfZyBkev92
    wRkYNCEwH1el4Da3UPdY95H7sI7ZnBCSqeZSsi8u4Ls0T0TiTwrBRyTNZlfKxWXR
    s6oakquNWZZWpxaHaU2ll5m2Ru5xQWC+d1udyDEGxQDKoOf6gr7ynbavk143hZc+
    IBSjGolcoQGqOCYblqovMVmaWPF+RSvKqQwh+7jCt6ra2l0x2WV3gTXvKBIv5Ss3
    G7XOREob7vzeWL6etTI4DOM8UDQdnjj4iqkTtHHOZ94iEc5SJUg==
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
        id S1753075AbeBKEky (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41684 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752930AbeBKEeH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Roman Kapl" <rka@sysgo.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.319592976@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 046/136] drm/radeon: fix atombios on big endian
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kapl <rka@sysgo.com>

commit 4f626a4ac8f57ddabf06d03870adab91e463217f upstream.

The function for byteswapping the data send to/from atombios was buggy for
num_bytes not divisible by four. The function must be aware of the fact
that after byte-swapping the u32 units, valid bytes might end up after the
num_bytes boundary.

This patch was tested on kernel 3.12 and allowed us to sucesfully use
DisplayPort on and Radeon SI card. Namely it fixed the link training and
EDID readout.

The function is patched both in radeon and amd drivers, since the functions
and the fixes are identical.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[bwh: Backported to 3.16: drop changes in amdgpu]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -45,34 +45,32 @@ static char *pre_emph_names[] = {
 
 /***** radeon AUX functions *****/
 
-/* Atom needs data in little endian format
- * so swap as appropriate when copying data to
- * or from atom. Note that atom operates on
- * dw units.
+/* Atom needs data in little endian format so swap as appropriate when copying
+ * data to or from atom. Note that atom operates on dw units.
+ *
+ * Use to_le=true when sending data to atom and provide at least
+ * ALIGN(num_bytes,4) bytes in the dst buffer.
+ *
+ * Use to_le=false when receiving data from atom and provide ALIGN(num_bytes,4)
+ * byes in the src buffer.
  */
 void radeon_atom_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le)
 {
 #ifdef __BIG_ENDIAN
-	u8 src_tmp[20], dst_tmp[20]; /* used for byteswapping */
-	u32 *dst32, *src32;
+	u32 src_tmp[5], dst_tmp[5];
 	int i;
+	u8 align_num_bytes = ALIGN(num_bytes, 4);
 
-	memcpy(src_tmp, src, num_bytes);
-	src32 = (u32 *)src_tmp;
-	dst32 = (u32 *)dst_tmp;
 	if (to_le) {
-		for (i = 0; i < ((num_bytes + 3) / 4); i++)
-			dst32[i] = cpu_to_le32(src32[i]);
-		memcpy(dst, dst_tmp, num_bytes);
+		memcpy(src_tmp, src, num_bytes);
+		for (i = 0; i < align_num_bytes / 4; i++)
+			dst_tmp[i] = cpu_to_le32(src_tmp[i]);
+		memcpy(dst, dst_tmp, align_num_bytes);
 	} else {
-		u8 dws = num_bytes & ~3;
-		for (i = 0; i < ((num_bytes + 3) / 4); i++)
-			dst32[i] = le32_to_cpu(src32[i]);
-		memcpy(dst, dst_tmp, dws);
-		if (num_bytes % 4) {
-			for (i = 0; i < (num_bytes % 4); i++)
-				dst[dws+i] = dst_tmp[dws+i];
-		}
+		memcpy(src_tmp, src, align_num_bytes);
+		for (i = 0; i < align_num_bytes / 4; i++)
+			dst_tmp[i] = le32_to_cpu(src_tmp[i]);
+		memcpy(dst, dst_tmp, num_bytes);
 	}
 #else
 	memcpy(dst, src, num_bytes);
