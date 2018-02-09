Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1726190-1518193689-2-2426650128569396027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518193689; b=GNSWj2wucQCMj8oUBh1fU/RO8LwrSTk1CRNr7mAdjmb7dql
    cVloWGhqUa1LunT002SD6Z8YWPwNFnNKEbYi2qV7nLOdUB5vlEP6ho3vd4GbJo9i
    MrkpsrjLsqmTR0Jrr/0iniDQUmlqJHo7egUgnaSnsTvaxwoYbgMGP2kbxYiVSlmh
    qiHPJ0fnNr9XRhMu0BLsWlHejxo0pQ0Wq9IlPu2U/M3hlPA/j+k3UnZYODqDXLz2
    Xk7Qv8Lsmgtmf8HbweYzK4wUw9OkySFMiQp6fA33AvjkBVFI/9djtrRA+IpuA2Q3
    fnWl6N3MY2TNHLlWypLH7Jn+dZT1aNp0k1cFztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518193689; bh=uxcYilSGaZ2kmHNcR6Fh6/6e8S
    pdO88jr3rJfuLezRU=; b=Np0LO655uVAkBNNaTRLTCYk/9QsAnQe7OmAhOoh+tt
    G0CU00ajuGQcB0/8nS7ODAESHLH4SmnTQ49jeisrvafUKPyCG0gWKcAsiktP0aoo
    vx63UrC2twL2KFD6mdhUaNqbxFaWx5BOmxmoiCX2VVYMghCTMw0XOxSAL10xKMLN
    NFGYCmVwB7h9WPInmbRTXC9PCggnOvLipGHyBgO3oErUQEeLnV8V28kI6VxxktOK
    X7WiV7SLxAS3ANRTNJgNzW1z8Ab3VKbhVT7AkEI3mvO62rhl0v1cm73yfVi+oCDQ
    N48VGZQrjgcsfXEAN8t76zArNumTNajrkNbOg/2lxeHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeBIQ2F (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 11:28:05 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:56916 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeBIQ2E (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 11:28:04 -0500
Date: Fri, 9 Feb 2018 23:48:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Megha Dey <megha.dey@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: sha512-mb - initialize pending lengths correctly
Message-ID: <20180209154849.GA22273@gondor.apana.org.au>
References: <001a113fae28e4fe39055f757ab5@google.com>
 <20180124083127.11239-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124083127.11239-1-ebiggers3@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 24, 2018 at 12:31:27AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The SHA-512 multibuffer code keeps track of the number of blocks pending
> in each lane.  The minimum of these values is used to identify the next
> lane that will be completed.  Unused lanes are set to a large number
> (0xFFFFFFFF) so that they don't affect this calculation.
> 
> However, it was forgotten to set the lengths to this value in the
> initial state, where all lanes are unused.  As a result it was possible
> for sha512_mb_mgr_get_comp_job_avx2() to select an unused lane, causing
> a NULL pointer dereference.  Specifically this could happen in the case
> where ->update() was passed fewer than SHA512_BLOCK_SIZE bytes of data,
> so it then called sha_complete_job() without having actually submitted
> any blocks to the multi-buffer code.  This hit a NULL pointer
> dereference if another task happened to have submitted blocks
> concurrently to the same CPU and the flush timer had not yet expired.
> 
> Fix this by initializing sha512_mb_mgr->lens correctly.
> 
> As usual, this bug was found by syzkaller.
> 
> Fixes: 45691e2d9b18 ("crypto: sha512-mb - submit/flush routines for AVX2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
