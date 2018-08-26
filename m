Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A0C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23140208D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="ZRNz8kAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23140208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeHZVOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:14:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45590 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:14:12 -0400
Received: by mail-io0-f195.google.com with SMTP id e12-v6so10976758iok.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p35wbnf0hub1pz1s3tWmbzvPN9oPVtbqV0rGTXBjSHc=;
        b=ZRNz8kAHOi0zwQgE49h167niBj09UhhuVeQi9KaL15VX79/rtb9BZvBgvL3soih1JR
         AAnx/UX5L9sOf6NMIiRDyQ+7LdZ5HY6vEBaPL1i56bGgpiGk3kBKHE2qb+2gWPZhAvkm
         Rq6ybTCgtzCSj5DPeN9NcmoMbiVXREjd3aNamwug1l15IW1wPafkpMwwF6ubHOPspdmW
         UonyUm8IS9cWAR3ux9Y+31OfUPeSGQEK59Qofi2CA1E5Fheq2VSBefb1N0meHHrAPXct
         Wv/zIclWKqPbX7YfpH3scqkuPvU/Pr6BH2FOoG3j+IHtKsZyafkvylTK3PKurtlW5D00
         ZGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p35wbnf0hub1pz1s3tWmbzvPN9oPVtbqV0rGTXBjSHc=;
        b=NICVnQMyieGH12jFIWuZXNVsBQBMHl8YburGM+V6C4LUxdntSA0Tl+Xfv1BeZR6wvQ
         iXewn7SzG9wQ/eq5UXa9EvB4ICJhbDtliq73WGN36slVo+I0PDxKR/0nZhtuhYpyiCzj
         v4QIVEdzZ7Y27AoUowt2NMVtp5yxbj+vPI3wvPhGL5KCYHKEUKdY46B0pFfBhcCrIy9a
         tVZ5ovnoROMsi6GuXLFgYIvUBSZhewCyD7BxJsX7Wo9haD0O0eTf397lI77ofRqnDvIQ
         CauxljD6kj8T/d3XYUg6k+vidWf0Q4lhGjaPJQAwYgAd5GtpvFt50hDCNYUtgpQa72dX
         Uqgg==
X-Gm-Message-State: APzg51CyNiseUscHNt/vBHCFa36fz57ct0MdWvkyIMgjZZY5mu6vgCGM
        U2AG/2uyIlFMM2SO874tsNvDGw==
X-Google-Smtp-Source: ANB0Vdb5cfRZpHLSxk68tJQ2uPGbKD0KtRqqbuRO4MpCbND30epCL4rWtUnDVXoRke+v9SF78t01Aw==
X-Received: by 2002:a6b:928b:: with SMTP id u133-v6mr7713478iod.296.1535304661888;
        Sun, 26 Aug 2018 10:31:01 -0700 (PDT)
Received: from [10.0.0.129] (198-84-205-232.cpe.teksavvy.com. [198.84.205.232])
        by smtp.googlemail.com with ESMTPSA id f24-v6sm4239875ioc.52.2018.08.26.10.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 10:31:00 -0700 (PDT)
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <5c88b08d-b9ca-f3df-ae78-cf685ee6723a@mojatatu.com>
Date:   Sun, 26 Aug 2018 13:30:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-26 2:19 a.m., Kees Cook wrote:
> On Sat, Aug 25, 2018 at 11:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Sat, Aug 25, 2018 at 10:58:01PM -0700, Kees Cook wrote:
>> Saner approach would be sel_size = offsetof(struct tc_u32_sel, keys[s->nkeys])...
> 
> Either is fine by me.
> 
>>> +     sel_size = struct_size(s, keys, s->nkeys);
>>> +     if (nla_len(tb[TCA_U32_SEL]) < sel_size) {
>>> +             err = -EINVAL;
>>> +             goto erridr;
>>> +     }
>>>
>>> -     n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
>>> +     n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
>>
>> ITYM
>>          n = kzalloc(offsetof(struct tc_u_common, sel.keys[s->nkeys]), GFP_KERNEL);
> 
> I prefer to reuse sel_size and keep typeof() to keep things tied to
> "n" more directly. *shrug*

Looks good to me.
We should add an nla_policy later.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
