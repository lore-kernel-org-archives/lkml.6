Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48p+tCZpb02G9mJ15VLvRSE1ip/+b5Ei8zr1sCTCS6WhZF97NjRSCxK1xQ0wPJHLmVX8Dpe
ARC-Seal: i=1; a=rsa-sha256; t=1524405329; cv=none;
        d=google.com; s=arc-20160816;
        b=k9QbaM/Zie0jDnrUV2cG2tnQEXXC1Kr1xyGvehwBpw3Y091oliIev2i7HgjmUA7uhx
         kJVK7q4/UKgpzMLiHtbJOkXaTQOxik8QZzrn38kxNUsle5Ab7imRgQyW45+L05C5mprz
         VLNYUBZ48y+WspgOnHexxvg6Z7ulr9LN5BFEqV2uIT2NTate93FirW27ODUPP92hB5Pl
         fdo6F91cUa+VRbRUB1cHTieAr1PW8+UQ8u9UqU3s+SjU1EwgmlpaMAmwSAjUeptEB6xM
         J4ztRXvmc4S82e2rpqZDWduEvhUis/6KJioZ3MNhVeBGO+GGO4IKX/KgeHmvlTQVb4l9
         OxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JC1tAuC1q96IlXy45KzvwqZJzEj9m9A6v9UOgUdw4sc=;
        b=CPpDp3R0djtUiGc/95CckzOS4ZQHVBP/iqCYaqdkuyE5SIs/L7Hblpa2+okUsxGffw
         PT8K86pS+gLasjH1qyZd9OcPSiF9hGul2/tSKGdQzLgKl4wc5EX2/ikrU42kg2sHv3Pk
         rA0nALOvvCqKU5njEuDdpPuvarktnH35dxyeQdDS3zEAe57WrxH368fKL2FYlw9tikgP
         TF3/6p52CKpxqH2M7EqW3qywGLqh5kRzJ4opEmzBjPx/c739QpuOCRDaWKGp06U1wpBT
         6NH4hS3p838HsLt4Nev6JDwssEUwCWN0oBIPC354Bl57DLW0PUjKHfq6McuuqFnyTknp
         6zGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Santiago Esteban <Santiago.Esteban@microchip.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.16 026/196] ARM: dts: at91: sama5d4: fix pinctrl compatible string
Date: Sun, 22 Apr 2018 15:50:46 +0200
Message-Id: <20180422135105.459462927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454842841403828?=
X-GMAIL-MSGID: =?utf-8?q?1598454842841403828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Santiago Esteban <Santiago.Esteban@microchip.com>

commit 9a06757dcc8509c162ac00488c8c82fc98e04227 upstream.

The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
it's the appropriate compatible string. Remove the
atmel,at91rm9200-pinctrl compatible string, this fallback is
useless, there are too many changes.

Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable@vger.kernel.org #v3.18
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1379,7 +1379,7 @@
 			pinctrl@fc06a000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
+				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
 				ranges = <0xfc068000 0xfc068000 0x100
 					  0xfc06a000 0xfc06a000 0x4000>;
 				/* WARNING: revisit as pin spec has changed */
