Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuqki/A/WDauD7JI6duaKXi6v1rIkpGCRLh6lnEb53taul4Hm9z/+IJyNzu4UXjxSmFEtw7
ARC-Seal: i=1; a=rsa-sha256; t=1521483889; cv=none;
        d=google.com; s=arc-20160816;
        b=ebjYDYtRux/1IFHIGt1QdO3cirR8uw5FdKA7qbr7eSn+VqUtzBnQ1MhW/M264ZNKs0
         ld9E5OlVe/52LRiQJgyOxwJxQ1ZDnM3Qc9h8+RWNUWsCo3rJgY3K20yjN+1zim0O9b/B
         2zYor7z9AonwrTeQk1RhyLLCUPoJCYMa06kttjAGESyxcTeZBRLodsS1en4aPJcsrB6T
         R1LsrJIpkVgsm64ko1Ll2Gp2x1gPEJw+DatZkY8Rvm+hkUOXNyyLPjmvHPxVlLGmEjBq
         y5tabmLyOq0Z6QZI+b8KXPbW8RDhGoK0mbO0lKknrSnJ74RxWZAeyLKOMZ5SJXe8KQRK
         aRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=moXQrkK+G78ZwhyFqd8UPXiGwIclCS5s/cg77DC4ers=;
        b=OlwLuCR8Ej3ouDUWtU0VO5yvR0uREd+8fo4/eBQuwZHmw3Xv2+af8SWmGhVboS3YXP
         to/4vL8zL5c+2DrKO+a/WbR61zOIM+ZrWxATVZfqHSlDOJeUpyKHpJ3+eAtwsMzipIB4
         8edwuG2geVPvLtXQn6ilCT4sZTl/mYB8W37kTQpkjy7g1upCMJBCm3hxaXSBHedZmjKx
         QWvWa8o9LHJ4gkdc3f0aHHgPQg4ignpoAS7UBDcBbx7fbLnbRTOk8dy34RutdmS7MHTq
         Xgqa6scMQcz9/w9RjEL3hzPcvcb8zL0gvWVRe3l7AQeAqP2MM8aJoVRLFBFKkQDIUk6U
         4kaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rajendra Nayak <rnayak@codeaurora.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 155/241] clk: qcom: msm8996: Fix the vfe1 powerdomain name
Date: Mon, 19 Mar 2018 19:07:00 +0100
Message-Id: <20180319180757.591764927@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391491416961206?=
X-GMAIL-MSGID: =?utf-8?q?1595391491416961206?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajendra Nayak <rnayak@codeaurora.org>


[ Upstream commit a62ca337b36e31621b582cbe8f17d9404a48e120 ]

Fix a typo which caused both vfe0 and vfe1 powerdomains to be
named as vfe0.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Fixes: 7e824d507909 ("clk: qcom: gdsc: Add mmcc gdscs for msm8996 family")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/mmcc-msm8996.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -2984,7 +2984,7 @@ static struct gdsc vfe1_gdsc = {
 	.cxcs = (unsigned int []){ 0x36ac },
 	.cxc_count = 1,
 	.pd = {
-		.name = "vfe0",
+		.name = "vfe1",
 	},
 	.parent = &camss_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
