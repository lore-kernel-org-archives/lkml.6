Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A5FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314620854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws6fbGVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3314620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeIKUxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:53:30 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34890 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:53:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so48160669oic.2;
        Tue, 11 Sep 2018 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SUJwUdB718TUwbffEbG0O28sgGrTIZx3GCmKlXl98NA=;
        b=Ws6fbGVhbSGDnCzmEk0nxci0IOp42tLi2r/TUupprZEO65HdHvGqKBTxSzG00QU6o+
         7utiuwxI2TN+s1PYzTVsGopZ0bWTWAJJe0Y5RT3hC5+1vxg1/WNO1m7YQZkG3QreK+ra
         SUhIRfprEeTC39MEEzNM/vddTUDXZYuFEF1Jt8wW3kNbpp1LjItkjB/eSCk3tuCjTRrG
         +0w9/Ak7zwY4lInNwiiH6C09d86sa/6BxcGZ/TFdPVhIgW0Q0HAbiWpAAsI+nXS1R9XG
         ni4+WIivVzifiUhlNG8Qt6rUI1r/uf2Iq1f/mxifZQ4G16hSlqSqDg3jd5YoJgx7frEU
         7hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SUJwUdB718TUwbffEbG0O28sgGrTIZx3GCmKlXl98NA=;
        b=BhUWEGR+b1im8EYDe21pP+4DmFfO7ULg9MTAK3NqU0hsV0KkV4CHrU/Mv7OEZ7dRHB
         oi10F86VIWUnSjwe/VUhNwmLnR9JLu5Gir47af+8Pm1u4Bq7G0RoLRwCHF+sxoLJfB4W
         C9TepxmQ/EtH4puAkSyebnJ9IR+Hegvk908g48VqLvBQKUaNZ29XLks+TccJO83G/sxJ
         uIm1mIU0ce6cJr76hrqmMSkmqMIfgg68IhHR7jPw2GxDa9yk7oYt+rS+OV2S7FJrkbf1
         2JA8gzQ7DnKNVgnT31pYrr/gbvOE4rtHCJQH+RrW4HA+TcqdN/V1LaC+KFdL02qBfphJ
         5CeA==
X-Gm-Message-State: APzg51BRrKVD7lsv2aquMG95RdgbcVrHtrMGvPMvOk2J17GXZd0Bunzx
        VEQt3CtCAt5ZuqlmhN8ixD+qJbsj
X-Google-Smtp-Source: ANB0VdYod27ios6GD+aYeRvH47ZRfqkKTSiFc5c3ftevMKQQudbjQFIfy6lYrALNyYyXetqocTc8Dw==
X-Received: by 2002:aca:438b:: with SMTP id q133-v6mr26759637oia.234.1536681214245;
        Tue, 11 Sep 2018 08:53:34 -0700 (PDT)
Received: from [192.168.0.113] (47-208-214-43.trckcmtc01.res.dyn.suddenlink.net. [47.208.214.43])
        by smtp.gmail.com with ESMTPSA id 207-v6sm28672869oie.14.2018.09.11.08.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:53:33 -0700 (PDT)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To:     Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
 <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
 <20180910125320.GA17028@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5af64ee6-c7c4-29db-9aa4-c40e35e241fc@gmail.com>
Date:   Tue, 11 Sep 2018 08:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910125320.GA17028@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 05:53, Rob Herring wrote:
> On Sun, Sep 09, 2018 at 07:04:25PM +0200, Benjamin Herrenschmidt wrote:
>> On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
>>>
>>>> A long shot, but something to consider, is that I failed to cover the
>>>> cases of dynamic devicetree updates (removing nodes that contain a
>>>> phandle) in ways other than overlays.  Michael Ellerman has reported
>>>> such a problem for powerpc/mobility with of_detach_node().  A patch to
>>>> fix that is one of the tasks I need to complete.
>>>
>>> The only thing I can think of is booting via the BootX bootloader on
>>> those ancient macs results in a DT with no phandles. I didn't see an
>>> obvious reason why that would cause that patch to break though.
>>
>> Guys, we still don't have a fix for this one on its way upstream...
>>
>> My test patch just creates phandle properties for all nodes, that was
>> not intended as a fix, more a way to check if the problem was related
>> to the lack of phandles.
>>
>> I don't actually know why the new code causes things to fail when
>> phandles are absent. This needs to be looked at.
>>
>> I'm travelling at the moment and generally caught up with other things,
>> I haven't had a chance to dig, so just a heads up. I don't intend to
>> submit my patch since it's just a band aid. We need to figure out what
>> the actual problem is.
> 
> Can you try this patch (w/o Ben's patch). I think the problem is if 
> there are no phandles, then roundup_pow_of_two is passed 0 which is 
> documented as undefined result.
> 
> Though, if a DT has no properties with phandles, then why are we doing a 
> lookup in the first place?
> 
> 
> 8<----------------------------------------------------------------------
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9095b8290150..74eaedd5b860 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
>  		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
>  			phandles++;
>  
> +	if (!phandles)
> +		goto out;
> +
>  	cache_entries = roundup_pow_of_two(phandles);
>  	phandle_cache_mask = cache_entries - 1;
>  
> 

Thanks Rob!  That fix makes sense, and the test results look
promising.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
