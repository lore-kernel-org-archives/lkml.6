Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELs13Ocdp31/PjO3yEpVMxeEB37ZudWIVquna6BIiB39FTV7zMGYg2uWzPvqD3lAx/qXaBsC
ARC-Seal: i=1; a=rsa-sha256; t=1520128195; cv=none;
        d=google.com; s=arc-20160816;
        b=QGnvrzgGoZ3crv6Cmtpb2mGVnPcwgboQ5s7D9qBiLKxJUFs2rkTccegamDcpHQXT+z
         Vi2cvpGsqOBDSHgJUCaA/JfbMGdZRqZk/7KvrcxhUIsOLTQdgQNFDt/tE8O52tlID2gO
         eWV9po2qkMyGmzBiCy/VmZ9bZk8rFgbUMOTGlNKyF3v8cUsrUu6heFBZU6+D43Cg6t5J
         nZIx85gwXLlKA1k0WsQZsLoMeE2Bt+sdTvB/sC8mdnh9p5JdODkgC8AnXWYGO4mMIM5R
         uPfccry2h+XPg9wIM7QN05dpj+gXq5SkE8Vj0/mZWc1FkYaZH8N1ryiAJsOjv3zASLlX
         kSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=MD1PAw7OUS3kfGy9zAwJDXDil7I9gDcQp7zLP4aAxkc=;
        b=d2CB9yWt59GLiaEgbZthIEyFqzTFVBP5j0+Qw7v757wXVQlMv6z1vQh2FKzDDVIuvA
         TI3YsdWvXTQe+Bh3F9Tq9QcS72o/uA60KBbM7iOO7mUsmibU0sOO9MXLPdPMufF+ttCd
         b7Ov6BkVLQ+lxWxnzGHEl/2J1v/QRsG8OKdZcqyKnGx0aWGQ6s8HrEBrLBtYa2y/xmXK
         XlMJiVNHmxR9d71N2oiP/IZyapX3eabntWygDfcHwLWMMWJo5shArF40YZMKbzPJLP5O
         u31lAjpGnK6P7ZFi/1kvpnlInKLiGprfQKYyjxsJLG/HilnFxJmuv6D8e+08qW4yyowI
         2BWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=UoY7nlWi;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=UoY7nlWi;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 11/12] staging: iio: tsl2x7x: remove unnecessary sysfs attribute
Date: Sat,  3 Mar 2018 20:49:41 -0500
Message-Id: <20180304014942.18727-12-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969942759533718?=
X-GMAIL-MSGID: =?utf-8?q?1593969942759533718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tsl2771 and tmd2771 devices create the
in_proximity0_calibscale_available sysfs attribute. These two particular
devices do not support changing the proximity gain value on the
chip so this patch removes that sysfs attribute. As expected, these two
devices already did not create the IIO_CHAN_INFO_CALIBSCALE channel and
proximity0_calibrate sysfs attribute.

Page 38 of the tsl2772 data sheet shows that the proximity gain can be
adjusted with bits 2-3 on the control register:
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Page 35 of the tsl2771 and tmd2771 data sheets shows that bits 2-3 on
the control register are reserved and changing the proximity gain is
not supported:
https://ams.com/eng/content/download/250264/976045/file/TSL2771_DS000105_3-00.pdf
https://ams.com/eng/content/download/250283/976077/file/TMD2771_DS000177_2-00.pdf

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index fb91c46c8747..8c29a52153c1 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1477,7 +1477,6 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
 	NULL
 };
 
-- 
2.14.3
