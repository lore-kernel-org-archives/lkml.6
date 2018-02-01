Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeBAKR6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:17:58 -0500
Received: from mout.web.de ([212.227.15.3]:60275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeBAKRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:17:54 -0500
Subject: Re: Coccinelle: zalloc-simple: Delete function "kmem_cache_alloc"
 from SmPL rules
To: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc: Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net>
 <alpine.DEB.2.20.1802011040110.3135@hadrien>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <22276745-4723-4391-4460-07f0820ae85b@users.sourceforge.net>
Date: Thu, 1 Feb 2018 11:17:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802011040110.3135@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JMY73i9cy9wvSo9CMl7iFVfPbXsLGepszHHd5l1z0fi+QtmUHPi
 dnHyRC8AvQO1p4bRMWr5KeV+vupLpNYb7hOW0eUG6PjQsSIomPghnAhU1zXmP3xcyNLrcAb
 BzUZjgqO4ChocITJozSGxm7FKY+n19mDrYhMquKeJEIpEtNl9wEr2z9hv9EPTYNQQsRPFMq
 ZZgCL/z9qqkAYRs2K1CbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VbtONembgbo=:FMm0GlS/gcmR/K+pb8tamp
 yIbu1SD65NI2hDDRsiOa2xjO3+39gR836BIS+XCEcO7UZLC3vc6f4XXfHxmX/3kPJ+IUoVh9X
 JWQEr5PVTasbIgM3sIjkPuxAU/5jLsX1tmbpF1IF72FRZAU5iXtCMXtcdSJNwCfBWl/ZxzteA
 VRWpSZSxL5zKwBboGdpaPI62JotTA5REFRvMTH33UOAcSM/4Z47BxGQmfMkvhAMP8WbSbbTSA
 8TVgEducbAzb3TH13WHoPwYLlPu91DTvvOuyCy5wPjXz9ArLys0OXow1F61MrthxoWpiyDq1Q
 nVIXgAUr+ja0LaLTpeZv8D1tp35vleMabvTs4h3eLmnukpi69sb6VsKRFxgbgw12urX/z5qka
 TSjwIzUkrMyb1/jdcYnyc1VA+OnlTuV84X0+Z8RIHCFkiRxoszc/+PfHBaYF3QjdWGteYNr8/
 GIV35sga9kWJYnZBuHH9msjsmCG8fepSxKDnvCdVf8PdHvGWxOxPlwt1fTyiWYLYv4X2hEOHZ
 xmmG7wdyie8sTcm5L5luRRw/bN5HrV0Ycyj5WSB6YU4hUHqN1qsm/0cRuxkRf5xsO9JhnK7kc
 gfyMty5LZo5R1I2We0gWM0Olf9IkbNoQGc71H586i4r4ezWdTTzFTUcsOhHkIwvVyFIGpafms
 WGvY1GqPH6Q6bZobijDMKgd+V7u8Y+U5kkT71eFPFg1PxsKl/CxinR665waugVE9lOGfqWVQM
 VLPT/8GdsLPKb80WfojKn0eW73ApNFl+8QgA64q4HelDr9iCucrqCsVTi+EluiyMMDT5XGLQR
 F6xbfdmGOInnYjGXReVSCbp4GgHVnHZI6qQoHMkfUK7NUF2KJU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The function "kmem_cache_alloc" was specified despite of the technical
>> detail that this function does not get a parameter passed which would
>> correspond to such a size information.
>>
>> Thus remove it from the first two SmPL rules and omit the rule "r4".
> 
> Nack.

I find such a rejection surprising once more.


> It should be supported by the size determined in another way.

I am curious on how our different views could be clarified further
for this special software situation.

* Do we agree that a proper size determination is essential for every
  condition in the discussed SmPL rules together with forwarding
  this information?

* How can a name be ever relevant (within the published SmPL approach)
  for a function when it was designed in the way that it should generally
  work without a size parameter?

Regards,
Markus
