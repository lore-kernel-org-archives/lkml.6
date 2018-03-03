Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055248-5-2260819512062119192
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520055247; b=YS81L6vyTm9W1eYxUHQIR4hsfNL+LCOg2ifpxdtA9SglPfK
    DmSPeX8i4yj9huNr9IdJpdt6EkXD150bR136LgC3keHP97CJS8X7Q4T7pduiFeS6
    k4ZvSCkFHRjov7JuvyDJeSt39Prq4Lefk25DNjQHBCMaBT0wDr/qUugM12MEHgwR
    rsHgKtskz1y2wbSNCWE9zuFLWgORU/p8nj04uttL3dQVPuaQP0jnKqWirgfWs3lV
    xgk1U3gCHvN3gZh+JCOPWejUUEVlcQplC5kUMbPTIhkzlcqeYYRl40V6Hj2O2COa
    Z3aGg/NXJuwu1zuiZUDruldpUtyKD2ExJ2HzTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055247; bh=l
    /JEcrG6bwuvXa6swYQ0qXR8hDrVZTAq9MTUcvqJ24A=; b=ZLk9cgiNA/YsvnrXI
    mF9It+Wta5oGCYoGza7/tkAJJ05FvhdFdb0w5Kouc82svhvnBGK7ijRdiPK2SER/
    +ZBdgVUYvPNDCkhs+Ckry4PAXyrBMYn/A5Oc+AofmbBq7PoDTEHZbJOj/HK3A5PN
    7ij37cWbo5iclXqaTrKegZ1VELL4sViUsJh4jchH+jN2BOv0/bcdfJDGuGytzZV2
    LnOr/y+sQnI2REFHugkR/+cG7WjneF5bZ6DFVZ4cfhWFLd9LvVcnO8mWiepM92Tr
    VPEZHexkkR6MSMovrNPuGMzIhSk6/QQMi5FuVtXCDexd32g1b+ebfEmcPsoIkzpn
    5oU6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NnrEf6qP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X1PjP11N;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NnrEf6qP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X1PjP11N;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtNpAdcjrwZJ9zWlb/YnA4/uXySYJtKWhI1IcTkV36bxFCZepUfKCWGvG7vLpIbJ+fKOtiOxw==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 4/6] staging: rtl8712: Added spaces around '+'
Date: Sat,  3 Mar 2018 11:02:34 +0530
Message-Id: <1520055156-8388-5-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
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
 Arushi Singhal <arushisinghal19971997@gmail.com>, Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add spaces around arithmetic operator '+',  to conform to the Linux
kernel coding style. Issue found using checkpatch.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
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
