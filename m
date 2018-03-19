Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvnZx0V/Za1b21zML5SpMSiWJd8Fyiyn3jzNjZH+xFyT/eGDUhJPfTYMTNWXL00HcguDPLd
ARC-Seal: i=1; a=rsa-sha256; t=1521482985; cv=none;
        d=google.com; s=arc-20160816;
        b=WjSqUAKLg5t5h1XKpgALomiLfT/Kf7BGo/HVeSfz24Jxlopnd2/dKakvnPoNO2hwX+
         lgfCE7ntA5iUNA+pgZuhe8Ouekw/ccwZVsFwH/gWZRsj7/m9R/bL4MsdpaWhYZa3eJdh
         NNkHo7TGA5jPpf6RKuhTRpKjEcxfcfbby/EyYqcPcglByM1WHY/vhLLnAH/XeWYdWnF2
         p6hUiNVc/U8juAi0HogxjteTeD+kkQOCpKAmnTbrGOX0+vDF+oDnnYX1MKs+PMSCSIAf
         TdTJYtpx4xzRkFzgWwbi9oUX58os3fS9LmYYwMrp2cmOelx9QVVi6IlBCH/gYNk35VJi
         BBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KnHe4JrGlhh3NMdYsvU5hACRoG9auQ4b2a00Ubcy73c=;
        b=SHTn6U+z47mW3gAvU6DLu2oyFsILZfq9Rouk94tbStHRrvOI60NN1IryaKZgi4q307
         kobxiKeCyl1e6Yn1Hdp1GHIbE8IyrANy4UCaJTCW9Qp3f4gYQrkiE/OcpzaE+YO2bIk1
         CQYaX5a5GHuU+hc2RFt/pfQunQS41zlQZfK5/CRqrCCZxV2DMpa6xIm4sK2EUvWyXGnP
         1YgIe17CNKdFlZeKl5HjUJchNtQ09yNOF08mY/wPEVHcra85XEeFtxUrwQ0/4kpQLpPA
         V5JrHKzbAGeXtsJIT6e7I9bc5ijp/pvQWCnTQ+L4QlyimeAr/OA5YUcEfjSd2HYsWodZ
         mOvw==
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
Subject: [PATCH 3.18 25/68] ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
Date: Mon, 19 Mar 2018 19:06:03 +0100
Message-Id: <20180319171831.369162653@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390543016288302?=
X-GMAIL-MSGID: =?utf-8?q?1595390543016288302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1001,8 +1001,11 @@
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
