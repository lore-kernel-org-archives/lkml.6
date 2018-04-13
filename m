Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637482; cv=none;
        d=google.com; s=arc-20160816;
        b=hcKwrCrvlE9MpFu/fLF4VTbCicAprc1kJMqEP32vB/lMkISKgdL28V8SsUdpMS4xJM
         eqyC97ziIljnJ9J7KAQK21LFaK/zHQ0pU5WnJfR7agPInYQmrtPHc2ncj3/B2Ap2DF5f
         ifWmWjfkvKWME5neiXJOoutCHl+E+kISMlTp52BCT/Uc0zXTY2mlUtlgzalCjd0azc3Z
         Yzm2QIHleZukGeKn33ITqI+BLL4uoKUhB+waegA/WCsuVoz0bOxMnlVR29vHq5/pD8wA
         XJI5MxpUGF/d5KNu/T3aUv+94hg+GZDo4g1ODdSxeIqQ9ZAZsTGdS8XoSfrnljldQTrm
         Uo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=sG5BkGcjcDWB2Hu5HyXCy2f1QwJaLTQWYWlu18vmXc0=;
        b=C/Mfh2fAYYHoLy7jUdNHxGgefwptoMaYuPqK2rHg/VrDcrh42G57bEg9n1sLD8cY8g
         mM6lm1HTH86ighuAN7uC1lP1etp239KEzR+JOQYSSQryRu2zjV/T6mo4jBwE81kun3E8
         7Qv9JrBoqmrDxcYOYIXOH/2WahRaizGN5nw+06lbYXhpSfPbSx70ieSkhD2QIddWUy4b
         feMhB2TKQ8TDrT2E2X0MCHsHlj7KcLSTSQxf5QCRhDnHv4dfVKz06PZNuLaQ70dOyMRT
         zA8zGwFFjxwuZSDyOV4cl1hb0emVmJP79oMjwAwSnGVt18wadz5fywcpCv99Lf6hHgz8
         Pmqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=pO1aWWcJ;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=pO1aWWcJ;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx4+JXGi8v2p/62sjlc1csydK0i5jQUGY//zbyJFZn5/7f1E3TBaCq/WLSTeNYjlQZnRbCJ/GYg==
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
Subject: [PATCH v2 04/14] staging: iio: ad7746: Fix multiple line dereference
Date: Fri, 13 Apr 2018 13:36:41 -0300
Message-Id: <1523637411-8531-5-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649697263625417?=
X-GMAIL-MSGID: =?utf-8?q?1597649697263625417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clear checkpatch.pl WARNING about multiple line derefence but creates a
new one of line over 80 characters. In my opinion, it improves
readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index d793785..82fac76 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -410,8 +410,7 @@ static struct attribute *ad7746_attributes[] = {
 	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
 	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
-	&iio_const_attr_in_capacitance_sampling_frequency_available.
-	dev_attr.attr,
+	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4
