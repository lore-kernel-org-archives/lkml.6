Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224j0cBkf4UDCfrepN1Ejw5Geu7QAuTuy/nzIOQQOZbWv9Bum5AF5w5lCTQQP+9kbfenhMfb
ARC-Seal: i=1; a=rsa-sha256; t=1519410620; cv=none;
        d=google.com; s=arc-20160816;
        b=eOah7c87BF8jDIxcgSJKAOOuZCo4lQuPixAYEkKp0OZ0z7s9Pxpr61D0sfyKskMOEN
         br8qYfRdXlB8m17QCMzHD5oaXe2NTMJ1jYaRldtldp5wq4jgEdyPHPWstKvwKU1Z4Vfz
         tAzf9FA4lkaYpx5BNlUw6C+qpa1/+LjdJinnTFp7tE7xjQ88nVzpsPQ/jiWA0MmDDXsT
         m0Lzj8OGTYGevev6pgTH8PhNw0I0ZqdhJooCW/I4Oi9EtV4/5yNjKmFkx9Oi4S3zYsTJ
         3g8GcTArl1ecQYnnVX4U+MT5bd/UAWgQ+Hp0SFsheDK9PT7dD2Km2k++dmHk22y0+yJT
         CRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mtdFJk3xc9Lca+ex5BbdDgv6fIT56pxj9gERrmQfAuI=;
        b=fQNo4agF0EFkv+bq0lFk+JEEs3LIyNkdEmXJaNoepLkkwFZMaGtZ8K77UqiHCZIDLF
         TDH29+mpNSEKaGu1jeJGT/5ObQ3UqKtXlwvCYRO58WoyGUCOV6zOyektPp9mI/XuwefN
         LB/ZcLO8bAJt0tq9v1RxJ2Ucz1fcnWXe0rkbhCtoH+b1jRSE5K7uEEwkIU7vmS0YHvdg
         iEDDhXKakM3dexBYgu0FyIGfCcTo/X7k71hTHf9WInWwJ4IVrQUTnGom+zFTbxmlEbXk
         BU3oXCpjNS0xr8hWxhcoTKr04vLIdSu5U6XGC8NpzJCIutqQP3XfTwuQkkY+Hi+HVdSR
         USvw==
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
Subject: [PATCH 3.18 16/58] ARM: dts: s5pv210: add interrupt-parent for ohci
Date: Fri, 23 Feb 2018 19:26:15 +0100
Message-Id: <20180223170209.249397076@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217510768231861?=
X-GMAIL-MSGID: =?utf-8?q?1593217510768231861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -461,6 +461,7 @@
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0xec300000 0x100>;
 			interrupts = <23>;
+			interrupt-parent = <&vic1>;
 			clocks = <&clocks CLK_USB_HOST>;
 			clock-names = "usbhost";
 			#address-cells = <1>;
