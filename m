Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ztC+3tXY1R80q0g3lTeNUwuoTOkn9vXt4clErlE2UqPPD4KwSQBOa9KZRGr4aCvRveZcA
ARC-Seal: i=1; a=rsa-sha256; t=1519217836; cv=none;
        d=google.com; s=arc-20160816;
        b=nvnlAhkCeBMmhdDk0WTr+JQF6UqwPDY2Z8zPNjyWau3FyVOPkTFuXf1tMyRrXVb2F4
         2HVhxXTH9YOLjohQu1oLW4XXa6z0QHypRhihYoO3IC0EzDj37vQiCLsry6jqLIxY2R6/
         8pQLmhw9dB4cdNiZl9PyTpybMf3tFHhA0Gg/Y6QbZ32EohY/KnUGevGHl1U2h4qJVvQI
         qGMaBR5/6iPXmvfcH7gsOG6yuGuX2/cQwufJIieyniwcxTHYH7JwCYI1JdAccHj1b/yd
         tkTLAp8dLMlq5dRunv330A2V9bfopbCf4H/GKPCfJlM1lhKDd6+MFZsFIdIP2xHhL3cV
         BR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UrL3snuF/kARTFzB40Nvmb7x4ivV/4QbWebtuSRfRAY=;
        b=rCgcigYqOxqGdrjB7PVZOHm6vucbxOuB18r29u++pbyKGkjaGMaJvm8TrC/e3zhfd2
         H+eL0298H+9JljPBiE1TuYHKoHC8bMB2YV0LZI5RIDG7ypcK6uIZ6+fX4Y9gwXjD7h4q
         PDow2/NxGunrcW7Zb4xwR5M37CVdd6ISZkK7QVIfszHxVDPzWu+D7xUaQnVzgvsFnTBK
         FDDbdWzHEN5HgBihT70yObv7C+oyC9ykzabAQV8McRH0XtIiea1zCytVKhKX9LHvXw+l
         wU8ugBnx74MC+5xPe7AXDc9xybQNIbqZfBEign9AhQFoZfPZ0I6tZ1wvgfkx/YoJLyc2
         /UBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 72/77] ARM: dts: s5pv210: add interrupt-parent for ohci
Date: Wed, 21 Feb 2018 13:49:21 +0100
Message-Id: <20180221124435.225580018@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014697725847233?=
X-GMAIL-MSGID: =?utf-8?q?1593015361903425104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 5c1037196b9ee75897c211972de370ed1336ec8f upstream.

The ohci-hcd node has an interrupt number but no interrupt-parent,
leading to a warning with current dtc versions:

arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000

As seen from the related exynos dts files, the ohci and ehci controllers
always share one interrupt number, and the number is the same here as
well, so setting the same interrupt-parent is the reasonable solution
here.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/s5pv210.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -463,6 +463,7 @@
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0xec300000 0x100>;
 			interrupts = <23>;
+			interrupt-parent = <&vic1>;
 			clocks = <&clocks CLK_USB_HOST>;
 			clock-names = "usbhost";
 			#address-cells = <1>;
