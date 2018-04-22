Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nKMCk3EPw16W1yh0t2weMbnzPk9Y8+CmP6gTNkCS53w4BSI8tSLCZuAs/ZWZTEi356bco
ARC-Seal: i=1; a=rsa-sha256; t=1524405857; cv=none;
        d=google.com; s=arc-20160816;
        b=ZeTJBQVjG+8SIR4S6zexgSWcSVhjGNfRiLf29HzY1cYHd1ibx7seEbU+z4rq4ba/b9
         kPxRswUfsS/LRwRq9a9eDv327UoKqa3EShO0pFZ8r3KnBuLeUc6uaUbwGTpVomC+D//y
         7f/r8gEna1CUcipRKbZQf7o8Ha/YiylHLjJtrPE0AcNdD+W7M5BSOb/YMkKfDvjpM2Uu
         GG0InkFmiaabOZwgE5Oc8KPJ8juYV4jEuS3WVHnlVQpuOea4zIyVSsfGj67sVH8oCcL7
         OyAku4a5Yzj8etbmaG4Gal5/8x6rvv3lJjVEq1xTwdH1bHEV69Syw7HGQEwtJ++snHnm
         dnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=clkDVArQ2+PEftt44znxSqHMDzYFxW5SfLLXftY8PrY=;
        b=E+RIX0CtUGUwg1LAnvBdtEeO0/DrPhlb8H6Ta4xhe0OcAsk7/rdMHrPWA3CtsHDwtw
         YS/praPpCtriV+PVsObKbCt1DK9M+/cuhG+h7UkvDKJx8cYAmZ7QCxi+1zUCbv+h2vOe
         +bHmyEFymdG2q4zG8xSex5tk3q4Btl4AQD4N8hRlxOKTZPMe/VEHVUy3RZNBEruIWecj
         RX5yFfi54k+6HAx/szwYkB3GO8HSAvgdxv/wWnX/lwPgWJs7iQUEs4r4m1VpV+Qor/pf
         g6UFvzV9Zp912jQqzPOiqqjI3PDfCBib0BF/ZFaS2oiPccLMNhrYnzTiuUWpIQhN+syi
         FiyA==
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
Subject: [PATCH 4.14 023/164] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
Date: Sun, 22 Apr 2018 15:51:30 +0200
Message-Id: <20180422135136.346614503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454833728898463?=
X-GMAIL-MSGID: =?utf-8?q?1598455396386443764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
