Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1FBECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F4C214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcIXcsSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F4C214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeIRF3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:29:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34464 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeIRF3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:29:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id j25-v6so5729352wmc.1;
        Mon, 17 Sep 2018 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jnOPP8Eo/r4wUSx5Dlimry4b+97n3yTM8z7s5kKDe3s=;
        b=PcIXcsSfu+cIFkz5s/5RriMPXCKs4eJYLGZyjaFm0se5QhhSoejs9F8Txoeq5Fu4SG
         fcN8hrQAX+T4WWFi0cs3qGSAc6TIOOgrI+PsSGRu1OV5u6E6tjHGfH2cgK6LjTeSsoX2
         52vq0hii4iyqGX9B7c3U/2v6TlVbvfcfzAU1m21+nd6MueWMWYdFBR8Tw36OBU8Fmga/
         SJjxX2N8kc1Bg0vNwC+H/aU+1ZREIbOPtrJhMrfQRAPkRckjROhYO5WqA7jXWEgZD3mJ
         dhhcIAHL5NFjzyRHWxbPGly/TKCvM/9uuKwBF5duQO2SERZY7y0Cyv6ufq1Hqb2km4XL
         yGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnOPP8Eo/r4wUSx5Dlimry4b+97n3yTM8z7s5kKDe3s=;
        b=Br6rZyjRma7P1wF2YXQxi1iaMNF2ds5Xa9vuK+2rpkn36/bL1VXJP7xbkbp9t0G5p4
         vsifjMzLOleUm6u0O9WUDiYeDV/3hE/PwEVLWHF9sQnTWhzwDrD+cyruXKOUKGmzBVCi
         VXvWx/1hBt+SanYgIUy/N1yAZkX3tPRDv2AyVXLrROhGPMnBI+3hFCEjpEatufrF8mKz
         NmdSt3OWuePtLwIGFruG9TnZ2WfmZes+OJYLklGfP8cSVGw31KsSOACJkqAQhywE2YRU
         6v27PCVCnm9NhBNUpkh6c8Tu8v0ArfE6L919IEu1A5QuZUt9G45m0IT61H6jX/W6EvNY
         h8aQ==
X-Gm-Message-State: APzg51AnQeO21LIHO4rshyk0OBv0FvJOPqBABKU/gvd9/6cSq64frmfa
        KJGT68GKHvItaOvwZemT9mY=
X-Google-Smtp-Source: ANB0VdaYDRTmQ/vU0x6GCg0DPvqZJ8+PeSsK/NBntQsb3q4tjxpyUqtxK1G5Z1ealLMkiBnfOsmXAw==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr13419937wmd.72.1537228792273;
        Mon, 17 Sep 2018 16:59:52 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a6-v6sm484058wmf.22.2018.09.17.16.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:59:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:59:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/126] 4.14.71-stable review
Message-ID: <20180917235949.GC5879@flashbox>
References: <20180917211703.481236999@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:40:48AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.71 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:16:12 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.71-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
