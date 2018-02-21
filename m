Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2260/cRcfnGdNXlceL+PTYjGWnTVQEs2TJ9SEyVuwPPo08qgL0w0A7WTRU+NPujEcQgPztjo
ARC-Seal: i=1; a=rsa-sha256; t=1519217811; cv=none;
        d=google.com; s=arc-20160816;
        b=yz2/C4fYL+xJNdJxM06ERfBJpvvnbFdlX5sIYwAwIOc8x9lV9L260ZjySb7SNmDdl7
         7PYMGhbw7G3W1PUDpuN2BDR069A1x2K/WfmYWFUgzxdcH68KZJPEMnnQzkwecMUflRc0
         YHf9B/5a7aiXu9Vke8wFo0SZd8FGLOjowV0LLkf/iIlTEiAzu4ZtvkXAvClXSAgYEeqf
         QXNVxjXidXM0x8QwadUgPS8Nhu3rvcJ09yuaU/Ec5/cSvSCuWtgVD1sL3A0z1jErvnIq
         xXYqNqlxX5uZC1JMCsYgDbAsmiZ3S6wlLgxeEQ4aX4XAbslPi73EXGxkyGeGNgga110m
         xucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5vB7WNLCzxxoG32rtZD7x1EoDoQ1YVaAN9B5KJ+I4gU=;
        b=HyEKGuKvfRPRGc9FtGLdiaExwcruzeEeq/pgGF+oxprXx4LJjxFaxvpM4q3wb6VDXN
         ZIJCTkYpe9iLAdUxmZQ+UQb2DlMplEf1aLxv9f4KjDKfmyzzIulEE8gtAOadCj/ToyTr
         5RR/03s4VR0mwpqAV1krHSluBlvmBy3lsUDwk4YTKbPRiTRfqcU5IALd2qhHOsprTCU1
         LEFKC7tbIbO2PQ9bdy2i0qN8I8fyVUSiZ0hfdGy7SX4IJ0HJAx8V0Xdl33UaiqIfbH6r
         a9c6kmbm+KaLgJRtWhaRun5QRgj/zxqfkyURLOADkYIVUrVKpBVDZvuOtjYeMmPnpGsf
         lsNA==
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
Subject: [PATCH 4.9 46/77] ARM: dts: nomadik: add interrupt-parent for clcd
Date: Wed, 21 Feb 2018 13:48:55 +0100
Message-Id: <20180221124434.121905442@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015335603363699?=
X-GMAIL-MSGID: =?utf-8?q?1593015335603363699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -749,6 +749,7 @@
 			reg = <0x10120000 0x1000>;
 			interrupt-names = "combined";
 			interrupts = <14>;
+			interrupt-parent = <&vica>;
 			clocks = <&clcdclk>, <&hclkclcd>;
 			clock-names = "clcdclk", "apb_pclk";
 			status = "disabled";
