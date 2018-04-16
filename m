Return-Path: <michel.pollet@bp.renesas.com>
X-Google-Smtp-Source: AIpwx4+L3hJWGwZI8kPGMpDHR3Z5m20bR0Gi0Tz9xYmWSxopdD16e9K1LPQ/IH7By+g+efaypHXx
ARC-Seal: i=1; a=rsa-sha256; t=1523871610; cv=none;
        d=google.com; s=arc-20160816;
        b=X2pmPV96IRbe9w/0WqkpJTeahXoj4rWSoTLB+IRPBcs65uuHl9AwZDK5BWJrUiz+F8
         AcqGVOJp2TDL9wuBRcxjBNK9O2JtIv64VVHr3j/NFHxfhH/4VGbssoBwo4CDFgYcUfz2
         bpwctBykSXoZIpKiPV9XZaVcZ3Yp6S6V37ynUkcI6yn9WfE35YDK+x06qBKWRW1CLAPO
         wRHEtQ8qskPElzCf9PUArTw4df64+cIud9uJWHOUg+XDtVjmjSZ6dvdkM6kt31bAX/hi
         n4NwQsAW+KJ8iER84CB+xlpLbcTnNQfOnw4UaN1tPOQ/fTgrPV2Zr/DP7P5TK9FLAk6Y
         3WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Ig1wXjmH4Z14uMhjqnkk2i5zudVb6BJWm7coN3lxpoU=;
        b=hXxDGmZh4i0IDZMnhxmMqszz9a1acEt2JOBmP3wwAEQILmEKALYXlEQjWm9eJCCJ6h
         h7pN+4KVTJvOXxXKLcnEmacR2eaiLwDuOdfJeyvWOXyhgTUT+XuJyHia+783H8MYy2IM
         7X+kpxrTJtKqZW2mbooR01cdheXJlunYSirT0wdli0aAJYqO2SHZ0cf5dYqcnWsB2XO2
         mXmuluA4K6Re66OW6hsCZGQtE75quOUHYG2BQyVRixwz6Mp0LVkoJod4yzqra1xgRZE0
         jfSt/ei9+TRyqwOrFCuxnnI1VcN2aPDKCl242I6SLTpra73awqKqqGw47eEZdbUT+09x
         y0aA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.172 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.172 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
X-IronPort-AV: E=Sophos;i="5.48,459,1517842800";
   d="scan'208";a="278331407"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
	buserror+upstream@gmail.com,
	Michel Pollet <michel.pollet@bp.renesas.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Andy Gross <andy.gross@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Carlo Caione <carlo@endlessm.com>,
	Rajendra Nayak <rnayak@codeaurora.org>,
	Frank Rowand <frank.rowand@sony.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC 2/3] ARM: dts: Renesas RZ/N1D SMP enable method
Date: Mon, 16 Apr 2018 10:34:58 +0100
Message-Id: <1523871304-48517-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597895198624440548?=
X-GMAIL-MSGID: =?utf-8?q?1597895198624440548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a special enable method for the second CA7 of the Renesas RZ/N1D
(R9A06G032), as well as the default value for the "cpu-release-addr"
property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 7d84b38..50f3043d 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -33,6 +33,8 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <1>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0x4000c204>;
 		};
 	};
 
-- 
2.7.4
