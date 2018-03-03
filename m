Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-794649-1520105227-2-6693932817737654505
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
    t=1520105226; b=ppV6tNq9qpb7d884SgdmU7kW4/CBf5M8RDDdyadUeeEtE/+
    oNMDkRpRUyruD1HZhTEeFHBcPVlZIvW2aBOiL07sJNGjBBoDJIIktKA5r38iqhxp
    zVrT/lHLrPjqNZCiq+PC3oIeMUr68kHQIBHttnR1BrWeIbsRQ4W5Evx5Fd+rlKr2
    izqEPMIX4CHIa8QT298jp6AQZGpNAEMpC/qaKseAFJHC6VDZYfxgslE5Gzlk7VNA
    Uk3UXFatj9yo5vURzLXgp9QyAHwzEbL8g51WPUtVN5xNyqcsC/6NlH9zEyOfYo4K
    4NR17AXxfNhLsKhpz2kuP5Kxq6vMxMgCvf7j9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520105226; bh=A
    wufiOQ/5tVkHR1ZN+52lMsPn3+5LfRWIKArnuuy+O4=; b=fJM+rhe1q/N16Og76
    aItiV7cbxhgdRzxqKR6utE+KB0nTnMo5gKtTkxsgwHhMnqAlCvoQreCXx1BSRB5A
    apVZ7xSDpcR/TLvOKHTyShq6Crc03lP52yXFIRXVkvMH5YoUE9kRCpjAu0wK7Woj
    ctMKgh3XznHXYGkM77uXgG0DJutaV51Azbel/rAVMXpZI3V5+G3LKV6OvUQzJE+e
    VCbXi/3DaIRrPf5SZOwXPgxRAN/A3uqyxLZ8hDXu31N2oQ+XxhKbs9QHuRG/DmP5
    8oi1r8Fxe9vfAY7T6I5Qcz8up4nY/cnTBV/XTxQ5ifKPBvf7jKdEcsLXSqUCU0ZK
    Jl8iQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q27sMiSa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LvEvaScn;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q27sMiSa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LvEvaScn;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtaShKBmnJSNDEogt38EYxewPIZcMGVtb510rgriXqpP540vL3DtzbkGKrHIZagJEAr5piHPQ==
Date: Sun, 4 Mar 2018 00:56:29 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: alan@linux.intel.com
Subject: [PATCH] staging: media: Remove unnecessary semicolon
Message-ID: <20180303192629.GA5198@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary semicolon found using semicolon.cocci Coccinelle
script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 .../media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c
index 5faa89a..7562bea 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c
@@ -196,7 +196,7 @@ enum ia_css_err ia_css_frame_map(struct ia_css_frame **frame,
 						  attribute, context);
 		if (me->data == mmgr_NULL)
 			err = IA_CSS_ERR_INVALID_ARGUMENTS;
-	};
+	}
 
 	if (err != IA_CSS_SUCCESS) {
 		sh_css_free(me);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
