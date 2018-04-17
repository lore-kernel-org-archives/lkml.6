Return-Path: <michel.pollet@bp.renesas.com>
X-Google-Smtp-Source: AIpwx4/jM9F/vuXkhBc6Uztqe9fSMyJJ+vTxioqQxTG81r0LMaY2mPOE266KlpombhCcUgg2+Abp
ARC-Seal: i=1; a=rsa-sha256; t=1523969567; cv=none;
        d=google.com; s=arc-20160816;
        b=zLgXlm1+3/3EmqIhfLJDZRPCdvl+RMSbXBInl40Cvim2fM3UKAnn8GHd3OYhwvoyCW
         KvKTq4tCmJ7IR7uf4IWz335X1ee4JAdWcRkGwkX5Vcm/Wn+UCRyjZuy79OE0i+MkjYe/
         bRbky7b0yBLsPWQWXIJplAIzda4PN7lYCPuIqVRf9HOZ4SgSmgi2NmVyS+N5LLTpUyHW
         p5xog6w+sW2+RGTpQo3gPFiW6JaD/D267+AfLjcoYg1w3nHaKmMpe+IYlxYG3+N9R+tY
         YVZmgFei1LD8oOye7OjAnvGhE5AprQtpDk6XxOEvDfM6sy+6mzSj7k4j+y0IVvLWElkq
         raAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8hme+0CFQfao087tpheE4AYd3xISuE/t5x1DI+iMNGM=;
        b=gjshp3g4KPcMyGaQ3Zg6W47fM7AWgtH/CdI4Bwlr68rCLUp5Nw8FLdv8xM+Gdls2KZ
         Oa9axF5dRj3nsWzC1A/S1CVbWNdcP9AXPP3I0/o9NgKiX9BdyF1stssfKcSPu8BpqPyq
         hzxacrpGxdXAs4xFL3rcAX59eQx+IqKK1f91sdT1mEH0DFuO75eE9J2htUSD/0Zhdv4q
         vtvh4IcTGu/VD3jEs8fFoeQhewMI9FROSEwquwRHiqYaQbbTsX39KvG1xq3W3VuKu61m
         IWsMXOZHCnFOA+bECkp2N3SuBXuA3Z6qCOac+Eea4KTs5lVW7SCsx+vhKY1d08Mozvgw
         XPqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.172 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.172 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="277046823"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
	Michel Pollet <buserror+upstream@gmail.com>,
	Michel Pollet <michel.pollet@bp.renesas.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Rowand <frank.rowand@sony.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Carlo Caione <carlo@endlessm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Juri Lelli <juri.lelli@arm.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
Date: Tue, 17 Apr 2018 13:48:00 +0100
Message-Id: <1523969291-41756-2-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597997912964742176?=
X-GMAIL-MSGID: =?utf-8?q?1597997912964742176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a special enable method for second CA8 of the Renesas RZ/N1D
(R9A06G032).

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5..b395d107 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -219,6 +219,7 @@ described below.
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
 			    "renesas,apmu"
+			    "renesas,r9a06g032-smp"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
-- 
2.7.4
