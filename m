Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQFUx3wnGN5wS0p2cTXpSrX8vnT69dFsJoK2a0JWC7ufzlxltJYFtfaxewl2eV6AmpKuzC
ARC-Seal: i=1; a=rsa-sha256; t=1521483499; cv=none;
        d=google.com; s=arc-20160816;
        b=lDEA9lXzdxmNmEMao4Z9FPEVfsP7+sWWdDEi26C8dOE5iPepiJOpCIzP6fcbsO5RzH
         wf4jnxa1Ac4i++GbR8kWenrU6pNVZjS9lWyeYA5o5Xm2q5MjIYlV8gKbtik7pUbUQxLJ
         /NgFpsnEeg9V1ZaJKqs0rRnpk21Y+/0lgEsNa+QqvY+5X2hcgv66YY4/2CcXjTGNFQFm
         RkL02ImmZccWPxXLQyOx+kO+wozR8gFTddxBHgkSAEV3ZhcmkB0j4I0vbzvPH0RKZ/h7
         hG86yK1Q3UrBZyN7mvLpcAGcDk5s67RdsLOUX07vVVrvzQvhxIFrZ1j6S51dKZLwExO+
         /Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SoV5O7WUCpn2X9IaMBXgfxcPWdgW3NSzSanLcFdBDK8=;
        b=nyE+6TBGrjQrTZj4KWmWhe3OPbrJuWdE4Ql0RtY71eX2REnnxkKd41YrMXmtJe+PRT
         ydujWTvDL2ubGi5Sc9GeDIPyTy9Q3vwSdFbuwpkCJRVysFcL5EbJEfGBKz0f5VyDE7kT
         lnhbcK0mlA0yO44d8bJTlOwN88rPCx9UFHN8rYvbhMnCLZ1ThwCk2dV46X38wvjRt1Gb
         ++ai+fJ0+BnnZ5Ay3EfRwqtatrbA4+bwjlnYsfxZ+i3Hf6wNw4F3eYkfALSFos1NzvU3
         suHZCk4fMrWzj4LUSVDvIOIa/pZ1IeNz0rhkm80SUlJvSUczTTV0hMytwnprQrkKJUPf
         k8lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 012/241] arm64: dts: r8a7796: Remove unit-address and reg from integrated cache
Date: Mon, 19 Mar 2018 19:04:37 +0100
Message-Id: <20180319180751.680211153@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391082252595170?=
X-GMAIL-MSGID: =?utf-8?q?1595391082252595170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 57a4fd420c6e8a04b6a87ff24d34250cd7c48f15 ]

The Cortex-A57 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 1561f20760ec96db ("arm64: dts: r8a7796: Add Renesas R8A7796 SoC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -36,9 +36,8 @@
 			enable-method = "psci";
 		};
 
-		L2_CA57: cache-controller@0 {
+		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7796_PD_CA57_SCU>;
 			cache-unified;
 			cache-level = <2>;
