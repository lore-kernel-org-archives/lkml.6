Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2509C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0C92075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="Digm0WkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0C92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeFUNfs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:35:48 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:40398 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeFUNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:35:46 -0400
Received: by mail-vk0-f66.google.com with SMTP id o71-v6so1878562vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xG4f3kdk0noKTA7CTBf5sDL9WPvkJ9zCMXAK4/4POtg=;
        b=Digm0WkF8nMSqy065IGl/j5N+0ghotrDCizd4pL5NU54RlyjFTYTOSL3kmWw2rRAmZ
         a9aYXYpuIkE5E+fRHNi0H/eGb6XycibgWqeKWX6BBs/LmWmSkWdzcCPgkuGVgx2b2ZGK
         LXM/5a/njOAanxyoEnqSaaWXuycmaJnIzDCHsMaPHdFKjbhu+Q8YaNW0RH3+l+UXYwfp
         WQT/sJBB+sc94wIx47oihmv5Ucw1nPNYnAe8uazjmnQyvx68+YkMx6ji3bws0gVuy9jf
         NtqPskq/d+OhK04hOR3oIZQzwDWjuYEPbAMGMsTXp6wBxIlkZeJ5bQYk0tOoy4RwfK8H
         DVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xG4f3kdk0noKTA7CTBf5sDL9WPvkJ9zCMXAK4/4POtg=;
        b=bkRBWEJzOiOC9m/cnnzlk6Za0Q0Fk9yIKcvPykXncV4XSF7gNMkd6FgqVn0hghZndl
         WDeD0iL/hOQhwwCUKj78rxvzAjDjUTPomA9KRg9kOFOFxSBlW0k+JFbeJuH6+VjtB2Po
         COGcewCPzOSHG/dZTOMVFSuMWa+CPCyHoa5MXzxWoH1R/lBiOX+2JkW7p5RTsM7auxTs
         1Id/d7otLFsiLiXf56u4+FSGDaW7oM0OYxsTjyC+Rwu7j8EK9aZp/ej2jNpXfHwoCiQ7
         AhqjRLCX7Yve023mnLpTzUpJtv7wW6V2NfSJPLIl3swUii3nXcArnKJtvutVcg5A/2Xx
         piyg==
X-Gm-Message-State: APt69E1M9oFdWCtM70s089rsXHuFN/uAG3eBASrSVLWMxAJiN1H1x6QL
        2IflyCbeNS9iAFLHuuQNDPwUXbd1IeDdnwQb2Kdiiw==
X-Google-Smtp-Source: ADUXVKKt7pNlBiaCza8o/5GAkeQsyYVBgSYI7XhKEroahmtH98cEEdEoq9FPuhQxJHQbEytIPrxlWu4jt3Wz1oX+qc4=
X-Received: by 2002:a1f:b393:: with SMTP id c141-v6mr15289381vkf.37.1529588145388;
 Thu, 21 Jun 2018 06:35:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3c4:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 06:35:44 -0700 (PDT)
X-Originating-IP: [217.140.96.140]
In-Reply-To: <20180619142713.dzipyarpb23a7qne@gondor.apana.org.au>
References: <1528361927-4172-1-git-send-email-gilad@benyossef.com>
 <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
 <20180613063030.bsrq3xmufcw4zi52@gondor.apana.org.au> <CAOtvUMdtafGwXJFD0Tm1tx1q+TxRsB4nwEKxumE7=--_PMCZrQ@mail.gmail.com>
 <20180619142713.dzipyarpb23a7qne@gondor.apana.org.au>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 21 Jun 2018 16:35:44 +0300
Message-ID: <CAOtvUMcChKswKBCOkN7DGvK3DcotJBh0y=-Xi8232uYK26-xQA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix iv copying for small buffers
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hadar Gat <hadar.gat@arm.com>, Ofir Drang <ofir.drang@arm.com>,
        stable@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:27 PM, Herbert Xu <herbert@gondor.apana.org.au> w=
rote:
> On Sun, Jun 17, 2018 at 01:06:42PM +0300, Gilad Ben-Yossef wrote:
>>
>> It was ctr(aes). I wrongly assumed that we are supposed to unconditional=
ly
>> copy
>> the cipher-text block post operation and let the caller do with it what =
it
>> wants and so the
>> code now does that for all cipher operations unconditionally.
>
> For CTR it doesn't matter whether the last block is less than a
> block, you should still increment the counter.

OK. got it. Although I am not sure how does one use this to continue
encryption if the plaintext was not block aligned.
>

>> So what is a good description of what we are supposed to provide in that
>> field post operation?
>> The next IV? but as you stated, that is not necessarily useful for all
>> ciphers.
>
> When in doubt, please refer to the generic implementation.  If
> that is still unclear or if it seems wrong, please post to the
> list.


Got it.

So as a sanity check  if I understood correctly I need to:
- Increment counter in IV for CTS
- Copy last ciphertext block for CFB and CBC to output IV (partial
blocks not allowed)

What about OFB? unless I've missed something there is no generic
implementation... ?


Thanks again,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
