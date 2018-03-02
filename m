Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2537421-1520027006-2-5789875794596552735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520027005; b=RAJ85T8qqk7/dvbGJkWqVpa3On9PXBuw7V8p5PYSX/JzVG+
    ytWbiiyNBL9EdRIoxj7uuII0Oiy9aOQEL9dmfeyOrn6zehr6Skjoj6gUinMP4PO4
    SL54KejcZsWcU+okNKTYam3lDdUwcdoDnyorXWR1JUzLwva01LV7JEfW4Mrj/SxG
    unKpJ/lUIly9Qf/BsqL1srrldDoNGYMjNAvMx/f3B//X+nzmrpGfdJAQOXAwie7E
    L0LGMXybIoz6D0GB45xRzE7Xv3g3avNC0Mu2pB3Kw7dN/SrjpXm6iyHSUYWesaGF
    ckmbogh9IxOgsLdaRtlMIpN18VE9t22dufhtSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520027005; bh=x
    A0xN5vJlaq6NGNuUN3TAa/r7vYcCM59C+nZf8bYapY=; b=qoTNBB8qftV8T4xhT
    H77i/u+RxFxEKnjvHvwb0im+J7UhUEL5JheMo5sGFWtS2j9+kABiBMcPrCv0kbWw
    NQ+iRHGpGH8f2XOqzqVNyZ9a8NINDWeUJYP0689A/k+h+x5tXcI+uZlnO3qHwAhY
    if0SK87vY3pHgEDcmlxpu/u7XiYXB4W/x/SUlAQvF1m1UwljNnXWR9k79OrL5AxT
    dztT61RtrPob7Gs3Gma3lHJmOnZscsAi9DQZoW3VUR7TLnMm217NfX1XgDUl/wkj
    DwG0aBU+ZGQ31cBKIPdsPaZac5px+VT5uzU6ZQmjgt7MXZsRZP0Yca/RFxQ/kVdW
    5V2vA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TUohz53Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MOXQxw/H;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TUohz53Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MOXQxw/H;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELu+KCaFZQO47VuS3/JDiZGWFcFREllj0WNmOb+xbs0mmQDWzw7GuKSwCc45FlejLsqdpy9uqg==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: Larry.Finger@lwfinger.net
Subject: [PATCH 2/4] staging: rtl8712: Added spaces around '+'.
Date: Sat,  3 Mar 2018 03:12:19 +0530
Message-Id: <1520026941-16548-3-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520026941-16548-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520026941-16548-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>,
 outreachy-kernel@googlegroups.com, Arushi Singhal <arushisinghal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arushi Singhal <arushisinghal@gmail.com>

Add spaces around arithmetic operator '+', to fix the checkpatch
issue.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.h b/drivers/staging/rtl8712/rtl8712_cmd.h
index 67e9e91..9181bb6 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.h
+++ b/drivers/staging/rtl8712/rtl8712_cmd.h
@@ -145,8 +145,8 @@ enum rtl8712_h2c_cmd {
 #define _SetBBReg_CMD_		_Write_BBREG_CMD_
 #define _GetRFReg_CMD_		_Read_RFREG_CMD_
 #define _SetRFReg_CMD_		_Write_RFREG_CMD_
-#define _DRV_INT_CMD_		(MAX_H2CCMD+1)
-#define _SetRFIntFs_CMD_	(MAX_H2CCMD+2)
+#define _DRV_INT_CMD_		(MAX_H2CCMD + 1)
+#define _SetRFIntFs_CMD_	(MAX_H2CCMD + 2)
 
 #ifdef _RTL8712_CMD_C_
 static struct _cmd_callback	cmd_callback[] = {
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
