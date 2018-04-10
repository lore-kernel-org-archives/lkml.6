Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yT0zuEEoyMd8Fadn5hsx+aEOBqgOLTb8osvZs+C3gMRTnUpt3mgjVTSEdeVQ61iAG4t0x
ARC-Seal: i=1; a=rsa-sha256; t=1523399673; cv=none;
        d=google.com; s=arc-20160816;
        b=0bW22cwW0AeBM/dCoa3X+e/bQlmo8XtwE22OkOa/i1uq0dCww4XWP6DPcdl/C0AlQJ
         q4MRXZx+RdLOqkvBTlRvUAZuqls3J3hxH75tzAT+8rweKJ/OOlf8Bj5q05F15QNGfjKt
         ZHUITCxFKjlBsFvhp5gqbMMsOmN0bK4NFWfMfcX8Rc9orvVjt1u3cCa0vRwU/rxktBui
         nohr8HI7ipEwclo+hzU1Crn/6hlmhUZwBiH56zYM9Vt5oFmoiHjcznAL2M4+hprjCPaD
         c+4mQrU4gEpcyqubxO6fq+JoLQe7RvbhhiVcYZgq2q3vVLMQa9SEB0Meu+H2ylEqJ8zX
         JQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FaxGGyQ9e01tZvkoe7dWlnh3ALvDW6hEg1ncY6DwnVw=;
        b=Yd6xqB2PPjlu504JE8tlLR+hlgVv+hCIDmVaVox+jLR/1v5WyHDV38C8RGaIxTqSbg
         MLwWkidh8K0KU6Af4iqqYRxNIVI2DF3y49tQa7LS51bwkNOIGbXda23Jt1IG+7dup55g
         CnRLe9GC488jar0w870o5AIqawYtjfYsX8AhIAnbtHn+95F3PCMwT9Iw0XCa7fvEwWxZ
         WwQeTiul7gH31DLFlNwp1nuiMn9LDVJecn97MNq5t630E7JxG16MkkAI4rORp07Tx3oh
         e3Jz5rHF6AUmamu53RQ8jWwiEevEPKOmDjCTRGVj67eykxN5LIeFcSjuC1KcEIh9OGZf
         FvrQ==
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
Subject: [PATCH 4.14 005/138] ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node
Date: Wed, 11 Apr 2018 00:23:15 +0200
Message-Id: <20180410212902.713448661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399809934543808?=
X-GMAIL-MSGID: =?utf-8?q?1597400336373107637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
