Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2125575-1518985681-2-7619128161019671206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518985681; b=Y6gOPJwtifd2wMj/fPkiBrII0ciCozV1LuT0ft86ywU2xwo
    z9Hfwjec1DoLOUIpHQ7bzo553aN54zc8zYJ5M6R8BUeqQzVxRXRIil6eHIlhIT4u
    6Eu6tWnOLooJ6HZV0nS46evKHj/U/ns4FQmaKzo15tffBVFTqzxJoL2lGEiSR9EF
    EWkt79yAoPYxjJkrkrbeNt+oiPM1Ayu6+lsqOsiKDQtfdsNPnL8rhPjvmvG6v6Ng
    edHLJUnMDpl8Y3vlbRpieGSm2F2wF+RfNOowP2dTzezmVaF7dm9p0Aq8i6Vm2jli
    YWUG/ikQfS5K1tfL6VstiuEw4KFPVpZIflsOycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518985681; bh=k
    Fk/umqysMIljpfIaYcV1GoanwcrPE4mfcvPZH8+Fso=; b=CsIxsXciJjyLnwIm+
    VU51pDe0QFjY/TGrt1CgePpTM0fq3D9IbkK5nG1ZXr3cwT59dXg+tAT0TMp9YL2H
    WDe+cTwGIsvgYYslVYi+6oaHH/ipRXbwYYji7QKNWMNw3R+rg3+zlOwsbMvSrAA2
    EqGvb+NIC2t9Z5glrnDRDCc0qKMs0WBOP5sdpyOnJ1WaONsMMYFkDpmUviQeO0Oi
    utJasKiB6VU1mc0BKqsFsZvbdIsvOH/y1MSg4oDUKvi4C/Kt/x06hwabEEB6qykt
    pM3mSiul/tVPMRjvTsnXFjW0qJHsAPNe/Ho5P4eCmiBPMEqlfI9NQm1hmcHAApsO
    ip3XA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, gs051095@gmail.com, jonathankim@gctsemi.com,
 deanahn@gctsemi.com
Subject: [PATCH 3/3] Staging: gdm724x: tty: Remove unused macro
 'gdm_tty_send_control'.
Date: Sun, 18 Feb 2018 12:26:55 -0800
Message-Id: <20180218202655.5738-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180218202655.5738-1-quytelda@tamalin.org>
References: <20180218202655.5738-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:KF9IOpW9SUfewTaFxwJBn9AimcyNmPgKzPpuSPK5380MNj+sZe5
 C4U7FhHUZKQR4NDMXgdFzgLY18W7NJnIIi4Nislv4Ae9M6huqw2b7CNp7MUcCsAKOitTw76
 wNPAV+xudhkV84u+/JoKAT70eQe6K3KcDoVSpVQ6q3I1hEjIzTZebz2+L9jnlgK7Ar0Ux0u
 /ocosxPG4H3aLjprP86ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sriBIUeeXM4=:C1lQ8E0j3EmnPh+lkoeyXV
 dND/boeANHFTX9kHQ05VQV9FhhJVPEJYQ4GSL/dgYIlahKQTFEmwjrazt5EbccY/ljRCuOsGM
 fCQrM+ogKjLzwKje2GRHv2TfznRhZyVyUnablO+b6FNB2858jPtIwDz2Q/5TNlH/XqVtu4nLJ
 Gic0Kf0wovGvpZhyCmm9fQP7PsLaC1F/yGDrGvwoYFGniMRArhY3h1GydXowxxn603W68Xp90
 21Jbi5oS7W9PbqF8OL6TW1g3RemRayJY7Vux1k1YPbn8+6C6f3sh1Uv0eWZMGMuOxXAqfUx7n
 KRES8J7V73fs/hzS3RfN0HNZaSluW7NpimYpXeBe0PCaCZKp7dBIHJUOc1NcfzVTQcy0DQ1PZ
 UecSmmqA9umCAVqoR4dudsNdIluixCJc7rTbZozMVVsuEbKi8DPjMTUHpk05g/ft7qZow5bo9
 Jj0qcux88HS0zUzlCpZ4Ecyg7AhtugXXlhoKhB7WJJh51d7FB5H98RkfU9ifWrnTA7tiJIEAv
 Bgli4+cxS+Q0XPoO0t8cwVO8XqYvPHO7j1bo5cHXSmwh2FbM0NiijTZfGOEz2tejW8xpxOHw8
 ISyXyZMxhrPtJg4erqzSOVoFOifx9D/oYdMkmywGmnv79rtJ/n2VOrpruvUdKKlNdSKKkIGLN
 Z522tlnR7Be8LDbe630FMLg4v2uM9l3EhJnBrRqIfwgamb3Wn/sJZqUCnlbbGCDTDhDDKGjnA
 H3KyNdrc2z6PY5CCWMjCmzd9gu2y43RvkGBiRg==
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

Remove the macro 'gdm_tty_send_control' which adds unnecessary complexity,
is unused, and has arguments that could mistakenly be evaluated multiple
times.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_tty.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 25357dc3d88c..3cdebb81ba63 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -37,9 +37,6 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define gdm_tty_send_control(n, r, v, d, l) (\
-	n->tty_dev->send_control(n->tty_dev->priv_dev, r, v, d, l))
-
 #define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
 
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
