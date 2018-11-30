Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD67C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AC42145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdz86olg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AC42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLAFIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeLAFIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:08:10 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4853620834;
        Fri, 30 Nov 2018 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543600685;
        bh=YUM7HXgxbQCLX+SU5jHzJJ4IAUHEHp/OdtRCPJKsd3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdz86olgqb9M71SDZhKF6VOHFdRrw0sGasaXR2hPtLLNmAvS06Fyu80MalgNEc97/
         mrtytNm6xwsNljiAfhBamOtR87Rdqqnwu5vkq/KdC1UM5cLL7JvYdQ8jJtM4kR56wX
         eRaJLoCn6LQ95FzreSi0ouABnsfkVQMIZLihfV50=
Date:   Fri, 30 Nov 2018 09:58:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: Re: [PATCH v4 00/14] crypto: Adiantum support
Message-ID: <20181130175802.GB135453@gmail.com>
References: <20181117012631.23528-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117012631.23528-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:26:17PM -0800, Eric Biggers wrote:
> 
> Therefore, we (well, Paul Crowley did the real work) designed a new
> encryption mode, Adiantum.  In essence, Adiantum makes it secure to use
> the ChaCha stream cipher for disk encryption.  Adiantum is specified by
> our paper here: https://eprint.iacr.org/2018/720.pdf ("Adiantum:
> length-preserving encryption for entry-level processors").  Reference
> code and test vectors are here: https://github.com/google/adiantum.
> Most of the high-level concepts of Adiantum are not new; similar
> existing modes include XCB, HCTR, and HCH.  Adiantum and these modes are
> true wide-block modes (tweakable super-pseudorandom permutations), so
> they actually provide a stronger notion of security than XTS.
> 

In case anyone is interested: Paul and I have made some improvements to the
Adiantum paper and have updated the preprint at the above link.  The algorithm
is still the same, but explanations have been improved and the proof has been
redone using a different technique that is easier to follow.  It also matches
the version that will be published in IACR Transactions on Symmetric Cryptology
(ToSC) Volume 2018 Issue 4.

All versions of our paper can be found at https://eprint.iacr.org/2018/720, and
the .tex source is at https://github.com/google/adiantum/tree/master/specification.

- Eric
