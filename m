Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3042595-1521470137-3-8984556394223534864
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521470137; b=fisdQgTn6P6Bikignz3lpkhe1Jmu596+5jsQIZ+Xpp+iRzw
    P5rZQUXooEaO2fO3hcmDNr1yehKqCE1b752k5Ms5Vf+g/94hTjtA9f2bwW3cE61d
    3n0kl1n//dB9mJoILULMZsGtEFykVmYD4+c5mzoI0+IQFeVAGvzTdPkUlp3iRMb1
    bbD9b95vZyPdhHt+sS8ZCJu5i/8dvnCuKbGgSAOCk+Ga3tF6Hb4ia6CTXSochZm2
    ngIw/wd0TTeiTQeFJCAOyA3bgGC7EabxpetY7o59PlHH4qfFtvDTq1CVtm8zEEzL
    X2waZO2+m0979U+OT6WuWMBdw44s31/kmu/foXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521470137; bh=G
    0+zRNJmoIYiu6hsmE14ooNqlxyyyZzKTaA+jsYGcjg=; b=OJ3KwQVOpSzrBJYFx
    lyFpXbLAoXdCwNZRNGO7nKHJGvbp/fgp0/HmZsceZ3D6l8V0eJ5vIdVHbrMv7PYZ
    BU1mtcGqUlB+Btk6wYkkicqcFz4zaj5z7WMwz1/QQ0+sOwTToaKM4q5zOGBr35yT
    xbbafdLPNdmvrSztsGi/fKs0Xx/AmoXwuUHSSwCUwBjG9ljDv3bwJCPGjDEBTJ2V
    o8YV67NZfht0SG6NCmk+gZpLOK9zo7uYG9lBOzSsItSxhLAZaDpQMw2aBIcpqiT7
    014AGC/57L30beD8KhDdUXO8pWCklvw96Te7g0ueKXf0Jsrd0oi7Gq0M8OXbnBkw
    Kka1w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fz1u60P3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=15 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeigeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffophejjfegudeftdggtgfgvghssehtjeertdertddvnecuhfhrohhmpefrrghulhcuofgtsfhurgguvgcuoehprghulhhmtghquhgrugesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefjedpjeekrddukedrudekhedrudelgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefjedphhgvlhhopehfrhgrgihinhhushdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepheejvdekuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fiipUWij;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fz1u60P3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=15 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeigeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffophejjfegudeftdggtgfgvghssehtjeertdertddvnecuhfhrohhmpefrrghulhcuofgtsfhurgguvgcuoehprghulhhmtghquhgrugesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefjedpjeekrddukedrudekhedrudelgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefjedphhgvlhhopehfrhgrgihinhhushdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepheejvdekuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fiipUWij;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvEqGTqIvkGAFhZrQU1692ZwmTsghqfI0MBcVTN9Nz7jVsrKVvNq8hikS7ly51I+hKsqfU3iw==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [PATCH 1/5] Staging: rtl8723bs: os_dep
Date: Mon, 19 Mar 2018 14:34:56 +0000
Message-Id: <20180319143500.19623-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
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
Cc: devel@driverdev.osuosl.org, keescook@chromium.org, johannes.berg@intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Linyu.Yuan@alcatel-sbell.com.cn, hdegoede@redhat.com, arnd@arndb.de,
 arvind.yadav.cs@gmail.com, colin.king@canonical.com, davem@davemloft.net,
 Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ERROR: do not initialise statics to NULL

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
index 9a885e626d1c..37ee8d90709a 100644
--- a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
+++ b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
@@ -19,7 +19,7 @@
 
 #ifdef PROC_DEBUG
 
-static struct proc_dir_entry *rtw_proc = NULL;
+static struct proc_dir_entry *rtw_proc;
 
 #define RTW_PROC_NAME "rtl8723bs"
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
