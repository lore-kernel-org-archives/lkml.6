Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtPUG/H+JH9+NtoIieTpZoLiwqFjm9Su8hh1o4eIr3Rha4C9SUFskU91J4yZ7PfaJXgSB/A
ARC-Seal: i=1; a=rsa-sha256; t=1519676639; cv=none;
        d=google.com; s=arc-20160816;
        b=PttVR+xzBPscbAPJ1AIP0JV2GxQwF8YYzvxbB1p2ahEiNoDLWWBa/uysKSeYtMhDvz
         +Lm3epgXSgo8QzBcdLaXrRjxbspG0byWrkbVJxubGJKDcjSLvsIhkwoHHdDeDtdLxhNj
         UyG5RQtsYwJ5b7LK456Y8KR2FSJWZFb2wBlzyspDcEA2bn8LgVxEbmEyg3/d4+x+3ReB
         ++ReH+XML7H6sjYF7rnwfQLnTWGLkkXqVY8/tBRXH69UqZOP9EqEX8OAKggqgxcqQNUU
         /BA/cfzh5Zq8CLaL4eawe4Yq0IyBx4M9U90Gnyna9zfv422hveJKeUo/7Zbcm3WIEM6Q
         u8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uWI2vw/POnd8uEMDfiiZ52/TIP2AzWg70CHt+fq93/A=;
        b=x3Gc3f2kXcg9/rp7+peqdbB/FXiIYmRlKEtI9vqNDNeD7tgZfnnAufaPeLtfu0x8E1
         nZjpb7GL05YpQcHJrJTBuzYmLGfa0L60baRHwjVAynwJinRacZvPHdwQxkMi+DCqIjwy
         k9jbuN1gSo5TtXMKGX/VmM4yKdBhk94fXtWWgtcmGAxMD9AQtGfRWjX0L4SjLLvCe9Hr
         x0QyOtEOZ34v30qmEjd/BIXmS2BrKu4uDQ31LHhM/PPhSUk9DIkUlhWc7RNFssBYodbD
         vGKdTxamwpnOGiput3ldXPkEUT6rp+piHKcejs4ZmCiIN22IoLA2V5QCyCP5jdqFWJpf
         AfWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 22/54] iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined
Date: Mon, 26 Feb 2018 21:21:59 +0100
Message-Id: <20180226202145.509731478@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496451515173902?=
X-GMAIL-MSGID: =?utf-8?q?1593496451515173902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Klinger <ak@it-klinger.de>

commit 511051d509ec54642dd6d30fdf2caa33c23619cc upstream.

Functions for triggered buffer support are needed by this module.
If they are not defined accidentally by another driver, there's an error
thrown out while linking.

Add a select of IIO_BUFFER and IIO_TRIGGERED_BUFFER in the Kconfig file.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Fixes: a83195937151 ("iio: srf08: add triggered buffer support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/proximity/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -58,6 +58,8 @@ config SX9500
 
 config SRF08
 	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
