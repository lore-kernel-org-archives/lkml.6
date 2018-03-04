Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2644496-1520167518-2-822064112593387502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520167518; b=T5ouyID5TgQSBBGAKG1S5PdtKvLTxexnmMQKysMxVopQOvo
    VyBP3AZ8V9q2IULFe8xpTKYDsgf+0qQFVZnUFwFTte4k8C7Zozes4lXTd18xBiV+
    1p+mrEz9g/JRsgf/ngLn2UpZD2dCgbnXiNCZIYzerunrj8NARj1NOuvqCyX8Dm47
    0KOiGL8+hD7cqKlLWd5kylFhLb5cw/sUqha54Be9eywOtfD1Ffo+MMZJgZSQHyv8
    hTfZh67ga+4jKxSZj1J2swFqzo+sx4REotMa8bwGg9QjVvpYrP8LlabUnFpPawUT
    ORRiCo0r9LQnnUNrgmPA0wEZZ6Go+ufnSZHiKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520167518; bh=8
    /uiNGG7gA+VYCfu+/WflOijudAqCBRG2cUmFj6Uzow=; b=ZixdOxXyEzTXHZRgj
    tOydyt2bP77D+9B/hmWGvak8ZSmovfRBLpCil5bOwvVBEWkxjospdQnybZt+5xfK
    XlcBWBwDIikyNavcSe7maIQnFZOvj9tgVjZySpBVf3Qe6qrYSCGSkXmckh9AIbtP
    shTpBK8wZgitMgFV4G9L2wuY3ksn5WNrTq+1PyURVNW4KghkuelmoYKN2yfmj+lu
    82AZkA6gmZYZwJ+71HeSRPboxS3T9kpXQULM5zFlFVHvGsC2o9sfMOYv5Uq0I81R
    iXrJbyyfDnYzIqQySkyxbX6qothpGvvEL+QC6FQwUFqLrAEJQEPPy9PEXphn4fm2
    /ZzZw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sHtOLwTd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PL7IpoP6;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sHtOLwTd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PL7IpoP6;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvHJjNKNUpmLlBCRkG26laPrA1kcDAT4epbPzq1gUmQYpwYlIeAQ/ruUQ2z+PW5fBOqleYiww==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH v3 4/4] Staging: iio: adis16209: Use sign_extend32 function
Date: Sun,  4 Mar 2018 18:15:06 +0530
Message-Id: <a2029d242df63f82ca791c99c86963ffeabc849d.1520164945.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520164945.git.shreeya.patel23498@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use sign_extend32 function instead of manually coding
it.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v3
  -After split patch.

 drivers/staging/iio/accel/adis16209.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 9cb1ce0..a8453bf 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -212,9 +212,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
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
 	return -EINVAL;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
