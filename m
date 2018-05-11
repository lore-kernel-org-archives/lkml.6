Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEKUKO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:10:14 -0400
Received: from namei.org ([65.99.196.166]:60330 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeEKUKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:10:12 -0400
Date: Sat, 12 May 2018 06:09:49 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Tycho Andersen <tycho@tycho.ws>
cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v3 1/3] big key: get rid of stack array allocation
In-Reply-To: <20180424202639.19830-1-tycho@tycho.ws>
Message-ID: <alpine.LRH.2.21.1805120609250.6601@namei.org>
References: <20180424202639.19830-1-tycho@tycho.ws>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Tycho Andersen wrote:

> We're interested in getting rid of all of the stack allocated arrays in the
> kernel [1]. This patch simply hardcodes the iv length to match that of the
> hardcoded cipher.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
>     sanity check in init(), Eric Biggers
> v3: * remember to free big_key_aead when sanity check fails
>     * define a constant for big key IV size so it can be changed along side
>       the algorithm in the code

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


Thanks!


-- 
James Morris
<jmorris@namei.org>
