Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520236242-2-8073658446520974959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236241; b=o/yRa7zKDqJRT10ZklNdDYUf0PsbbnTmA5O2TrAWukwaPbH
    B9o3bwoAejd2Gm88LwCUkc1KlC90poyTWXuSsWrv6wRoh6548wqxkXULuvEMCaEL
    /QKvppuV+y33E73INlPVnWKozpRiFnLjMZ9qurkiB8pzWlb9q/JISyKg3V6V3a3p
    DbEUEWQTOVKgucjwVhgA0RJghEa13zwyiQRXpa0GjxrLqyCdWVN45q3t8LBPWva7
    WSRj5fo0PPxg27hkHy6TbnAKl0h8nCKj94KQeq5loaHM2iQ7pV9OqeajPEIhA37g
    ONIs4kZzcSK+CVzlB5AC6EZ1u+K0P5JrhM5T9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236241; bh=w
    0iIUyGXhZBXO/4U54lYBGgCu0cDLGuX0aWi9HRGHTw=; b=bd7FtgZ2bCltEaRTh
    +z1NKyD8uVvPU+V+BAydLCzgu9qpeOhOoSOcJLfXA+Mp6OZ3tX54sgqe6Z/K8MoA
    IME/Yayle1t5fR1VZx3QS6QhuGvq7stDzMIzeZ/g8DJCVRBT1kBGTl8gQzNeGrXi
    YkMbyjYMhd/YGPqzMny6cUTTaca3cYHp1P4Oly0CGtABWDDO6oqf18ZqwdVMuRpe
    D+GGTWHP01Be+loWrEikGcL3FZZZbs1fiB0rHbvuPGbxkdiSsT91d18U774l5Kwy
    s0fa2g1URwcOR83bYWP3aHY6nzjYzRmA97RTxox8mYzy/+QnSkhPYxgoAskh247K
    I6B7w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lZRE9kNW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CRSGsAcJ;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lZRE9kNW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CRSGsAcJ;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt1SZrzkHLz6eefA5a7nUoRajGF+yv7glSVD+hLrU+Y+C7ncr05a/w+LKrlAGrUY9g75xy+kg==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 09/11] Staging: iio: accel: Use sign_extend32 function
Date: Mon,  5 Mar 2018 13:19:28 +0530
Message-Id: <1520236170-14668-10-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use sign_extned32() for 32 bit sign extending rather than hard coding the
same.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 307d4ab..8d795e2 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -159,9 +159,8 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+
+		*val = sign_extend32(val16, bits - 1);
 		return IIO_VAL_INT;
 	}
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
