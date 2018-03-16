Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELup3KJ8TEMBk32gbty+UG412SK6ymNMId/JRdu2n+5J+JRdO1AIdzuo7qx3p2V/hO2TCQa4
ARC-Seal: i=1; a=rsa-sha256; t=1521214788; cv=none;
        d=google.com; s=arc-20160816;
        b=IUUvwuEe+ho2KecyWi8bq2FYp81yxpHO59vFWy7Ex+auYzuJqfqjOIbHUIiNLv0tLT
         bLHxH91Dv9kKSVdIRHkjpKch5gVkbK1LaFMnQNlt+uVHPlCeUOYjKYakFU2JtBtarAIy
         iJJV+qCsBhIOZRsTdkScAx2ba/ltrF7vLzef9OqE39V1uWa7k4UaEJK3Gds4v0iHZDut
         u97niFTVnnHCTqjwF/WxkZ0KR4md2Mh2RYljby5fpsPpKv4/F0bBGfcllaw5XzAJOfPE
         EQtxWfetq54IhVczeARuWIGx2Ay5Qzcf2YJke6pc4AOYoseky20MpEEUevsuSok68BQC
         Yong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2110F3GiQpu9HhuznlQo3MEIwW6eTIZT9aF6F3DUiRQ=;
        b=t+HibylsXFdZWPGXjR5dFdjpL5bDiRaT8qZkpgvUUZvelNgMdU0v5WEd36N+W1Ipp5
         fQ7HljwCyf15VJpW6Z5VID06drNu58lORadVwC+UjOS9t1B82azDZXQK2Qb+d+/MtcVb
         z7YtXDfMkfZIyZJnGI1s31KoTbZLmjoG3ZGA8Zffcffw3im8oIYTSyMyiMVuClUsHKFK
         bD0K+GCw0Xvqhmzv0u1syna2bhHlfa+QKWeGWKS93WdUFAoiz/VTFN8gE44PC97tfwJq
         wY3qzIa/deU0jKZL5Iuq3LC9cwcj0nb3N2mPxHF6LGGO0gqIKupsddkZRdnABuiuswXj
         Zv2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yong Deng <yong.deng@magewell.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 002/128] ASoC: sun4i-i2s: Fix RX slot number of SUN8I
Date: Fri, 16 Mar 2018 16:22:23 +0100
Message-Id: <20180316152336.328780695@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109012270090465?=
X-GMAIL-MSGID: =?utf-8?q?1595109318264273289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yong Deng <yong.deng@magewell.com>

commit 5a3386790a172cf738194e1574f631cd43c6140a upstream.

I2S's RX slot number of SUN8I should be shifted 4 bit to left.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Signed-off-by: Yong Deng <yong.deng@magewell.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/sunxi/sun4i-i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -104,7 +104,7 @@
 
 #define SUN8I_I2S_CHAN_CFG_REG		0x30
 #define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK	GENMASK(6, 4)
-#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	(chan - 1)
+#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	((chan - 1) << 4)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK	GENMASK(2, 0)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(chan)	(chan - 1)
 
