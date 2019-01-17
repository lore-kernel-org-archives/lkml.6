Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6D62054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="Qhb3TQAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfAQLem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:34:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:14069 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfAQLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547724878;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CMsITsKbyjvgEhreULlkX+EiLDgq7x58vODMBNcvRzQ=;
        b=Qhb3TQAMufbkZG22rBvSdXZXwMWLOdG1mfz4Gsle4oi7H3e0WV/0K/Ys8rBRbCi7fR
        FItT1dJrNFWGSL2YxLK7tv9u5nQP8JUL3lUWVyE7OoRM1e1arqKljsqIxNdH0lsQJCRJ
        iY13GdS12HfYtFe8ERAyEpvvwt0KeRcx1T4DwAGtokeBw2iONMU1Clf0FaP+6WBe2/wx
        SGctJSwgDBXnfpJZBQ89Q9OP80n874jIjOYqFwjnv/PP2ughXZhTvLOR7341A3kvnXwo
        vXgOJu0h6LpzBhZAbCGEFo2CJrSOiAvLVyQx7TqyQLiQHlsC/XFRmuLIscRgF3QKTmTy
        zIJA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0HBYSB7s
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 17 Jan 2019 12:34:28 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Kalyani Akula <kalyani.akula@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>
Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Date:   Thu, 17 Jan 2019 12:34:27 +0100
Message-ID: <4735882.YQOrfzxm5S@tauon.chronox.de>
In-Reply-To: <1547708541-23730-5-git-send-email-kalyani.akula@xilinx.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com> <1547708541-23730-5-git-send-email-kalyani.akula@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 17. Januar 2019, 08:02:20 CET schrieb Kalyani Akula:

Hi Kalyani,

> ALG_SET_KEY_TYPE requires caller to pass the key_type to be used
> for AES encryption/decryption.
> 
> Sometimes the cipher key will be stored in the
> device's hardware. So, there is a need to specify
> the information about the key to use for AES operations.
> 
> In Xilinx ZynqMP SoC, below key types are available
> 
> 1. Device key, which is flashed in the HW.
> 
> 2. PUF KEK, which can be regenerated using the
>    helper data programmed in the HW.
> 
> 3. User supplied key.
> 
> So to choose the AES key to be used, this patch adds key-type attribute.

You expose your particular driver interface to user space. So, user space 
would need the details of you driver to know what to set. If another driver 
has such key type support, user space would need to know about that, too. I do 
not think this is a wise idea.

If we are going to have such a keytype selection, there must be a common user 
space interface for all drivers. I.e. define common key types the drivers then 
can map to their particular key type interface.

Besides, seem to be more a key handling issue. Wouldn't it make sense to 
rather have such issue solved with key rings than in the kernel crypto API?

Ciao
Stephan


