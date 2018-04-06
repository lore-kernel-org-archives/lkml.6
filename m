Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/NJR4opK73pB7yWknBiVJaOF1acSrrZPnbBsw3LHqCoMqrWvMwZ6ZQ4wGTSspUiM3IXzAs
ARC-Seal: i=1; a=rsa-sha256; t=1523022276; cv=none;
        d=google.com; s=arc-20160816;
        b=jdyVO3RY6H0bNugtmvOmuquUfoZTQURPu7u7gGF+ZYp4j2P/eG90Pr6abC1YRq879l
         BcFlc5Lva+N1U2USvvtCcXZqvcZ97vP82VIsbgKPK/Rq41tJnDAx3JytM1NGuqlOjT4K
         j6ic7Aaz5tj2x6tQZ/1DtwzyoGbvSHGbSZ3Od8XiVHaE2iKWjEbiIPfCPUsUzg/I5/Ql
         51STuwSgdBLCS9qGyqI6r6yjkgbKGcEFYUmKIDOd5t9b9aOHvEnG2lJ8rFy/eC6Vfd74
         qd5z0T6+dfTWVG3bU+m6xDmdtOFf23RXmN09StBD7HeIt0XYdsWFT2SBpMyWXqyb+G8H
         YYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=whXvO5YAhAVFvq6QJ/clQFpjD+9gsAF0PPOrh/Q/9Mc=;
        b=czrSKlpF2RbeQXR5o8wNd0Wpc8ekHUYHoUrzLwLM0pERUz/lmYiHPFqqhSe2UBZ6xX
         VET7TrpV5qN9ZS/kjbMWGxieSqnzX4MGeNClI8Psen9yyzdyABmg719mkak2GC8kkYPf
         Nd4bvm5GCBKGxzwJ0Op2B+627kO8Ap5eiMTImgWsR2iUpVtF4304w0tRAAJpfKBJer5W
         bVUPFxJXnfHWrV0vYEDwcQ99nOlM2C8xkJHXyvtbENYrLWa4GPZh5ZQXe3gnlkY8v+61
         vZl2Vz3kvRd/vD5dfJ83krZycMmGdfYltc/ff3tjQO/HVIgBekjmOX8M3LJ1HN9+MQc+
         zUxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ryan Harkin <ryan.harkin@linaro.org>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Aymen Sghaier <aymen.sghaier@nxp.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.16 17/31] crypto: caam - Fix null dereference at error path
Date: Fri,  6 Apr 2018 15:24:42 +0200
Message-Id: <20180406084343.321425259@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004279167623961?=
X-GMAIL-MSGID: =?utf-8?q?1597004606680840995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rui Miguel Silva <rui.silva@linaro.org>

commit b85149f6f5d5a9279f29a73b2e95342f4d465e73 upstream.

caam_remove already removes the debugfs entry, so we need to remove the one
immediately before calling caam_remove.

This fix a NULL dereference at error paths is caam_probe fail.

Fixes: 67c2315def06 ("crypto: caam - add Queue Interface (QI) backend support")

Tested-by: Ryan Harkin <ryan.harkin@linaro.org>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Cc: <stable@vger.kernel.org> # 4.12+
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/ctrl.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -815,9 +815,6 @@ static int caam_probe(struct platform_de
 	return 0;
 
 caam_remove:
-#ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(ctrlpriv->dfs_root);
-#endif
 	caam_remove(pdev);
 	return ret;
 
