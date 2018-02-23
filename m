Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvj5XaJllZx+gvmkl3z8mr2SXBvzrPw+gT2G+R87Dy5yPeOn02JeYVFsAjAzW7i2nTOhWOh
ARC-Seal: i=1; a=rsa-sha256; t=1519411110; cv=none;
        d=google.com; s=arc-20160816;
        b=KDtHwDwLwkM+Ox7rpvOJC4gib8l2pDc3kJZlCsnJQY/smyO9mNLt5RrfWrp8EPv7c3
         I49N8s+VO0rw+gcc9kozsyrlv6Hyor9C2Z+rG/vUDaqLxNg2HLt25eWjRqVBZQ4pDguo
         kK7u59ItkOJQKbnif2iQp0g5nDINPl4msO7YSkD6VKwwlu/3LbfjI3jKIQdbzUiHdbNN
         924Jw2LEBXfJf5Ekej5n9fDcrz072+0sf7Jwm4vBD2XGsqIo1tPCx5YRyYVu16wJ0Ndy
         becKNnb0sZZZuCoNdIaWUgCRI8z/gxKCvXSTbAm8Y4YlyATAuT8XftQK8E9YQi2e7jz6
         TnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aA5fD2niqzAQj9n0F2WL9Y4jqZZD/Q2JsQqWLpXW+as=;
        b=vMSpn7LGvZbChq+88U2ZwR98Vkq+0Kv9uLsSN7SeHH9A1Tri1RCDxMgBCSAk2ctXI3
         kAjziRTfyZ8/dfiNfWS6agIWA0hTzEtuiEbtwROk2jdrQtIlCioldxij2yZ4IPt1BE0N
         2ujl4ngEKhA6G7E873IPdhYEAcmNOmC+TzJKZ1IR/7VY7KkprWg3DsNIJUfaiBZL3sV4
         uZBw10kFnhUStjIqJ46ZPZkq+65X5odllnzOILiqot11MGKV2FQxh0119pVK60s5OhY/
         qY1Yhy4vGA5fy4tbaqm6sqpNaPpkwuTzjhDJ2YtGdL8Mf5gr9QSMxTlQh68Tv1oQPbJY
         T9oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4.4 125/193] iio: adc: axp288: remove redundant duplicate const on axp288_adc_channels
Date: Fri, 23 Feb 2018 19:25:58 +0100
Message-Id: <20180223170345.413910898@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218024277293879?=
X-GMAIL-MSGID: =?utf-8?q?1593218024277293879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 7ca6574a7afb669b0b4b30dd63adeb310e97e250 upstream.

duplicate const can be removed, it is redundant. Found by static
analysis using smatch.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/axp288_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -44,7 +44,7 @@ struct axp288_adc_info {
 	struct regmap *regmap;
 };
 
-static const struct iio_chan_spec const axp288_adc_channels[] = {
+static const struct iio_chan_spec axp288_adc_channels[] = {
 	{
 		.indexed = 1,
 		.type = IIO_TEMP,
