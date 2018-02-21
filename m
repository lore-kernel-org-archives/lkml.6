Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226UgEEc15x26G5WM0giW3H0UlO1gW0JZTed4v0lbYOnogOWnMDC/M1cbls+TjNcAno7Bvw9
ARC-Seal: i=1; a=rsa-sha256; t=1519218410; cv=none;
        d=google.com; s=arc-20160816;
        b=E6UVZ0gFpJEVrLEg2AjDhDIv6guKi6Tfu2GKxSHepMJ9FFUzXGwZWs0EodM4g+pwag
         /jFd4YgyGPjG0adme8MYrb+iGfpsgfC9QE91KT0f5Z++uOIi5gUxxsh1grQur9UyqIJ7
         PqNZ2vib9hsKrsc2n5xsn72HLTnpAl7oLbknsQwp4aoiaw9FpIsm/xW8K04EGWwWW/Ru
         8m4cGAmWsN3GPvUQQv3eI3CBbarjcdb2ZF33yRJAp2RmQGDtF1GQSFT1gd9GEM+9F52o
         PdTrHHc27m6TjeZmDolDh6dnqPtSR/lXd34CpuDw1AbQoWmbCb122a2gmHSmw/GUNAL9
         6S4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A8v1n6uDCxzPy0HoCabXrJNTCgC/J/DhRXfI4tHZPXk=;
        b=xXZZ1KAskz9/UrHGIiYJrCyv5wdOZ89vacw6O+TKP+dedPwj0bKiWCwONW/w9SvZBc
         hDvjMN+unJhvPdHjVn0YL6bbXd6LE7tGEsRQoz4YXSc3BEa6ui0DMCShbLCATEEbLk+L
         W2qqEqRHUQOmQ9klRqpfKHyuGui8uUhpBO2hsppXYFzA3+iSMOqfhVpguBL7xIiOTaig
         7O6Wvss2+IIiN89Xvu+AmrFRkop/k9u6LaQdUUYobWEVBN8zYn0ov0HqypcttyEQFS7n
         p0IKXg5G5YbUNhlgPvjeeawligv7qsjvzpoXuTk2+0DMmHeeeIa582IIwC5seQPI5JfP
         rRag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 030/163] ARM: dts: nomadik: add interrupt-parent for clcd
Date: Wed, 21 Feb 2018 13:47:39 +0100
Message-Id: <20180221124531.894980425@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015335603363699?=
X-GMAIL-MSGID: =?utf-8?q?1593015964452212120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e8bfa0422469cdfc86be3f525f621b1d44d2481b upstream.

The clcd device is lacking an interrupt-parent property, which makes
the interrupt unusable and shows up as a warning with the latest
dtc version:

arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000
arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000

I looked up the old board files and found that this interrupt has
the same irqchip as all the other on-chip device, it just needs one
extra line.

Fixes: 17470b7da11c ("ARM: dts: add the CLCD LCD display to the NHK15")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -750,6 +750,7 @@
 			reg = <0x10120000 0x1000>;
 			interrupt-names = "combined";
 			interrupts = <14>;
+			interrupt-parent = <&vica>;
 			clocks = <&clcdclk>, <&hclkclcd>;
 			clock-names = "clcdclk", "apb_pclk";
 			status = "disabled";
