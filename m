Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3746462-1523363048-2-17195618550407500619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523363047; b=a36v87R0/wdNsWfGgGB5v8Zr++VWPYkzviZXkFksXjmPvi5wrN
    nbL6hERxHsxx1663wxXVEROhY8C7mXPMEajWz+wCdbrwPzMQlpHLkdC93PeJlP+q
    BDfl0B/S2RzL0ZymUMkz6XbBFoYIb2pJKdBp34+Sq5+W5CCzJsvont3Aa8loQV4c
    CaqLb5ZwoR0u2b++9zPvavBOyMYXUwXPa+dG+2B1EUvWrrULmS9qqYcUigcWlV3j
    wHAwBt1J8aI6bDZ3c+kReQsCUb4MJRh6e3HfLlDTksJE1w6TOKQGO//XR4/tjU7x
    3qqTVkNUYeTz9phGtBWxxT8tRnAiFoFulCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523363047; bh=arEJF
    Wp0hPWATcvUpU5X3aQlqEJ4cTaTj0G2f2sTuJ4=; b=nV+uRsuQJrG5q+rk9V1kO
    64MoWL6LJgGDoxGGXk9F4zKgy9hPwUZcotEtSL6NTqPYVOUgqKauGIQE+swcufWt
    6mKB2MaYsLUyry4jaOYIPo0sBFcDDWamlJCZs0JWhdqZ1Vucn4MIpD9IixkyvPy5
    HmJ9MfVui+AzrP51GGCx97lhaEtDbLw3AcVI7vF12QkCWdnoLf2LXvmvWmXzIkBZ
    4lUEyf7yKlppzvtNOyxwqhQ8EYQjmMuhf/Ujr5BfkZpDhxUHfRPeeuNnV4zVgmYx
    ESuxsEKWVLS4/B4Kai2q9a3/vFQlcpIroGK+G4cpHIx7O4nr9pYejJIj2bLFocJ3
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P2IfDdQT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ffcFh29Q;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P2IfDdQT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ffcFh29Q;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBYVq82UCOyYK+iYOty9oMEyaQQ0JCim6fdIHy4aQolHjqpO5y/i3N44Qav8CQhEBicIlQZVFIisER4V50u+hKTzCTKAS11ivCBuVphZi3VNzCgrHoNR
    O0zhIjeog6EoBQ/BjS9TuYeSN682dy49CQRVjtvMnK8WG2JlQdSsQ3yNEIkh7bF3Y2y22MwNXnwTVnugGX0mgcQgo8tVFuBYQ3s+t8Xs0ppROY+n9ieypcCM
    KPbnF5tsY03kO4UiJvV3/Q==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=KUgp_o9Td9nQKI1mOJsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/S2qra4xG3YkvaFGT9RbhUqhSesl/iI4IySsRyh9snLKTTPFKKQTYY0zNgZpNUKXmsXzFGNw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 3/6] staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in
 prism2_wep_init
Date: Tue, 10 Apr 2018 20:23:54 +0800
Message-Id: <1523363034-30892-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
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
Cc: devel@driverdev.osuosl.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

prism2_wep_init() is never called in atomic context.

prism2_wep_init() is only set as ".init" in
struct ieee80211_crypto_ops.
The call chains ending up at "->init" function are:
[1] ->init() <- ieee80211_wpa_set_encryption() <-
    ieee80211_wpa_supplicant_ioctl()
[2] ->init() <- ieee80211_wx_set_encode_ext_rsl() <-
    r8192_wx_set_enc_ext()
[3] ->init() <- ieee80211_wx_set_encode_rsl() <-
    r8192_wx_set_enc()

ieee80211_wpa_supplicant_ioctl(), r8192_wx_set_enc_ext() and
r8192_wx_set_enc() call mutex_lock(), which indicates these functions
are not called in atomic context.

Despite never getting called from atomic context,
prism2_wep_init() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index 7ba4b07..b9f86be 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -41,7 +41,7 @@ static void *prism2_wep_init(int keyidx)
 {
 	struct prism2_wep_data *priv;
 
-	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return NULL;
 	priv->key_idx = keyidx;
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
