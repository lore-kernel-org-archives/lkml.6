Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELucsl4IOeSF6Wj2+vqWzxTvR6roKOuDpvZq+9g1t1pkOmxbl4IYpHaLWR8EyKHnWxJ7kUZg
ARC-Seal: i=1; a=rsa-sha256; t=1521214726; cv=none;
        d=google.com; s=arc-20160816;
        b=z90iK5JuHbAShMvVK4YoFZUhaLfXLpDkl8t/gVhBP4uUCIR8Fea1979UmtH7sW39wE
         aGvIalodSgQPa7fYiCOGM7hb+ierfvydwOO1CQrdwkd/oQtJYHa8e9/fMZ8BeZn43XKF
         Du5khqujKCJySNoqRHhTN4hdbyYaqIHNZRXz8BZtqb0pUdbKeLJgB9SOek8IKytKOXaP
         S2z4aRq17kurmX1A85ryX0XTX+0BMchESNzogTVjBlbsO5DqW24xuaNVl2zM+scnEC21
         Zgj7VDrCrsQU/t1Yb3q4/HhkY0fcnofYaLVQokzesPxkpsY9ZP/Ir0ilrBLRz8bPdr8U
         5Tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5308sIk9Th9+vqhOLM8APyyMskLs0NpAcQA+YKDOTIQ=;
        b=CP0HSkFXSLKBzxfcn3S/ElcBiZas9gcn3MFCKTWz/yJfIAa+nsiLdA9/BGP6EC0Ort
         EijAU4J0F+oRHI7zXe3DFUtOYB/W8YSr8dEV7Zv7wz30fGWr4yo/fz3kbpLVafdp2YWJ
         tol/H+Lrp1lCuv5d/8JnZL3bSTcAY2mfyh+P66iHaqXyMuGGq5Dmfzcq8nkh6dyQyp1r
         pSFGT8fcqvTJwL8sznIoDpgPFeCut/WwszM2EYkYupjUPmaFDtjV03Bo/DjUPx/X8zLY
         h2brn6hqfUa+1pn/Bb+MhrZL8yKkaExBXujaRJYGkRm+CvlbpDWESHRGFHHaNB9LafaA
         emQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takeshi Kihara <takeshi.kihara.df@renesas.com>,
	Yoshihiro Kaneko <ykaneko0929@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/109] pinctrl: sh-pfc: r8a7795-es1: Fix MOD_SEL1 bit[25:24] to 0x3 when using STP_ISEN_1_D
Date: Fri, 16 Mar 2018 16:23:40 +0100
Message-Id: <20180316152333.848343221@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109252946854950?=
X-GMAIL-MSGID: =?utf-8?q?1595109252946854950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>


[ Upstream commit b16cd900de7911f96af17327a081a2141a0b763f ]

This patch fixes the implementation incorrect of MOD_SEL1 bit[25:24]
value when STP_ISEN_1_D pin function is selected for IPSR16 bit[27:24].

This is a correction to the incorrect implementation of MOD_SEL register
pin assignment for R8A7795 SoC specification of R-Car Gen3 Hardware
User's Manual Rev.0.51E.

Fixes: 0b0ffc96dbe30fa9 ("pinctrl: sh-pfc: Initial R8A7795 PFC support)
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -1397,7 +1397,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP16_27_24,	AUDIO_CLKOUT_B,		SEL_ADG_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	SSI_SCK2_B,		SEL_SSI_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	TS_SDEN1_D,		SEL_TSIF1_3),
-	PINMUX_IPSR_MSEL(IP16_27_24,	STP_ISEN_1_D,		SEL_SSP1_1_2),
+	PINMUX_IPSR_MSEL(IP16_27_24,	STP_ISEN_1_D,		SEL_SSP1_1_3),
 	PINMUX_IPSR_MSEL(IP16_27_24,	STP_OPWM_0_E,		SEL_SSP1_0_4),
 	PINMUX_IPSR_MSEL(IP16_27_24,	RIF3_D0_B,		SEL_DRIF3_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	TCLK2_B,		SEL_TIMER_TMU_1),
