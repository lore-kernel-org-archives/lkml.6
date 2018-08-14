Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C576F2172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xS6WMAcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C576F2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbeHNTkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:40:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39728 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeHNTkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:40:16 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so20685565ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BxnbpcGS6tjDkY1nxTGBB+Jd98MdCsMTskf9OKP5jkc=;
        b=xS6WMAcLgQlrgPQMCFaiek1kRCE55j/Zn90FjlhgA6s8tCWo6C3KISd3KSEhFZawuf
         gOMZ9D0QqR/QVio8VH76VgsT6n8JeeU20uQk58uitiAbs/kT9jMNThfNsPzQyUuuRoKO
         B2ququavf3GHR7y03vPJfU/D1uZrgx/8YhqVRLOI76ezZWVKD3T1btoxC6povdmp/4PP
         YBDqpfoc2f/ee2lJU6Du8b1RpASqzY4Hv1/f3w0EFOh6Dysjtrc17AhdJEybVoAl6q+B
         /p/Ief60KCBK5cN0raOF0LLBjgpP6UjajK0SenAH7x3VYbKTflEhuQQmQW/mHUl7Jiml
         PIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BxnbpcGS6tjDkY1nxTGBB+Jd98MdCsMTskf9OKP5jkc=;
        b=ZtWaCPz77Qu8mQdLAsvqocwpysdaq6LsTkMQR6fGMZvNS1rR8/9luq+YEPbjSeY07O
         Z1tRA44hYbp9qk/AgBsSntQMtHjp+WVOCEvsAhJ/q+xwzvIuQviGIdoCvhBca+dAI8wx
         29e4xTy63SlbI2T5FKblHgBD+w9epP81Ay6ulfUfC1DGz08I8HoZUm1iXDCt57m2MfcS
         05ArcBakc6DJ0rkPGSPZ4GD1ugLo25EU0UDSRbis67QdRrh1zLOHOn3DPmDsNlPRTzVM
         fKXUYeQyGZhzsjokoQX5R8fjaPwl/ECKZnNSKFHWue5f65WEQjaMcKR+uOmoQE//+Dyn
         yTCA==
X-Gm-Message-State: AOUpUlGVf6tDZKwiMWyYIgGzfZENWcouiT0jbwctQTX9nWgogUsBH1wp
        WYcMH5+OzNkY+y4srzMcw2JQN6UdCjY=
X-Google-Smtp-Source: AA+uWPxW8OYJELaBdg9U/6QjCgyLcfRz/4W2L+5NDfLMdx7cBBkwoLPAVD6HdYj9Ow7WjklF3APo3g==
X-Received: by 2002:a02:b4ea:: with SMTP id a39-v6mr20107292jak.95.1534265539062;
        Tue, 14 Aug 2018 09:52:19 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q8-v6sm6573389iop.12.2018.08.14.09.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 09:52:17 -0700 (PDT)
Subject: Re: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>, stefan@agner.ch,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
 <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
 <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
 <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
 <e5589461-6331-7c4c-4171-7d7e304410e0@kernel.dk>
 <CA+55aFzisr_YkMJggnG0O4ALzjwKsPeio71PJY8Jur4afnOVOg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <629769cc-d50e-f7f1-7327-23c751f95be2@kernel.dk>
Date:   Tue, 14 Aug 2018 10:52:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzisr_YkMJggnG0O4ALzjwKsPeio71PJY8Jur4afnOVOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/18 10:51 AM, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 9:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>>
>>> We probably just want to special case a flush for this check. In other
>>> situations, like resource allocation and issue, we'd want to consider
>>> it a write.
>>
>> Ala:
> 
> Ack, looks sane to me.

I'll add it to a followup pull this window, mark it stable since it's
hitting 4.18.

-- 
Jens Axboe

