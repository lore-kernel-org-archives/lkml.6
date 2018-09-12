Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDFC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsO9AHlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeILUNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:13:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44480 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeILUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:12:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so1109741plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r3e4kTpTtL5OyH+GkjcdzNGiLuO7SHzm1M3ZBdOkJtY=;
        b=RsO9AHlg5shFdw8M9PemoGEiCfCaDDbJfviJCCJqCMVfxxEd7ZPxuSQCeUh6vS9cem
         /bPx19bcGGi+3lMzewk2PrzoRKwcsRKTnx5EyU2PazTkSHp0Q7v3dbTe6Bh+9qwL6ytb
         /ktf/hF6nVl6mgV09JiHanFyXW91fyipqHH+FObuP7apCHBOe6nZKiOFV7jOkbtJNBv6
         uPGW3xdw40dxfZHZoa2RVZ0p4q5k2qtM6cy6zW05IZXf/p6cvE053hphRkhp1KKorVwz
         GYX7DChMs+GobnJO/88MxjRZchqTDIb6N6r/UBB8Ugl0p1l5Ut1YmKJ0UyTaGgklxqt+
         Wg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r3e4kTpTtL5OyH+GkjcdzNGiLuO7SHzm1M3ZBdOkJtY=;
        b=QExInkvnTJjMD+dCEJuxMpWgDyGP0bbJOKjN79S1/+Ewuvbz6a46N++USmyK2lsUX5
         MlCL0oxuZWGU9EZlWiCuNJnUu4zDpfPHWij4ToGr4/5aaNa08ijENedaKLu2gyHiCptz
         YMWCWuytqP/eJFzbJnTYdnIOVege4twP6WxyEEiVtHJ9v1B6EoEnGMm6aVXU12jzp9Ax
         CvN1yLJdM2BaOISdyev+0GDfPtcC/0UzKh3TZeJr+lYlkoFaznacq/G00WGQ4Fytb9WU
         E3a8m0ITyAtwyfoSh/+e8UReGgOcw/J7744YPSsxMRTKl8CBHLqC82CktGCrCgR0sZzH
         Zb3g==
X-Gm-Message-State: APzg51A0s2WE5yCPQ6FyUPD6mNnBuZ72j3Bc8/RpyxD9nL9Evysuy6Ne
        JRTbhQSMKOCngfabNgCqJJ5SUVYw
X-Google-Smtp-Source: ANB0VdYjuaowo703MXkI2sDH8n73sPjJIgJfAJsA3IgZcvn+LGTeUMnDL7wNqJ9ZoUHtmrebAOmW8w==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr2744194plb.299.1536764883768;
        Wed, 12 Sep 2018 08:08:03 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-113-8-179.tukw.qwest.net. [97.113.8.179])
        by smtp.googlemail.com with ESMTPSA id 71-v6sm2362342pfx.182.2018.09.12.08.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:08:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] Use named address spaces for percpu data
To:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180912144442.29271-1-willy@infradead.org>
From:   Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 xsBNBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAHNI1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+wsCBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVzsBNBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAHCwGUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <988cf77c-e0cc-25fb-dcd6-945e6f2ba65e@twiddle.net>
Date:   Wed, 12 Sep 2018 08:08:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912144442.29271-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 07:44 AM, Matthew Wilcox wrote:
> rth wrote a patch back in 2016 that uses gcc's address space machinery
> to improve code generation for percpu accesses.  Ingo asked for some
> minor changes to be made, but Richard didn't respond.  While looking at
> something related, I came across them, and asked Richard's permission
> to resurrect and resend the patch, with the changes Ingo asked for at
> the time.
> 
> The important information about why we want these patch is in 1/2.
> 
> Richard Henderson (2):
>   x86: Use named address spaces in asm/percpu.h
>   x86: Enable named address spaces for percpu data
> 
>  arch/x86/include/asm/percpu.h | 147 ++++++++++++++++++++--------------
>  1 file changed, 88 insertions(+), 59 deletions(-)

Thanks for resurrecting this, Willy.  I'd totally forgotten about it.
The adjustments you made look fine.


r~
