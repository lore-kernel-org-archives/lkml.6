Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB4D26480
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/kQQ4Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB4D26480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeF0JOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:14:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36925 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeF0JOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:14:17 -0400
Received: by mail-io0-f195.google.com with SMTP id s26-v6so1217100ioj.4;
        Wed, 27 Jun 2018 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XgV8XOc4ppYyI2b4wsHJAWDkSeIn1S7mJHYIJWGjJP0=;
        b=e/kQQ4Js4DhtzKw+8mKqRKLZNfMFZ8f53q4Zi/uHqx0kiCcq2YJnEro5/uGRhTnyeN
         bBP5LVizBacW9ax7X4/4gtod9PRkKEdDT7ZJsMf2wLAsrLPM2L7/nNbSIvkHn49Vh2ko
         sCOVWvYz1Nlo1XYU0r7dwxrmxeb4rNhMGjnAHEmiAmCK7yUJz21mWhZXOmcQw0a9Tvqe
         2c5uKcROZhOviMkiFFngMFr2Xh+05B5zn6c6uAdKLZa0xg2jUjh0PAVueA/wB2PU8lzV
         tq0QRhZjpMVeeEvXdeB3WNsSe0IRgSxd8IJ3n+2i3EzWyhYfuipCOIw0y8N3B+uqzedf
         Jc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XgV8XOc4ppYyI2b4wsHJAWDkSeIn1S7mJHYIJWGjJP0=;
        b=UKRUu8NaL9Qw64BvkI+47b0r8jG6zz5yVZm9/v/Y/jP/lgFLdmBYmFtLmAyc/cqvZh
         8zfpJSstWJ7bkGpq8e8LqjmaErJJTH2/L+J3nmoTOZWlbzrl0yyb5gHLU0cGC5A69V9S
         90vMrwEWE/I0ifXHVrF3JN6fvmbHKkSqN19ftQokCNuw0iyfFSVoIdyYxxQN59S0z+PV
         DAgCXivyhfpnqaBPArLl94G0B5tLuHdlnnspoHkgb3alS40EoV5P0BNHGRCF20BuloJu
         eSLPVrew7vQ3DbOV1i70zN1gO38dLOj5qnYxCVeqJdDJyPzMwVZkqV04eTrxjBExsRu6
         0fxw==
X-Gm-Message-State: APt69E2V1XuLgFcV6zOYlWx+vBQKLfsHNtPQ22tNB7cpUHy1IlIEj1XH
        y8x24xO25AFWhffeaax9qpGA5Zlg
X-Google-Smtp-Source: AAOMgpczR8iglxufuslPN6rF2B24dxeBgAvXR0uTWXzRAfL5tkV8MlqfJxA48rMWtpqNBBFmITUnoA==
X-Received: by 2002:a6b:c501:: with SMTP id v1-v6mr4033298iof.172.1530090857080;
        Wed, 27 Jun 2018 02:14:17 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id w139-v6sm2920107iow.61.2018.06.27.02.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:14:16 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
To:     Gabriel Paubert <paubert@iram.es>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
 <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
 <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
 <20180627090022.rij2owx5durbc4e6@lt-gp.iram.es>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b699a590-2fad-2dd4-f85b-75c771af25f2@gmail.com>
Date:   Wed, 27 Jun 2018 21:14:08 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180627090022.rij2owx5durbc4e6@lt-gp.iram.es>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel,

Am 27.06.2018 um 21:00 schrieb Gabriel Paubert:
> On Wed, Jun 27, 2018 at 05:39:15PM +1200, Michael Schmitz wrote:
>> Ben,
>>
>> Am 27.06.2018 um 15:27 schrieb Benjamin Herrenschmidt:
>>> On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
>>>>> I will rewrite patch 10/12 after Arnd's fixes and this series have all
>>>>> made their way through both powerpc and m68k trees, and submit it
>>>>> separately.
>>>>
>>>> drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
>>>> series is high on his todo list.
>>>
>>> We need at least to pull out a couple of powerbooks we have sitting in
>>> drawers and try it out.
>>
>> No need to root around in drawers - I'm sitting in front of one (G3
>> Titanium) writing this. Let me know if that would help (I've forgotten most
>> of what I knew about powerpc kernels).
>
> A very rare model, all G3 I've seen were plastic, all Titanium were G4 :-)

Right you are - the G3 was the earlier one I used (which was stolen from 
my office). G4 it is, then.

Cheers,

	Michael


>
> 	Cheers,
> 	Gabriel
> 	(still using my Pismo from time to time, but much less since
> 	sleep was broken)
>
