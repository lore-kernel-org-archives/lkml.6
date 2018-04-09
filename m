Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-499609-1523266050-2-6158214229830145916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523266050; b=A8EqYpP8rMY+MeoIgJYuyJRoTK2iVXZAAGISR/NzFpXP37ELzv
    Ju0GQofQxhDTtvsUL17F2Xp+yppJTpTs4J6oj3lBpZQfo/LGwI4n432KVzUHxTxs
    LdhwaO/aNFjEcMMF8qg7IDARtl+ChkAAcYay32kVi7lqXsup9f9F+Bu7XdPZH1vP
    UWPWZ+6kgqKxpbxsf8Yb5mOpv0skHUUoi0GCN5eEhHA4XvYu/4dxhPI6EEOEkntD
    t5kXxPfc1kBBsQJ9g7h4yCPZ2ICbsgvaOiNwzhcM4WqcOYIat6QzHWImiwbicr6p
    H4fEVJnSMTwoltR5JHuvK4lHQtHrDkZViTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523266050; bh=PMA4uRmSew30/S63pOpYzLMF16Rihm
    vmHFdP5kZnrdo=; b=ie/BEafNWFgftYQN8f/zvLc0vee6NeVBNaA9LCfbIyJ4yX
    quKSIMkcAvyFuQFtZlWiIP7UgukVFKDmQvlU4RosbkVL0LvXQikqB6GGzYxPQ13X
    spSSLTU01UCuLJONa1WCGk+3GCBZvP0D/ic3/2WXHYREFibIFHw7KXLazhPHYZvE
    XmmYWI2amhMlU8A1F0IP1bDudlJi+fjJzhKNmKDlRnjC0HQ5PhkjjtRM5a0tPntR
    KK33tAFpa5MD1ZxcVZF1hx9a70ALdmZef9GlOK0L5zPcczzkBpxXleEDAMFRv43i
    VCV3yqU32XQbMo2IF7kbTYjFhykJTQ1i9YzklqcQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=PKZqZey8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=PKZqZey8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCrxl7rdtE1Ou10rCHx6RlcVVowIxxLxKTUv34EYKugzf8Yq9U+7nRM2nmhtj6XB3c2kjqQFziA2FhU8PmmqhOf7c3YOAQ/MUOJXYZaF+Ckt57e/ODfx
    9vabkXCrFZBiFuADQsWRF1kY7neRkzqYVri5YWPQmqqUU45Mr5rR6TzIdllm/Sca1ePmkhI/xNRaQiuTOMrpIMacKqLJCHl2LIP+hkkLJ2S0x5SPofc6C3OQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Wp7P05NkjfQO3gTPPqUA:9 a=CjuIK1q_8ugA:10 a=yJeI1O1vidUPoUe4JT4A:9
    a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeDIJ11 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 05:27:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59412 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeDIJ11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 05:27:27 -0400
Date: Mon, 9 Apr 2018 10:27:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH AUTOSEL for 4.15 044/189] ASoC: bcm2835: fix hw_params
 error when device is in prepared state
Message-ID: <20180409092724.GA11532@sirena.org.uk>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-44-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180409001637.162453-44-alexander.levin@microsoft.com>
X-Cookie: Professional sample - not for sale.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 12:17:20AM +0000, Sasha Levin wrote:

> ---
>  sound/soc/bcm/bcm2835-i2s.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

This is a relatively big refactoring, including moving things from one
userspace operation to another.  I'd not be 100% sure it doesn't have
any extra implicit or explicit dependencies.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrLMfkACgkQJNaLcl1U
h9CcmggAhrKRCa55LeP4t04MmvRReM+JfKimnsdLVeMiTpyYvhNaJMA61iAI8kzw
qalxYvgKI4rFYK9oYHgYN9TWXybW1LwQ37oIyN8+bnHzYStC953RXCZWp6J8MsJW
HVfsl0d+VDihX8nsXjmcAffwrpn2kDl+dv6u9v2b4BNvQhR7ylCfmPX8Tu8B4AuC
j+0LByD4E3OPeN3P5ze1l1d4iUNpFgJWpN3Xio9FZcaIbJVxoLaJpcBVB1oh88HU
mLG5KtyCcp+zAU6ZEExgtUeWpDCLWy/pL2uhcVrYILLcoxLzUUs7cajtUOTk3jhr
wOrV/44Hop8trRrSdfaE+7qgigjPTA==
=S7I1
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
