Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F31C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4925A206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzHLq/15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4925A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408486AbeKWTCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:02:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40816 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbeKWTCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:02:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so9939518lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jJOgYsgRtKKoUoRNJV1fdTlWSFGRpGITvIfXG5xt8JY=;
        b=mzHLq/155gcZla6q3sMl18bjgq1Dznl56C1/jZSuJ3O9YdjqFGDM6xrzyAXaZfu7qz
         Dh5GrexFGLx6fooBrKx7mwn7BaAvmPCnUUjBpCWRHKFXXggD0ByZg5FU6WUHxnsgqZRd
         u4SUDvqupmyI2dXIr8FV77rW+EYRhnoPFfaLkCvIaN9P6BsLztbgROjSfff/pSFTGTM0
         6Qw2mMCbGHI0F//Fz8vLiA4FLQqxu1a6lkKTRDVuAsZ/6vavJRlz41dL99aZorZXQ010
         WI3wZ0dlRfRO/pchAmxbS1EWb5aUvgJYDbX44GRaj1U+tWORwA8gB/yzUQGfGjv6373J
         fzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jJOgYsgRtKKoUoRNJV1fdTlWSFGRpGITvIfXG5xt8JY=;
        b=touNGvhaykoMoh8hxt3fIMyRBUmGPe+OSG6zfchNJCkJKv2HP4u89C+TeoTY/GIxXd
         2FL6fQgVTZUxAx1OrnBmBzwYKt4FeYNqgylVBzZZsKqUU9V1MN6xT779d7eWplg6gCuN
         Coh08FyHL99hIJM4INhcQW2tPV0YocqNTpXoP03az5B9YJhDrTGYmB2J2kmEOP5BHGlZ
         1wxb0ncO/BYJyvfiDPbYdnDQM79MoH2L7vQzVcWWJZanUP/YnK+ZnHC6BgYbhF7HyeIm
         94DRNUK5lTXMcVUwEiy0bb4Qzib6RND3lBAPComQGCwDSrDqJQf5frXFocShGXpThK/5
         wUag==
X-Gm-Message-State: AA+aEWbqKooz3p7dm0u9kvHVb8iQ3jYdbakdr1HdxTL47z/kM5lpJRZK
        y90pUQQhNraIf93KZOg9EO9+qBKk
X-Google-Smtp-Source: AFSGD/VxDo5EiZ1udEvrw2hxu1tZ3UjxFQXV51D2/D1K8n9mbQ62Q+6VuesVB5uNKDdIG8gO89eeWQ==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr8753536ljk.109.1542961180458;
        Fri, 23 Nov 2018 00:19:40 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id 10sm7604471lff.62.2018.11.23.00.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 00:19:39 -0800 (PST)
Subject: Re: [alsa-devel] [Xen-devel][PATCH 3/3] ALSA: xen-front: Use Xen
 common shared buffer implementation
To:     Takashi Iwai <tiwai@suse.de>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181122100230.14976-1-andr2000@gmail.com>
 <20181122100230.14976-3-andr2000@gmail.com> <s5hzhu13yil.wl-tiwai@suse.de>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a5a5754f-0a1d-d537-feaa-8f4ff4e203e3@gmail.com>
Date:   Fri, 23 Nov 2018 10:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5hzhu13yil.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 5:47 PM, Takashi Iwai wrote:
> On Thu, 22 Nov 2018 11:02:30 +0100,
> Oleksandr Andrushchenko wrote:
>> @@ -214,12 +221,19 @@ static void stream_clear(struct xen_snd_front_pcm_stream_info *stream)
>>   	stream->out_frames = 0;
>>   	atomic_set(&stream->hw_ptr, 0);
>>   	xen_snd_front_evtchnl_pair_clear(stream->evt_pair);
>> -	xen_snd_front_shbuf_clear(&stream->sh_buf);
>> +	memset(&stream->shbuf, 0, sizeof(stream->shbuf));
>> +	stream->buffer = NULL;
>> +	stream->buffer_sz = 0;
>> +	stream->pages = NULL;
>> +	stream->num_pages = 0;
>>   }
>>   
>>   static void stream_free(struct xen_snd_front_pcm_stream_info *stream)
>>   {
>> -	xen_snd_front_shbuf_free(&stream->sh_buf);
>> +	xen_front_pgdir_shbuf_unmap(&stream->shbuf);
>> +	xen_front_pgdir_shbuf_free(&stream->shbuf);
>> +	free_pages_exact(stream->buffer, stream->buffer_sz);
>> +	kfree(stream->pages);
>>   	stream_clear(stream);
>>   }
>>   
>> @@ -421,10 +435,34 @@ static int alsa_close(struct snd_pcm_substream *substream)
>>   	return 0;
>>   }
>>   
>> +static int shbuf_setup_backstore(struct xen_snd_front_pcm_stream_info *stream,
>> +				 size_t buffer_sz)
>> +{
>> +	int i;
>> +
>> +	stream->buffer_sz = buffer_sz;
>> +	stream->buffer = alloc_pages_exact(stream->buffer_sz, GFP_KERNEL);
>> +	if (!stream->buffer)
>> +		return -ENOMEM;
> This keeps the NULL stream->buffer, and then the caller goes to the
> error path via stream_free() which will lead to an Oops due to the
> unconditional call of free_pages_exact().

You are absolutely right, will fix

Thank you for catching this

>
>
> thanks,
>
> Takashi
