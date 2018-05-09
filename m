Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-888773-1525895065-2-16081037413460475505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, URIBL_BLACK 1.7,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525895065; b=Va9I9AZx8jd3c2ka4EHhI71LDpNXb5IzOVR3ROkMtsShrxkBtJ
    E+QFX5W27OrjQeLtmj37C+Zu+kJrH7dO5G//juhcwcego/s1LGnSJEzh+5lzJUBT
    4dXpC4FX0N7syhYBBk+pMst7dZGuQ5qf+V7znnkeEfur3gZ00w+v1RcOReqfkuFU
    iaNqvtdsbVgh61W9F3VFWehDb1JGqBRja4x7rYvlfb93h33fLtn073sQ6nKyEsVA
    n9ZZI+ea75rUgfGP2tQ2QL2jN74qkmjq2e3zHkObs9h0SxiSG5kLo2493G/hq4Kl
    +3mabUvZAZrmj9HZAckEY3A1+M2qX0gcaEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525895065; bh=C/lBc
    fP4icaL2t9vqGKQR9DE7231HZMd0Xkxnt3rp1c=; b=eQt794zniW8oo2A9kRXbD
    4Zqe5LbJuyxbfhsPjYW+BT+TbEh90YwTtY0HBKBaQAb+K3vNDyW3wgjAV1tEnxuW
    y1uyMeOlBy+sGjbZT7Un8GlIkMWGvr+J18sa3JLvH0Ky6kYtjZTtoa6OnQYZu16J
    PsfAjciWXkIvQ83/FA6Syzjw5vlIs9iOGgIlakYfgBnTJnOa1h9zhoQpQ/8BCWw6
    aC/gcnAFQbdWNK5ENnHYw1b9H5dLSagxNkwVLT6LV2oqamI6K33rVG5tCpfRjsJw
    t299OgvhqXFwW7v2mEpPFYkYJSNMrhbRNYXz+lty8SB/DCnsrzJRdtc8su1cf0I9
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Ad2Wnndz x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=oJDxDIm9;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Ad2Wnndz x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=oJDxDIm9;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNgGDeAEc/aDeL6MqfZD/GDj7tIcCH3oBBhmyTmfaM9uk3FL46bspZeqtSV9EZCjLpisxtby9ntE3ackDWlqFnUwPjw2wiXmlVlTfXYdX9l5Fxz2+ly/
    XuLHuIw9BskNXImVxGyrOnxLa5BTJYOi5lSM/p93U03SJT4QtjW19YQbGq9XicToWxFx9sCBUWb6wc+sCYje/jBhNOA9g7/qw2qso5/R9ZPbkIHiDd8svDwI
    3dkfyIVyDAIeiu6BlGoecg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=3BECGnMkOFYA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yQdBAQUQAAAA:8 a=DDOyTI_5AAAA:8
    a=ScQNz3MzK_BIX4Y0yCgA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=SzazLyfi1tnkUD6oumHU:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoXM7C9jmhZHi1nDf0XbVopgeB5oVcHB1ZoBRn0lAyj8C4pXVLITTQZSs87vjosE2U+4fzirA==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging:r8188eu: Remove rx_handler_data unnecessary read
Date: Wed,  9 May 2018 22:44:06 +0300
Message-Id: <20180509194406.22617-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.16.1
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
Cc: devel@driverdev.osuosl.org, Ivan Safonov <insafonov@gmail.com>,
 Larry Finger <Larry.Finger@lwfinger.net>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rx handler (assigned with netdev_rx_handler_register,
called from __netif_receive_skb()) uses value of dev->rx_handler_data.
The driver has no rx handler and does not need it, so remove rx_handler_data read.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/TODO                | 5 -----
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/TODO b/drivers/staging/rtl8188eu/TODO
index ce60f07b9977..7581e25f231d 100644
--- a/drivers/staging/rtl8188eu/TODO
+++ b/drivers/staging/rtl8188eu/TODO
@@ -9,11 +9,6 @@ TODO:
 - merge Realtek's bugfixes and new features into the driver
 - switch to use LIB80211
 - switch to use MAC80211
-- figure out what to do with this code in rtw_recv_indicatepkt():
-	rcu_read_lock();
-	rcu_dereference(padapter->pnetdev->rx_handler_data);
-	rcu_read_unlock();
-  Perhaps delete it, perhaps assign to some local variable.
 
 Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 and Larry Finger <Larry.Finger@lwfinger.net>.
diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index bda4ab879f58..7ec53a9dfa27 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -121,10 +121,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 		}
 	}
 
-	rcu_read_lock();
-	rcu_dereference(padapter->pnetdev->rx_handler_data);
-	rcu_read_unlock();
-
 	skb->ip_summed = CHECKSUM_NONE;
 	skb->dev = padapter->pnetdev;
 	skb->protocol = eth_type_trans(skb, padapter->pnetdev);
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
