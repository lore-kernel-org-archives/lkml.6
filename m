Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655620-2-17394437799271606229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655619; b=Alf6ht82kxF832ErUNVhLX9aEk9lvNQKq8xyGXf2RSAGaQ2Mho
    ZKJgRZ7M1/r1P5pkODFrSQRBcmbThXzlDyvavp+A3n5I18JJp5eTqlbdbK2SssKC
    sY+EZtZJ/8QzKBFwoD5YJLuG6FZQxmHuFLBwws0D76/Xskxgnvhn85Yl2XBIiCsJ
    hBzMn4DrUDGw8te6vJxTOmix6x7bZCgbZ49x7uE7OUVZPuR8yi6b2ZMijfQ9OMgR
    5AKDzHDfHezQM6o2PM0T5YPVe0YEDSQ8FV7MC3zLKYGtnEurncw+aemIED3JP+3i
    t+A883iD9jhXWv94jz3nZ5/Fndn0A/bBASjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655619; bh=ercDl
    Hee6n7ahz61AuAEso8edx9+T1Ae3F+8S9FCTnI=; b=iWc2Po+rYKAZ0i7Kmy6dA
    cBwtjQMb5fsEzKZ3GsVSxW2mw9qJ0uegjICmZONukrj5Bh2hshRae1DHBzrFXMsV
    RUBMMRIhLmalEwQk3/q3jw4Okf60Z9DA4hy2ynwr5PsUtH+S1OcNhKJEYTDJHbYs
    XluarQOKKtg6hmMstXxp2fThZ0ZREJWULx6ilKIvvZVBT6HIawEQXpa0SMmm0Zfm
    LBRIETPInthezY5I28gbxfwRFI1jpaDx596kEM1zQc0YN5CTDFdVjccX/mbD4scf
    qv8qrOqHUCGbu6M11LKU401MTCwGjNCWAnDM72XIPBXa1+RcSnmqQB79N9tM7vgs
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=JQos1QIO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=K2XgK1ne;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=JQos1QIO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=K2XgK1ne;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAsgbwzfqsfJqHq9QaBxjggv5U74l/cmGVhQvEVe/Bdy1NfEoNDatdEK2WZIQS5Vx5D8+94nBVEEgqJ6EtqGREOXGLmzu2SlafyP93m1EtsKxW2hoBYi
    vnh34sCqC47juMosG4PJeTMem/bCytUkEjE14ZG4sHNZPKm/P/9XDGNZT5VG/t5+iHBFtU4iVS+9pPn5LHHKVe/Wg5k5scL23itNkOJM/DqNgEv21KXQmrxE
    W6XMMvllOwRiaqFjGCUrjw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=uWkGACebqQqNKXD9YiMA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqZ4x6CFQnFqy/wxvpJSvDzqxt3DEABNhHOO2a1I2nD/ij2r4dd8LPhBlxl5Ayu3Xh9gemDAw==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 4/6] staging: android: vsoc: Fix ending '(' warnings in
 do_destroy_fd_scoped_permission
Date: Sun,  6 May 2018 18:13:26 -0700
Message-Id: <20180507011328.11982-4-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507011328.11982-1-natechancellor@gmail.com>
References: <20180507011328.11982-1-natechancellor@gmail.com>
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch.pl warnings about lines ending with parentheses.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/vsoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index b5307fa584d3..7e9cf3e4fa04 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -367,8 +367,8 @@ do_destroy_fd_scoped_permission(struct vsoc_device_region *owner_region_p,
 
 	if (!perm)
 		return;
-	owner_ptr = (atomic_t *)shm_off_to_virtual_addr(
-		owner_region_p->region_begin_offset + perm->owner_offset);
+	owner_ptr = (atomic_t *)shm_off_to_virtual_addr
+		(owner_region_p->region_begin_offset + perm->owner_offset);
 	prev = atomic_xchg(owner_ptr, VSOC_REGION_FREE);
 	if (prev != perm->owned_value)
 		dev_err(&vsoc_dev.dev->dev,
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
