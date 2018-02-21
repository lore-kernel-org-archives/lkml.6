Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2246K89LguT13wDusKrcwNIwk8wQh1VP+D6HlbF1pA+vIu+7kyEvL4o4IZOIZvkPNJS6XVAP
ARC-Seal: i=1; a=rsa-sha256; t=1519218298; cv=none;
        d=google.com; s=arc-20160816;
        b=DzKhOeXBzgAjMh7c88SY6XCYZ4mLTlwd1TUUlmkarpiouUOn3tqunRXCD+M3atENwk
         kBHYePkb3wTSSK3V5oUKyIggLbuPcdvMglf5kxcpstsWDM2xnm43wew34u1KQmWUxeoY
         X8JU62HH2tgAtzq0gw3seIpZFVKKjU+J/NBKAWiIKQMEee4FcAivJTlj7gW8Vp+BwwB0
         GpNPVHGsgW8gt05pYpYUY0F5TEEryV7Y0pcUKEoblzpzFDFxzIXS9le+4iX7lO7rDyse
         qgXqVb8HXj0SnJFQRmbNWcVIf+nedfVCSQj4tuQ2HGXLLBgHzChc1q60kbgaXkl/9JBt
         TSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UmY1MdpGTXStX3vPFYDb3sr5eXXmjVNXlVEC8mMctKM=;
        b=EK6/QsM9uGt1d9phZwkry5uuHXVeDN8bq4g851gu128nWUoIyts+Dyb6icA0oq0KHy
         tjUc2+XE84NZ1PH93sHIjozcQlP9QrgjInIFa8UHmz3EQT6tUnFJtRXkolnfRdQHVAsx
         LRZ5rj/QQ29WYLt3f7DxQ1P3sOQTTol/zhpGcPNQuZ1IfG9PoXyer1YmtodncipBHCqG
         3g/gzqaO0NqUycDP0TVEOs2oL7nYwxGmrBh1a5RVJn3xUhFEcGstTQEIaKzZZnCw+XUK
         tYwLzZOM52tQ40ztfIQNyDyz8vq1WvspItZB+RmWoVYxgY2nDQl+AgSrDUtS2OZKvSRt
         hx4g==
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
Subject: [PATCH 4.14 158/167] ARM: dts: s5pv210: add interrupt-parent for ohci
Date: Wed, 21 Feb 2018 13:49:29 +0100
Message-Id: <20180221124533.488097846@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014697725847233?=
X-GMAIL-MSGID: =?utf-8?q?1593015846955244389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
