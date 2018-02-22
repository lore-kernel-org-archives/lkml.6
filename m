Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-294332-1519309484-2-9559481770346485871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519309483; b=H4PsAogtJNCizArFhS++UtH98HlyimO6lIQKzo6d0aZZDca
    1zZEvSOgtAoyJ0MMJZU5UYj86/m1W6IOH7KPFxSAphdxVBtZ/Puda9GzF+iiE3LD
    nAMlNcchjidNUt8Kf3OIrqy/NrCQCaL1uO1Tqdnr1/6XyUlOcecpvbuMuxEQ1oS3
    J/cuyUjK7ONuGpD5ARbSzjS6x+5DF5Q+jkXIXj/5CpD02lZEWvQNIrnajVixCJhg
    jJhVzoY1rX2MRwNfG05dtjoN8I5FARPLyMY6eXmdkI6bTo8OESr3bQU1nuXuDYQA
    dFg2/LU5WwfHoeRJArSXwT+BbDCOTgM0h3ecRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519309483; bh=Wh8QljMeAjFdEXTPy7ohXGq00a0zQ29xSWkC2pVDqaI=; b=I
    NJHSkrh5ekAeI/AMfba4qHAIB34V8RS1XfeqP4S9gizzlgNX6XpFnJWtkP5g7DjO
    Fgm3VP5c52rbuWn5idBBkh1cYOgR/JjnoBW8D2HoOWuB1bbyOwij8tLz2up+2O4O
    bJsZ3G+4LWbR/F2TkUH+pd3cs1yMQ8S6L9PCyPMLBipoFfvRBdL00E8hFtorOcSM
    VvU21YZlkyupRew5jH889mhqNWasatlx9dBthe+fq6MhHq96zmUFtPR9LjkM9ID9
    vIcBnO+IgEFNi8AQo7a+oXDDbGY7YV29aPus6lxwm8DFtOJ70bci9lZWfNqmzewm
    OT0LQmc3OQr8WaOz8jzJA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=EM0jsAKB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JycEOcyR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=EM0jsAKB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JycEOcyR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeBVOX1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 09:23:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36383 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeBVOXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 09:23:22 -0500
X-Google-Smtp-Source: AH8x225D3UhVZ9RGWWA8P1JmpwKebbY1TXCTNAkqJ4uOQoZhdBxgedMVVSBlVicI607hPNnTzWPJ6A==
From: Rui Miguel Silva <rui.silva@linaro.org>
To: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        stable@vger.kernel.org
Subject: [PATCH v4 1/4] crypto: caam - Fix null dereference at error path
Date: Thu, 22 Feb 2018 14:22:47 +0000
Message-Id: <20180222142250.31348-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222142250.31348-1-rui.silva@linaro.org>
References: <20180222142250.31348-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/crypto/caam/ctrl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index e843cf410373..361e750f9cba 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -815,9 +815,6 @@ static int caam_probe(struct platform_device *pdev)
 	return 0;
 
 caam_remove:
-#ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(ctrlpriv->dfs_root);
-#endif
 	caam_remove(pdev);
 	return ret;
 
-- 
2.16.2
