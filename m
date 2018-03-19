Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtsYrwhM6oZz0N7el5hRsbdbDLYTlZDDR+wIPtf/BScLcWMEoGTL0t4yH+LCMhhqt8n2Ck5
ARC-Seal: i=1; a=rsa-sha256; t=1521483855; cv=none;
        d=google.com; s=arc-20160816;
        b=nJCtjWTnD/KZELlneABeQp+nWSsTWXSDjaT/DQiN7RR8lXfrKLpN0qvqSq6Gg3NZV5
         00suQWaKihrNc76Ozn5LZQp2yPZ1OMS4TPsyq+MdRcgKVJPXmmaOKi4Nq6ZYj4/L0xdN
         XsYCfPPDDr5UQ9EbP99eW76LqXVHDV5INztkrXBj4wT571MuwsbTMKUYlvk5ecPNzRkK
         ND+xwRBwCX3yQb1ZK1DA0ikntfLqa5Nisz9+ySm2GniB5hY8Cc2eULzzlJS+PVTlCAIv
         v9A3JpXCixSpeuKU/4poLTE5yKZ9H9ILllYfZ+Q6TNxgVp/rk9vztEivfX1JxqRYlBQ/
         wxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KZiKAZ2/jKknknqBP2iaPRqRM3J0U2GSKOGgtHVqqzY=;
        b=d4k6q0Uznt9wkE+P96UF/5B1PqziyDaohJRBwEpL9ODnQqAfHaZtcdyftUe3pXfdJw
         ZXqnTqbjGdtigXwZYkFh9YHTIbR1nAXhptoXk4HH4IBkI9md13PryOhaTErgKHIPdj3Z
         6OH8lqdyXMohWovtvYoGzx6kRLvOghLKP6r9BRXxHl/HRLuEiNMs0ZDwNUgzXe4VayoG
         NCUsGd82IdwuqDe3QbG0bhubLBXyzt/xDtg5/SqwCGw0Lce8M1GFHtMOGHWCjaqr1OGc
         XYlK1TqkHIFWi1Qx5L1l9WN+nA0/G62zC5uaFMGyo0i2sC6JMJ9pqHmmdk4DfpUcfA2a
         rLuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 105/241] ARM: dts: koelsch: Correct clock frequency of X2 DU clock input
Date: Mon, 19 Mar 2018 19:06:10 +0100
Message-Id: <20180319180755.540339990@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390808962226509?=
X-GMAIL-MSGID: =?utf-8?q?1595391455086314456?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit ebf06af55c7594ed1fc18469a5cddf911c40e687 ]

The X2 crystal oscillator on the Koelsch development board provides a
74.25 MHz clock, not a 148.5 MHz clock.

Fixes: cd21cb46e14aae3a ("ARM: shmobile: koelsch: Add DU external pixel clocks to DT")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -279,7 +279,7 @@
 	x2_clk: x2-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <148500000>;
+		clock-frequency = <74250000>;
 	};
 
 	x13_clk: x13-clock {
