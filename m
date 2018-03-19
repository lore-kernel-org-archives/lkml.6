Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtnM2oiXVe2a0ev1nQWe6wXcrvSQ3qs9OnHj78xBAZlWReANkHI5JIUnVQTmS1mojft3OcF
ARC-Seal: i=1; a=rsa-sha256; t=1521483728; cv=none;
        d=google.com; s=arc-20160816;
        b=WdoJlbVGffceGylIRSl346GIzDm82PtgmiSZrCiLfuOS0sUbbktxFDfCw9oYZrL2zK
         QIJVD317XP3IR2J3wkRunAUR5ihQGU936nMiMzHUhVKF7UQS3lSBDG595pKON0UJvknY
         DQgIEhpcGPYjncN1suftNjN8vWmno0q05QlhPVGKQaC9vK1bQ7YFAaABdKbkvRx973im
         lVIacu0iFbZkjO2a3Z0Cc6jwLT5M7HdJwSmkXMmO4pUQgcsTC0haxmCZvuplpBODq2Nh
         HqnC2XftrDs4KjMxXiyJjuLc1z93Lm24vlps1PJ9/JbMyCK81pBKSM12GunzAf6Q/Ls8
         Ggzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hk8ixyUP12D6KSWpyUyu0QyjT2poHY0itzC7H7Ydq3M=;
        b=DWSNHmtmygN0I+A7FuV/zU1+hSqkZRnVM0HLVnWndED00f4An7+oCgUucXx4T4e05w
         SkcsTjp0ID22jsC+9yzcax7BY4A3Ckq50sOLfkrk05OZQSWFElTC99UEblTq5/jzeIbl
         EKxxxAAi6QxaWdNn689k0IF28oN9nqkg/EbbwfuGddO1mfcvhd1Sxc9NqMlxuUchlS9F
         zyD7Mqze7r6325tPxlVXHJ76vVm+CpOIYG+etmGiKXSzIAQh60RDiZvC+u6Jz0oY45PH
         48u5aWtHnILoaZe4L116Pp47mAF4+7rjxsndkCNLCpWoSUNQ5vP45t7I5e1c8ALhiNXc
         MiWA==
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
Subject: [PATCH 4.9 094/241] ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
Date: Mon, 19 Mar 2018 19:05:59 +0100
Message-Id: <20180319180755.088055504@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390539934009417?=
X-GMAIL-MSGID: =?utf-8?q?1595391322459272620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit d13d4e063d4a08eb1686e890e9183dde709871bf ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: bcde372254386872 ("ARM: shmobile: r8a7790: add MSTP10 support on DTSI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7790.dtsi |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1437,8 +1437,11 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks = <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
 				<&p_clk>,
 				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
 				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
