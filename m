Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-496490-1518937664-2-15167183587014140906
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518937663; b=dsoJSewCAurNKch7wjzYH13GdWoDxoPj0bh/1nvIVArhoXz
    xPYW98eP2k59H5sh+GoTqbPtRmfqfiW70S2Nn4Dx3vZCLqjdLrpaoFXASoGFxN41
    8O39BqAjWEY+Tr5TMbfA6bDIO5g1kQ6vR5JFMd4cY5WedOOEpIzwaof54AcW4D9I
    +ZpD53UrbI053HoYfH7TKZag8GRQwb1MrHcOAXH4EB48dvfTkDbLApHMVYkAeTVI
    KucueNsiK9JsKAE37IkZ2e4CurfqhphVB8hIkLlg8vlD6ZmZxGy30mRF+nE+Fmm3
    Rt5+K/qPygQx+WQS3MYxd29xPJu82Glbk+kNelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518937663; bh=T
    qcodtaPwA7/1uS1IEn6jx3hDgXG48jsM+FaCxFrBao=; b=steUUpYjAvax4jaNf
    M9N+ocSCfnZMqtMPGwAn+S96WvD7CiPMro+TDyzl6+92M6rGvxS5bjAXhGFehVey
    Xaz4xc8V3qwlpR4OtUpbTk9vFGhWo8J7lgJ77JsSRcK5mJ4rXDHrU191ROB+gNKP
    TaFt+WznoyMua6U4A4SflUcjT0iRk2ZvMB1FIHUmSSYHAXm+wh26RyWob8IwaAmj
    gUJjjqJVS+Hxndi0QVFxd4vmFLtD8ymnMxhsbOJIJ4OSv8yBJ4QIAKRExRtcJJdw
    3bCGxUi2U29vMClqNvtHkyT98sSMnWKTEbd8d94Le1tWWSRPcplq0Y00Hki9HNAj
    EZj2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
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
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 johan@kernel.org
Subject: [PATCH] Staging: gdm724x: mux: Check return value of
 register_lte_tty_driver().
Date: Sat, 17 Feb 2018 23:06:35 -0800
Message-Id: <20180218070635.27479-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:ybFyt5oqJvALuk5y6plKwQz1hyooPNDb/rUlbPdjv4E/y0jk3jM
 G4SfyVzAm9amz4hrfg0CfGhgd78TFfJoBt0HkbMuYHyxWh7RNj3O15P5sbZIbZfOgsdCmDW
 cgssRtTdW/uJYV3JDelenPRxLQEe3Mev1eFWHouaBomRQEaUuXuNx96Nstzgnq/sEhrA8Lf
 RxM7KCP4B7lowMOIt/qCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MESUiW9fb1Y=:rKCCLnit7EuMcjQbd+STxk
 RiM4ZoYGbroIjQQJVqzcauPsrK76EyyYTImAIghIfNf49zlpDZHmk+8PAAtF8vwNe3BFAdk1T
 +dqUWU6jz10nia4XE8a5HlgpyWt3S5bxoi9JNRRUaMWQzowpT6RWNceMnAgx0qjE89ice2vlL
 5mWe2RcFzMM7mcIVIuucJ1WgTlvDrzoec5ng85ykjpVChqY7C1raM9qo6kQ9LQjx8MCXdBbSi
 VfkHG/6xMSgsIqiSBHYVFrMVwwtd34aBLhoC82L/Gqtbc64oukCQyz/YG+04o1hopAsllSMK2
 Oi8CR6xYUcwJdgvUts/H0ZCkthdhmzm/xb4WL7WROUEx346Hv75Q7/uCDsDyW6x6bVarEUTtR
 bSMHryFFcnxzbuFJbfWNbCYRVvuInw8iaiCbeHZBQBALNNKHbLLtedC44DjWxvprb6nFjA5Ky
 gZ34ZC7SN7O0zvxweL9KD23rYbIl8OkyKqiAweelevHjNxwplFGlwfla+jCTRbmxOyMAIOI7W
 2N1IgNBIt6hbWO57/U6Tm/ySM/ZD97NWzukNig8Nidwbm8kHh/nbJjBvSZf1S+irh/XVqiJiK
 FB+nhVzWf8QfQPThVxc8bHd5SC7EYoZ/GfWDwDHI+QLIX9qlHh+VoZitmJekY+qir3iGqmp6N
 bNIm+2+Al1CfxtqGayWmgW6/htMIo8mfYkRXOwUs6xWQLQarbiGOHT7BWFqPPWoNlsTqBQyuz
 ZFignGGqyVgzYgDGfh2im5RzGjHYulausxc9hg==
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
Cc: devel@driverdev.osuosl.org, Quytelda Kahja <quytelda@tamalin.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Check the return value of of the register_lte_tty_driver() call in the
module initialization function.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_mux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_mux.c b/drivers/staging/gdm724x/gdm_mux.c
index 996b1f538aae..63921bad519e 100644
--- a/drivers/staging/gdm724x/gdm_mux.c
+++ b/drivers/staging/gdm724x/gdm_mux.c
@@ -657,7 +657,11 @@ static struct usb_driver gdm_mux_driver = {
 
 static int __init gdm_usb_mux_init(void)
 {
-	register_lte_tty_driver();
+	int ret;
+
+	ret = register_lte_tty_driver();
+	if (ret)
+		return ret;
 
 	return usb_register(&gdm_mux_driver);
 }
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
