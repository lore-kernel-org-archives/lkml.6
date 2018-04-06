Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48W+UQS45x04zv8sCIUKfxM8ffaigpvzsA9R7l3hUnfrp5C2otYh+U4UB4PgOw4KSPi1F+2
ARC-Seal: i=1; a=rsa-sha256; t=1523022238; cv=none;
        d=google.com; s=arc-20160816;
        b=kS8tSsulp2sMfpC8wWF1DxH+vXkUn6ZuNZAyxmwLdaRQaSEtuuri8evAQT7DkF7ANi
         Gt3lDciuigVhtTzD1vMjf1uLDdPCplnBQf4ZnbshEXRHLVtkXE3OHgduVbOwHcG8hGoF
         E6/5Vw7oBBJkJZB5vn3VQrQh8ZpcT2Zzb9AFVkQFeZSN3DHdtVz2ykHqOJuHP09j6YgL
         N11SnwoEt7lXelNr8I+wEydrE/9MSndg5LFNGQHpp/zHDCB1FF+ZemZDrIGhqobQZ106
         z7TC2PReUMfTF71zGk0AJQQFqExMrPTLTVSp8e1fvn+V4/Z/tVxQ8LOq/1x4UCdjeUyI
         ma3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s/8J1edhvrFUxmgm9xrJzRdPlO+JBrrbrPY/qh9/qQw=;
        b=jvj44Oz1IGCk97NcZRBwF6WQBP7WSLua2krUjnkHxyyWzUxT2zJARMnB8QcBfYMNSn
         Mm5tkvwkVX/LOFPavFaepI0+EV1N5tLuhAaWoOGw3LZ15C6a6DzeonrDc4vHri+0/Kf4
         qaeG86RZQ1raqXouko7amM3OEeF4Ac8oLeXinFDsbp/AXK6u5I+GP7Wmdfd/8LrlGyCH
         KS1tqEP1UkuBPWUd91hKc73p6VCbYzjxW1fgxR15fnmxXiFZjb+30HIOk+2PnPpY+rOZ
         3LpeAgxuue/zrBVoxgzIVffg/Sin3XeF/jBBNzefUeRjPvjX8xReGhgTC9h7D7JPj5Td
         JPRQ==
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
Subject: [PATCH 4.15 55/72] crypto: caam - Fix null dereference at error path
Date: Fri,  6 Apr 2018 15:24:30 +0200
Message-Id: <20180406084353.209635383@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004279167623961?=
X-GMAIL-MSGID: =?utf-8?q?1597004566486390828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -813,9 +813,6 @@ static int caam_probe(struct platform_de
 	return 0;
 
 caam_remove:
-#ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(ctrlpriv->dfs_root);
-#endif
 	caam_remove(pdev);
 	return ret;
 
