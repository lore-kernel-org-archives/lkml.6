Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488A5215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488A5215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeI0R1S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:27:18 -0400
Received: from ozlabs.org ([203.11.71.1]:56503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbeI0R1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:27:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42LXBd23LFz9s55;
        Thu, 27 Sep 2018 21:09:29 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org,
        me@tobin.cc
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
In-Reply-To: <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr> <20180916190610.vzqxwps7zqy2zc6o@holly.lan> <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org> <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
Date:   Thu, 27 Sep 2018 21:09:28 +1000
Message-ID: <877ej7urh3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 26/09/2018 à 13:11, Daniel Thompson a écrit :
>> On 16/09/2018 20:06, Daniel Thompson wrote:
>>> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>>>> On a powerpc 8xx, 'btc' fails as follows:
>>>> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
...
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> Cc: <stable@vger.kernel.org> # 4.15+
>>>
>>> Would a Fixes: be better here?
>>> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
>> 
>> Christophe, When you add the Fixes: could you also add my
>> 
>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Ok, thanks for the review, but do I have to do anything really ?
>
> The Fixes: and now your Reviewed-by: appear automatically in patchwork 
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65715), 
> so I believe they'll be automatically included when Jason or someone 
> else takes the patch, no ?

patchwork won't add the Fixes tag from the reply, it needs to be in the
original mail.

See:
  https://github.com/getpatchwork/patchwork/issues/151


cheers
