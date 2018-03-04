Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2826322-1520173064-2-6943835112418826542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520173064; b=Z4LunFQBxuNjaJxk0NA/b/IFqUfmcZhhnAn3VoaEqobH+sI
    anEKGe5G15/R8jdClFUEGIASRokxn66e1hhkKy1Twqt3ewZkGOqw0peOJzMBdwfw
    TSGvnrhKcHSxfzDYzubl8sCNYTbgev7syRozuVnLk4LAtaqewk4n/JlkyEca5yGe
    v0LhjWisb9/eCXBewD2nJh67pUILLiRrc9cjLh9/tlipwRAbRdj9XEbLsigeseoy
    9901Ny0xzzeP97c9+kmFNfhaN4i34XKgTVdY6vBfLcY7sTGLxOKDAkCrE86lhOYO
    hnoaNYt18iO2vWyaVf4Qrt3wpip0vYJHiQdi67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520173064; bh=E
    e9mgsdU63KBtSpase4GGkvsfy91ebySRIYQrGDlI+E=; b=l/w2UZ8OXWRVX4j75
    0UYsWxUqpUuCfj9LnXV4rZYC6nuoIY78fk0uCZVuFms2wUSJIO+t1sIFRAVujXGB
    wzyfQjPygX/ecnRjUQZ0RmH38/0TlEiHMCZxe1X9eOed2CmrE5cdaqsbZ0CzQcq3
    PnBMxKgZACfy1c0ZtDmXgIXjG4OSzC33t2BqK5TR6NECgJ1zy38aKwYb+W5QgUBr
    Jrb1Hg2KJ0ZuaOJCWlhAz8c+jAd2s6rvW4YYcfqYwyNAl644QFwCV6C03Xh6lJBu
    Fl83L8VPQt6NwT/e5SAfQIXK4U7oPkYWNL6rs5GyORPXQpc6zfWdq/ivtqJ10Da7
    Qy+/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sPWoNwfm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yr8oa/SR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sPWoNwfm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yr8oa/SR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELty/vkBj3i3zvReLRc1E6SFn8k6WesydOgnorXYvqjoahMRG+HkiTRtrBDIkM+57L0qOsj0/g==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: oleg.drokin@intel.com
Subject: [PATCH 3/3] staging: lustre:  Replace "dont" with "don't"
Date: Sun,  4 Mar 2018 19:46:08 +0530
Message-Id: <1520172968-17448-4-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 andreas.dilger@intel.com, lustre-devel@lists.lustre.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace "dont" with "don't".
"Dont" is not same as "Do not" or "Don't".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/lustre/lustre/fld/fld_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/fld/fld_cache.c b/drivers/staging/lustre/lustre/fld/fld_cache.c
index ecf8b9e..2d61ca4 100644
--- a/drivers/staging/lustre/lustre/fld/fld_cache.c
+++ b/drivers/staging/lustre/lustre/fld/fld_cache.c
@@ -263,7 +263,7 @@ static void fld_cache_punch_hole(struct fld_cache *cache,
 	fldt = kzalloc(sizeof(*fldt), GFP_ATOMIC);
 	if (!fldt) {
 		kfree(f_new);
-		/* overlap is not allowed, so dont mess up list. */
+		/* overlap is not allowed, so don't mess up list. */
 		return;
 	}
 	/*  break f_curr RANGE into three RANGES:
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
