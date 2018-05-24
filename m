Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159841-2-15590420373709894166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159840; b=PV8Q659wvP07W7uIeNgyCbA+5tzBXKofGx/ent6rLcZaJequDh
    tgCfGvvMqzNcECE2RPTWZpSP9cLzgJTzKesSlUJo/vOQ6iMs7wxyxSR7m4N9MFB7
    uaQ7JGqipZv4LLkDrLJ3CZkRJm0AzYhVtA9fR8dDbJwJ4gwz5Bh+IOWFH2PVPAOv
    +d5vXqOu5D5/ua5uwGmG7GpiWfOW/hl2DqiovNJeY7TCldaHZ7OixoxSETcG0Ut4
    Jbej6Th5s/8MSE7yC5q3oji/K5zOGuxVvRyWT7OJCYbQbZ+APwy08WsBHs8z5nx9
    22BcyuuhuE5yP/SffDPNagdBDDU9u8qQTSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159840; bh=DvDJWAtX1dsvR5TtEU95dS9TJ1OtN6
    34eUmIasfZXfg=; b=CZpeG0EemTbOv5/LYcEWtbVHb8GvBZvDvK/Gvsfq5wbGXS
    B16adOjhnCzXK9d3lEZ04lid/IMQpKK8o04Br0DUXzGwqbzvkeWLNpWrxR3j96GC
    O4SxUx6bRRhIWAu/6e4Sy502K38I+badbJDbZvEj0FlCXdR73SQ9e3LnnnBVGztt
    JTUmtcXBg0UZRfD807fsp0UhY0OaASprllan1njowiUQJjKjvE2Sw+Zc55W1TxTt
    o3LpK6TcreQvYY6W7YFXAWETOiO3/brqrCVbMtZylQheTDbBnvBCjhyqvF+HFaXX
    FHPQkZ7lSzdzD831P+DlBGV/lnz7yBIwyH/Px5zA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rBe8vz4f x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rBe8vz4f x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfARHo2F7gf1VSLFs/ZtZQOSDSGbz8O1dW/xoAMudevlPOYGZW/JnH78GNMg0k1nXdfcB7HT60qtVCP9hiczc8Qmnl1oYuaQoyPbQn/Z8mGPusvuenvei
    E1k2u9aI8G9uY7TIN9hOrBxsaSv0fYrrrebV5sxJW1jIC9JY1lDyqNUY4RVfLlBcnjdvxk2yAsitF5QvmBvbrq7if+Ep9SZIJDkKRMX2FaaAD5hzYJYjL2HH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=eU1mK2Bu_64X5QokrNAA:9 a=QEXdDO2ut3YA:10 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030260AbeEXLD6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968085AbeEXJzf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 097/165] crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss
Date: Thu, 24 May 2018 11:38:23 +0200
Message-Id: <20180524093625.943468331@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 7c73cf4cc2ac16465f5102437dc0a12d66671bd6 ]

The MODULE_ALIAS is required to enable the sun4i-ss driver to load
automatically when built at a module. Tested on a Cubietruck.

Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -451,6 +451,7 @@ static struct platform_driver sun4i_ss_d
 
 module_platform_driver(sun4i_ss_driver);
 
+MODULE_ALIAS("platform:sun4i-ss");
 MODULE_DESCRIPTION("Allwinner Security System cryptographic accelerator");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Corentin LABBE <clabbe.montjoie@gmail.com>");
