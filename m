Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+KxwnLJsNeaeG6VBswi32VMcfLHXiw2bTKFbyEEpYLZIKzAxKnZoAnAdNZSaHeqt1HDUE5
ARC-Seal: i=1; a=rsa-sha256; t=1523021331; cv=none;
        d=google.com; s=arc-20160816;
        b=kGpOYw+Qg2nx9BLmsA1o87bZlpIS1Mo9j9TgnKrDVl1l0kcjsUaSBB2d75W59akp1D
         vD6eQxZ8utfM1zYSY68LRXmOtwV6khc63JVgUukfWGkkrvEaEqTiMH3eIIovWK1Sd3gU
         FEijo7A9ZsPDcxWk32s7tmxueH/R/pVLlCIyEIb7kOuui5uAxPZYUAUw5tk+bhXcv/YB
         8UAE4Y9bcH3P6wAF/lPdXYSWZjpoBpDNKE1aUuLBBREMu/uzuKXMt5HOjPRiqgVTgkPz
         7HPp+MIbU2lzEICsTNk6aCtGwoDr+d5GgO6mMXHjzUF+2HGCh+CkzZ6Uxg1yDghQXy4c
         6UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XHw+zqUVwkDSHcYTCpvApEYeEgx+TD6Mm/y/KlJuF7A=;
        b=Orv/ZKae+0Sf8lxqmSIVX9Rv3hUDE63RXoiEx0YrFujnwGS68IhIMYTnwARqY6aui4
         hgBXqZ3wx/bFOUEN1QASRyFWfHxOme6PWMaP9G7KW75fiDJXU+7J2Yy9Ta28+PHD2zwz
         ifB7xkK8gXNVay7hlNkXLhqy5d0RdjSnuIG7fIdD0xY8Cs/okyGn0IrdjTkIHxADyRwq
         w7EFNYcHW0+wP7e8ZlKKMQUY6Wnn/6P9DFdwHBz23eiUN6XifXYlK8KOPy1a0rrqzpvU
         bfvt+K+1Jok22ev/d22sEzLdJDzC1JvTSjkDk4p6+CKrQPQOjVIhOGfwcFznfbxxeEe0
         z1mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 92/93] Revert "ARM: dts: omap3-n900: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:01 +0200
Message-Id: <20180406084229.187808452@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003615276485458?=
X-GMAIL-MSGID: =?utf-8?q?1597003615276485458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 9d8df5594467b6c73c3833b462abe5811fe7295b which was
commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap3-n900.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -435,7 +435,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -452,7 +452,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
