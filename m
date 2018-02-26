Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226KcRIbem3zv8ney0QhXSOlNZn2Td2eOSAt8Sah+aP9FoWLOXylswgSTP0nVNIMYKWIgbTm
ARC-Seal: i=1; a=rsa-sha256; t=1519676813; cv=none;
        d=google.com; s=arc-20160816;
        b=TkCwC/BRZ4Ph8gRRnmVmX5qdk5KW2ko1OHNGEQajIq+GyfUUG9i0U8AgIQFxwcFTy7
         zz1mE2tO1LEn6fmPel1+5+VxnCCKkrla7OhQgDeZUjv54Ylclt92+6IqduuUfQQX7v7a
         7Nlj3joOJZpT5RlWQGcKAI5UTvZgH7CqBpWhaJ8xPlR4Z80y2NUjOIqigrqFuiMyTIwr
         2QEHRtpsUl9nCiK3cm567czwvKIezc1Rroht0bzaKOblIQST25Vz27garw+3juINX+Fl
         fxmnZE/Aj3tRP3tta5qRTslKUT/oIrXDRMhDwadpxZ04zs7oJyrY8va/iA0HKvoPHrt6
         b8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=usxpVvsw/UIr5Gf3qX3GpUOSVv+VH7k1CvZRl71jsk8=;
        b=DhCs92/vOsmHcVQkc3xzDbqurLn/Mws48ZU8tcZs+JGpyeXbJVo6U9axE3hTMtWgQF
         L4jedXTaSnHtrdfjW+rGjd7HUcqSvUpHgA4ONyzKPFuLS0zI1PaQwkeOCuvrLmb4Aax0
         ks1cIR05NKjTG9WbawGovM3EleInZIUOYG6oQFUrqGmqjmce6EwVFMAMaL3AH3khX0wT
         asdB3B106207JwPDkBkEGG5kW229wlMLeZk2g85JlnnpjWtysucYZEqg/53WJDx4AvMX
         KxzM4hDeguBDAl63BSjN4KkolryThiSh2CYgVeI31sAqEZr/840LbmHYbgrKtM5tVFre
         hEwg==
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
Subject: [PATCH 4.15 23/64] iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined
Date: Mon, 26 Feb 2018 21:22:00 +0100
Message-Id: <20180226202154.461701474@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496451515173902?=
X-GMAIL-MSGID: =?utf-8?q?1593496635206682339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -68,6 +68,8 @@ config SX9500
 
 config SRF08
 	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
