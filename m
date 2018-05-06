Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800236-1525644191-2-12728905243006582540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525644190; b=Xw6/NLL4cNZIV0/dOQBMTUZfonF8IsKM678OzNRjLh6TUh82/x
    lAkQgU1fInqsdMvrfDsUzi1wa3cx74dee1iIKdgjiZib3DK6oTwycDDkqSvuXAZi
    qbx6/8uHt5ejmRPp6R2W72sLsSJ58zSUlVoms7uDSGV57JCIdFwUyK81BvOk2eOb
    1HzcAzh/ZYBwvgubilfyq9SgbHV86KRE7KXPds/Sw3NBfGj8F/1YXha+HHiEpn72
    qK+wfJte5y0d+6bwGUKjTnRGiryMmu7aP9kqpsHozDR6fal/nl3NW0IKxTcG+Hx0
    ZY71LAxfnQ70m4Bo5emzwO3y1maXApjICXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525644190; bh=PY86W
    fN0OV4g47AEzJ/LkkrkY4LmkgX0Ntygme4vEGk=; b=mxibdqhg0hepmYrED7e8e
    8LUkpVgfqGB8e9uFgglNPRYz+e76kRrtLODYN2G3jHFheccPX7NHJ4EFuEYgTG3u
    79jgzvDOFkwIdxMJy9MLA5x21XllrZdGA0A/2dA1nGs5CfMIALvHNJhD9I5RUkIN
    3FG2jVu/xCjKy5xBfwd1y123XDcpv5yffShF7sDnpCwkjDCY1pDTzIEVPXWzylz0
    49wr+1pJnAbwU5txM+vrujIWEDJR5g14ET73MVywFfn+xQXlE5iWluPds0B63Nn4
    efgBYmWcHLMSgDJuBL3BehZ5q9Z3JSUV2PnyvuXF93TgUTzy1j619fWd5i5L6/yk
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=tBg4I99p x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=eB5frjOu;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=tBg4I99p x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=eB5frjOu;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIUSMdXZ32sMRaAroZY8JfLjb57djo3mUPnnsHqa/5zGuGEKboFPApVb0givFqBrskTyGUpS2nTB34GZzTBJQzUJI9+DzsbdIy2fdAlLy2n9sn4ml4eL
    /5ef1J9ol4CZ29UjCFcUBWRuZGTizhxc/gTxRAKZFskeWK+fnx40Y0HfqfrNUJXm8mYTfd1nrv15ZiK0WZ59Z6JSUZnD2dMpqgCL6VnpeL3+pn9l2kYmH2SS
    CbZVpeF0xLt8vf03nYJiSw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=vMFYa23uP1_PdkcpLagA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZorAJ7t7ntoq//B1M89rWVG+UnoStyoyw3WfVyQtW0gHWj5YvsGU7Su/JefUQpek9YIcnzOQg==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 4/7] staging: ks7010: Adjust spacing around functions and
 declarations
Date: Sun,  6 May 2018 15:03:01 -0700
Message-Id: <20180506220304.13040-4-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506220304.13040-1-natechancellor@gmail.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

checkpatch.pl warns about too many or not enough spaces in these
locations. Adjust them accordingly.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 1 -
 drivers/staging/ks7010/ks_hostif.c   | 2 +-
 drivers/staging/ks7010/michael_mic.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 6a5565d479ac..e23173a81f24 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -776,7 +776,6 @@ static int ks7010_upload_firmware(struct ks_sdio_card *card)
 	int ret;
 	const struct firmware *fw_entry = NULL;
 
-
 	sdio_claim_host(card->func);
 
 	/* Firmware running ? */
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 4c2f8f710c6e..a2833707e0bf 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -191,7 +191,6 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 	return size;
 }
 
-
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
 		       struct local_ap *ap)
@@ -2272,6 +2271,7 @@ void hostif_sme_enqueue(struct ks_wlan_private *priv, unsigned short event)
 static inline void hostif_aplist_init(struct ks_wlan_private *priv)
 {
 	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap);
+
 	priv->aplist.size = 0;
 	memset(&priv->aplist.ap[0], 0, size);
 }
diff --git a/drivers/staging/ks7010/michael_mic.c b/drivers/staging/ks7010/michael_mic.c
index e6bd70846e98..3acd79615f98 100644
--- a/drivers/staging/ks7010/michael_mic.c
+++ b/drivers/staging/ks7010/michael_mic.c
@@ -11,7 +11,6 @@
 #include <linux/string.h>
 #include "michael_mic.h"
 
-
 // Reset the state to the empty message.
 static inline void michael_clear(struct michael_mic *mic)
 {
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
