Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2125575-1518985679-5-10677950812615732237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518985678; b=sxPTMdG0H/ym9dqPGp+YuMXuTd0yN2LjJsLlA6Q3dwlHsry
    vJRQn61qEnpSepEchtb3W1WR5kA0xxdU1npz/lkwmBOgxz2rSBy6EFQpxI8dz7q6
    Wm1oIThdXPDN3lTPNJf49XCkH67wNFm5RAwH2Y+AHHYTe1a6bonRaP6ZN+017pl5
    3iaE37TeoKsozUtlsLeaco5q5zvB3QxaG9t4Vbgciw0QXbVKjTwE8NqJNbKu9ske
    JLidWt5JqehzDOJ8OgawB4L0IdksDxSESE9WeZmNBsteuXIRp/b2krXJA1ogyOc/
    9U15jxWTapyOYdTjWwe/FbAswHqUCfMfxy+fyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518985678; bh=V
    jkH3s038A+ABrmWI9mTMEgvgbcWO6yxZCdIfpVzc5Y=; b=eZoHi6b7kkaVTjrxg
    eQgv/v60R04qC8I8s5tsPwBmsTBOBPW3PhvuTdci7Qvp/BTv8saa+kIye65dNTLv
    qKOKjTLsDlfz5Yk5hqWbT29ZAf/xV9Fls8zscHHfavWUFCXc1ECwPYzGLuOezSg2
    0b5khVhzllKFtISK7IaEz+OurKNCxJcVPTOe0k/+yDIVkOBXjmfBAQEWWffluq70
    7SzgBTwDTtfbYJjeQnuuJnZai8GB2w6KVzkpj8R0YOD6n3SC7mjk+6YhAjzRCOPF
    wO12ynoNq4kKeyvzqk5YyS/DPMHRgAVhMtSEdYOyfj95MgXIBcwwDD/QLlRKe3iF
    NXpPg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, gs051095@gmail.com, jonathankim@gctsemi.com,
 deanahn@gctsemi.com
Subject: [PATCH 2/3] Staging: gdm724x: tty: Remove unnecessary macro
 'gdm_tty_recv'.
Date: Sun, 18 Feb 2018 12:26:54 -0800
Message-Id: <20180218202655.5738-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180218202655.5738-1-quytelda@tamalin.org>
References: <20180218202655.5738-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:BBsUWQUPu8FvPxCDX48pOmA0WNqI8k/LGqV8e3nSDWrKYVlekJr
 PHORG5CuJbWqYGOk9Vmh+N9xUqk/GI59TM5LahRCBUvwZsu04lVxcNpX5/xhzjp0oLyissr
 D9SSDp4pa09OG5f5U1ZLxBot85TC66YmN8TkSpPMS1Yk1/ICD4SmJsh5Kx2irlY/FNdTAuF
 Z2ORDz+DkGcadI2po22WQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lHXe56pTzP4=:wNKj5/3LelBZEu1g0Okynj
 chD6LTZVWv3Oddhpr+gaIcI+c9is1eVQVcPuchCqmoIPe9MzP5LTq+55fLiaEoAtWSfhAwA9m
 ItR2M+HZpnLKTK/6KeNCkgpiRTvmynEk/5NXRuO0S3Z2XKWU+JB1R0BIGg2ZOP7in2i3hKY8F
 JQPOXCZuL6RstjOAcgcYrf0B1glx0CUkK6Qf1n6s2i8CB8j+X+0QPOoT+bGlg78rOyIyneULZ
 lcva+8KUMda1NSdOpOZqVdldwmn37vfJlXiV5jY1a1S/cfIPLEoEB2vUAPTE1+Uh4svkCMa/O
 z1caYv3IfARjvy2uo6Hy6NtF2FjXO2huRON0+fJ0SFQv8B4kiZmYkutukqduKHHgcPywZxNVi
 UZHwmrNetPxwrEsFCqdR4/XrlCsumU5v6KyEJh3gnxvC73kMAZWl7tN9XeS5TKgxWKC9uIEhL
 G+6sEde4Y7yX4WRhA4M0rv+F/GjBn/hj6g25EjHWKq4DO6E/+yVqP8M+KbugwhUFKfDhcYxuF
 UH+I+cw7txI/2ghj1alEDCRQ8SCFUWKwZD4giWXkzjyJ27LR5o3zBLD+8x23LZdgfkSaXkLqG
 hsVjFvgWGh9w88Op/3BPzVjhUUu1rNY2xxeEle2JnIPWJNGqsske1mv6cWsmq83Yv5FOO/AGe
 HiIvWeHjGpUZeSY/ay8hjgpNjSCfGKnhLrB+gA7i4lLP3C+r0zPTEYWd3jLuxc5NT5joOee4m
 9wYiyMMiK2vluaDGkoXm8igVstH1D2WVP00Ftw==
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

Remove the macro 'gdm_tty_recv' which adds unnecessary complexity and has
arguments that could mistakenly be evaluated multiple times.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_tty.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 1c3853bcfac2..25357dc3d88c 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -37,8 +37,6 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define gdm_tty_recv(n, c) (\
-	n->tty_dev->recv_func(n->tty_dev->priv_dev, c))
 #define gdm_tty_send_control(n, r, v, d, l) (\
 	n->tty_dev->send_control(n->tty_dev->priv_dev, r, v, d, l))
 
@@ -144,7 +142,8 @@ static int gdm_tty_recv_complete(void *data,
 
 	if (!GDM_TTY_READY(gdm)) {
 		if (complete == RECV_PACKET_PROCESS_COMPLETE)
-			gdm_tty_recv(gdm, gdm_tty_recv_complete);
+			gdm->tty_dev->recv_func(gdm->tty_dev->priv_dev,
+						gdm_tty_recv_complete);
 		return TO_HOST_PORT_CLOSE;
 	}
 
@@ -158,7 +157,8 @@ static int gdm_tty_recv_complete(void *data,
 	}
 
 	if (complete == RECV_PACKET_PROCESS_COMPLETE)
-		gdm_tty_recv(gdm, gdm_tty_recv_complete);
+		gdm->tty_dev->recv_func(gdm->tty_dev->priv_dev,
+					gdm_tty_recv_complete);
 
 	return 0;
 }
@@ -253,7 +253,8 @@ int register_lte_tty_device(struct tty_dev *tty_dev, struct device *device)
 	}
 
 	for (i = 0; i < MAX_ISSUE_NUM; i++)
-		gdm_tty_recv(gdm, gdm_tty_recv_complete);
+		gdm->tty_dev->recv_func(gdm->tty_dev->priv_dev,
+					gdm_tty_recv_complete);
 
 	return 0;
 }
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
