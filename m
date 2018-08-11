Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B5EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F092421A41
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFMJT6O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F092421A41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHKR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 13:58:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35311 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeHKR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 13:58:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so5221268plq.2;
        Sat, 11 Aug 2018 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTVhSgiWPunea9cz+MQ+oH4PRXA8BAIvBZrrdRZNFT4=;
        b=jFMJT6O3vHO9Rz8PIhSWHD1hsWpspoKmPxLP0hKAGpYQH1ARjRaiN3YI7ZFTwUdk2T
         njvBQl3Z8R230+VoosrQ+xs5bACspCOERpMxcKxq6HJRlHwkuF8zKf4igSngpL/6KAkQ
         Qp9YbYmRsE/bIMOrP8K1BLeaOowP1nHk47dMQl2zysSB3Gh27uv/effmoUk2A2xCw7JH
         LVf62MwgsMWX0z8cy4BQXxcG17zarYwdPZC/rQ+9ALQIj37c7QBnYMmu3fXe0TtW+lxu
         jeyVtuFbM5/OK/h55j9G8hwNjeh/YeF26qFqeGv7t/5rgvRy0VFR8eNeKCUVkDWH53Ei
         n4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mTVhSgiWPunea9cz+MQ+oH4PRXA8BAIvBZrrdRZNFT4=;
        b=oGFxnfqGsvch5RADF3Cg5iJHCCiNath7iRtMuJbj997HQ4WnekxvLcOf3Y1Btd6MxN
         fkQajR5NAcfLcdC6LLS5YHX9deVk7aGq6H8wpGFgxEBJ/SqvkdIFucd9mW0stOGNuhlZ
         eEfShCC8aRJUIh0P8lJFmko5FYtwdSNUizIae1M7ySc1NX/gNltQWX1jYdFQVyddNcAi
         bA/1gS22u9lJnXbBCS3R6brPBcCTYgwHXq+p3uymEfqp/ApPFWpGVZCnMVgY1WZlN9zC
         qLFSYAzQ/BbEHVdmthUL05X2Ykj86vLbHlOgHR+B32Dul01I1uxRJN/CC0h0mwKZOJHE
         3W9Q==
X-Gm-Message-State: AOUpUlGfEQBhiKttZi8J96bu5f/thz3mV3fM0wWuYI98MKz854AWOa9v
        IE5p1+VHltqEZVVQJYFMeFg=
X-Google-Smtp-Source: AA+uWPx+qrhnzzkpzMzPvOziO4zXzk4aafw5Kh/fDMaaOy3D0uC5YF7//hJjDFB4iq0pQSCoN04pHg==
X-Received: by 2002:a17:902:da4:: with SMTP id 33-v6mr10095544plv.193.1534001045019;
        Sat, 11 Aug 2018 08:24:05 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-113-8-179.tukw.qwest.net. [97.113.8.179])
        by smtp.googlemail.com with ESMTPSA id d81-v6sm24389375pfj.122.2018.08.11.08.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 08:24:04 -0700 (PDT)
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
 <20180811024553.GF6515@ZenIV.linux.org.uk>
 <d223ad23-04ae-408f-2a73-d5fa641ad725@twiddle.net>
 <20180811150731.GG6515@ZenIV.linux.org.uk>
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
Message-ID: <7521cba8-64d3-c262-5590-791ee0abdb7d@twiddle.net>
Date:   Sat, 11 Aug 2018 08:24:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180811150731.GG6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 08:07 AM, Al Viro wrote:
> BTW, looking through old patches around entry.S, are you OK with this
> one?  Same kind of macro as that for fork/vfork/clone glue...

LGTM.


r~
