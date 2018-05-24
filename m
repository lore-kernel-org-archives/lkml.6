Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156319-2-5139584424579341510
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
    1527156318; b=RBiR9a9rWZs5AKDT5WowdGvHgxthMpIsnwwIE3JWWLylK4/4mt
    nMNHfrmVPR2NUi+CkGfivVEB4ZPTIK1bGj9DWUq9o9TBwxiloIvg84p4SpF1q4X/
    E9UKg98DaqovWOqwLQXgJWc2rssQvzdoEpwWGSFDxVY/fkglv0omrhhxaXsdwhf7
    Kw7GMZl8uJHaINFq3tpP2j35FE2XdAR1GlGCF3bLVY2cPhf98jETHedIEpjN4Us4
    mmDLIpqGYFVw58nxcKlDgetIDDhu8oZ1rbXYd1GEFq5EU2EIQxSneVtM8P1oKfCg
    vZWuLPXO47t0JpzPOVMTJnYu8AD69rsDYseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156318; bh=GQ21AFmZ6wgWa6mpgmLqwnaASTaNnv
    QwjIpC2HOv5E8=; b=jtL9GgiODVOGtaaQnKtQi40m0/xiZEQu4ivUGFAZc+C6VW
    26YnySJzN5+VTc8Tp67wkL38w9H3t+YeKXiOCzcZwAzEaFXwzEGBP8S7O4bBieX9
    rSxMxNuKN7O8ZIMYy3/rCjA2nBwZdZUIcEvTZhVehrgrN6AEnM/AsZbhWmi5s7vY
    MqPUV4aXZOPlCMn3k5YfYCBcMbtdtXkPB0D2B6jgdBeIZxxfvAoJihhoyYAitsI7
    RU4yzkjhUUb/mGfZ9DUzamW3PWRnIVcVxkTTUcRZ5mU2cxX4tJKQBn0+nKwm0nu+
    kOajPSRxd9wVjAOYbCXxNfN8ZKS2HHqygqL+I9cw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=i6GREgek x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=i6GREgek x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJJTcTEOGvUk8UhSStw6Q4o9A5pISZCszAuyE39V9zmWkjshe1qDsSInMfJv4N5M+/65kvucXrSdmPufLl50h8tUpelABzK2RvmtJALpKguyIhJWjeW2
    AhtfAnAcF59+EutXobvhfsl+jRUB6RcsxIPMhhBYtSWaFCvhnGGzVjtOJ45DKKGa3w7FKs9/0qY/dJKeRTVrF6bxPaOCY1NaWTlttSf6xnhJeUWkLqTFDOdl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=eU1mK2Bu_64X5QokrNAA:9 a=QEXdDO2ut3YA:10 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031527AbeEXKFO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031012AbeEXKFL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:05:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 105/161] crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss
Date: Thu, 24 May 2018 11:38:50 +0200
Message-Id: <20180524093030.975093868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
