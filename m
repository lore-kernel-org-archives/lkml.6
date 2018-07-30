Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C32FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BEF20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyZEwNJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BEF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeG3LBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:01:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51854 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeG3LBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:01:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so12351028wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMojuwbFXVdeYJZGWbrGgipfOMNfMh3sAY5iuH+04cw=;
        b=uyZEwNJvRqY9Q/qh7wkaW3i4TE7vqpg8pI4PP71ZzWk/sme6+kBFoPB7W+gxbO/jGz
         4yi+jyGpZBXMIwFNiTKsjNsIneKLekO+tAzRUGv6+wvgxiCwtELz801TVlNzHFlBK80D
         A5hY/MCHFWR0vHu43BzkMxi5hsY6zsKS3BTxee8qZDmKWNUnBQlM0Hx4FFRDsxwEuupy
         sXsPYRvGB4x2cn3hRVtgYbeg7iG/K5qpsJ60JWsGGgR5BOt68rsE30IcN1vLkglD3zTb
         cbbbwn8BRl27tJ+AnsAm+EXrnckSUq+Wlu04Tv6iRPLnHmrAqcY0UH6TVGafd2Ugp2QV
         zadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMojuwbFXVdeYJZGWbrGgipfOMNfMh3sAY5iuH+04cw=;
        b=gFhhnUoVIN/7/x/rQLoO9M3VhWPkYojOuu9mH9oGfzcqDoND8l5QOnLQWwA81CpLMC
         T7ipUDhkGFwI+kyQiQSLsvwY+bZnb/iSwkGgw9jy3bMnFcxWcfum2agngL+oz2VAVle4
         T4qnPLDc8vUAFeV7mGcbsH9KG60782DiirJmct7Hou+nVbN+FMyD956tbeVW2aeouOJ+
         s502dGqhuvPF3cwvCnoB61Kqmzt3QF0i719K6k01vy24rbFE1NNoOC0yFsN12CeJmsTT
         cl+/Gu4RaSgu5+PVksMkYJ3wKho3drS5grQ5o++VKgCDHsOdaeCGM3HyfYFZ3QvAcScM
         PwLQ==
X-Gm-Message-State: AOUpUlFzzRA7Q43BEixX/S89Gy8SyoM6XX7qu8xsLo5TGPMGE3eFbtCu
        ObkuVHWU5PjgkNTH2k/LBWySMUXV
X-Google-Smtp-Source: AAOMgpeWMDdB2r0BlIQmTGt2KvT6srUnTtbqE/+Il5myeOKD0jlsh0wXPUv6fZEbpoVp6oumQ3LNyw==
X-Received: by 2002:a1c:e708:: with SMTP id e8-v6mr14824357wmh.134.1532942864786;
        Mon, 30 Jul 2018 02:27:44 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z3-v6sm15035463wru.27.2018.07.30.02.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:27:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] staging: rtl8188eu: remove unused
 rtw_handle_tkip_mic_err()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180729185447.19903-1-straube.linux@gmail.com>
 <20180729185447.19903-3-straube.linux@gmail.com>
 <20180730090216.GA19163@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <9ab9ce0f-4b2b-912b-04af-736ee9f23d4e@gmail.com>
Date:   Mon, 30 Jul 2018 11:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730090216.GA19163@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/18 11:02, Greg KH wrote:
> On Sun, Jul 29, 2018 at 08:54:43PM +0200, Michael Straube wrote:
>> The function rtw_handle_tkip_mic_err() is never used, so remove it.
>> Discovered by cppcheck.
> 
> That's a bad tool then, as this is used, and the build breaks when this
> patch is applied :(
> 
> I've dropped it now.
> 
> thanks,
> 
> greg k-h
> 

Hm, that's weired, I also checked with:

git grep -n rtw_handle_tkip_mic_err drivers/staging/rtl8188eu/

There were/are no uses and the driver builds and works fine here.
I don't see what I may have missed here. :(

Regards,
Michael
