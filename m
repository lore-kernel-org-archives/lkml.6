Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F06C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F9206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07F9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJLOMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:12:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41064 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:12:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3BC0872CC5E;
        Fri, 12 Oct 2018 09:41:06 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2786C4A4A29;
        Fri, 12 Oct 2018 09:41:06 +0300 (MSK)
Date:   Fri, 12 Oct 2018 09:41:05 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] crypto: streebog - add Streebog hash function
Message-ID: <20181012064105.bchujbwoaszrcu3l@sole.flsd.net>
References: <20181010121254.12220-1-vt@altlinux.org>
 <20181012061659.mextetc3v7urqkzx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181012061659.mextetc3v7urqkzx@gondor.apana.org.au>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:16:59PM +0800, Herbert Xu wrote:
> On Wed, Oct 10, 2018 at 03:12:50PM +0300, Vitaly Chikunov wrote:
> > Add GOST/IETF Streebog hash function (GOST R 34.11-2012, RFC 6986)
> > generic hash transformation with appropriate testmgr and tcrypt
> > tests and vectors.
> > 
> > Streebog Hash Function (GOST R 34.11-2012, RFC 6986) is one of the Russian
> > cryptographic standard algorithms (called GOST algorithms).
> > 
> > References:
> >   https://tc26.ru/upload/iblock/fed/feddbb4d26b685903faa2ba11aea43f6.pdf
> >   https://tools.ietf.org/html/rfc6986
> > 
> > Tested using testmgr and tcrypt on x86_64, arm, arm64, and s390x on qemu.
> 
> We don't add algorithms purely used by user-space.
> 
> So please clarify who is going to be using this algorithm *within*
> the kernel.

It is the first part of attempts to add to the Integrity subsystem
ability of verifying file and module signatures by Russian GOST
algorithms.

Thanks,
