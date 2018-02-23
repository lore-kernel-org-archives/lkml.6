Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224quttAx9dAgl7X8xjxZfqpoLrI5Qxa4fKjZNbMtiHJHutjvWkfvJ1gfZ9nl8gmWun83OZo
ARC-Seal: i=1; a=rsa-sha256; t=1519411107; cv=none;
        d=google.com; s=arc-20160816;
        b=a1PEDUPnqAvqRjSoc4Sd6pj0InLpN8h0k9HGhpQUeeRnS4UMLFvTqjHl5sv9wK/mbH
         +olXIocqxqPZNoPUV6oyPMHWW06Orw5EIH0ES6XOANmrSy2RY4eN3hpOGzEED3wd5C0I
         Nx8/jFSiR9H9Wh/lNWCKQtg1VNbwoS4aHeGZh+xrUTbsG/JHZduLmTb2BtYDZz4FiXsa
         Kwk26RZrvVyKHRJNT+UZ+jxxemR2i4rlTNwJ/D6p0jp6bT0HGpX1y+TYK8p8XlPmV3uG
         sJjGqzoKpH0YRoDESpH8Xn8uORVlu/e0A5U7Tma2qHEndqfvKSNEy+SywOpK2LFjcS/S
         Hgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MZ+olY7KIvAxauzteX3Kjwa3xLP/6SpYu3OAS0Vr7qI=;
        b=TjP+WBBYKY4zv7n1V3I2pLaCEw72kaS0gS15bNAxhucinVH9XhlYW2ZNR9STnPC7H1
         8/Mrvau9mELZODfBS6OZBsYUBQnz2Orvq/YsiFTyRHSxPwZGPLedoPXQotFcfPxi660k
         quuDuRibXuMqpzKrgoZQCtZaLb0FB9nY4CBs07YBlI12E3m3FFf0GOc05GanXgb3c2Ap
         49f0jGMobrzh8QcSkckjA1RvcVuqV8q6r0lKA9a6vi0LUmHGH4ccRMM+RYa12b35eUZQ
         NdxC4M1BNzyoapgfrjFpRlp79RwwTFAmLIhGjpxi4y702kI/KN2na/lEcmC8It0PF/v4
         68jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Koro Chen <koro.chen@mediatek.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 124/193] ASoC: mediatek: add i2c dependency
Date: Fri, 23 Feb 2018 19:25:57 +0100
Message-Id: <20180223170345.279538740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218021187291234?=
X-GMAIL-MSGID: =?utf-8?q?1593218021187291234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ec3995da27e782cc407ce48101c98c19c9ce738d upstream.

The newly added mediatek drivers for mt8173 select codes that depend
on I2C, which cuases a build failure if I2C is disabled:

warning: (SND_SOC_ADAU1761_I2C && SND_SOC_ADAU1781_I2C && SND_SOC_ADAU1977_I2C && SND_SOC_RT5677 && EXTCON_MAX14577 && EXTCON_MAX77693 && EXTCON_MAX77843 && BMC150_ACCEL_I2C && BMG160_I2C) selects REGMAP_I2C which has unmet direct dependencies (I2C)
codecs/rt5645.c:3854:1: warning: data definition has no type or storage class
codecs/rt5645.c:3854:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
codecs/rt5677.c:5270:1: warning: data definition has no type or storage class
77_i2c_driver);

codecs/rt5677.c:5270:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

This adds an explicit dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/mediatek/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -9,7 +9,7 @@ config SND_SOC_MEDIATEK
 
 config SND_SOC_MT8173_MAX98090
 	tristate "ASoC Audio driver for MT8173 with MAX98090 codec"
-	depends on SND_SOC_MEDIATEK
+	depends on SND_SOC_MEDIATEK && I2C
 	select SND_SOC_MAX98090
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
@@ -19,7 +19,7 @@ config SND_SOC_MT8173_MAX98090
 
 config SND_SOC_MT8173_RT5650_RT5676
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5676 codecs"
-	depends on SND_SOC_MEDIATEK
+	depends on SND_SOC_MEDIATEK && I2C
 	select SND_SOC_RT5645
 	select SND_SOC_RT5677
 	help
