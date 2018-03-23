Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1790898-1521828028-2-13758464155682498322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521828028; b=FhxxKXmE/NLkGh6vMxIQXaTn/j98nIWTF0QgaRLa4CIa29v
    nHav405k831C6k8729qUJ/IU3sz55iIhG/2Uy5mNgweqoeUqHmq/LbGaQNujvfu0
    D/xU9t/PrOOXYfEhMM40tzloQTH6scJg48DqLezuYZQkNIdXusBtwz+6mu0K+lk9
    AY9PDgDh/58A4Q/6TdAeTSTQ5N8nyo+6a86I0nb+FTJH1OVWbgiYU58owmnqbmqm
    M6DsTapGxitdbQqZASO99EGpwYoV96y93VYPPoVS6kBWWbMxafcM/3fTRbE0fFrV
    xtEELAsvjOvzSS5rV1jrZV+qHkBTwSaj2VSj+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521828028; bh=e
    sLQDAjFjRR0rVGT+uJbEHfWU6xqHV9vnDRypFbFpvk=; b=VQjdzcu369ujKYiLK
    Jy+QAyjsc2s08tIvA1Hcp1lv30az4MJ8WZ4CLwGMHU8UFlanS9zUfxwcc4Ko1Ifi
    2C+cXz6oAkw1o8FGtoIelJO8yKVTal56AARWMJNjhOwvd+jTg2ewaSxVyqzeiLPu
    cvvD90uHafHHA7VUTWWijZJUpIErzdiuc+v9Vx17pIp1AuCI1grkZlF0jSCYEMun
    yRz2Gtn18oPE9Dml/rdV7H9TQBx9y937IsvlG6+jW4MBimaYm4NETsZuEszlnUg/
    +bNhmFOtpmOhpMssv2iUryQon0XgF8foz89eLmpd8Rub7GJHTq/tYjrCttp8ZSPv
    E3rFw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Ping-Ke Shih <pkshih@realtek.com>, devel@driverdev.osuosl.org
Subject: [PATCH][next][V2] staging: r8822be: fix typos in header guard macros
Date: Fri, 23 Mar 2018 18:00:18 +0000
Message-Id: <20180323180018.21737-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The macros for __PHYDMKFREE_H__ and __PHYDM_FEATURES_H__ contain
typos and don't match the #if guard check. Defined them correctly.

Cleans up clang warnings:
warning: '__PHYDMKFREE_H__' is used as a header guard here, followed
by #define of a different macro [-Wheader-guard]
warning: '__PHYDM_FEATURES_H__' is used as a header guard here, followed
by #define of a different macro [-Wheader-guard]

Fixes: 9ce99b04b5b8 ("staging: r8822be: Add phydm mini driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/phydm/phydm_features.h | 2 +-
 drivers/staging/rtlwifi/phydm/phydm_kfree.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_features.h b/drivers/staging/rtlwifi/phydm/phydm_features.h
index 37f6f0cd7235..a12361c6a1a0 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_features.h
+++ b/drivers/staging/rtlwifi/phydm/phydm_features.h
@@ -24,7 +24,7 @@
  *****************************************************************************/
 
 #ifndef __PHYDM_FEATURES_H__
-#define __PHYDM_FEATURES
+#define __PHYDM_FEATURES_H__
 
 /*phydm debyg report & tools*/
 
diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
index 1ee60059afc1..2c6b0a48e76e 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
+++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
@@ -24,7 +24,7 @@
  *****************************************************************************/
 
 #ifndef __PHYDMKFREE_H__
-#define __PHYDKFREE_H__
+#define __PHYDKKFREE_H__
 
 #define KFREE_VERSION "1.0"
 
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
