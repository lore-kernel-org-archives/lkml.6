Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1635656-1521821050-2-3800699408610543005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FAKE_REPLY_C 1.486, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521821049; b=I7ho2kLyePZDiL2a0x5OWZ8BQPIFRwBLj0bX4Tm2Jr4NLMO
    6u94LvLYbVL3CcPLZok8CWUaN72TosofKq092tykM29BH5HccXDBAkPHtZ68+3Pn
    L/RHMgL7ffkNOrv9H6Yg1NReiqgg98z5ALOnq+nFefKCRRB8g8Xl1y8wMiMv1ru1
    eFbIYhDlCgUVsZETWCdLI44+maMXMqlGkGNzW8meY5ug8/X6Okc79eiEYCr6kYHq
    Uaof32ACSECBEWL2XjpvazCTxytArEiwtStTp4Kfe9LkGy0+IGFS9iBIi5R6p+Wi
    QRypnlRQvT10b//hZNdZuEgiGU9c+yHAJFjh0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:in-reply-to:sender:list-id; s=
    arctest; t=1521821049; bh=M/FNGOBI2w9Wa+y/BHQc/FI+PSKl3qZIKKEesY
    8iG4Y=; b=W+MBIxaFkwM0mqrdy3HzGdMvKJJmfd5zyn46wCtm8vRKXETJ9XX2o3
    rosrY8iK9YPpqI6T2apUsaqzH8MkLGLwohqYMRmQfqsxvX6+IPQ+2O6QLXaD2aqu
    n+bZRqJL7Cz+Z8UqR8XxLh/MxqVKR1MBZolJaeKhj/CucP+6RBMLDb+dg/AS3sll
    K/fXw/D9q04GG5PTxhtJhityTUYWcFKQ2l4YbRrYCk/DTm7QJiSVCLLZol8L2C+H
    0yPGhpUBcI7YupShX3qNzWwMGxcgN2+hRJgDDy36eCye5sARuyj14Kj/BWR6IyWa
    3+BAAJqtt6RmjMXggBnMCczxBCDGCvYw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCWQD6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 12:03:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36248 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCWQD5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 12:03:57 -0400
Date: Sat, 24 Mar 2018 00:03:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        linux@armlinux.org.uk, linux@rasmusvillemoes.dk,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: arm,arm64 - Fix random regeneration of S_shipped
Message-ID: <20180323160327.GA2414@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db77e20709db11b951a28c3303feb63990ef82d7.1520972030.git.leonard.crestez@nxp.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The decision to rebuild .S_shipped is made based on the relative
> timestamps of .S_shipped and .pl files but git makes this essentially
> random. This means that the perl script might run anyway (usually at
> most once per checkout), defeating the whole purpose of _shipped.
> 
> Fix by skipping the rule unless explicit make variables are provided:
> REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.
> 
> This can produce nasty occasional build failures downstream, for example
> for toolchains with broken perl. The solution is minimally intrusive to
> make it easier to push into stable.
> 
> Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: <stable@vger.kernel.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
