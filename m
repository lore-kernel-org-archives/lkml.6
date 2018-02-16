Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1225332-1518820037-2-10835852284421296616
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
    t=1518820036; b=J6jk6rkaLvWrQTKhAtwAOnOFKaDplnr0TB17K2KAJJnw7JE
    TG1N79OrJlw8VF380BrmG7EJXvN4R+yUpC+grzz6HlWY+bubtIDXxm1Z1qOrGduO
    M8r7frU5zDY4CiCGrnx2e047UPjpk81rIOZ+wWD+tFGW1RAYLq1LW4zzDJv7PQPU
    1LcPOEa8sOFb6vbbtEzZnH8sJdArf9TFjHYO4Cavkk0imdo4HbSGiiWjyiE+UohP
    /2DqRL7xYBachQyw8Hyo5Hypi62oV3Pkmti8exIzXyETqmOAXROJhowVScAREA1V
    +KH1xVMh5ERNGFX/rFmRj+lJfTApoBOn0m0mvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518820036; bh=X
    pFLzN8iCLxVseGWlOfqrI1lUg1PT4TXHt6tRYjvxrA=; b=EpzfFjQihoDuQS5k/
    edlNkV9A6hgddohPdcDeO7oUVgl/rYydB76PucjnkgRJ85aj600UwBFl+b7uk9HE
    a92uQmywJKdtPZo22a366zc8WoBo0pI+6fOtrfsA6TFAkuKHipjY4znyNtEnXGGX
    KKMGkni64ks3pa8i4aicMqXiRBB2srNs425H50lfjnPDqZOEN+SMgy+x7EUAsU3n
    W6b32egUJaBy/v3SqhRCYiLNR233BVkThRolD2fFrby8kYb5K1vdwZ+DIWrORY4X
    RwKHsDYpUvUYLwFFceT7IjVajwD6j1BG67VBN9i0FZE5w5q9kNOuPZ4IyeirekcZ
    Emcsw==
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
	gs051095@gmail.com
Subject: [PATCH] Staging: gdm724x: tty: Fix macro argument reuse that could
 cause side-effects.
Date: Fri, 16 Feb 2018 14:26:55 -0800
Message-Id: <20180216222655.23919-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:Z8VD5Ksub9CCT1NR0VrdbF1g/xTuK90BdTM4ECTWSlOm096wyqn
 2BlXjroyGnXI94wsGtJOVQiozylx+1Ta+WjZfUIoEzOrQposx995PX5gLnMf0n+Kl0OuL0O
 sIVcepJaI+lnmmTcVWgyNXDAZYPeBvHuxQAC1ZWvjg5vmi2aeXLBoYEgRw3r/5Zar3Sgufm
 bHM3oIf1JcC7vVLz8cbaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7vfZJRPoHCc=:bLP22YHByGHg20c9+r9b/V
 OqyTSgJbMMb/1mEtbKQ9o1AeAmIPQR7tJY3mGraPWCEpOI7gMD41p4kEu9CUWO7RBoPN1RlIW
 jo/7wwqJy9+722bUlDVXexMaEEEpNW1lK/IVvwKtof4MZeqt2QbUeBxIMVTXcq7kJ6l/iv6Fo
 /gt1hpjwwHb6Y/ktLmUrqQAsQqVoLG5xZR3p8suFGqCffwhSse9QNhyWjOx+AQWyFJQn+OsuP
 0wmzjFpLyMbMHfKFlAp7vN9m4kXwwlBR6bG31j1DG+TTL76LS0EkVGa9BifImUv+yFgwroTKD
 HbT/6vALXSdL9fWUrU0AdBlUiavuLankOql5dH+EVhiHqNNNyajJ7y51hHEuUG6XiS2gqJ4dx
 QL6cCb7LqNbAMQJht3nNlXOYD1OUMW2AOC8mhwSrvsdMl0P4Gj71iSh/l9frC90dRX1P9Xp5w
 PEMHASn5y0NxcjpZYlLwOhB2A+HJ5SapjSNE6GUMQEK41xcnBidSar5zR7MaHzk5yDMvBYMSD
 CHYjgof5LNr3LzlOHbesaMdWIJ8y2jFTpW/iXimqNBkQH2YLYDaQutbp4gCHwIPjE0aGlmeBA
 ROwmlwr4X3kCz414Z6gs8LKGfiL/GgJGnTM1BAu8STnwsD+lQ52pNF4xzboEqS+X9qZODMSsf
 a6S/lJdmCyfsrc2an3jTjugykJY+uPYyiRAVf+KTr6LsrEnwomhzJBfZdbeJeQla9/ciN6L3D
 Y/fepqw/FtcSzqLt4F33FJNe04yrnRMjFlXRmA==
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

Fix a coding style warning from checkpatch.pl.  Use GNU extensions to create
references to the results of problem macro arguments when they are evaluated so
that they can be used safely multiple times.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_tty.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index fc7682c18f20..73d39fa86d10 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -37,14 +37,22 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define gdm_tty_send(n, d, l, i, c, b) (\
-	n->tty_dev->send_func(n->tty_dev->priv_dev, d, l, i, c, b))
-#define gdm_tty_recv(n, c) (\
-	n->tty_dev->recv_func(n->tty_dev->priv_dev, c))
-#define gdm_tty_send_control(n, r, v, d, l) (\
-	n->tty_dev->send_control(n->tty_dev->priv_dev, r, v, d, l))
-
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
+#define gdm_tty_send(n, d, l, i, c, b)					\
+	({ typeof(n) n_ = (n);						\
+		void *priv_dev = n_->tty_dev->priv_dev;			\
+		n_->tty_dev->send_func(priv_dev, d, l, i, c, b); })
+#define gdm_tty_recv(n, c)					\
+	({ typeof(n) n_ = (n);					\
+		void *priv_dev = n_->tty_dev->priv_dev;		\
+		n_->tty_dev->recv_func(priv_dev, c); })
+#define gdm_tty_send_control(n, r, v, d, l)				\
+	({ typeof(n) n_ = (n);						\
+		void *priv_dev = n_->tty_dev->priv_dev;			\
+		n_->tty_dev->send_control(priv_dev, r, v, d, l); })
+
+#define GDM_TTY_READY(gdm)						\
+	({ typeof(gdm) gdm_ = gdm;					\
+		gdm_ && gdm_->tty_dev && gdm_->port.count; })
 
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
