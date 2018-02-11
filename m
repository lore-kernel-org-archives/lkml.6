Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324176-2-15752777037856874062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324175; b=JniWxLCC+LkWalWlLSL2mffke/H+unow1N1xAt5quRRXFWw
    ttBcjswR//mwkoRsmnLdIUtL0zvnBhQivIhCOovkGh7dIg1XlYDdsALxLE1X3oSY
    ZeXcP3UgoLPAyy/5q3+Fo4RoRS8NdbvZKChIpwlNdagH1SGXztkDegJ/AX3gN5hy
    3hTL6nv7pfe4NzGIn6rqXBosH12t13h9/P5A2ydW/eXnOImiKkaVcjOKpYIWqYA0
    HVjv19Va3FmoI76yn/8/ZZElCmbj8MvH3DH7nHCWrM7DT5J/3dOAIqDunPFq1zhX
    4gtre/8WoWWpuGIBevm1iXrfOx+iVSYbgmeJHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324175; bh=wWAd8A7d4HOhp2IiAJ1
    Dtjd+Kvg86lxbDYUAglh0XbM=; b=lpatDoY+2Hardqt6ZnNW2LP5QETTd2dsNCk
    nY3bvrt9XZDNdtxWCrA96kBKKptoKtzLWEb8/oO/hcQtAwfhjH6fqMJ14wqV68ry
    f82XQmlQruMXiwY15lfdR4/HwIjZB2skVW6BtR1fL+V71p6eFtANLiDdlHRUDr8U
    MhJjd+WHD5RNxEv9PZZvmYzatPIvi5b+m4N2jYCaj1BEgkWVBJ56p/lcA9P98/ql
    /NEgXEx8WMpJLoZniLX3Gg0dlvul+DNMimnsU9WdFbmW9bWJPd7qjf07OpkFaRC1
    ktviGlamaHrtGTWbDFZVWd5gJBr3IZNM61PvLQeP3nGKPuQYQ8w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeBKEkx (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41675 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752943AbeBKEeH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Horia =?UTF-8?Q?Geant=C4=83?=" <horia.geanta@nxp.com>,
        "Radu Alexe" <radu.alexe@nxp.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.765378345@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 049/136] crypto: caam - fix incorrect define
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

From: Radu Alexe <radu.alexe@nxp.com>

commit cc2f8ab5334a736fa0e775cfccf06c1e268667f0 upstream.

Fixes: 3ebfa92f49a6 ("crypto: caam - Add new macros for building extended SEC descriptors (> 64 words)")
Signed-off-by: Radu Alexe <radu.alexe@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/crypto/caam/desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/caam/desc.h
+++ b/drivers/crypto/caam/desc.h
@@ -1434,7 +1434,7 @@ struct sec4_sg_entry {
 #define MATH_SRC1_REG2		(0x02 << MATH_SRC1_SHIFT)
 #define MATH_SRC1_REG3		(0x03 << MATH_SRC1_SHIFT)
 #define MATH_SRC1_IMM		(0x04 << MATH_SRC1_SHIFT)
-#define MATH_SRC1_DPOVRD	(0x07 << MATH_SRC0_SHIFT)
+#define MATH_SRC1_DPOVRD	(0x07 << MATH_SRC1_SHIFT)
 #define MATH_SRC1_INFIFO	(0x0a << MATH_SRC1_SHIFT)
 #define MATH_SRC1_OUTFIFO	(0x0b << MATH_SRC1_SHIFT)
 #define MATH_SRC1_ONE		(0x0c << MATH_SRC1_SHIFT)
