Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrMbwBZEGn10SpP27q7RJZVP4B30E6HP8Lr6b8QsT4x4dkAXDQ52HMVgzETA2xha8Gx8T5B
ARC-Seal: i=1; a=rsa-sha256; t=1526281205; cv=none;
        d=google.com; s=arc-20160816;
        b=odYOd/ukorSlCUSSCgTcC1ON8fqKqkYSy0LSPtymHblSIsjsrLWGyqV7fO5SZKsnwx
         3y94lpqz/QK/Gni/NFira+OYqJY+epd7Q/wpKPVoggz1tq3euw6VA337bIkA1z/HK3dq
         sDy1lvF+HOoO4kworkMTT6UNbGbQZMaoDuRPqesInCVKv6sqzCKII8FPnRDBlpzqkK21
         iRJ9pJao1UvNwrz6R/H+8epQ6Fbg3BPVjwuWLgY92DijfFXqfW0pqaN89zWxYBg8A6jx
         4EEGhHRpu78PI+SYL3MRq47FvnF3muvPp+FksOcjs5wIrWEt07EUibK3gs5mzpEvyvOt
         uUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NAEij0GIBmFRPA2mM0zSZUAL3kzLfe8TC/NX17ajyd8=;
        b=BZ07kG08h+35CS7jJ2GrH19yUj0oVymf70Vth+LfJlz29eeIibLcEsMt2RiJywPr12
         LkdiQ9z5X0GbPTb6itxwrNoE9vm/5cuHrX7OBg6GVH94q7NlRc1etjMzW+5qeqcMw8Gq
         L8uxDx5bHYs8sWuBBD31YMJGtkqEePuR2PzjTOyNutIOWVoOoJUcRCN1dueF6rFkJxdE
         ySAFO7Rcn0o+L6Oflpfpb/4Sz7cC0L07j0O1pFB9e4spghtfEjVAiDLa2Qt8zyBABBMQ
         hLRqCxDih1siX1guKNfQU7+hNaObnEnZDGul6vaeWnJmY9vwBfXm+WtrHoR8NMUJNK0O
         mBYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a1KVcDec;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a1KVcDec;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.16 55/72] arm: dts: imx[35]*: declare flexcan devices to be compatible to imx25s flexcan
Date: Mon, 14 May 2018 08:49:12 +0200
Message-Id: <20180514064826.797908061@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421840577580267?=
X-GMAIL-MSGID: =?utf-8?q?1600421840577580267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 9a62dcf486c10daf5366f29df1c799f69b1510f9 upstream.

Commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan compatible from imx
series dts") removed the fallback compatible "fsl,p1010-flexcan" from
the imx device trees. As the flexcan cores on i.MX25, i.MX35 and i.MX53
are identical, introduce the first as fallback for the two latter ones.

Fixes: d50f4630c2e1 ("arm: dts: Remove p1010-flexcan compatible from imx series dts")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org> # >= v4.16
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx35.dtsi |    4 ++--
 arch/arm/boot/dts/imx53.dtsi |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -303,7 +303,7 @@
 			};
 
 			can1: can@53fe4000 {
-				compatible = "fsl,imx35-flexcan";
+				compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fe4000 0x1000>;
 				clocks = <&clks 33>, <&clks 33>;
 				clock-names = "ipg", "per";
@@ -312,7 +312,7 @@
 			};
 
 			can2: can@53fe8000 {
-				compatible = "fsl,imx35-flexcan";
+				compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fe8000 0x1000>;
 				clocks = <&clks 34>, <&clks 34>;
 				clock-names = "ipg", "per";
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -551,7 +551,7 @@
 			};
 
 			can1: can@53fc8000 {
-				compatible = "fsl,imx53-flexcan";
+				compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
 				clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>,
@@ -561,7 +561,7 @@
 			};
 
 			can2: can@53fcc000 {
-				compatible = "fsl,imx53-flexcan";
+				compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
 				clocks = <&clks IMX5_CLK_CAN2_IPG_GATE>,
