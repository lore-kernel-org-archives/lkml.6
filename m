Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225778QpaaJ0YmZocoSnq+sqr/AdeRA8xcQV/+4nYiwbL/zu7b1Xfts1kjLKmKD6yzi7ii1a
ARC-Seal: i=1; a=rsa-sha256; t=1517591720; cv=none;
        d=google.com; s=arc-20160816;
        b=r96B1vv96uHKQk+tjTsyY87PI/H3pWtpYVS1CtKcJZZAw6T+sOKILIeKYcDD7iPuN+
         ziuHnCS82GFRROCqvAvzPptyroBuyTlt7ogG3bI5hfBlazY2EDbxb6OTBggiyVUmRvLy
         h21OD/7wmN8gjD9HA0IDwrxsNErBN/Bm1NMa2br5C/5/AWRlkHUUwOAf1wo8/HEm8Gi/
         t8TA9/0JuQn6lJRcalUu133gGUO6ztbLwYdOh6JfGKIoSqrsfkot8on1aSo5Ir+7ftBV
         yHe26sRGP7QnNRLcur2spCjwh9W6a1el2n+H9vADU22DoZy9Vd13mw+s2tbR9rnciNby
         a0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zoZoWRb2NZqborgwwRbZKG7w7mjSNsRjJNS24KNLZ/E=;
        b=h9tDypAm8OHBfYe2Vuclb8O2M2o5HmSNTeYniNUh6W7oo1mcirhzDCDMzCz4Aynq4Y
         Vhol/JPGH2uR6zkwbfw1+brBFlLJ86nzLXceyuYfIurm/cj3nNNOMwikoYC359+VYGCa
         ocRnCzcXmETivMV6REWjSvy5dkVnZXauq+6W+zc8pq2gfA0M+jy3+VPg/BslwWGMYUxs
         9rfpxJidm9ZPXEX4ijPHkxSO0ObBOpdPZm2oNeth8AnoWtsZIzJCv5+XyBI3yLW6EIKx
         TqM/sQY177xRXcA7UWT8lFJxvoc+ARob+GMDidxd8MVr27+5rvxjXmz8yJW0tbS5s255
         q5Kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 06/55] crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH
Date: Fri,  2 Feb 2018 17:58:24 +0100
Message-Id: <20180202140826.603285760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309493854941730?=
X-GMAIL-MSGID: =?utf-8?q?1591310255770547654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit b5b9007730ce1d90deaf25d7f678511550744bdc upstream.

This fixes a typo in the CRYPTO_KPP dependency of CRYPTO_ECDH.

Fixes: 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -130,7 +130,7 @@ config CRYPTO_DH
 
 config CRYPTO_ECDH
 	tristate "ECDH algorithm"
-	select CRYTPO_KPP
+	select CRYPTO_KPP
 	select CRYPTO_RNG_DEFAULT
 	help
 	  Generic implementation of the ECDH algorithm
