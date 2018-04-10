Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx487bqnty54UWheskcif/SuYM+yKm1ApdjjYQPmJ9TsbV7m0S5UwcehtuhbE+/Q553Num5m8
ARC-Seal: i=1; a=rsa-sha256; t=1523399681; cv=none;
        d=google.com; s=arc-20160816;
        b=AOwWKtQRxCHYYnYsLJBeuPuX+MFtjY4xZNr35Ym+NuW6P7unQ5X3RIv/P+9StnPuDb
         MaLvrY04t4c1g7xEz9YRqR25tNGfEu3SbZKCX0iFGe2mglf7jZvvRUdDP3qUicFFIJmg
         o7WUWSzYPexOU5hUdhYGLJF5HAwQm0O11MXpG+w8lS/pPbOAgyrWPl1pNCngAjeAI24l
         gzZUb8ukVHy7YnvsGBi8V2ibyZJDKkujyD0/5tqQ5+T5NT3JDKldjcMkI1mx974xYuXN
         /tKJLNv3Yzx9xwO4bSys5iFsE4iaXYy5fR78/vSqh4JXnBv6LzCd68WhGmisQPgnexpi
         LqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DOCxxJO0DbEYBjdR7NT9JdhlfA1IHg/WsFvoW09QzJ0=;
        b=XcDhShpF1GrEWAYoR7L2qHH4Nht7S7fn0GbNohVK401fiFd6lj4Z5Duv8WuAUE8o4/
         dPU9adBT+Y+qaxDz/6qDmpL0YmNhgwOoTYLIYG/09bl274qOYvqILP35xgWboCdZcowR
         Qvz/GuDY7hcq6Gso1f1n8fL7K3DiAE9kXS4dWtQOPZoYL8VqnuK6VE8hkNHwMnE6Bl+l
         1DtJMJXtleD1VBD4dcdjOXr8OrdlfmGq0xquHX2ONI0oeifmvYrwK/YPk8nUyRoCaSuO
         wwpyRJIdsnl0qWPeIoU8o3v2aUyIEQEXBN+xSxeEsEVKFtBI3idUfe0r4Bnx7jYBjtO0
         AKxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 025/138] clk: sunxi-ng: a83t: Add M divider to TCON1 clock
Date: Wed, 11 Apr 2018 00:23:35 +0200
Message-Id: <20180410212905.051485893@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399923960712704?=
X-GMAIL-MSGID: =?utf-8?q?1597400344755914655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jernej Škrabec" <jernej.skrabec@siol.net>


[ Upstream commit 7dbc7f5f4904cfddc199af171ea095490a434f15 ]

TCON1 also has M divider, contrary to TCON0. And the mux is only
2 bits wide, instead of 3.

Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
[wens@csie.org: Add description about mux width difference]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -493,8 +493,8 @@ static SUNXI_CCU_MUX_WITH_GATE(tcon0_clk
 				 0x118, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static const char * const tcon1_parents[] = { "pll-video1" };
-static SUNXI_CCU_MUX_WITH_GATE(tcon1_clk, "tcon1", tcon1_parents,
-				 0x11c, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_GATE(tcon1_clk, "tcon1", tcon1_parents,
+				 0x11c, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(csi_misc_clk, "csi-misc", "osc24M", 0x130, BIT(16), 0);
 
