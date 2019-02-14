Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB23C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FB3218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1ep7qdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395432AbfBNVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:13:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40176 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390474AbfBNVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:13:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id w6so1761482ljd.7;
        Thu, 14 Feb 2019 13:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZChMsRAHP0HW2emBAI7wrSCyLQOM/tkfKHcmHmvItsg=;
        b=C1ep7qdToipEDkT2jKMT9jNz2FXvqu3KQwe+21P8CgtJTgc6amKRTbN9i3vSVYNJlz
         CQ3znWkxW3O8Ggt8hsL2CE7QtacdUqtBnsBni0Ia3urR7qgEfVcSbtpprmgVrpjf/4d7
         TkBSnX+058N4h0cIhweRcoTEAhQbVY0pC/s0Wk00XOoJ4LU0oFqt4n6Ter/3C67dfisz
         HUAU2JyicSC4FxfP+LCeDj6agWU2YZzhcvS3vNIaD3+FSzp5BSHO4ydGVxA8TkHbD0S1
         s9EK3kAkqzQScVQQCRabHzbdjwkyWE9cYgRNQWUVkqVLPB/V7HSezYTq2sP/nqhta4NN
         fuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZChMsRAHP0HW2emBAI7wrSCyLQOM/tkfKHcmHmvItsg=;
        b=HT/C5RDcYJdeKQNK76vKvS4y4Rr3ZAVIbQq13wloZTPvvVNrIe1Us+cNfvRmSj6Sg8
         PdyooDQsIoSYBrdNF4XunVd5bi/I4bvpPg66OUsVnxlevkZtoeqeoV8MN9ocNMbDqdGo
         hBxsGMEf9d2tCFuql5PEJ+djg7eotEKxFLm8X+CmUnswTTiq+/tKsyWHiZXK72m88e1Y
         5SoIgydcxjCttA7Tr/jBEdHiXi3cc5qLE/89xvvOKaRNiejl3dJkzZUeMQ5sMO0mdzQg
         +inlKMyczeCNk4/b741dlQZPAKWoZj4Yyg6k+4qsftbqK9cu46lGDLpOsi0yLi83oZ3K
         gc2Q==
X-Gm-Message-State: AHQUAuZ+w1d+s1xJ4mAbPBbxer3rTpwrS67iUfE4+yYKDz3hyu1ycUoh
        o8NJ35k3+XLnWvYeRWTv3w8=
X-Google-Smtp-Source: AHgI3IbDAtYtvy96iV3PtirRgU0/KtP6QXw41bhY5PqPF1FwegsKKn6P2WlvxhJnWWyNwxQ/81Lsow==
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr3620164ljd.31.1550178829521;
        Thu, 14 Feb 2019 13:13:49 -0800 (PST)
Received: from [192.168.1.18] (chh67.neoplus.adsl.tpnet.pl. [83.31.5.67])
        by smtp.gmail.com with ESMTPSA id t12-v6sm642176ljd.47.2019.02.14.13.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 13:13:48 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the leds tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Kazior <michal@plume.com>, Pavel Machek <pavel@ucw.cz>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20190214144610.3672e9d7@canb.auug.org.au>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a741b99c-83ff-547b-90d6-f54f8f7de966@gmail.com>
Date:   Thu, 14 Feb 2019 22:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214144610.3672e9d7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and all,

On 2/14/19 4:46 AM, Stephen Rothwell wrote:
> Hi Jacek,
> 
> After merging the leds tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/leds/leds-lp55xx-common.c: In function 'lp55xx_firmware_loaded':
> drivers/leds/leds-lp55xx-common.c:217:1: warning: label 'out' defined but not used [-Wunused-label]
>   out:
>   ^~~

Thank you for the heads-up. It's my bad - I didn't use sparse on it.

Fixed up the original patch.

> Introduced by commit
> 
>    905c2157dd19 ("leds: lp55xx: fix null deref on firmware load failure")
> 

-- 
Best regards,
Jacek Anaszewski
