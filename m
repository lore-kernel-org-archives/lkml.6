Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DEBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF0820880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wXdc2B4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF0820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLKSxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:53:40 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35344 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeLKSxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:53:39 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so5641278itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wbPAhLt2fDGBmcnE7/YRRo4I9EDR2wBe8YvC0vOSPac=;
        b=wXdc2B4EpN9c+0UAujOUgdRVT6IL8a3fB7/orBqfpIeHVIsPWAANq3hfIA3PBBihqa
         IDh4JyweU1u5ykci1qILXbIOErELix9YNECiL2Aaak5ILCzj79YODWJkd0rUdUIwF+v6
         NmR+EkoNwRijYrvNl4HY7oNFfnRupd/UdYpFZneKz5J+1jShTfE7oxxm2Ogh4CCCB3CB
         WqQY1R846PwtpMZpwlgYD+gKYY0mHqNeRqP5hT1ES8E3v8PbCN781purOWHLxMWv6wb5
         D8Db+X01ylXAe2J/MhLoqMH1wTRqu9ceMrOPyhxhPqqTHja1ZPN24wb0xb8QJe4PbT+s
         GbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbPAhLt2fDGBmcnE7/YRRo4I9EDR2wBe8YvC0vOSPac=;
        b=GxyaTg6zX8x9/W2hK3t3iIpJHK4K0hSMUHZ9K5jWvybmvZJBJlo/Y8Gnk/hKzMAmHo
         Je9ct9T8XBNkQiwBb70K2u3uNedC1RYg35mHpShMoU/0PLCseAd5yrUGTsoZ/Ttq3Qv4
         9qqwZ8SURuwHpo3qa/6h62eOstVy52dCknA4qAUt9vpKaqC/USbEXtMKx/Y6/dJpQkDL
         hQ9baqgaYEo7cHr0kVlWzOSXluaJWpTiaWjY9t9PxKG0TiaUBjdiNJC5mxlje5K8xdxs
         TxrG9OTTWMeVD2kaqt94UQmzk7seOpPrwl7GYwubtIZPMJXVpsaCTA27ipTK0zKVcB2l
         aYmQ==
X-Gm-Message-State: AA+aEWZhSWICnNcMQWHEQ4RN2/b3lF9yNLrGcMOj9ITQW7HNhGHlohD+
        u3wiAVsUFuQlRVpsd9FAJ9wXdg==
X-Google-Smtp-Source: AFSGD/UsU7wH4CShHVRMe8pyIJKZoQE36gZzDDaJ7rja7D/LXN2PEiy+clzFzX1yQCBlLWs0k8Btyg==
X-Received: by 2002:a24:94f:: with SMTP id 76mr3419055itm.169.1544554418807;
        Tue, 11 Dec 2018 10:53:38 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t194sm9183769iof.3.2018.12.11.10.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:53:37 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
From:   Jens Axboe <axboe@kernel.dk>
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
 <75267003-9407-101f-33ee-685e345a2c8a@kernel.dk>
Message-ID: <e4822d16-efec-46f1-8f4c-ed68b8e5f27f@kernel.dk>
Date:   Tue, 11 Dec 2018 11:53:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <75267003-9407-101f-33ee-685e345a2c8a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:46 AM, Jens Axboe wrote:
> On 12/11/18 11:45 AM, Matthew Wilcox wrote:
>> On Tue, Dec 11, 2018 at 11:41:55AM -0700, Jens Axboe wrote:
>>> On Wed, Nov 28, 2018 at 11:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>>         rcu_read_lock();
>>>> -       table = rcu_dereference(mm->ioctx_table);
>>>> -
>>>> -       if (!table || id >= table->nr)
>>>> -               goto out;
>>>> -
>>>> -       ctx = rcu_dereference(table->table[id]);
>>>> +       ctx = xa_load(&mm->ioctx, id);
>>>>         if (ctx && ctx->user_id == ctx_id) {
>>>>                 if (percpu_ref_tryget_live(&ctx->users))
>>>>                         ret = ctx;
>>>>         }
>>>
>>> Question on this part - do we need that RCU read lock around this now? I
>>> don't think we do.
>>
>> I think we need the rcu read lock here to prevent ctx from being freed
>> under us by free_ioctx().
> 
> Then that begs the question, how about __xa_load() that is already called
> under RCU read lock?

Something like this, mem remap has an existing user that can use this
too already.

-- 
Jens Axboe

