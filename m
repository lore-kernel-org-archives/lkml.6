Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0675C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871422087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="am/aK0qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871422087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeLKSq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:46:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40277 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:46:57 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so12654992ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1UuBn7QfyEgJbYlSxhHcHzu7EKmlGeFsx2YSV3KduyU=;
        b=am/aK0qwK9lkkiGz2gZPI/63RPPFjOnbTILx/zcBPnD04kevu5HzAQtZhXR67t/hlL
         fQVo3ino7+V6QfWST5fKV6mAyuN7OtH7+WFpc5RRwz6f4EwX9Zbkp8acR8dH1XJDVeVp
         9byf8Fiba//RB4fJrcdyvAPMbhyUgS5j2rfAy0GtX1zibAqK7GM4zktkSW2jWl2UGXWu
         2gywk/jCzLi3y1/waYjbP8NkyMeE7siEO/MjIYURjFj4s54VIpSNsuI2ac7BOAaLFbty
         GollSctKboxXsbsK7K0Rc65mTaTMOnmScXkovm2woE909ioq8/bFYnwnc6TG2KZTnVvX
         sR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1UuBn7QfyEgJbYlSxhHcHzu7EKmlGeFsx2YSV3KduyU=;
        b=K2fauf5I16lu3iQJ4M5AoVObEsNx8H6fMWnFzuoHloMNPZPMhpIOELS96XpuM1Xbtr
         vLqTG+Wag44pwipyEeJ8Dnoye7R75GqXK7hbs/qkVcvhPr/JSBAkDS8jkLQhCauWl0OH
         wxfSnQw0xnmdsXGX6mnNcsnJqlLkx+/V+7N+Vke327avVufWslAYwiXELPIpA0v0T82N
         qk9HGM0g4lBClq+ber9osehHN9GTIZUuvQOX5/006k5qVNlesAkqEnp5ETB7Ugbknruk
         ZFCjgISedz5zWddQ2CDIFPaCO+MS/x+0rc9B50lvrqwOoRX+TGHYoFCjyynPNjPapv49
         ht+Q==
X-Gm-Message-State: AA+aEWZRBLH2BHuwIeaZsXbghvfj58cz15xsji6Q5vA02B6ZZ1xxniWx
        tqQCFFb3nc89u/HOyLXhj//FdA==
X-Google-Smtp-Source: AFSGD/UYgXFWZLhyD6Ck/WfUsXGKxf/PbYGsZQKvEQDf6ScWH30CNHv9N5txbNyz8ZJNtUdzP7j7lg==
X-Received: by 2002:a5e:8618:: with SMTP id z24mr5593023ioj.35.1544554015966;
        Tue, 11 Dec 2018 10:46:55 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r85sm5943022iod.13.2018.12.11.10.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:46:55 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20181128183531.5139-1-willy@infradead.org>
 <09e3d156-66fc-ca17-efac-63f080a27a1d@kernel.dk>
 <20181211184553.GH6830@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75267003-9407-101f-33ee-685e345a2c8a@kernel.dk>
Date:   Tue, 11 Dec 2018 11:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211184553.GH6830@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:45 AM, Matthew Wilcox wrote:
> On Tue, Dec 11, 2018 at 11:41:55AM -0700, Jens Axboe wrote:
>> On Wed, Nov 28, 2018 at 11:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>>         rcu_read_lock();
>>> -       table = rcu_dereference(mm->ioctx_table);
>>> -
>>> -       if (!table || id >= table->nr)
>>> -               goto out;
>>> -
>>> -       ctx = rcu_dereference(table->table[id]);
>>> +       ctx = xa_load(&mm->ioctx, id);
>>>         if (ctx && ctx->user_id == ctx_id) {
>>>                 if (percpu_ref_tryget_live(&ctx->users))
>>>                         ret = ctx;
>>>         }
>>
>> Question on this part - do we need that RCU read lock around this now? I
>> don't think we do.
> 
> I think we need the rcu read lock here to prevent ctx from being freed
> under us by free_ioctx().

Then that begs the question, how about __xa_load() that is already called
under RCU read lock?

-- 
Jens Axboe

