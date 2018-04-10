Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Pe/iaPkpUf5TKjA2EBDNCoL+q0JZ82gmIbfahq7fwIPQFVNm6pnvg4SJa2blbBtwJspqT
ARC-Seal: i=1; a=rsa-sha256; t=1523399171; cv=none;
        d=google.com; s=arc-20160816;
        b=QOhkwM+IFzw7T/ajkcQvtREGlv1lOPzK4Bn7kv2jASP9j8EhtDogQ/hq/Xr/GOLqEI
         Hby4vowvTN+O0gzOcVvK3s9OIL49PR3K5RjsI2wIkVFENcCbgvc8dkSxnpT7pnoSuMUE
         s2ezg40K4/rZktKXiCkxETymU57o2XhwPn3k8gklAX6zwTmjVXhAoiRaeIBgYTijNhqr
         mVzo7+M8UfMY2ZZRYyet0k1N1gNGYl+55VVc0o5YaBPn7znxUHWFY5gRSM+5ZNcAkjea
         gmdDvPQ1VB72EEC56SB5be5jAz083kegLHWhTYKrX24pGbEu2uPiMWBFnCTGdN8m9Qlb
         XLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IIrVx8DLoEQL9ltgbrREcwNtoOiNnDtW7liRstkdrmo=;
        b=BDgM49ufa7ElqEXGNUfk2Egp6IZTDQQDGSYQBm832sDCyLEH+3WO2V5Yq6Xxs5c+Ge
         1xWxp+RKh3FRskTD2fYMXU1k3ZVIpOL69jYY8fGbufWMd8vkFE2fT4nhIN5uV2Kx2dm6
         4c5ceVelvZZ8UE+vehNcusx4CbnlXKfLqPaDNjTvL3NvHZIaIynQUxeMfleXXqLAKb8R
         wkWSU6nn4JZL0q0/XR0moeNEWDPUT9QiiQOamBVqDCd4JK51exS8re9lN4D7kz6Fqvu7
         1w73jjuU4KoLjQG/vOAI3232DYfsvRuSPoBb4PzPpmyfXJg9tqqt0TQh1EGgI6iL9uAb
         muWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 005/168] ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node
Date: Wed, 11 Apr 2018 00:22:27 +0200
Message-Id: <20180410212800.456211733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399809934543808?=
X-GMAIL-MSGID: =?utf-8?q?1597399809934543808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>


[ Upstream commit d5c7b4d5ac2237a6da7ced3adfe6b8bf769f8cc6 ]

Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
enable the broken timeout val quirk for ls1021a, but did not add the
corresponding compatible string to the device tree, so it didn't really
have any effect. Fix that.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/ls1021a.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -155,7 +155,7 @@
 		};
 
 		esdhc: esdhc@1560000 {
-			compatible = "fsl,esdhc";
+			compatible = "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;
