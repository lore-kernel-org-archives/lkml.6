Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIY7x8wzQKc4VV/nFd7pk14+NfWFdPzfW3vHA8sLZTasGCPvx2LrD0ITniRcGKxASeBmYi
ARC-Seal: i=1; a=rsa-sha256; t=1521483734; cv=none;
        d=google.com; s=arc-20160816;
        b=NDfVbUQ2oExRA2Q79YkHCIp4lcAwzzhuYz355HHKVzjnfiC79Aw3CHhgA0YGzM+0UA
         Q0wHgChfNxMwmGJkaPPr2NhpBT38yzBNWRQvy9UwJ11KF0LOERFam/AF797wcEvuMTA+
         2nHuoRcHi/Jtiq2S/VCY0jDLmaBZft06xszmHV+IzI4x6iG5Ps7+M2yhOIq5GAYLzSzJ
         bkPVefnPpWif87PGRTKATTkNM/WMSBld7vaWmVRKuuuyCK8RW52Nf5GNmRBLD6E6tRgA
         f0LLvPtiHtruGU7Zdu1JNqH1x73dpCHD3y/0VvqpLXi1BFLZxCG7qlzc9AXQ0QQmnt50
         CKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6TA6tGRHXQMZUF7UgDsplIz2Y7CPWRTTEJR2p+JiFy0=;
        b=Ym5TVh0dcY9w0Dp96ml1jNZ2eneLs3czyHXqNuXZJEqMYvS32HYib+5B9wv2YvRE7a
         Sfa6YCFLQU91dJdrukRizJ7adQvWEm5FrB9lPuoZf2H3QACBsoeO03Ve9H/XXW7sMCwu
         PGhX9N/XFlql5348sZOCYC5fwy7Ck044Z36a0QlCnFldTuyZw4pDUS6xu/ugaSxdS2i8
         8OStYSGpS8FFu0hqcpsctP7QXhhy8khzObr3W6qHXR7jfnSU+9QsA+CcGzT6dAgU82o3
         7keZ2RVmTIcuQ86ckdbCU8jAAK1W/g+iOvLPtqBvNdleSwf+Ivz2Q4+Tj5eC86Oce/LX
         jn9A==
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
Subject: [PATCH 4.9 096/241] ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks
Date: Mon, 19 Mar 2018 19:06:01 +0100
Message-Id: <20180319180755.170979343@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391327974650816?=
X-GMAIL-MSGID: =?utf-8?q?1595391327974650816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 1cd9028027c7a7c10b774df698c3cfafec6aa67d ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: 072d326542e49187 ("ARM: dts: r8a7793: add MSTP10 clocks to device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7793.dtsi |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1234,8 +1234,11 @@
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks = <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
 				<&p_clk>,
 				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
 				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
