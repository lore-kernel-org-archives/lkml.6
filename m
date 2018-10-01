Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D89C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C4D21470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C4D21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJBCcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:32:06 -0400
Received: from mail1.windriver.com ([147.11.146.13]:45531 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBCcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:32:06 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w91JqDP1001179
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 1 Oct 2018 12:52:13 -0700 (PDT)
Received: from [172.25.59.211] (172.25.59.211) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Oct 2018
 12:52:12 -0700
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kgdb-bugreport@lists.sourceforge.net>, <stable@vger.kernel.org>,
        <me@tobin.cc>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
 <877ej7urh3.fsf@concordia.ellerman.id.au>
 <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr>
 <87zhw1srt4.fsf@concordia.ellerman.id.au>
From:   Jason Wessel <jason.wessel@windriver.com>
Message-ID: <ca845d92-674b-4ca2-3535-2621972bd13b@windriver.com>
Date:   Mon, 1 Oct 2018 14:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhw1srt4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 07:57 AM, Michael Ellerman wrote:
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 27/09/2018 à 13:09, Michael Ellerman a écrit :
>>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>>> Le 26/09/2018 à 13:11, Daniel Thompson a écrit :
>>>>
>>>> The Fixes: and now your Reviewed-by: appear automatically in patchwork
>>>> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65715),
>>>> so I believe they'll be automatically included when Jason or someone
>>>> else takes the patch, no ?
>>>
>>> patchwork won't add the Fixes tag from the reply, it needs to be in the
>>> original mail.
>>>
>>> See:
>>>     https://github.com/getpatchwork/patchwork/issues/151
>>>
>>
>> Ok, so it accounts it and adds a '1' in the F column in the patches
>> list, but won't take it into account.
> 
> Yes. The logic that populates the columns is separate from the logic
> that scrapes the tags, which is a bug :)
> 
>> Then I'll send a v2 with revised commit text.
> 


No need.  https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git/commit/?h=kgdb-next

Since it is a regression fix, we'll try and get it merged as soon as we can.

Cheers,
Jason.
