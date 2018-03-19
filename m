Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsX8MAtDze9ezRzWyZiVgg6AJHjr+7ictQ1lobf/D9GIJK8vHasveR+xOosJncSngV7brtS
ARC-Seal: i=1; a=rsa-sha256; t=1521483045; cv=none;
        d=google.com; s=arc-20160816;
        b=BjNgwu0T3INkLvLY+qm+Mzb6OrcNOe+jSdtjhHyCO42Ok8AvD84xvkW2ZzH0y8QwAB
         rI+7Uwg3/+4avBY4V4O8THFSaXK0uFRI4P6aMTUDquapFdNe97AuvkiJ/nD6Nztt6ToK
         jQHxV5DhP4ocpQPvxJOmcH9yz+hbEn9/GFzf8rIz6G+bPde7RFkRGOi2mndQjsNvkxwo
         hUgFRbKNqMIIQKqw5BdPCIeiqGGX14N1vvkOEgKv73fHlJ2zCEqsxFt+74+dHCJowOPu
         SgTmRiIinS1qeDPymWpUBhHtarwd2NksP1PVSPvbFrJ384/h0HrFnapW/9W5/IvFAHhg
         GEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+YMPjKfAp+Vs5qs6pDN9q3iuP5TSllF7jUP1whQ1PME=;
        b=skt0YY8ktFIl2IaXpUB44yiQSWFa/63fNo+shlSDwl7t9NmD4iBopFiz+nqNV2F2hW
         MBxprS8JX5l47a85Gf7PXj1n5Hb5Olcsu6fkanhr4wCqyfsY2DDew3EoE55Oil8TLUf7
         cBjTARuvffopF83E5Wvmo4uGPOnvpHhcMfszZoBtzrmhylxOTRAb1xD32llNRYVtN75d
         ysZHUvwHLiwYrqDLI7RGxe79Od44QrfMCUsdH0pM5RRm92oHVhTaVFER7H3OIUUQyTUY
         0K0jtxH1jMOXOzGlHvmSoJAxDn02w+lUqdNCK3VQ69o4I+yTGPz3HMH+rH5RaDnqTWmL
         6THA==
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
Subject: [PATCH 3.18 48/68] ARM: dts: am335x-pepper: Fix the audio CODECs reset pin
Date: Mon, 19 Mar 2018 19:06:26 +0100
Message-Id: <20180319171834.646617334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390605554403205?=
X-GMAIL-MSGID: =?utf-8?q?1595390605554403205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -138,7 +138,7 @@
 &audio_codec {
 	status = "okay";
 
-	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
