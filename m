Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/vUkU3UgPwBBlVHMo373osGfnswbvIhC5TFvVQ4SKQwd1XEbDonz/QAU2pihPQ7xJsDKoj
ARC-Seal: i=1; a=rsa-sha256; t=1524406593; cv=none;
        d=google.com; s=arc-20160816;
        b=tTipaYhGWN6wQRIOyDDXGNVxuXepA3JiAYDWNJA0I8kuHskCASyMI+HjMCQo79SxtX
         nag9N9fqq9QyomN0RMDUt/gmGh3xjTxuebFGe1DyHtpWtxvGsDN5HAlEzbxtCxz5mqum
         yRxjXOE/YEd+4sHflryCbQGbChtBYrU9IoC6EqZ3SVGJ5EnAoYLyFsmR1PlLX9W0AmlP
         nm42CflM7bkCamihtCFLZH8GrkoTdcL3uX6h28GsmcXsNQUScF0deX+bJaw9ygWyML/4
         CXl0e5/Lmm1lhWKbmVE9uZQFgSYZkI+7p8q8DvFrYNodr6CnSBcEkWFFmnlRhuI5Lky7
         dY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ekLNjP/oQcRPtmTihtGhFmdBEiqnqUztGVd1aCVtNVY=;
        b=f7Tv9lnoHSe/LL6oktV1XYTY1E+88kpODLt0xzF4yLSuuS3facA4COBbQLo1WZDmO1
         nOvUacBZVeQUTqpCV2jYQvoP9VZet/IEuAoBP7/k7aCHVPxx9LOy1g/uf7wlvnr4UAF/
         Mkj2/66g5dRp4GgwuTEim3TlC7II8L8vrRSTMkXNASQ+oFGWrDC1QwqEAMX7+o12VLTx
         Rt9qYL+ej72BYTC4XFnJo+tDmqyZJmTynv/isosveNsqJz9zD8QCtqfyWAMWlxk1jnvK
         Edry8po9Q5OaexYbM/gJSzRS8H3zusZY8m5w17lKTzdKuiMGZB7Yc3CHeIa8IoTBzZfG
         Nf6Q==
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
Subject: [PATCH 4.4 31/97] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
Date: Sun, 22 Apr 2018 15:53:09 +0200
Message-Id: <20180422135307.085462826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454833728898463?=
X-GMAIL-MSGID: =?utf-8?q?1598456168297610904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
