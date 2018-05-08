Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3181716-1525801384-2-1949918111003731470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES rosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525801383; b=UfceWL58wOTGhI2yzZftYsi4k0YSrbmmZmVXZjGRhZmxN8MqDV
    /xY+3jSxB9Rhwub4LNGm8AYeXvPEjqQ7iOwtlkUVhVjRQtT7/6Q+0mGasjts5K6I
    bKLyTsH4QtRru7qpO6hPOrevMVIWQmn/919yQjr1hPSHPybw/t/dpq8gG1Ugp0UO
    PjPQoO+n3BDECE5XjwDndhG29Rn/9txcGuMFVl8LhrH0m6tPW2ZVDXp8xGfFj6ky
    RaChWRsu2BcPALp9l9h2ffF3N2NAnU5sZFTDXFH6HMKlkTJwL2oSJ5GZYTugUrkV
    Va/6MEtQgOhsev/D18FpnkEuvgAkJHAUftHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525801383; bh=
    bfbbUSBgTlYSGda+amdU0YDhCjXFlrFQlz4M9dbgApo=; b=WSglwv4h2YuZVKuL
    naS7gFZ/flArQR1HaUPTSbgAzFFyD0X5OjGud0XyekI3c2uUuL2POUx2DnPa/qAr
    ic8LMjZWIhFRBDN07X2YjmkDascsxqqCLOQ/lhiGZODamSgYyYetI7b5jVwbu0cG
    CcTWgYXruns5+W3+Xzzka76JO6jlcH8zg3NApSceCWtYtayDkciAsrBeskpP71Vb
    x4cYOLlAoZRZ1S1uAGOWK+ExDLCUh7Q1BPMfxOsCmvaxNY6g1GJtIQgdaokOXSQn
    00yo4dOKoWUk7MBx8DHxU/ZSzmE0ks5dNx8Mux5i8sOOpdomM1TzWq811jTYbUoy
    fWZvkQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=NtzTE9hU x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=NtzTE9hU x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOGPNpWO3KDR3G7yxF8hdyBLEec/RPH7fyg2IAtxYMO4gXeEQe51P/+vH57qe6PdKjpunMWwXNaFih+F4/Nkv/DwDSFxB27qAbQfp7os6dYomb8XehlF
    wwJmAYmzVa8Ozl+oYeoWsLTxf92WgfSOTMxPVwnM7yKKOcPd2BcCp7mviqddVTibiGDsMaRQhRdhg2au5c74svBD7AMLqpA2QIXzy/vaQED3w25wvCmKSyQ/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=ZYdTY-Wl7BD0CIAsORkA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755364AbeEHRmi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 13:42:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39537 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754370AbeEHRmg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 13:42:36 -0400
X-IronPort-AV: E=Sophos;i="5.49,379,1520870400";
   d="scan'208";a="180732632"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v3 2/3] fs: Convert kiocb rw_hint from enum to u16
Date: Tue,  8 May 2018 10:42:01 -0700
Message-Id: <20180508174202.2537-3-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508174202.2537-1-adam.manzanares@wdc.com>
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

In order to avoid kiocb bloat for per command iopriority support, rw_hint
is converted from enum to a u16. Added a guard around ki_hint assigment.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 include/linux/fs.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..7a90ce387e00 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -284,6 +284,8 @@ enum rw_hint {
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
 };
 
+#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
+
 #define IOCB_EVENTFD		(1 << 0)
 #define IOCB_APPEND		(1 << 1)
 #define IOCB_DIRECT		(1 << 2)
@@ -299,7 +301,7 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
 	void			*private;
 	int			ki_flags;
-	enum rw_hint		ki_hint;
+	u16			ki_hint;
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1927,12 +1929,21 @@ static inline enum rw_hint file_write_hint(struct file *file)
 
 static inline int iocb_flags(struct file *file);
 
+/* ki_hint changed from enum to u16, make sure rw_hint fits into u16 */
+static inline u16 ki_hint_valid(enum rw_hint hint)
+{
+	if (hint > MAX_KI_HINT)
+		return 0;
+
+	return hint;
+}
+
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
-		.ki_hint = file_write_hint(filp),
+		.ki_hint = ki_hint_valid(file_write_hint(filp)),
 	};
 }
 
-- 
2.15.1

