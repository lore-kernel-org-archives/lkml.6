Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2259617-1524120442-2-6809260168717442671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524120441; b=eYN5y0klUNZy9YnOxzBMG17xgU1MW0iSSr4zJklwxo0oULP0bs
    +dmLLxxWVpRput4dN/nrKiNi/gDLUbMxklf0a/181RwwyB9+roPAeF9ltYlGr+3S
    FTsxLPBWJ9Lce8FM48Ptf8Cd3k/MJYpFALApi84iUReijqUQ3iupolza48lEjXQf
    +qaxumbDizghTM150Ue6dCo3yNgjD7Gg7STjtzYyaMA7QYlpAuGJJlDonsjQUk4H
    /4R2HknA7jN+0q0vVBkPANapZINDPb2F7e3I7BjYPa3C+zQRHKEU/dSdWoVwyP8n
    AVE2W0X+mkUkxQ+cWbloDJnyGvkIaOyE50yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:subject
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524120441; bh=0tFHh
    KTHPhA9llMctwls0oVbg+SzVNPukfJEKOZhM3c=; b=GpL41HfQGKDd9L2AySwrQ
    aMDaFPkeaw1sUZQN7T9HiMFuZPbFM62gVaLDcSagPewcaZUzuE1SSuGLPJl0QByV
    SXmxm3ERHLw4K9YZ+qFKnk1xZrnLfsKGqCuRYZ1vs0PBIkIwOEP6Jc+6Au1vIr4V
    yCj5cQziV+IwTa0+mQQHp3+BXZdJFToWFHFX6XLiOuaVX8j5v2Ya75cnkURCvLua
    ftE9Ev3sd23AVazVMpoi5hMAAu9Y9X0k2xH4/UUiCycppFVHC9+2BXOqVEw4kiwO
    y8WyXXFEIysKb2s0CZeRFDcwjw1i0B2sR6w6p716QN0PJ9p9l4RQYEmfRRE1cA3H
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QodJ1csH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W7B3M3+u;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QodJ1csH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W7B3M3+u;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBw+l5w7WJmcQOSeXDSJ1UxzQT8YFhrEyqz41Z3qX3MYvFOTz8f44l0LQI8c8a2X/6p8T9VhBoLW/l/fSS0P/8CNPm0Es+LBTfAwQz0XwtDv/sv8zjVD
    uTF1PqvC/B/fJPnXufdBkuf9ZWKuzHi45CryMnIv6qdHHj2Z3D6DOAsmn4PCTQY/0fUATK0yR3C0epNurgaVMg+IzhB0D3t9rHE3qANH+O+Ngo/mktiZJ4VG
    MGREk/4ihrcICBF83qsl2g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=SzzekA-baL0A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=OKep1EyhOitqe1QKljMA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48EDFgm5phQD6CzhX9fwwhO3E03VyXvzVar5CqOUF8x4OJhqtRN2RpUUn3IC10OjrMRb2p2OA==
Message-ID: <5ad83b71.1c69fb81.f8458.0d85@mx.google.com>
X-Google-Original-Message-ID: <20180419064710.GA16792@andrewjschuang@gmail.com>
Date: Thu, 19 Apr 2018 03:47:10 -0300
From: Andrew Jye Shih Chuang <andrewjschuang@gmail.com>
To: William Hubbs <w.d.hubbs@gmail.com>,
 Chris Brannon <chris@the-brannons.com>, Kirk Reiser <kirk@reisers.ca>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 speakup@linux-speakup.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, lkcamp-request@lists.libreplanetbr.org
Subject: [PATCH] staging: speakup: separate 80+ chars lines.
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: andrewjschuang@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Increase readability of code following the Kernel coding style by breaking long lines and thus eliminating the checkpatch.pl warning.

Signed-off-by: Andrew Jye Shih Chuang <andrewjschuang@gmail.com>
---
 drivers/staging/speakup/main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
index af30b70..2ba9989 100644
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -899,12 +899,13 @@ static int get_sentence_buf(struct vc_data *vc, int read_punc)
 	while (start < end) {
 		sentbuf[bn][i] = get_char(vc, (u_short *)start, &tmp);
 		if (i > 0) {
-			if (sentbuf[bn][i] == SPACE && sentbuf[bn][i - 1] == '.' &&
+			if (sentbuf[bn][i] == SPACE &&
+			    sentbuf[bn][i - 1] == '.' &&
 			    numsentences[bn] < 9) {
 				/* Sentence Marker */
 				numsentences[bn]++;
 				sentmarks[bn][numsentences[bn]] =
-				    &sentbuf[bn][i];
+					&sentbuf[bn][i];
 			}
 		}
 		i++;
@@ -1233,7 +1234,8 @@ int spk_set_key_info(const u_char *key_info, u_char *k_buffer)
 	key_data_len = (states + 1) * (num_keys + 1);
 	if (key_data_len + SHIFT_TBL_SIZE + 4 >= sizeof(spk_key_buf)) {
 		pr_debug("too many key_infos (%d over %u)\n",
-			 key_data_len + SHIFT_TBL_SIZE + 4, (unsigned int)(sizeof(spk_key_buf)));
+			 key_data_len + SHIFT_TBL_SIZE + 4,
+			 (unsigned int)(sizeof(spk_key_buf)));
 		return -EINVAL;
 	}
 	memset(k_buffer, 0, SHIFT_TBL_SIZE);
@@ -1247,8 +1249,8 @@ int spk_set_key_info(const u_char *key_info, u_char *k_buffer)
 	for (i = 1; i <= states; i++) {
 		ch = *cp1++;
 		if (ch >= SHIFT_TBL_SIZE) {
-			pr_debug("(%d) not valid shift state (max_allowed = %d)\n", ch,
-				 SHIFT_TBL_SIZE);
+			pr_debug("(%d) not valid shift state (max_allowed = %d)\n",
+				 ch, SHIFT_TBL_SIZE);
 			return -EINVAL;
 		}
 		spk_shift_table[ch] = i;
@@ -1256,7 +1258,8 @@ int spk_set_key_info(const u_char *key_info, u_char *k_buffer)
 	keymap_flags = *cp1++;
 	while ((ch = *cp1)) {
 		if (ch >= MAX_KEY) {
-			pr_debug("(%d), not valid key, (max_allowed = %d)\n", ch, MAX_KEY);
+			pr_debug("(%d), not valid key, (max_allowed = %d)\n",
+				 ch, MAX_KEY);
 			return -EINVAL;
 		}
 		spk_our_keys[ch] = cp1;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
