Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+jkoUq3r3KWZfCbSmPEdInq7egEg+WVI1e7er+kQWafPNjOyhibkqt3vQ/A/lSffWIFPB
ARC-Seal: i=1; a=rsa-sha256; t=1524406102; cv=none;
        d=google.com; s=arc-20160816;
        b=kc7OH3H0ImHN9zT0IdlhxOCCeZCqLGsQWx9FAbQ9BH/CjR2vp/qh4QGhS/7Tq0rY+8
         P7u29+iDQPNrsg/2ouAgs+oAKz7KUGRqRT48vmyek2gh201sTZqCc66iXChtUt71gALm
         h8fg/alYzHbNCKGmqHzqgwTNH6SR4YN9ts3FAHOu5qurmc7Peyy6xt+XMcwG+dFeu5je
         x1ObSam5w2+s63ed1P7E9ijoSGJcTspzZ7mC/jQUOiJVtQX1afEklKKS7F1AnzjMndFs
         84HG/CeLDSYe2lAnOnzDN9rkvWU5GQjuOaiy9iFow/2FZjdWhi1FaAdI6uYKprBkAecP
         4auA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+QAJPJrj5M0H/uouygfuK7JDRiGWp9g1TbNdFHYV8xo=;
        b=Qxa4jRKHwJ+c+R0fvTQR7MEyJntUllH34iGAzEvK29cA6Eet4QtOIJjjr1PBzM1Wb6
         X7HuD6ZZBjHtdfjlc/8RNXE1adhdDLFLGJlVD4oLfJ60qUUyLXxbNuWreCy8tiMAFxWz
         8JrMXsXiDz+zVU6T5ajWGluge+CAgzzAGD3DmUaT7VcoIXwD+SBRJikUBbi/1Xjk01wo
         phnUD24e1cVwI/JdPO5RPwOx/GXBd3mkClSkhKhnCwCkysPw2YfdSlfa2arw9FGmZIcW
         M0q7zEic+eTntc2S1gJGMQoeNgA1NiUVg/wD7SEjF4Sya0D4YJQA1QCiWyHeKLi9QUx6
         N6AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Genoud <richard.genoud@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.14 106/164] clk: mvebu: armada-38x: add support for missing clocks
Date: Sun, 22 Apr 2018 15:52:53 +0200
Message-Id: <20180422135139.754201508@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455165839826384?=
X-GMAIL-MSGID: =?utf-8?q?1598455653292390655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Genoud <richard.genoud@gmail.com>

commit 6a4a4595804548e173f0763a0e7274a3521c59a9 upstream.

Clearfog boards can come with a CPU clocked at 1600MHz (commercial)
or 1333MHz (industrial).

They have also some dip-switches to select a different clock (666, 800,
1066, 1200).

The funny thing is that the recovery button is on the MPP34 fq selector.
So, when booting an industrial board with this button down, the frequency
666MHz is selected (and the kernel didn't boot).

This patch add all the missing clocks.

The only mode I didn't test is 2GHz (uboot found 4294MHz instead :/ ).

Fixes: 0e85aeced4d6 ("clk: mvebu: add clock support for Armada 380/385")
Cc: <stable@vger.kernel.org> # 3.16.x: 9593f4f56cf5: clk: mvebu: armada-38x: add support for 1866MHz variants
Cc: <stable@vger.kernel.org> # 3.16.x

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/armada-38x.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -46,11 +46,11 @@ static u32 __init armada_38x_get_tclk_fr
 }
 
 static const u32 armada_38x_cpu_frequencies[] __initconst = {
-	0, 0, 0, 0,
-	1066 * 1000 * 1000, 0, 0, 0,
+	666 * 1000 * 1000,  0, 800 * 1000 * 1000, 0,
+	1066 * 1000 * 1000, 0, 1200 * 1000 * 1000, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
 	1600 * 1000 * 1000, 0, 0, 0,
-	1866 * 1000 * 1000,
+	1866 * 1000 * 1000, 0, 0, 2000 * 1000 * 1000,
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
@@ -76,11 +76,11 @@ static const struct coreclk_ratio armada
 };
 
 static const int armada_38x_cpu_l2_ratios[32][2] __initconst = {
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {1, 2}, {0, 1},
+	{1, 2}, {0, 1}, {1, 2}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {1, 2},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
@@ -91,7 +91,7 @@ static const int armada_38x_cpu_ddr_rati
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {7, 15},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
