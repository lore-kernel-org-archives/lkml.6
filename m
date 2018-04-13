Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeDMFii (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:38:38 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:14251 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752996AbeDMFig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:38:36 -0400
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq7U2oCocl772u2XiabRKKbHM1HYja5N/pDsB6V17g==
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        stable@kernel.org
Subject: Re: [PATCH 1/5] random: fix crng_ready() test
Date: Fri, 13 Apr 2018 07:38:30 +0200
Message-ID: <1699469.KmO53oa8XU@tauon.chronox.de>
In-Reply-To: <20180413013046.404-1-tytso@mit.edu>
References: <20180413013046.404-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. April 2018, 03:30:42 CEST schrieb Theodore Ts'o:

Hi Theodore,

> The crng_init variable has three states:
> 
> 0: The CRNG is not initialized at all
> 1: The CRNG has a small amount of entropy, hopefully good enough for
>    early-boot, non-cryptographical use cases
> 2: The CRNG is fully initialized and we are sure it is safe for
>    cryptographic use cases.
> 
> The crng_ready() function should only return true once we are in the
> last state.
> 
Do I see that correctly that getrandom(2) will now unblock after the 
input_pool has obtained 128 bits of entropy? Similarly for 
get_random_bytes_wait.

As this seems to be the only real use case for crng_ready (apart from 
logging), what is the purpose of crng_init == 1?

Ciao
Stephan
