Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwpwkEAyr0csW8RTVLtIsigbUs7fUgL7SqR5UuAgpOhdQb154t1pWNHAn74O93grcKI7ew
ARC-Seal: i=1; a=rsa-sha256; t=1521482982; cv=none;
        d=google.com; s=arc-20160816;
        b=AuMacdPpps8k+VzQwGgNABfT1oC3rfdnSMKths+Ki3zkvPd0JNTQcESiqWRiB13ywJ
         832vJD/prEUhbwbFTFizl9U1EzLqMazumRdZtCWgccLfsQ946fCOOGSyW/+3UyfPl9tg
         J0n0QDU7hjoVK1RfyRtCAQoS4axXr0V+VpXfObMF9wwknQvA9EDco6P1t/U8O2plyyIm
         5E+c2UpVjgNzXuJ+cwYw6OlJMXB0HPZCwdTEkBN3sJuceX15dWYm+cKv6NyBFTn3L+yt
         VbpzQ8OkJ73H+oRFWkk2doBof3YNk//m7KQNLhaGivaJQI9jCHA395SjHcnkp5ZsnG/Z
         kD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9c+7ntxwC7B2VsmUCU0ArP58WI3Ypp4kTiJyyM1bvhE=;
        b=FhEwVO+ELZ2Imq+4qlHCZTbiCeyhr3TdM6sjo8vFAoLzf5Eu6jHQBtC1Xw0AfDit8A
         b82TW4ei77cP4YFHMZj3e7akTH/JAHJfjYVG6g901b1mYzWOw8lqktRuFnlIR07PgvGS
         HV4fs7m8o2jf9LukdQTCLyK/j6aEzTycAngwTSKRcSNc6UyXf0md7BZ+BXmOSTqz0bWT
         gEraGrhzXV1CDw0xwra6SpQ7fBfG4fk3ATEvSmpsKXFn/xGeFahyCOgQd+1VMDfWeeV/
         Q2wP3h79IGvWOE6YW1fNBbqPXuh2HrcqmBhk2WfMGuUhF7FRw+x++LgGHUjMXuDWY6ad
         fl3g==
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
Subject: [PATCH 3.18 24/68] ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
Date: Mon, 19 Mar 2018 19:06:02 +0100
Message-Id: <20180319171831.240650898@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390539934009417?=
X-GMAIL-MSGID: =?utf-8?q?1595390539934009417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -978,8 +978,11 @@
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
