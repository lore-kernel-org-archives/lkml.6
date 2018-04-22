Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4//mcMWoO496P9exO/hVx3qg8jtbz2sQLV7oIfYhVm20Q2c2Omi+9TaRFI5lfe2PEEO5E2v
ARC-Seal: i=1; a=rsa-sha256; t=1524406276; cv=none;
        d=google.com; s=arc-20160816;
        b=gP7DZewezl6WadBLpENCt49BRG1rrYs3yDy6m/2ZrBCr0Z4rCx3fQa8AlKorQeeeu7
         f5nhgjUziBer5lU10wx7qM0H8zr0cXvIXZuPNI0kNgyjcfiMSWiibFue+uR6zpODtVA4
         rAIbvicMyuzTBxd8meiAImuT61wb5Jum1Ej5Hcmr5897XWEMGR4Bz3XSQ/0PjvA8eGgQ
         ynlKtNVHoYLGrMROrY/Az7INyuOltCqTeQXnjLCNoY49HqhyXFx5Ysxa7wl1aKZdWPWa
         wov7VxFv9XtunwcKFE2tme9JUo2vOLrhW4u0uu2ejw9mgfvL3rEmZDGNtGdHFo5eB7oK
         WzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DWvzdesUyRm/ku6Zn5xddOfZpmDSlQhG908aCWXgGzA=;
        b=mGdcIDljmInXaTGhmel2snK3SMHKD9Jbv8BzIkb1ufb+FQEgE1BhB4l5RXAs48xAS2
         JldX59EXGjGQk3nL8YCEwNx1tpKlNhQUhQa/g90WBHF6/Y0bKgGMBCB5bjFivMOX7xci
         Fir7ATJsu9L7tFrEkCpthUW5DnInaETQzmmJoRoXUvb+BuYmKiBj6H1azSB4LJGBZgSV
         ekfPzoUCi+AAia57iHOWe4jIzc2dmhnESonNenUEXM3krxzgnzoQyWDLk5wCqsHAB6DF
         Wv807gvnsnxVxRGImlcAT3dQ1/Ea0+d5cvd1ybmm156koOXR+Sp1+bKgPWVzGa+MpmFL
         kxrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Sieranski <marek.sieranski@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.9 12/95] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
Date: Sun, 22 Apr 2018 15:52:41 +0200
Message-Id: <20180422135210.927601975@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454833728898463?=
X-GMAIL-MSGID: =?utf-8?q?1598455835378860318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Ferre <nicolas.ferre@microchip.com>

commit e8fd0adf105e132fd84545997bbef3d5edc2c9c1 upstream.

There are only 19 PIOB pins having primary names PB0-PB18. Not all of them
have a 'C' function. So the pinctrl property mask ends up being the same as the
other SoC of the at91sam9x5 series.

Reported-by: Marek Sieranski <marek.sieranski@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/at91sam9g25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -21,7 +21,7 @@
 				atmel,mux-mask = <
 				      /*    A         B          C     */
 				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
-				       0x0007ffff 0x8000fe3f 0x00000000  /* pioB */
+				       0x0007ffff 0x00047e3f 0x00000000  /* pioB */
 				       0x80000000 0x07c0ffff 0xb83fffff  /* pioC */
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
