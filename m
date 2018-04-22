Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Sfrs/XkDJp4+kqyr5oGWTssPhK+GGPDYYLlqKdjSTvR0gXUl+dp8LN+C0dht5V8TjU6Bz
ARC-Seal: i=1; a=rsa-sha256; t=1524406938; cv=none;
        d=google.com; s=arc-20160816;
        b=SHZWUPAU72+mMC5QM4klh77uc39UUd0ny7XFHOE33MDDw0Y2DXN0waH2aJ/BGs3hpO
         6vj5P9nJIlyFuFHL/OlsZuOkhIe2vmbEOj+a1cHRk+/+iawrK4DL2D6Li1ofJwF90TEu
         WDyD8j0kVKzz2jyU2ec8ZH7CaK1G54SdYm1+h2K0V/GT2e0jn1/Jfp4nAreu7ofml34k
         SyC7eIubSF4fyzlwuHB58/YJLUtQGjYRntUT8Di7Qhu68SY78+tdr3UhfJzDq/K5U+m0
         qlv7Toq+ziSixLL/KU7DWQ/rnDnH5euTQ/6aZGIW5psv2man88wrOnzpxhiZt8hLx+al
         JYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JNCSB9rjCZoBp6Zwi8h5TvBFyDSUGEdNn8SCIiV4u7o=;
        b=BuF9kuoPlOnRPgV5aEqp4m5QEpjKpd8hb/y67SNXD82woR1JN970X25Ll3FsXdom3k
         kkpwztDUPgUqqJ8Vgvo/eUDLyJTPhmoeqNzz2L/wiJx0CqSnivH6IM+SZNz3i7R3wOX1
         Y1JN3EsinI+mea/I5E6LXVa7u3Nsd8KabaVQePq8oM1vSYFgx2Oj+DSu0+s7ajVZIeDa
         sDKLIzcN9HqCkSyFSrzMsWot6okFLfuusCEF7xdLrFmxy6xdQbiO+M06s2MsKePJ2pi9
         C7NO+dh6IJRNK97sLkvdPeRvX/i95OkaLvthg80uOl/hky4UHJG/UzNOC7wjPGCBZi9Q
         RWMQ==
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
Subject: [PATCH 3.18 28/52] clk: mvebu: armada-38x: add support for missing clocks
Date: Sun, 22 Apr 2018 15:54:01 +0200
Message-Id: <20180422135316.753242336@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455165839826384?=
X-GMAIL-MSGID: =?utf-8?q?1598456529333964177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
