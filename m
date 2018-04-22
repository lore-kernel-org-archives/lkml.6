Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49v/6dRHZdB6G7HoawRqP1z6qq46rRD6nlwRitXH/+fz+GAjH7A3vQn1eHcYd2aNUWA7P23
ARC-Seal: i=1; a=rsa-sha256; t=1524406670; cv=none;
        d=google.com; s=arc-20160816;
        b=m0jFIkPgWycPZ1fyz4r4OMXTX7k0pZPuj+jcIwNG8bUg1qK12x38rl2kTICiRMCQJO
         KpjoTF2mOnyXNziUiz7QkCYcTJP3CBNgvw5AW4euh2tTqwyjGmLpyx8qUicEAcr6EcZd
         5XCMcJAB0+xXVxIqyO86I5ReyVsLy2s31RUmVDkAoHmCvkQxD06gAEm2eqA94x3tJNBK
         fAhlvshffJ0+NtZw2jjGHHjWe7xWdGbGcAIVZWDfbVsnQtpTwzHFMelxawLqPul60RPm
         YIPa6/XWOztC23E61vK8Z66dSBDVsLCi6Cv/DkJpty8Tx9dxd0fJt0osSyTiktj8+4QB
         3Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZoOMs6dHfYF+kRny5qh03B9WA8RRmlq+9hstta4fQ1U=;
        b=sWAy1pWzqUyJjRMELunyyVz1d2vYccFtZJqjPTaXxAmS53JHTyMVi3s9MaQW5iEUJV
         mR5esTfcSLNXri8X56Cx7c+Fsd3cS0qnFiZLXHMsQxlgwGlSx1PxnMTDFUdTvsUi+sMA
         PTkVP3OAWaaOad9LbILWLPuhbrSYgXAeLQx+YnWO8aZr8IpPbKX2pnO4cUl8ITFec3dh
         1eqgVlmRxseGCLQ2/bOtHxRApfVg93XTgTrpQUQ+WXYhEMoVi4FwbDqg0W4ZQV5o6jLe
         gPUo9j19GlyEOED1pUGZVP3UBndquz5FeKGTa+/GYF7yQRilRvwBuX0RGbZ/zglG4Bf9
         op6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ralph Sennhauser <ralph.sennhauser@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 4.4 60/97] clk: mvebu: armada-38x: add support for 1866MHz variants
Date: Sun, 22 Apr 2018 15:53:38 +0200
Message-Id: <20180422135308.591594256@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455951758345944?=
X-GMAIL-MSGID: =?utf-8?q?1598456248683126963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Sennhauser <ralph.sennhauser@gmail.com>

commit 9593f4f56cf5d1c443f66660a0c7f01de38f979d upstream.

The Linksys WRT3200ACM CPU is clocked at 1866MHz. Add 1866MHz to the
list of supported CPU frequencies. Also update multiplier and divisor
for the l2clk and ddrclk.

Noticed by the following warning:
[    0.000000] Selected CPU frequency (16) unsupported

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/armada-38x.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -49,7 +49,8 @@ static const u32 armada_38x_cpu_frequenc
 	0, 0, 0, 0,
 	1066 * 1000 * 1000, 0, 0, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
-	1600 * 1000 * 1000,
+	1600 * 1000 * 1000, 0, 0, 0,
+	1866 * 1000 * 1000,
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
@@ -79,7 +80,7 @@ static const int armada_38x_cpu_l2_ratio
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
@@ -90,7 +91,7 @@ static const int armada_38x_cpu_ddr_rati
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
