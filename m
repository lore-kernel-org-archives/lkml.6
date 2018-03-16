Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuCiraQGAPw7taogUH/6AvXjzJ4y5x58GvydjY7CQT8UgE+UgaUQV9idV3iIqh8mbJcEmSj
ARC-Seal: i=1; a=rsa-sha256; t=1521214497; cv=none;
        d=google.com; s=arc-20160816;
        b=hMW706GwUWNeTqHmacPvxlqOtJRGLMPjTmEiSmeIS2OujclUFsoMzcnQnRHMaToiqx
         WKhHgWZzyGAB2Ve/jjKp1VsBBXwIt7LBEgOAirIlPUA+Mmrn8QuoJGTpqbfPWy6luoIU
         cazYCcCS3VsDXNgrFPIYxVCicthAJ5mfvD7pqNmzoGRnftKlfAgARSb3nBJyIq7IDusI
         mPKT3w+alAi+trQP0VnF4BtGIR62Lww2JZ18Upc/wGzIVrPanUc5BtYmMKQYrfqv0T/p
         qB8SCF/t8ZRXMfGDYqq7Jv7c1vH63/b2eQs/Pe04ZWEFgQOKHMAHjKSM7wMS6ubqLGMd
         WPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u2AjiNaiaBL8cVsjpxg06vkQ2mdN+NXvCBNgwEbWcXk=;
        b=JBCRVEqPRjBhh0Ic9NBNdUnqapejjX7yNBBx2KuHe0v4s+ugATN8ZWlFFcMPHZgn0Z
         +wwehSXN9uGoltI0+QgW8+NkqQaJ8shPLpovFmvc3hZqoMGgUlRud1jDU2SFa3+40NxD
         teYuNXQxlGkNhP80smEkFj0DEzYtwQz5PsNS3ftD0sBqqEXVJi4MCIo4WJzwreyblegQ
         augUHi4N4B7EDgHJHHx4YHTg/c9jTYyhPnV3oZeBjWLBI5yDWoxWgQiETn0b4jrIeN8i
         5ZZX367b8mUja1cdOz9pP94XgvhK+eQzqAqMB885nRhdDfj8GnmwqGacmnS2AMGHJico
         ZFXA==
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
Subject: [PATCH 4.14 004/109] ASoC: sun4i-i2s: Fix RX slot number of SUN8I
Date: Fri, 16 Mar 2018 16:22:33 +0100
Message-Id: <20180316152330.074643729@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109012270090465?=
X-GMAIL-MSGID: =?utf-8?q?1595109012270090465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
