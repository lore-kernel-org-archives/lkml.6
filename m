Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF67C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D802085A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D802085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeKCPB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:01:57 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:47206 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeKCPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:01:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4791072CC67;
        Sat,  3 Nov 2018 08:51:46 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2E1AA4A4A29;
        Sat,  3 Nov 2018 08:51:46 +0300 (MSK)
Date:   Sat, 3 Nov 2018 08:51:45 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH v2 0/2] crypto: streebog - add Streebog hash function
Message-ID: <20181103055145.ndvxd7nbnoqtwrk5@sole.flsd.net>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
References: <20181010121254.12220-1-vt@altlinux.org>
 <20181012061659.mextetc3v7urqkzx@gondor.apana.org.au>
 <20181012064105.bchujbwoaszrcu3l@sole.flsd.net>
 <20181017060851.r5mxvpq3l2ycvpio@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181017060851.r5mxvpq3l2ycvpio@gondor.apana.org.au>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

On Wed, Oct 17, 2018 at 02:08:51PM +0800, Herbert Xu wrote:
> On Fri, Oct 12, 2018 at 09:41:05AM +0300, Vitaly Chikunov wrote:
> >
> > It is the first part of attempts to add to the Integrity subsystem
> > ability of verifying file and module signatures by Russian GOST
> > algorithms.
> 
> It would be better if these patches are posted together.  That
> way we don't end up with a situation where the algorithm goes into
> the kernel but the ultimate user is rejected.

IMA does not need any particular patching inside of their subtree to
support new hash, because it is using any hash registered in Hash Info
which is still under crypto subtree. I added appropriate patch into v3
which is already posted a week ago, and tested it to work correctly with
ima_appraise=fix.

Thanks,

