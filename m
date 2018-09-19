Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0005BECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958462150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958462150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbeISU3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:29:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:46821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbeISU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:29:53 -0400
Received: from [172.36.0.37] ([217.86.137.241]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lrek1-1ffrm13ssP-013PZK; Wed, 19
 Sep 2018 16:51:32 +0200
Subject: Re: [PATCH 01/20] Input: iforce - remove "being used" silliness
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <0541f46d-1f4f-05f4-8e93-6663f6c13bd9@gmx.de>
Date:   Wed, 19 Sep 2018 16:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BCPEi9yIFpM70bbWgZfyzMvbSUjYoN2mIl+EafneAYL2TY7Ivyf
 RTsqAIXQgERc69CI6OU9JF/V2UQmnxwkhvl+pvCZ18mw6dDoPYkQ29C8mFKyEbYrX401eBd
 BbkCh138x4p3/i7fywBNvnFqafWb+0no2DDycwzN/M30bZeyHeIn/AO4609T+lYi0Ge+PFs
 3ybYjerEgfE+Te/95qL7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PDt8b8OUw70=:ipEIB4iEwepz4/pqg7/Elk
 fGuRbNT8Yfxe1Nfak1cab3wGVqvpQ4SFzlmsCZaE/mJdidLlGkhXyaMjpbnf4mjyW+wlTQocP
 7gkVQbouEFPJITp1dRP/nVM2KtXQtJQ/QyzYE+sLpuAjzek9ROqNeGddIcCkefAM+Je8/itCS
 Y+agw8mY3SRKtSskQquCtD2qXOFX0/26hlb00YN22ws0Co2NVKQ7iYe87WuqIz4r31cg1RyvR
 kSYqGuN3wzEhKJGAWeCptCuj9ril4lrXJAyPPcTg5PbsUsY3Pc6fnrL2eX8v3pkqMOlvelQIb
 W7ATSqOjB5M5JgcQw6ggpOdHQcAZzuBPxipGsKDiCnK5IdA+OnauHTfScJ57S76U5+rhQEtKf
 2TRgXZCJZnfQJ1rqVHzlQHlr5gVJlkysg1rTCDeh0+rrcSkIL/EwQnTe7gN7wT6es10EZfVtY
 pN76r7xoisRK9XR4Q6u0b6qzGgN5TggnmSRD6SjH2jSG7hcq66ZKmC3NyBlLDvzsTLXNYMVS0
 MFCQ8KGQ/38uWz7JZoTH3NSdqs0SGeegfavoY618NHAvOcf9bH4CDGv0Wjv5o2+AvvQlNKBpR
 8TfqAxIQZwupVxq8BpQF1187SmiwJbhE/t0IPcZICZRaSFXLn31pRfUgRPt09YGNjjS9DOH8/
 9kHK63jA7wT9n2G33KW4P3+Umv+Ru1Abqg9zQTxjBCiTCaXO12em2nX67bxDqAVzMglVg3CHg
 Uy902CYiKfdUwLrr18qys+hTjBC6NT23x8SOvIEepT63SXlXUHbt8uODkAhOQA9r/MNs06wWs
 0964jooaIsP9MeVsgF9k7BxC3lQf8wvurEmeEqUQgh1PinTLSY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.18 02:47, Dmitry Torokhov wrote:
> The kernel is supposed to handle multiple devices, static flags
> in packet handling code will never work.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> This is a random assortment of iforce patches that I made a few weeks back.
> 
> Tim, I do not have hardware, so I was bound to screw it up, but if you
> have some time I'd appreciate if you try them out (and if I indeed broke
> things if you could identify issues that would be even more awesome).
> 
> Thanks!
> 
Hello Dmitry,

I tested those patches and I didn't find any obvious issues. The basic functions
do work (i.e. buttons and axes, don't have a HAT so I can't test that), force
feedback seems to work to the extent it was before (I only have fftest though,
no games that support force feedback). I'll go through a few more applications
and see if anything not obvious is broken.

Unfortunately, I only have that one wheel and I can only test USB connections
at the moment (unless I find a proper serial adaptor, but I'm not sure if that
would even work).

Are those patches planned to go into 4.19 or are they intended to be merged in
the next development cycle?
