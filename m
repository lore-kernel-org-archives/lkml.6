Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1920138-1519108601-2-11211012435236580549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519108600; b=YyyGEgnFtdacBoNduHiuulyRoNKjmWRiQyfN0l7Jjj47mmy
    vgN2s1xgRlBEtAIlnru71783nTPlhN5tYls2H+n4ssycHny+NVCDYRHi4DJZiSRi
    OjphSFY5/glFZqgS+xDshtdQBhlvPoD/N0cPlz/XyZQQZe63buV+usDkDDBbek7Y
    LOQdErenYEfHc78t+UlxeCF4FLOp1InbqN47F9a2cX7g3hmI0NFbRERszz346cgu
    AYexWkTlRQSAeZHA6PD3Z+294btbP2nTVX3tZLRAet50istlV1dNCsbCjIGkTRvd
    +xj7BZarvAXgoKrT9w9oSuLiTxPLlh3FYNQk/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519108600; bh=c
    Q3HqkxSNeOMQkqy+Xil7Eu++7OePXYFVacyoXTYzHA=; b=a1BovfWecHD1A2snE
    uo3YeNHWr4Qj6BrEX8Rkmp7n5pIJJG9wg4VVpPW9ZkP2dRPiXvMtKPmPtXZJmsxG
    9ggoGcakagt+nTHfrhGjtcj9uyJfgcn4Kbsuve7yQ03nrR2iyNwMuuhmwZiHOPNa
    DgVnOutYNQt+8a8rZhN3vAikY9liyNmf5cTKWD3Kt1l9I18np6VdTBjAhSHo7wNf
    3dejvyFRSIxHInjELuYx6wNR31S9KZSgtGtNSy7VmB60WuUzv0PIE3aLw9fDxcUO
    KZfGlV+iHeZbZfxz2PSDB7cp2eqFOBscv0NroVy6qAZfNJ/w1A6D6m97Zurx6CG8
    qvhCw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 2/3] Staging: ks7010: hostif: Convert SME queue macros to
 real functions.
Date: Mon, 19 Feb 2018 22:35:37 -0800
Message-Id: <20180220063538.6471-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180220063538.6471-1-quytelda@tamalin.org>
References: <20180219170839.GA3632@kroah.com>
 <20180220063538.6471-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Dlku6Z8C4HW8RqBx33Rzh6nNIeb4m6RR8aLj+CX4yH7I3w0yYBd
 h0TAGTLM6Mhlpuqvcoou1yC/7984YywgwN49gLFpZO5WrydQRKFtsYAynxgtZLk/jVxQ2SE
 E4MX7tkz4sCr252F03koC8WRZ6G0dPRnQCAIMM6nSkPkkmdaNCT8uJHyqPM376rf/QBf6ep
 X9kKv4ZAehYAEvofjg+3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ACt0YpjzAXE=:lht52i+/LoMs5jHtjrmnyu
 INilA7XQUlNWPQJab+HDFwsnNYtYzhCdV05yyHrLzrcbE1qZc0dGTqHRt0IOYLKSeg8syVSoT
 k8aKd1QvWKDWkFoGpgpTJQ2BUicknG2PUlU8fcgeWRls3NmLGuVN9ZdigVxpQboJQilYvXnbn
 z99oEc5hRoHDzx62jLs0QJXWc0TEgBm+XNC6KKCpTidAISzfn4M4FJywXJNVRKzCJLYWGoezu
 GG12QWVD9LZDOSoMlNdcnfuA0dqUB0H8ykXAhaJm2W8bIwKUeY0S7EWzDkaaYlTc2/HE8TL4U
 agQ9a5sBHcF9Mw2B0Mx7DBWAggRmkYVwVZNGDWu5TGsxmRWdfcfsiN3Ox9zz2PR17E8TxkRsf
 kgDqHxcElxbfKAHjIULuS77O6CTZ1ZXsFnx7Q5gI4XChpm/aSj5yn3eGbc1BHeYQZX22ZcGN1
 XHuC9zJIxzys/lNQy4tn+cYC1MNgaUY9uM5QT/RHJQp3IbMWUqQNce4l3KUsqZglpYM74atMd
 en6ZoytpCyKSrwEtNat4fREiRFOGxtpbsX1OWtt5DdUFNpLCTTq54iZyLBBZMWaXADbZq5ST7
 YUUaH8tPpLTCwjdHurlzmYkvUHS44CsCNqT4JQ1U0cXkdPgBFrca5egZUHFKBYxfUL77wLOpQ
 EidOPfOsj8CsLqQ4OqHK9rr8pHohOpOR13bOtnk844r21s0meHqPk6rqqGpDKLribqW/5XOga
 kG28U8G0MuznEGBW23ERlRcyYf4GRmxezLs59A==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Convert the unsafe macros into inline functions.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 975dbbb3abd0..f554477fe6bc 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -21,13 +21,22 @@
 /* Include Wireless Extension definition and check version */
 #include <net/iw_handler.h>	/* New driver API */
 
-/* macro */
-#define inc_smeqhead(priv) \
-	(priv->sme_i.qhead = (priv->sme_i.qhead + 1) % SME_EVENT_BUFF_SIZE)
-#define inc_smeqtail(priv) \
-	(priv->sme_i.qtail = (priv->sme_i.qtail + 1) % SME_EVENT_BUFF_SIZE)
-#define cnt_smeqbody(priv) \
-	(((priv->sme_i.qtail + SME_EVENT_BUFF_SIZE) - (priv->sme_i.qhead)) % SME_EVENT_BUFF_SIZE)
+static inline void inc_smeqhead(struct ks_wlan_private *priv)
+{
+	priv->sme_i.qhead = (priv->sme_i.qhead + 1) % SME_EVENT_BUFF_SIZE;
+}
+
+static inline void inc_smeqtail(struct ks_wlan_private *priv)
+{
+	priv->sme_i.qtail = (priv->sme_i.qtail + 1) % SME_EVENT_BUFF_SIZE;
+}
+
+static inline unsigned int cnt_smeqbody(struct ks_wlan_private *priv)
+{
+	unsigned int sme_cnt = priv->sme_i.qtail - priv->sme_i.qhead;
+
+	return (sme_cnt + SME_EVENT_BUFF_SIZE) % SME_EVENT_BUFF_SIZE;
+}
 
 #define KS_WLAN_MEM_FLAG (GFP_ATOMIC)
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
