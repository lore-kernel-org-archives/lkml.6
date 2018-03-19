Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsBnxZ5SkQ798TCDiyMxj55CzC/Ol7cDDpf+l1wtoB1VQAYUiWzOHAzOXg1Z+o1Qc3xw+YC
ARC-Seal: i=1; a=rsa-sha256; t=1521483731; cv=none;
        d=google.com; s=arc-20160816;
        b=nRAFIut/UBuinWH/4k48Lx6T6EAcJiGxZYaocwIv/xJwsxA6AoqZX4JB2XgRut2z9v
         Z++vUvq3kTy4ZIaADPpNp31BO6GwPdT1YvDtVZvTFdcbblzf5COxaEL1gPytHLi1pzXh
         HiZOl+KkyuH957/zdoeh7wXRj8sJs5loRBMqragXVqHwWq05f6jLqfmePYl23bWUG3lR
         ID/HE3BKMBQUhgs9MDrvj8B5OsTc/kweGX6tc/qLcUw1Rkfh7+P787qNQGtP2NvMPJy1
         P9Ns6Qa2jl08ryyHkOpG38OdZgRpytaqNeBA3GhKex9EPsaTDAzDkK2bqX4oFCHIYaxn
         g9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m7lSCoMoDN5lx9VIWX1rw7v2aSX3HrjlN921q8192rM=;
        b=tiF31gnFoF2oIR2diFGIg1tSJCbXCEewjlEXfkLBqTOvFMwmdRkOZvLnOcYSk1Y1zA
         qOmTtktdqZGFDQf/z0AxL+8cfudtMV/tmULPcauFnhQt7VISTthwFTr3wWI0aP046bBh
         QHkO/8OYuo0X80uio6Gz5Uu4sOfP67KimgfobUBFxuZVwmjoCsO3vqbLsEzdy4sn5iSm
         WxoQ/LmC7kGbwJHg3T+0OJcI4pj29R81hBarKSe7ZUhTaLwWkum2nsPYAscfkVhjAdUC
         rm07esVW3XP8EcrC4UasAexYS+J5KNJdlljDcIP94K2NKVi864iDL3vjOdd0XLC6jqIW
         c7NQ==
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
Subject: [PATCH 4.9 095/241] ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
Date: Mon, 19 Mar 2018 19:06:00 +0100
Message-Id: <20180319180755.133390652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390543016288302?=
X-GMAIL-MSGID: =?utf-8?q?1595391324913873640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 16fe68dcab5702a024d85229ff7e98979cb701a5 ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: ee9141522dcf13f8 ("ARM: shmobile: r8a7791: add MSTP10 support on DTSI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1437,8 +1437,11 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks = <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
 				<&p_clk>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
