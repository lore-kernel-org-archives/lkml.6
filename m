Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8991FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3757520664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dq0+mn1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3757520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJaC2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:28:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32933 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeJaC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:28:17 -0400
Received: by mail-io1-f66.google.com with SMTP id f12-v6so4528398iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=buNwFDxTWFskPDzSjp2WeLtCfda2WjX38lJIxhn+3Io=;
        b=Dq0+mn1bsG5KFKbgKEvli8H6WfmyZG0f+OL46Iopq92W3CmMEe5H4qOHqIAH0aBnx8
         SEsbQJsK4K3x2U3UJ/jpLpqt8L+o1gnkYfnUvkZ95wdL7TThdCf132iun92qnnFThkSI
         54zSsCBFB98uW4jYahY73xnAoOQP7fA1icRAb01kM0MVbYXINpbF84XbLB2CBREiJ8Dp
         nXfOAvsB2VKyCosoKPZLz0p3MG3q0QaS5aD8sDjsLYSw2MyXMBJ+pfn8W6hCcRKvQ0fd
         0QmAYOg5wmNq/uo/6HDYKSr22K+FH3NVl/aLYzmlVrVIkXUWqCRyFVAqn5VTJSdOh1nD
         vMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=buNwFDxTWFskPDzSjp2WeLtCfda2WjX38lJIxhn+3Io=;
        b=siRiKbcm+gLLNwXBeMRiplKC6QaC4dK8eiuuPpyjnybCOpasA2Yof/682b4LhYv7qO
         xiWsJxl1U4VCfHG3yBTjIB+0fWabOyFESjtH1z6VccqkAJ1R5AWqNlO98cAuDUiqQXCQ
         wwHUjekyADL2P5qzUMJo3YmVh1EMkLyG7N+o058PhuG4I4AdakzeKJtE8NYsKdCYO6HL
         yuylNfTjDpa1WxKdbhCowPtDeJ6UOQ3GT+k2mK3ohVGzGpyoH5TX3PTRqP4w25HgUkLL
         iTv/ridveAYgQzJQ5SI7kj98Pxft3tJYpMC/lQZUhVzDOBSH4wzSdghK1tdAQPu0Dst+
         2aXA==
X-Gm-Message-State: AGRZ1gLpJnzcxn5MmdBOzBaVT8yb55ZHASpIEfojGSycvgz9kCknvk31
        3Fcoha8KoKCuAmRturhdFa2WpQ==
X-Google-Smtp-Source: AJdET5eR7sTWfXMaQVUeLphNNtchWwzfIRZy2fpf2yaOjAdfdeNFbg2LPHjnh//4xlBIGY/NBGBslg==
X-Received: by 2002:a6b:1807:: with SMTP id 7-v6mr1712383ioy.143.1540920833859;
        Tue, 30 Oct 2018 10:33:53 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o10-v6sm7086137iob.43.2018.10.30.10.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:33:52 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
 <20181030160242.GD18906@localhost.localdomain>
 <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
 <535480f3-9087-b4ae-e7c8-cfe3c2d1e2c9@kernel.dk>
 <20181030172234.GF18906@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d393e6f3-bc45-e038-9a5e-e51018f0a15a@kernel.dk>
Date:   Tue, 30 Oct 2018 11:33:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030172234.GF18906@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 11:22 AM, Keith Busch wrote:
> On Tue, Oct 30, 2018 at 11:09:04AM -0600, Jens Axboe wrote:
>> Pretty trivial, below. This also keeps the queue mapping calculations
>> more clean, as we don't have to do one after we're done allocating
>> IRQs.
> 
> Yep, this addresses my concern. It less efficient than PCI since PCI
> can usually jump straight to a valid vector count in a single iteration
> where this only subtracts by 1. I really can't be bothered to care for
> optimizing that, so this works for me! :) 

It definitely is less efficient than just getting the count that we
can support, but it's at probe time so I could not really be bothered
either.

Can I add your reviewed-by?

-- 
Jens Axboe

