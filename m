Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv4BwFsjCWQo48173QBzDLSzj5CdzaFYEgaCuBU0xYJ8iOKiye73M8gbZPK5sfowZpCnCuH
ARC-Seal: i=1; a=rsa-sha256; t=1521214912; cv=none;
        d=google.com; s=arc-20160816;
        b=YbVyTyYCdyH4OM5Z1HRACOxplwiM4rjsF0jszrySbzIUfgn1zAR4thC7K3p+85h4GR
         pMVBwOFsM692ZClm8SyTlNT/4KfIEFSrSBXKhBL7hGybN9Ci6aJvUlYysEqPtitAhTLu
         ALJDuSbHwKRMu7sXVVYTRnTsSZ+HTiGJoq7hiYQ9AKdDI65fE4LNDxpPkw0OQf/4OMYG
         tnZeAnaV8snlebdsETH5Nn+L8stkXM1ow1tlqaHNidQzu0OYHbdy39Kh6HtLpx4Wq8yS
         XLdt9pnIyQbefjmIBiW2EXHfrvpLVMh0560kpezDcGngjTOY0cDrgoHGeCc8l8+M3OP+
         PYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QP9kMTYJ18SB3w0bq6MEQsp+BEIpkJ9d5ykM2M6KtTw=;
        b=wI7hvj1jnaRHxszRVbpRuD6X52advtPmtMqTbBCvJW1EzOZfSAtAaul3fywzuXYQuK
         NG6aWl+xLccA8ZfhZeTcbYZG/lm9JqJP/DxLiWUE0oEwP0HDqkkFhcdMUWYP9fEsQCiS
         Iw4NdkPY1VKc+SEhrh7QscAHh7EnhsohaeN6JqPzXoo8WESm04U302DbIpvBjHkB6F41
         ulnGdvTIder1BxIKYWcr1s/euWKnyfhvuWSFGgNio6zEPSKhEjzYK4qn+nu3aacZ/B0i
         47l89oeJ9cRegymX0RUQXO/IHJAg3vItNph4UEkPt4zQbNiHDgLlScZsmwozi6PgWz7r
         FOSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 061/128] ARM: dts: am335x-pepper: Fix the audio CODECs reset pin
Date: Fri, 16 Mar 2018 16:23:22 +0100
Message-Id: <20180316152339.841601712@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109081244207453?=
X-GMAIL-MSGID: =?utf-8?q?1595109447571255660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Andrew F. Davis" <afd@ti.com>


[ Upstream commit e153db03c6b7a035c797bcdf35262586f003ee93 ]

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status = "okay";
 
-	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
