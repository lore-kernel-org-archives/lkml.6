Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1614509-1518834343-5-12988497548124465684
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
    t=1518834342; b=gzLEf8RZhaG0hO23JjTa+Cqn3frNdI3rWjwpZhA+Dy8OBi+
    Z/U4JA+cXfJU05F0tmP2HKglbXvIcFw6NUzsE1f0mrMs92VWGBsEaSOUZQ5wtqoJ
    ZbDgghU3njNE1HpxS0ikJjU3c9dvn5OpJVeFdVJuCpSHyMpRJrMAzQYbV+C2iE4g
    QJ1xXHF/rsBS2SxiQ8fqTvTPQZcNT4YfRqdfL4LSyDRQrc0M4GBu/5ECDfOl/vS8
    EB8e8BhGvYNLHRCnCtixEwxc8UIWflefggoCrkdmxLmzIpAgPwkDd/aqKndgdKVz
    EAaBNibDcFcLPnUi2PSGgp4zKA9mKrVAPZ6A2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518834342; bh=Q
    FgV5BltyyLjWekquvNcgocUaOBwQfqj01WTRj21mNg=; b=UCif62TM3qbBLRET7
    CC0C78t8vc63HcCnFPCiuDWyivS1OSx2tRpn7fXjgAieSAwzVGEgLRBrtHwx1Pyc
    AitN2n1vNXzwjJjrsGvWv2h5kArtXEFc05RhJKn4y7EPP3v3prhTDwnKc+tvuDMs
    mGSZw2RtektEjJRfxhNYjLhgr3XrfOXnJUfnMpvVjgESmysG68nNQqGlXb6BHkPN
    0Ll9DHI4kNx2M5OMzeEiRP1ay7Ny47gfkoqGjmgsupUSlH/JCBrJuIDCw/qZozvv
    HoM8pcu6P5E7gSyJdGuuzXRmwWBLisuMu1geBI3TGDuiAegDy7cqvF+zAVlpVKHK
    cy4Yg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
Subject: [PATCH 2/4] Staging: ks7010: hostif: Fix multiple use of arguments in
 SME queue macros.
Date: Fri, 16 Feb 2018 18:25:01 -0800
Message-Id: <20180217022503.24982-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:xd9mjK+3JHyNABcLxlK0mwKgCVGQMG80l4XSwHtHDw8pxfePh75
 lyL9JSFci1QKbUjp+s4u42LyyVaWEJeV8naVjgvBm+GWk4cNGnjrLVf726F8rqyiisZn7Oc
 zyZgEL35zX/5Oyw3ueif+Ql9xwZk4wtwzcbbd3pKx9OYyG4kscG63M5ePB2Q0CBFVrNGCZQ
 Y47EQOFsTyzOkzU6l5iTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0zwdbpvS5pU=:ibEcCxE33Ympp/EYwl83vA
 EgzHUaVvPjlM2rgYzsquYlollhYEDU+Is/Scm7174rc4dMNAybuYvYxO4S9WJ0LWwe2sJl5bd
 jfZpnZt2LA/7VXZk4MJITZNJI+HlDkUFocSOJa13LUbifNYfkJSqfMeVJrR7i4pIH1oUvFF8V
 E1uYDD5+I2vDxyH89T0kBlsoNwGBEWNzrArxsnO9pn/zJkb/zJneWhqQXunXXAZrxRf2JapwS
 jSjemdjyBTO25795aY19DM96EJZ3FBZ9U3pt0+cxtVQzfAcaqfyWsW3hqlIwsAFQd7RChdrQ0
 ZYknUYIdEtgPkRyLKCJ4U3KfbT0WBJqelOcIceaSpp5Itqpqg9ZRMoQyx6/TYllvf/RH/jR/1
 H5aCbm2uPRKf/lJkiv+c3KvDlzldBCqVascAtXYdFX7VhMFmihU0SUC3qcooXh87Ip5PJ0GpZ
 Nmg251ceX0Zf+XJ+Q1BZFFKUjuHbIVwPzUUHq6sG/caIi6AKkPqd88zdqnwptePC53SkE7tfw
 SJX55hJpUwXgcf3zE15xGTvxhEuv0OCuUsMoPA0MbGiVwwjOk6kP5mlNvLQ84mHD5O6o1N6EJ
 F63I+50OxYgBkQjOhk1ExJHTRtz04wdiza5wCoYPAQ0Eg3jr/NOLMwR4Qni7rKW0YeyBPdZso
 JthTZvt5k4o143ARgP1q9sFRWX2gnh2cZ8daMGozP1gmqSizzShqlKlUJkeiqjyaFakTIhz8a
 hguPV27FmExgV+ns5/NDuKGdUjeFSayBat4ztQ==
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

Use GCC extensions to prevent macro arguments from accidentally being evaluated
multiple times when the macro is called.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 975dbbb3abd0..30c9592b3a00 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -22,12 +22,19 @@
 #include <net/iw_handler.h>	/* New driver API */
 
 /* macro */
-#define inc_smeqhead(priv) \
-	(priv->sme_i.qhead = (priv->sme_i.qhead + 1) % SME_EVENT_BUFF_SIZE)
-#define inc_smeqtail(priv) \
-	(priv->sme_i.qtail = (priv->sme_i.qtail + 1) % SME_EVENT_BUFF_SIZE)
-#define cnt_smeqbody(priv) \
-	(((priv->sme_i.qtail + SME_EVENT_BUFF_SIZE) - (priv->sme_i.qhead)) % SME_EVENT_BUFF_SIZE)
+#define inc_smeqhead(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int next_qhead = priv_->sme_i.qhead + 1;	\
+		priv_->sme_i.qhead = next_qhead % SME_EVENT_BUFF_SIZE; })
+#define inc_smeqtail(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int next_qtail = priv_->sme_i.qtail + 1;	\
+		priv_->sme_i.qtail = next_qtail % SME_EVENT_BUFF_SIZE; })
+#define cnt_smeqbody(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int left_cnt =					\
+			priv_->sme_i.qtail + SME_EVENT_BUFF_SIZE;	\
+		 (left_cnt - (priv_->sme_i.qhead)) % SME_EVENT_BUFF_SIZE; })
 
 #define KS_WLAN_MEM_FLAG (GFP_ATOMIC)
 
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
