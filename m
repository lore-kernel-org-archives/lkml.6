Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB144C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873502150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8kCvqx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873502150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbeISWj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:39:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbeISWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:39:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so6575244wre.2;
        Wed, 19 Sep 2018 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQZK3LSAKm9Q/JEej51ize82XF99eUCDqrirO3cvFMM=;
        b=N8kCvqx+kF5FwnRdOhnpRR7sRilpMHTWOpeB7ISTni9fAvPGATzshNfkhQ927SnFc/
         frgP5JdZbKBMKxWA7JySFf5grIoyvuel9TUJN5q7j+xVv/S0RFwBnX0HcAjwsTgxrUkN
         PILna744tpJK1AGP5BKYvF+K2HqA3H3AwCUrl0fyt+6NYuXY0W0tq3xvXDoR2WkBWGB9
         FaeD8wSgJ0BracrJTj7TpVM0ClW979oOL9wbfid2K29CP316VWX/XhtFAtGL+pbeAnPD
         x13X+qLUNxlufDGIBBjeUpnDfsZ32PRldCKxyT5xR9T3r44fvsSUAXkrIoGZ2AjkCdqy
         gPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BQZK3LSAKm9Q/JEej51ize82XF99eUCDqrirO3cvFMM=;
        b=jIPBCaDC3pjcaO8HdYoKZBdN5tDZROwNvcr/01RqA+tNF0XegjoZ6RpMI9FOEGb9Tx
         qu6vCLSmKM7tP8t4NFBKwGqX/lp4XEMNTkIByWpq/2lamiRpvV6S6SxAFZHtUZHm9RGU
         bu9gVhsBkps5MyQyo3EaKqljBKqg/T0J0oO0aDRHSp6qDKJ3u5XmgFQh5EU2TPj6R9Gy
         r2pxtkLppoaHel5vfUpPJsKBRC31LcsoMMq03kD5kO863lnd5Ti8sTx0Ix4kXx1xTzsl
         b4Ys3zd5V6s3/YHVMB+S8r24Whhp1uD446//avi4OnbS/lG4133nXwU47ASuShk8VSf/
         UJwg==
X-Gm-Message-State: APzg51DsP5gqLvuXFddvP4bUH1Mjm5N1XQWzWnWhTq6z9aTIHeFgd3hB
        ebki+ERaA0Ek2NBrHNCcdkwaovr8
X-Google-Smtp-Source: ANB0VdZipJ1KjDsTK6bEu0UIs2Kz2Vltj9HR71BPF/lziBc2SxSmnc+uU/ZWWtkCpqFmSSzTSDFYcg==
X-Received: by 2002:a5d:4250:: with SMTP id s16-v6mr28759409wrr.260.1537376437234;
        Wed, 19 Sep 2018 10:00:37 -0700 (PDT)
Received: from [192.168.10.165] (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.googlemail.com with ESMTPSA id f18-v6sm20619572wrw.32.2018.09.19.10.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 10:00:36 -0700 (PDT)
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
 <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
 <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
 <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
 <20180918160419.2zeru6xnufxixcax@linutronix.de>
 <11aa7d0f4ba36eff8b61a5dc1bd35ee5195fd576.camel@surriel.com>
 <c3492a53-74cd-4474-b664-f227ef37b7de@redhat.com>
 <20180919165719.iepvc7tg6aabp5mm@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <099b9f82-e162-c91a-bc51-aa1ac0cd50aa@redhat.com>
Date:   Wed, 19 Sep 2018 19:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919165719.iepvc7tg6aabp5mm@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2018 18:57, Sebastian Andrzej Siewior wrote:
> On 2018-09-19 07:55:51 [+0200], Paolo Bonzini wrote:
>> A kthread can do use_mm/unuse_mm.
> 
> indeed. The FPU struct for the kernel thread isn't valid / does not
> contain the expected PKRU value. So loading the pkru value from the
> struct FPU does not work as expected. We could set it to 0 for a kernel
> thread so we don't end up with a random value.
> If we want to get this usecase working then we would have to move pkru
> value from FPU to mm_struct and consider it in use_mm(). Do we want
> this?

As a start, I think keeping it in the FPU struct but loading it
unconditionally will work.  kthreads will not obey PKU but it will be
better already.

I honestly don't know if PKRU should be per-mm, I don't know mm very
well despite my brilliant observation above. :)

Paolo
