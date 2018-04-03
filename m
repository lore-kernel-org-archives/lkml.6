Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbeDCMWr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:22:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42701 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:22:45 -0400
X-Google-Smtp-Source: AIpwx4+5bwDV6t8qnk7TjyaB0WYGipxVEpXMWpGbuREXLmHrxkpAB5UR+6b8VOw0Dcdee42X5D/6+A==
Subject: Re: [PATCH 2/2] crypto: ccree: enable support for hardware keys
To: Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1522049540-10042-1-git-send-email-gilad@benyossef.com>
 <1522049540-10042-3-git-send-email-gilad@benyossef.com>
 <20180330172616.GB28120@gondor.apana.org.au>
 <CAOtvUMd6MMyQBHU4E=5DKXndhZw90=K1V1apD0uRRaMLyp-0Ag@mail.gmail.com>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <13b816b2-cae1-a926-d60b-734c77a6361c@gmail.com>
Date: Tue, 3 Apr 2018 14:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <CAOtvUMd6MMyQBHU4E=5DKXndhZw90=K1V1apD0uRRaMLyp-0Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/2018 07:30 PM, Gilad Ben-Yossef wrote:
...
>> Are there other crypto drivers doing this?
> 
> I thought the exact same thing until I ran into a presentation about the s390
> secure keys implementation. I basically imitated their use (or abuse?)
> of the Crypto API
> assuming it is the way to go.
> 
> Take a look at arch/s390/crypto/paes_s390.c
> 
> The slide for the presentation describing this is here:
> http://schd.ws/hosted_files/ossna2017/89/LC2017SecKeyDmCryptV5.pdf
> 
> And they seem to even have support for it in the DM-Crypt tools, which at
> the time they claimed to be in the process of getting it up-streamed.

It is "in the process", but definitely not accepted.

We are just discussing how to integrate paes wrapped keys in cryptsetup and
it will definitely not be the way presented in the slides above.

If you plan more such ciphers, I would welcome some unified way in crypto API
how to handle these HSM keys flavors.

For kernel dm-crypt, there is no change needed (dmcrypt just treats it as a normal cipher key).
(I would say that it is not the best idea either, IMHO it would be better to use
kernel keyring reference instead and somehow handle hw keys through keyring.)

Milan
