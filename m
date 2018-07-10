Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569CB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="P0whw0rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569CB208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934643AbeGJQoV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:44:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:30056 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933331AbeGJQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1531241058;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/MReB7pfyMArGyqAquKMgo2/n0Q/5QdRphNHEym+S98=;
        b=P0whw0rEPdJbd7HCz58lufRYdzGa4fRZFEjZ9atME9iKrFNX2Jpahpx3lPPZIiKS/H
        Zt/MjtVvw/UAlQCHxjN57kdYB4MJwJBjPsra7cvlv542O/V5ypUEG3cTZasDTC/5E7CC
        nxfsWupW+eG6Y+krkmFOJmkF30FU1D0h8tJ83LItbgsZG6VA+bg6Osybr6bazUqYwspm
        L39zFmZWbySk2hoLPit4YZkRJvdEZaxvXl706JVZv0krZm2ZhNnaAFcFihaX7zCx58PB
        Rq8V39TShcPqLCBg0HMP+vtLoy56VybKQMMLVPgsZgJEpcErcvzZmZjhNjnJHw9E2dnw
        hbqw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGri7RBBYk2qJvGdF8MiqOOAHCPc8jOeCrHJoAiT"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id c0bedeu6AGiG1q3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 10 Jul 2018 18:44:16 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: dh - fix memory leak
Date:   Tue, 10 Jul 2018 17:28:34 +0200
Message-ID: <5010742.5FTaVXtiru@positron.chronox.de>
In-Reply-To: <20180710142252.GA19600@embeddedor.com>
References: <20180710142252.GA19600@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. Juli 2018, 16:22:52 CEST schrieb Gustavo A. R. Silva:

Hi Gustavo,

> In case memory resources for *base* were allocated, release them
> before return.

Thanks a lot.

Reviewed-by: Stephan M=FCller <smueller@chronox.de>

Ciao
Stephan


