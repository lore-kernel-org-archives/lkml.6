Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ihHu53oekKSTHamGsMwXU5sw30jHrTFgDZg0jgUSB8e/iEHM+XVh8Hr8yI8/SX1tUYdMP
ARC-Seal: i=1; a=rsa-sha256; t=1523399280; cv=none;
        d=google.com; s=arc-20160816;
        b=Fp5EE2aPhVKAO5ffU8IKBOuUfz7AMCuaYkj6zMYLLTdTXU/wyQTP/B/T24EOlFEYeO
         QkHDoLfUjXoxqFH1TvH0qkhupDiSTUiFcX4VJ0zoKKRKtn/MbBEn/Ju+26vCettGOXsO
         rJyBPNK9aJQCQt851TI1dzcp4RKspJkZDLBodrCU52yljvJCPGkfRhsaKU+TXVsYl6JJ
         tUP2zJX+5b2LupULGeG1exlaYL2QjSHSSfN6tmaVA8HgYviOreSnwDjZ5oH5gAJuahTU
         gdwMZ4slWqkf01qko/foIB66ropFtt5ZKVgilPGgzUZjpMFA2KLwNf3eBMYTZbu196Cu
         AaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ctVPNnAp0Oz/MynhLbyjappfYgspOBB5qJcUb866ySM=;
        b=Uq9WP4ag6MyMk/IbAE9U8RDzmU/SwKM6q5SNKCS6MKR5rwr2n8mixl/njDARZrtlq5
         acaSm+LvmzBigQW0mx5kFS8w9Pg/Tj9OqAW6jMQbjRmjoCLzFw4DfMjgGxxwVqgFVN7E
         yEVeDPS9dtPSy5vKF6SqbBMhc0GlZ/31XfqhWfHg6VxI41UyG/7nInbzbH1VMTzPUtXO
         erZZMs6eQa1FSlzc16qbWVBuXb3+Ikc0tCKhD6zXl3Ygwkw58LnJq2s8Hp+cMCRbqQA/
         tLiHiJBgr/HkjYs7s46j6NL6sNvKzXCeuZ9nrVT6FY7S3feCEB2naxnkrtYpFcnB/FDm
         t5ZQ==
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
Subject: [PATCH 4.15 032/168] clk: sunxi-ng: a83t: Add M divider to TCON1 clock
Date: Wed, 11 Apr 2018 00:22:54 +0200
Message-Id: <20180410212801.564519725@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399923960712704?=
X-GMAIL-MSGID: =?utf-8?q?1597399923960712704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
