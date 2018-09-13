Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DBC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE0E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrARDw6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE0E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeIMLsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:48:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39804 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeIMLsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:48:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so4857527wmq.4;
        Wed, 12 Sep 2018 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOwpzXDx+6vLnMI1/h5r9swnGVpnPIU6gUBRO54kikA=;
        b=MrARDw6eKB58FJDp3EXvpI6k+2KD/KTTwvtDetwvltBhHTrtpJpkT797a96RbC6B6/
         U8LMAUc93TQ27pBBJ9kIWafI2OYs0oD72rBl87bBrg1Nksjw3TU5DAkj4y8JmdRAXmXO
         R6GjDFuu21/GFpTc7OjW7qCy9+80lHm1s7YhFBSSPmBWrRBPKsKQo5F654RxIXzI6L77
         Tp/SFI6d2AHu0TNkecqsDaoXwCF4g7l/nwzeuJyWcNCiHmYFcKePVijFjk71bpLG3Tud
         2vrf+a35HTbIyyFvJ0gOkMYrKXR2e7a6UZl5rmJ+Im8RRO6dD5Wg4s6ec3Y52+UuMMqz
         ovlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FOwpzXDx+6vLnMI1/h5r9swnGVpnPIU6gUBRO54kikA=;
        b=HznA50bVCPdXDX20yazugiM3L2xkNb1uI0WB+RwmzshwaW8QAGnybwFd3EXYytoR39
         H2GBVCv4vVXV0LzKvRthSwbbLoA4TSDFd3KfZtwFSoM+UntqpEmjsOUeMi1buLmo7VHV
         7VZY1g0sOSQ9mRr7QAurZKRAANB42EvNtKA6pVU4eoo4G005a71+hJx4n5Tprf6S5RHG
         otBWUn6lFDJpUy4W5g/Gl0fpwR0czakYTGK61PMzlPfMun1TzyBuyYNbyoRFhT68llS3
         k050bCaUnsMOQq9lL+v6yZ0pdGy9znJ77VvXaZorxmtgJKNq0yFScsCvj93jyjLov1wd
         toug==
X-Gm-Message-State: APzg51ADshSSJS/L2H6q5Dnl0o1dJnB1FLI2f10y8V2ri2+Ydyk4dIFI
        VttyOeeiwj838GxZL7wUHIyBjH6662Y=
X-Google-Smtp-Source: ANB0VdbvjWDDvNvGEizpg77welsr1cIm8dM2QAzvXkxD+aaf9r/ytQT69rLiqu3ssoXUS2sHcAkdJw==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr4238256wmb.14.1536820796383;
        Wed, 12 Sep 2018 23:39:56 -0700 (PDT)
Received: from [172.22.36.62] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id 1-v6sm4848751wmf.47.2018.09.12.23.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 23:39:55 -0700 (PDT)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
To:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <c5855aa4-1561-8387-aebb-0a7587ac6d4f@gmail.com>
Date:   Thu, 13 Sep 2018 08:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/18 01:45, Andy Lutomirski wrote:
> On Wed, Sep 12, 2018 at 3:56 PM, Ard Biesheuvel
... 
> b) Crypto that is used dynamically.  This includes dm-crypt
> (aes-xts-plain64, aes-cbc-essiv, etc), all the ALG_IF interfaces, a
> lot of IPSEC stuff, possibly KCM, and probably many more.  These will
> get comparatively little benefit from being converted to a zinc-like
> interface.  For some of these cases, it wouldn't make any sense at all
> to convert them.  Certainly the ones that do async hardware crypto
> using DMA engines will never look at all like zinc, even under the
> hood.

Please note, that dm-crypt now uses not only block ciphers and modes,
but also authenticated encryption and hashes (for ESSIV and HMAC
in authenticated composed modes) and RNG (for random IV).
We use crypto API, including async variants (I hope correctly :)

There is a long time battle to move initialization vectors generators
from dm-crypt to crypto API. If there are any plans to use a new library,
this issue should be discussed as well.
(Some dm-crypt IV generators are disk encryption specific, some do more
that just IV so porting is not straightforward etc).

Related problem here is an optimization of chain of sectors encryption -
if we have new crypto API, it would be nice if can take chain of sectors
so possible implementation can process this chain in one batch
(every sector need to be tweaked by differently generated IV - and we
are back in problem above).
I think filesystem encryption uses the same pattern.

And btw, we use the same algorithms through AF_ALG in userspace (cryptsetup).

So please, if you mention dm-crypt, note that it is very complex
crypto API consumer :) And everything is dynamic, configurable through
dm-crypt options.

That said, I would be more than happy to help in experiments to porting dm-crypt
to any other crypto library, but if it doesn't not help with problems
mentioned above, I do not see any compelling reason for the new library for dm-crypt...

Milan
