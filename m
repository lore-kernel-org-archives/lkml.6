Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB62C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A86C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="QVQ9u3bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A86C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKESVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:21:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:24089 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKESVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:21:11 -0500
X-Greylist: delayed 733 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2018 13:21:10 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541408549;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=eaLtxhWlgchk/AoUkEOxwhdi7HdmZ9GdCs5PQABtI18=;
        b=QVQ9u3bE5n8lHHU6r8eaxtJsIg7bV6C8cCo5qgbN+by46aXmiOz8GpYg342lj9d/UQ
        NYhEvP85i8KMNIC6O3O6+WUH8WXw/lKRXlBvaE8j+4ibQKdUBsSkQ9TD1EzHiMb76ck6
        qlMEW/uaeXih7qpK6A0ZfgQ2VkSWU30oSvGZFkk5XVkOMO9lWlwWdmhU6hzZDR90Ywb8
        Baq9l3ePME6rIGuiWCnoZtlg6+eWY3qXCam8A4Tu/cbb15BcpsMVUoxNRVYmctEuL0GL
        qZvwqGI7R+r0NyBb8f4ZqCtYSbm8IQv1PeyiqM+yJcq7srb56jnn/gkxAqwYklMDe+g/
        +K+g==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSYiH4="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.3 DYNA|AUTH)
        with ESMTPSA id w08d48uA58oHDGq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 5 Nov 2018 09:50:17 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: mark cts(cbc(aes)) as FIPS allowed
Date:   Mon, 05 Nov 2018 09:50:12 +0100
Message-ID: <2578248.XAorIH2ink@tauon.chronox.de>
In-Reply-To: <1541325924-14777-1-git-send-email-gilad@benyossef.com>
References: <1541325924-14777-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 4. November 2018, 11:05:24 CET schrieb Gilad Ben-Yossef:

Hi Gilad,

> As per Sp800-38A addendum from Oct 2010[1], cts(cbc(aes)) is
> allowed as a FIPS mode algorithm. Mark it as such.
> 
> [1] https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final

There are several types of CTS approaches. Only three of those are listed in 
the SP800-38A addendum. The source code only refers to some RFCs.

Did you check whether the CTS implementation matches one or more of the types 
listed in the addendum? If yes, may I suggest to add a small statement in the 
code noting this fact?

Thanks a lot.

Ciao
Stephan


