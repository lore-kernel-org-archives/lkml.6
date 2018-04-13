Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637477; cv=none;
        d=google.com; s=arc-20160816;
        b=FhvW6gmh3f0ypjmRGcg2tCL7SR6hbfQ2kqv6mX4T4S3SFTuQ9Ja1JfiF8LuxP5yPHm
         efJhNGYkuZJqDVum8x97FL50oDpCT4Tp15SpghvhkeZKBMO+fe1qsnQQPQh8EuP1vM4q
         PBnd62gK2YBJ0AALuM/0903+NKdyebXak34gsMIvVMrwxNVQ234PAlGiQDEQc8Icpj6h
         V3YSbiEtGhnvqFStimDxAyJRqIs2b2gUfl70dkmM4De6vARLbklfLLKEdShmWUA/j9A4
         lL22lkdLF3wkjnwphXR8t036l4l+sxljpJHWZzx0XHGLAMIKdUQdBjfWM4o1KtojP4Ka
         +2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=AUYcWjSzrPAo1AAFd0fCJjYN3y2sBNkuo6UzBvviTWY=;
        b=X5U2lbkoqLGciP9wVsW7+Z3FzcipJBZ5KOAOiNR7w+2PcRl5YuAY8L3JYIuGN4N/LQ
         G7sGbyOFLKWlshn9vKzaDnoE+B8fADB8vBHPIpskgMYN0tm1qX+wFrwcmild0XBWi5VC
         ZaoYjXO4nEfLymTZ+nOStCTv4Kdbli2ktMCmBD0jUminkfze1qhJkPREQG2ypQQe9alT
         19SVtHiRCyxv2R64U4W43AGG3t4kfzo2WfDljGvb8xPo+H6tkqPSchQw3SYPzFWTWTPn
         MBY3Z9utUJZwF+orS7ShSH5eAFBOpWCoqoJncOtg2a3ePMEWHJlRs7rjdh5Rd+/1e7MI
         NsVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=eJn5J1b5;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=eJn5J1b5;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx48o9zPklx5b4iASPHdOSQaHLWNovWPmheQHXbnC0Y3I/LQnFJCMISBylXQhBCRNVnZVpnMZTQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Date: Fri, 13 Apr 2018 13:36:40 -0300
Message-Id: <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649691066295032?=
X-GMAIL-MSGID: =?utf-8?q?1597649691066295032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Also remove unnecessary parenthesis

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 516aa93..d793785 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		ret = 0;
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if ((val < 0) | (val > 0xFFFF)) {
+		if (val < 0 || val > 0xFFFF) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		ret = 0;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		if ((val < 0) | (val > 43008000)) { /* 21pF */
+		if (val < 0 || val > 43008000) { /* 21pF */
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.7.4
