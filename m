Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rSj8XSBJkZn+0JpRnF3rwh/yuXvckRS4l1rhvFqRwlzj50J2wI3dGxtzd5ql2YYVmdnDe
ARC-Seal: i=1; a=rsa-sha256; t=1524405637; cv=none;
        d=google.com; s=arc-20160816;
        b=i7gasGXixSHUnfaKWyrQrsb1BTQLfiopDzQX2+YUJkv4Q/7D7WhWy4MmCPSaVsBU1M
         0Y8a9FMdQaw2IKCXMDUqv5U7TDwmFskcmxa/biqL4VC/iz7VRY6+pAQMsRZ9+gDhhKql
         jxiz+Tt7yExCylcqxrWWCxwLhXTmXh7W8OsrKzqT0Wn3O4fVX9eo40xNMpTRw91zQACb
         Ln6EcpXHOvjtVO/kt3dkPvZsB3b/KEpPbS+VmCBT3quCQG/e3tmVu6AV8/r0TYEXZP6E
         cgJWJCcUW+PQRKdq9gY73jCu14cIG+RuoeWbfEW1aCytHvz1Bq41qN7Pn1GxIFpwSNAA
         6y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B/3WqXaWeyOa03SoS336UIE3OPXwc+2qHrDzlA7P+jI=;
        b=aUPDQ6C0uPZg0LobgdCcAR0PwYYbxJUpXjReEz+HRFp2p2aCji3ecVN0AuLh/VTdBc
         kRs6b1izHsBjawTo1UmoN/jRlQCKmhclWXmGrWlSzlvRyujiwi/6nHz62kVGU4rGBP1s
         NeaHHCJ2GgwFoJs2q0ZY/R4tBrp6GzAE1jJpGgHqjmkxTU4Lfkdd3mlGnNfvogP4WZHx
         LWzStN6uyNzujUwoARFkCf47C2LvwAbSFSM2O/LM3TKXBmfPzT/ax7jwxLkjEFJu5ulw
         t8M5DMYc1LweMaKI05Y4y2jRwJdjbtTjVp8zaZnm43rxeSaCpc3SnD+ZAUr06BPAgGA1
         owjA==
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
Subject: [PATCH 4.16 139/196] clk: mvebu: armada-38x: add support for missing clocks
Date: Sun, 22 Apr 2018 15:52:39 +0200
Message-Id: <20180422135111.426563695@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455165839826384?=
X-GMAIL-MSGID: =?utf-8?q?1598455165839826384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
