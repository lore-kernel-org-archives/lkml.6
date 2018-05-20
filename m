Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeETUGR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 16:06:17 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:25752 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeETUGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 16:06:14 -0400
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq7U0Y+oJw372u0STleFxYicB5ZQNmFJTQ3JS+3E3w=="
X-RZG-CLASS-ID: mo00
From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cryptomgr_test / drbg_ctr: BUG: sleeping function called from invalid context
Date: Sun, 20 May 2018 21:54:07 +0200
Message-ID: <14009987.cibGRJrWdm@positron.chronox.de>
In-Reply-To: <CAMuHMdW_4gvQYhCxcXR+sa6dhwAshyJnhXhc36=VC=hWKB-7Jw@mail.gmail.com>
References: <CAMuHMdW_4gvQYhCxcXR+sa6dhwAshyJnhXhc36=VC=hWKB-7Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Mai 2018, 10:36:04 CEST schrieb Geert Uytterhoeven:

Hi Geert,
> 
> I tried following the code path, but couldn't find where it went wrong.
> 
> mutex_lock(&drbg->drbg_mutex) is called from drbg_instantiate(), which is
> inlined by the compiler into drbg_kcapi_seed().
> 
> Do you have a clue?

It is the first time I hear from such an issue. Yes, the DRBG should not be 
called in atomic context. But I do not see where we have an atomic context 
(either a spin_lock or in an interrupt handler) when we are executing the test 
manager.

I will keep looking.

Ciao
Stephan
