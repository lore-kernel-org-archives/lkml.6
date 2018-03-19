Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJpNvcrD6Qzaz2T1Eedt5fEIY7DMPw7tf1FaNHpGlu3n0E8CyaDrUI2jr8P3smWec4ALGs
ARC-Seal: i=1; a=rsa-sha256; t=1521483726; cv=none;
        d=google.com; s=arc-20160816;
        b=uVLgxvwVyS4BMSaU8BB0V9JOmuwwaPp3DpiLbqqf54rdRkbeZUejeG+6+qlIDTYxI/
         oU+A39pYvrsw2SxbxaZykcgdGoWf2UJWiHQjfOuUKzhEGmXzd4+S7VnQ7o2i96AmMio6
         vVMT88TpEnaSQdQfee56qKd8osRryEHzlaAhHFoVPLdUIEBQGzQ1fdrm7IYtR9r8Kt5i
         egS8D5odjA7MAqRd+070rgFqCVXieUD4St6hgLxK3qqV72MxEOFgHiO9Vvpa21ARJGwn
         AaQ9HmRgbJHzBBk61tDHxFRWZ3xrGByUt+mQkW+zRXWTSP+VcxqxqfWRpAGp2uXHQt00
         t6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=86rqAxDJMjTRLxcrEiQ1EX5DJfnVAWiyEbLEh7QMWG8=;
        b=bdTNcZEinwUpnbiAbh8rRm7j5H+k0Jo2phnPba5KhRI5LtvnNeN80EVwDcWfpnV/+L
         dBJRzvi5F1BHzQFlteTaA96ESz8IXqtPa0QkkvNe4TziPqYy81GREE9TPyQ0EC+4gHz4
         XOomWUgzV6EgYJxOQIh104HbW5vyI6GUfuYpzfg7p+AABni2J/DRNNFguqXILIGMcP22
         ROjQU/81ob4jnVua/68Ufuwrj4RVyoZqLOx55C80j9IQH4K48kpjuoDnn4DkxP1rkMob
         y1bPb+2RSbpzqPKh0BRk8pMLyjPQ+Q2KTA1CRfcES2PQVzoqI8IthzMhw/kx+y1+HbbD
         atvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Brandt <chris.brandt@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 093/241] ARM: dts: r7s72100: fix ethernet clock parent
Date: Mon, 19 Mar 2018 19:05:58 +0100
Message-Id: <20180319180755.045849020@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391319376570363?=
X-GMAIL-MSGID: =?utf-8?q?1595391319376570363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Brandt <chris.brandt@renesas.com>


[ Upstream commit 91a7c50cb4fabfba218549dfa84356069918bfbf ]

Technically, the Ethernet block is run off the 133MHz Bus (B) clock, not
the 33MHz Peripheral 0 (P0) clock.

Fixes: 969244f9c720 ("ARM: dts: r7s72100: add ethernet clock to device tree")
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r7s72100.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -112,7 +112,7 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0430 4>;
-			clocks = <&p0_clk>;
+			clocks = <&b_clk>;
 			clock-indices = <R7S72100_CLK_ETHER>;
 			clock-output-names = "ether";
 		};
