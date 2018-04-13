Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637471; cv=none;
        d=google.com; s=arc-20160816;
        b=xBLx7qG0f+pamOiD+Zjpa6y7Tx7o27Y14l0RrQ/HwyU03v38YnHWxy21mFpoY2D5F/
         WOHbyy/1ESbdXEuWX5zuYOVZtLz+eh80EHaohDUf78KuBYKy+IvYNuyJyTJVxksBxtF1
         WdGP96qhlWItEaIHJ1Cg6ReubTZEyy4UvUWs84NFpXs2FLFE0JoCI+/U46t3+HKzKkLB
         P3gF5L/rkRba4WxVd/r0inFB+U27K+qAhpR1s5awrrmx7Szsme/tVmiTwNkX62lH3M81
         J24kDXUNImOwfBDKPYF4AMz0XN6cqRiBud6D1Q8IPQlvby8GUeVvjK6VzVzVcXgN0+RO
         ADCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hDbQCRKM0vsD6Rv93OShsPQEs4klxobdChSK5PAmCgA=;
        b=MpCrgvdOfFqF3na3PW9ZauwtxX+/j0ZkIAhKivm+/Ua2wbbCKn20Q4ctmemWx76kkZ
         U4D0L0K4kGtNiesKMwoVLuZLg6kgLqMbZsP5vpdAaA5ICYd9ubUILllSB959blbZXrHh
         9tCimOGouC+gKsOZZUit8vHfStLlEWZKxRSRnjtKpxyyDXgwppkToDNada9s1DG9l7gr
         Xfzw7afJvQC0yrVNm77Ptj9XSl6mpIOd3J5Lf9XugWLAjUAF4slPyRHnkJDjRKJs39uk
         WcjFd0aODrGpbpardFYEY0RlNQ6+EHJOtXGG0OFs3mw6JcFuieQa8LDFohAucT5GTW6T
         TjJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=12iwmA1h;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=12iwmA1h;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx4/PhLClubF7eXWsMi9s2noUjQ0H1SpHLBz2OJQBNR7kAYnlwjF7KBSo+8J25pMiccnvqRCleg==
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
Subject: [PATCH v2 02/14] staging: iio: ad7746: Adjust arguments to match open parenthesis
Date: Fri, 13 Apr 2018 13:36:39 -0300
Message-Id: <1523637411-8531-3-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649684631908375?=
X-GMAIL-MSGID: =?utf-8?q?1597649684631908375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clear a couple more checkpatch.pl CHECKS.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 53e28ae..516aa93 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -556,7 +556,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		/* Now read the actual register */
 
 		ret = i2c_smbus_read_i2c_block_data(chip->client,
-			chan->address >> 8, 3, &chip->data.d8[1]);
+						    chan->address >> 8, 3,
+						    &chip->data.d8[1]);
 
 		if (ret < 0)
 			goto out;
@@ -614,7 +615,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
-			[chan->differential]) * 338646;
+					  [chan->differential]) * 338646;
 
 		ret = IIO_VAL_INT;
 		break;
-- 
2.7.4
