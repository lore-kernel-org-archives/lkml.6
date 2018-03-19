Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtq6oIRPDIbJX0J/GJdoH25ChxrlYTF7jT3Kk6vXtRrv9OWEkBsIB2+H+StVqg8E6K25o7E
ARC-Seal: i=1; a=rsa-sha256; t=1521483239; cv=none;
        d=google.com; s=arc-20160816;
        b=ujy5zVWLN7tqzjR+EeJQ7gB3IeC3kQIgf62KmFciBg7d3qAJkvAqO7JIzIaNZ/4zLk
         f/MiEwvXAAJvPHiFFEp2aZyEKctwFYxmQIGDwrxFpRF9gXtVG0SUVyVuAphAeC0MyJHA
         W5T7sAJnb/+Ek2M0gzDiMfhGeDQ8ragb9i3Eira4wl9OlFKZptFV7SbKu3grQRRRdJge
         hlBtfdTeKqhSR3vQxQFQuP0CBAnuU7crpV208qk3sSrNmcovLnz+mBUDzSKqisNOgW8e
         G4ELLov8AUeEU/CyS5ImY2d9xdGuqzUOKOkraOacGBBBUmK9YsqA5mvqIqv/FZJ9zprk
         Mcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yRq/HAbKgoT670Ipb1YgsSRMig7jkx4jS1iSdqJaW9o=;
        b=n0Ue86ZNjVRAv6xRXPmr7qyVmuudMLo8hsV2dznQ7UJP5nvxeJKg4gKKBhKwx64Ke3
         0edl7zrWYhDGCcMdmG9M6Ky9dHg/xyfqB70j76xlqR/VAgNIVwxBly5okukpaQRa8VJU
         bgyTxSUPvGfn5m8j+R07ywWlOu8m4cRVHPKKJy16cXyuMF7xlji9S6P+jFYmlbBVnvIC
         WiStZWMIzMJflqS7GlaVYoMW2y09u3PEK1jFlhxmt+TTTMJHTqe/kUG/Ug1mL1ckFdTf
         7a9CpVKdeY7V4sD6iZbDTBIQnv7dXQGigleJN6SRG24sPuNlnjxLgnw4n99Ds8DDHwBg
         OAQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 051/134] ARM: dts: koelsch: Correct clock frequency of X2 DU clock input
Date: Mon, 19 Mar 2018 19:05:34 +0100
Message-Id: <20180319171856.723297606@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390808962226509?=
X-GMAIL-MSGID: =?utf-8?q?1595390808962226509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit ebf06af55c7594ed1fc18469a5cddf911c40e687 ]

The X2 crystal oscillator on the Koelsch development board provides a
74.25 MHz clock, not a 148.5 MHz clock.

Fixes: cd21cb46e14aae3a ("ARM: shmobile: koelsch: Add DU external pixel clocks to DT")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -280,7 +280,7 @@
 	x2_clk: x2-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <148500000>;
+		clock-frequency = <74250000>;
 	};
 
 	x13_clk: x13-clock {
