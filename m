Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227156-1518435292-2-9769364153111801443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518435292; b=ouqApfhfVndKdMW+rFxybx7HK3cbGvDltdS/WbYyNEf2anL
    6OqRq1gvMkvoX7XJM8ND5XiQTxUDPBoPzT7XqsGcjhJOEciiQZZO1IPg+XNcNXQJ
    JEiGJCW7clbWwbcDaJjBMvyxTCfy8H1W3iFfBZuI+8FxnwcdFqCGrYcHJ7KYENgN
    HQt4wpPEyLlO1TWWyN8ksDihJIa/ahOsAc/o4g6Xwj1wd6NXyNElFx8HpvMQZQ32
    qyAIYWJ90Pf7MPFU2v6REKCd72PUFDwIRcDb4/eDVMrQGL76g9Wy8BXAFzVbPRsl
    ArL4Ms70in32gi5MEv/JV1dwPn7eTgWobsrg/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518435292; bh=f
    9X5hLPJPkHZ6JPBkD3ON952pX9NfWj4thupF52yWT4=; b=slv3JAf/zckrKkd3C
    yc/Az3VCbClav3/kjjox2HCRWNezkML4JjO1daI6chpVZ31MxwLiWtjikyIOZHZ1
    e5DDFn8lekPCU5Xs5LObMT1H7NCcEPbH8in4KqAbG0OOTK2bA6mzCZZsJQZeHH/Y
    sYgqBRLnZHgBsFiTSmgaF13avmEOmZ/ObjPdtdft+J241VLcIf/6pwEywCyi/VDO
    fIDQPR4GDlrsFDu79fxeYdotM4nyvVRW+Z9Je1TjyvLoHLFPLfkyWUEav2d/Tf0x
    GsK4IC+MeJkHZwP38c6BdChFiBbwEf3G4Ujkxx+BsSCSkAMdpYddxXPINQFuWCqq
    VP7OA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jvGRroaP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WGUkUKwu;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jvGRroaP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WGUkUKwu;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2259KKQ05FkywnsGMZTRclTa5rSjWFVkdwdHDDy4qaouS17J5U5TISIAVoEI0F3fXh10DxVQ/A==
From: Dileep Sankhla <sankhla.dileep96@gmail.com>
To: Forest Bond <forest@alittletooquiet.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Malcolm Priestley <tvboxspy@gmail.com>,
 Jitendra Kumar Khasdev <jkhasdev@gmail.com>,
 Dileep Sankhla <sankhla.dileep96@gmail.com>,
 Arushi Singhal <arushisinghal19971997@gmail.com>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Remove unnecessary 'out of memory' message
Date: Mon, 12 Feb 2018 17:04:27 +0530
Message-Id: <20180212113437.8953-1-sankhla.dileep96@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212070218.va2zivzu6qdejk3n@mwanda>
References: <20180212070218.va2zivzu6qdejk3n@mwanda>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch removes the unnecessary out of memory message fixing the
following checkpatch.pl warning in usbpipe.c:
WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Dileep Sankhla <sankhla.dileep96@gmail.com>
---
Change in v2:
- changed commit message
---
 drivers/staging/vt6656/usbpipe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 273176386a51..5bbc56f8779e 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -194,9 +194,6 @@ static void vnt_submit_rx_urb_complete(struct urb *urb)
 		if (vnt_rx_data(priv, rcb, urb->actual_length)) {
 			rcb->skb = dev_alloc_skb(priv->rx_buf_sz);
 			if (!rcb->skb) {
-				dev_dbg(&priv->usb->dev,
-					"Failed to re-alloc rx skb\n");
-
 				rcb->in_use = false;
 				return;
 			}
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
