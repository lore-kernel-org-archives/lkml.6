Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48uYKRP0BJUUTa2R/zkr0SspnKmRDvk/KMxlnYPmkOqfx4mJpzqGvOp09mKYtTth0oj5nHN
ARC-Seal: i=1; a=rsa-sha256; t=1523021964; cv=none;
        d=google.com; s=arc-20160816;
        b=mvFEqBeTAftw5WNHODB4GdBvlkouGV7W5TvlTqk3xz3aPdExwZhxWTnXdO1jad93/N
         XJ2eJ/gyuYvQEYUGxnzS02j9Egqm0gMh4jH5nweeOyhLHsIxx5q5bWE6ieuYyG9fBcvQ
         JjUJ2+2eevbZx1DQKDB4aotML0PpKCbohnsJOCQf2Cka8epydRJGGiuQwGJnruth+gas
         BXnLR5AfOORTES7sS7QCNTV/SHoRHiA/n3Wc/r8uVb1hGULDUgk+P14L445j0DVnZcOi
         t8CoO8Hrng7l7hnpuSuF7TkB9BRf5OWItpHBMn+IkuYjAPQtevsynfustCBpipIHzNjx
         S2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=noum1gDHzmNoipDzMaQwjAHxgspK02Z9ZsiY1vL+8gY=;
        b=WiYgVW6p5YmhfJ1fapi1dEV+H0GzhymvsXYBm3fWFop6PihZpRxQvEDeDcLqcnFrxN
         GA7btTGINH+SjmngWwigpHg79WHrthnRgrkP9OlYeW4TR9c8P0O5bLUdVtqqFEHqmEsU
         +svG7093dbVIRNsmJYoS5WS8nZvExq124IgyKE2o3phChCnwKoH70QleRxkmkoxZ8bX+
         5d1oRmRXpTGZTVAlRfvF/HDY9Ziut+xYVa5HmnyiXACurz2r46tXY0mvcJcHeXXb8nr6
         17+rvkL0x6VMy+3U3ymIPkUyJC0Sm2OXKlZTjEYySyaB1jS57Ym5xU3OhN9wGUw3z2IY
         oLZw==
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
Subject: [PATCH 4.14 50/67] crypto: caam - Fix null dereference at error path
Date: Fri,  6 Apr 2018 15:24:20 +0200
Message-Id: <20180406084347.671555937@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004279167623961?=
X-GMAIL-MSGID: =?utf-8?q?1597004279167623961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
