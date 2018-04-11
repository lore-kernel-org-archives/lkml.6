Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48yWJCLb389UE9SgmSpbRXkoDvR3/RDomgw7y105utqvr7UlJtNb5QPsXImjMkLrxCo7uLG
ARC-Seal: i=1; a=rsa-sha256; t=1523472968; cv=none;
        d=google.com; s=arc-20160816;
        b=LSumnNHD8lpwNBALmfMvcP91QI/v0ngdnM7RiQVGjrt2uL7tZuulwwSB/whdepFQAW
         0LckRqiT/ft+LPAjY9rtBt9pbvzGg3Kaf+z/wPOhgcGpEBvqU+jpAjtd1q5JfrTseGVJ
         G3fIqeXmdbMLLpmaLe67NWyBc81myOtsKATlmRnFuvZQ8BNmgJZ/By9b3xeIpQeSvouQ
         qpstbbEwIFt8iaiMf+NwJfjzyoVkEMWdobHDmetCy1MtxAPx67898zjzKRCgW84T5Gzk
         ICi6wWCPfyx/Hm+3473gleDlZkq46lB+ZBH6rjDtoLsHqR9ysHsHAl3VRKEnURJmfzV8
         XPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ngu3wrpKarBrsQ1WJ680P5T3Gq4dxv6j1BRL4PHqawE=;
        b=XJVO6qqfAVwGDPUCujkA7cDcwmacg/N7CIX33kfnWGpN1f+/zWdkAG/18vN8u/fUtc
         tCtfPdRLvIIthVC80eap1b5wJfTGOd8Mgehe0EOOeGLL0xdW8j5kdqMPRpUtN5Vnvj9V
         uuBsT3ZhtukNgrJWICTVj3JAofZTRFvef5ka86o9wQPAa3KLWeZNol+tI2Sr6fdvbdJf
         vCnsnbupNlQ5RO5f7dRUVX7bFTmvL0JFhzm6hPPROChOd/h0FBXzIGze9kJsXGdEmDKK
         p27TrauXvzDg0Ta6vmDgetiDWWRCkB7lbYZxkQ8tfRlt1saYCzp1+FmGhwBuwukU38XO
         8aHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 082/310] ASoC: simple-card: fix mic jack initialization
Date: Wed, 11 Apr 2018 20:33:41 +0200
Message-Id: <20180411183625.817846082@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477191061594774?=
X-GMAIL-MSGID: =?utf-8?q?1597477191061594774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>


[ Upstream commit f746aa5e8636c83e53bbb2d988bb614f732b2b80 ]

Initialize asoc_simple_card_init_mic with the correct struct
asoc_simple_jack.

Fixes: 9eac361877b3 ("ASoC: simple-card: add new asoc_simple_jack and use it")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/generic/simple-card.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -201,7 +201,7 @@ static int asoc_simple_card_dai_init(str
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_mic(rtd->card, &priv->hp_jack, PREFIX);
+	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
 	if (ret < 0)
 		return ret;
 
