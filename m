Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrRBgoJV+pLbj3hZAApN0ZgC7CxlNeOez9CgXLc4J7TDwo4n9QliQyMfMDIB6jRfIitgcAv
ARC-Seal: i=1; a=rsa-sha256; t=1527156247; cv=none;
        d=google.com; s=arc-20160816;
        b=hj/VWSRpLWiQXC70l8Vy/XYyKoHFpVYN7GbYdTdeZ2cENBdcFrUcZValEc3iEKL7dZ
         fJy/BN+431/vwu5P8uhykDJMd2sO2pxOkzfGQiRPCicKyMOcSNtJhnXBzTUVgJ6OIPCF
         XBzqPvUwQ4fXO7ISc0b2VnFvG7vqXpexIqgQNTAiRAaedHoL8YxkdshzV78PvjRaswBY
         R3ODiVKHBUbrZi1HXh6fh/a1FvRqELM0ategmIXnSLLZqmVx0nx/kLiVWkRJJKYvB7jy
         b7TFH2UjVhcc4IUf3oK3x+zUfYua8vX6ViJartQq0LvobQSEV+NlxIaxYMy+7FMJlBQy
         nN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=OtYE7whmw25CB2wwgcRTNNuX1XORYl92iUfojxTykNc=;
        b=zEXIzCFA4a/6rFfdKUxSaAUrqh3n0cwlJ/gDkZ/jdqDFhG/NIPPOqM89ZfrKK8RRjt
         XRi7LK5+zcJOm9YISFrRo5iy9B0NhWFNauz8gsnulf1YcNIWXJSiezgYHGbBIxsgkk6p
         opF38KskHyLS0GAmZMcr9azaXsx8SEqUXdkBrvQlAY56pbMIJw4IPiEQwhzh1JNJpSWI
         RRsbw9giuQ+2qomKURpEJ1HyxK0bgKH8wK/F8lJ7LtqWRAydSFiSNfmQ8rt8ACWfYN6U
         2WKEdxz/HnWgAtzzLYTGHV1HNzCvLFlfWAAXbSfpCoNAJan2bm4GOO2M6Qvg4vBTywiP
         6BxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Y4bLeSgy;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Y4bLeSgy;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
	Ezequiel Garcia <ezequiel@collabora.co.uk>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 117/161] ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs
Date: Thu, 24 May 2018 11:39:02 +0200
Message-Id: <20180524093032.349169931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339021586590897?=
X-GMAIL-MSGID: =?utf-8?q?1601339389566083445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

[ Upstream commit b1d0db067fbe2598d62b248beea5d705a0ea7642 ]

The driver does not select all the codec drivers that needs.
Fix it by selecting the analog and HDMI codecs.

Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -56,6 +56,9 @@ config SND_SOC_RK3288_HDMI_ANALOG
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_ES8328_I2C
+	select SND_SOC_ES8328_SPI if SPI_MASTER
+	select DRM_DW_HDMI_I2S_AUDIO if DRM_DW_HDMI
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  RK3288 boards using an analog output and the built-in HDMI audio.
