Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48L6s5ijH1CIoRu1HajMynrIq8hgUDMEnDmNmbL2gIzVrTj6H8pPsx6jjROgLu/YH6uBKsq
ARC-Seal: i=1; a=rsa-sha256; t=1524405320; cv=none;
        d=google.com; s=arc-20160816;
        b=FCijIj9n2BgRNVn7NUZt0qtuvXlo2ea3FZ6G0F2M3RwdooYhBswPcPQgztpaiA8d6j
         tQihZwxrhqr51OMu+GtP4hmKGb4LZ115lvADbySfQm+zb3oPpaobd9jOjIik9LLOTvJt
         SBhc6+1Atg9Qnz9evQ0Bren+BDX5c8aWNlOCG2usTmSRMfbeycuZjN6Rog1L2+NOjpGD
         ZHh13jauFJ8XCWF+30i4ZDXX+Thr9OMk6Z6Bbq4TS0QArhNto5nu9hOtx1iRHTQ3v/uF
         7Z8/RCa8LGImi0VqVRwFyD/o6yiUHTOqxH/6SCUwjjFBoUzBjFIEI0so5u+tHviByXaK
         bQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eHSmVFK89ImrOm3JcC8BDYeTHGA0yE30mMrx/S0oD50=;
        b=dFm7tfYUvhwO87/uTF9tadmHIzPGOyML+HQ0+qm/cprZEtQ8b5z2Ol/5o6T6VR61Vd
         CSzZYTXiIhN1n3O5dUTzvysv/Jo9TMbPINgXsOORHbbCLj1zMeppJ29x0iRBefA04lUo
         mkCzc0NvmHJg7ENqbXADKGWSwSI6RC23hxSaN1qsEsL/7EJ8+9bfRc4Z+vYwwfWBYKvR
         h9s4yTH/VwXxnRsP6EvbZHPDtSh7iv3Ac1ZqcMTmKDFNGxtQj+r1zrM/84RB8KCB3eI2
         2bV53ewOYS/1t/QiQWuoHSJS0jLgun4Vne1Vlqx/krDCuCgUbGiHic/v269S9OZoRry9
         gF3Q==
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
Subject: [PATCH 4.16 024/196] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
Date: Sun, 22 Apr 2018 15:50:44 +0200
Message-Id: <20180422135105.361042929@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454833728898463?=
X-GMAIL-MSGID: =?utf-8?q?1598454833728898463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
