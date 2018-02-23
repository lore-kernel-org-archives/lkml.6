Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2253g2B2wdQYRp2fbheNeaBDgRksyQ+tU22vIPPIMt7upKelE5UWWHGF7cFaTkHaOJbORShA
ARC-Seal: i=1; a=rsa-sha256; t=1519412078; cv=none;
        d=google.com; s=arc-20160816;
        b=tyvP+4kowXxA0h3qjk9Qs7bHY0a+oXm8ZdgT+p6TBvZG7zViGiOZyp8DvvxDe+05mi
         oRoc3K2HKNqgMBEOBqJInDrwDoDbvkPa+aMKqojLHtkHBheyF7+rdiif3F6mz1ZK21Z0
         4es+lxeh1jmHdxwlNCdbIWGYE+JOwkxCy4WfdKIi0Waix1MGo42hMK4ipej5PlxnldzQ
         IQKUBwD7ULgrUIQtjDFt1Fby/I2QTByCNHDRgdECNuUQq+18bDQxfhhNcuBQPgAkibu3
         A5GGLl3HalQzCu8v6LW+o2NArrjx8UiWv05mEs9ZeMz51MDDVa73N1R3tj+wMnO/r3Yk
         ZUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IUFkaCcDaDOaZqK+ojWbZ296YfRJvUdL4uRnfmNvzwM=;
        b=e46YHvAAMPTVa306f6w2V+FOIrncoQ+Ut7767cogVbkPM3GGc4Ib0XYSccFuSXVwon
         91DRKXkKx5e1Bd6tKdJ2ORNg1RpY/FYzc1KZ9yNur6kp+VFpktwis0a8Peut9C/V3zzB
         e2PtOonAZJN4jkU2u0jRAfVlP5y9+K0Fo5zpgKZXewl3vFzExbosvCg9hYPUusYZcf6H
         IARAsGS7awfLlufDAgYDl3tE36IZxDVnukvlUsbtWb7MXFLY0FK36HFIUBVdvLbRy4CV
         Zn6XlW80aTHPxBut7O/vNLGjTakREDr+cbj21RcC2XaZV2Jh8jdA7reci8NO7ROs28VM
         xQ1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 080/159] media: ov13858: Select V4L2_FWNODE
Date: Fri, 23 Feb 2018 19:26:28 +0100
Message-Id: <20180223170753.280357800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219040057436719?=
X-GMAIL-MSGID: =?utf-8?q?1593219040057436719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>


[ Upstream commit fce8ba670b7418319da14a6fc6668db1f1a96267 ]

The ov13858 driver depends on the V4L2 fwnode, thus add that to Kconfig.

Fixes: 5fcf092e0c9f ("[media] ov13858: add support for OV13858 sensor")

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -660,6 +660,7 @@ config VIDEO_OV13858
 	tristate "OmniVision OV13858 sensor support"
 	depends on I2C && VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
 	depends on MEDIA_CAMERA_SUPPORT
+	select V4L2_FWNODE
 	---help---
 	  This is a Video4Linux2 sensor-level driver for the OmniVision
 	  OV13858 camera.
