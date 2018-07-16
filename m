Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C115ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2A208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/jkEdr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E2A208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeGPJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:40:27 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34307 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeGPJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:40:27 -0400
Received: by mail-qk0-f194.google.com with SMTP id b66-v6so20128517qkj.1;
        Mon, 16 Jul 2018 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=17T88GWyl/SmbdtSglxGikLCTqHFnAL+LZ/lRoA3aZc=;
        b=c/jkEdr6AvD6l0qSb3bHHY/Cn82ITuymKOWzoao+0U9h+3r3xeFWHwwxAmzaojSZvw
         pwGPmNtGrOUG7Kda8JFpNgHpl2LMNfvFWWidexqAIMJeVjmXpUTJouBhREUGmDnDgQUW
         3Ey6elmX5LfcrduccqaovdNYRuTvpxNGfFBYZeSjmaMcT34fITEdsOxP8YvB3zFJwE2N
         s0KlIlIZ6lKhvXv0fc53/34A1Ig6laMyJfFo7KJYv6J+7wsgJ8XUCPfE1RpWP7n4EVkq
         QL0jMbksPxxq2bJNSDZaju13fZn/cRgoNEBU3cQFMLXRr0dhXnaUdVp0Owh/aeFlsMAW
         zEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=17T88GWyl/SmbdtSglxGikLCTqHFnAL+LZ/lRoA3aZc=;
        b=HiG2Nqv82ZWENjTZsM+FTrRGp7LJToD0lcg2VaU6QxeApUKzbNcU701tSntLtRUUEZ
         F5Mhn18y/ffcGo5cuBFZ3zLgKh2NRdn7OvpsaK6/us8KWytWdSkS10E+Ssta4zNmQtsn
         E6JBM9McQmyunffKa5ulJe9cvVJozUZ/xT2Jdm+YQTtxX9ht294/dHVXVu+zO51CEGry
         WNII3k2m0tdR5YsfSx3Nen28+GNlhCe4SM81hS3WXkNn6cRrOy++usCRqejeyJvKfFUX
         z+bbgweLY/ycxiVV+p82CY7GGS4PeWEk/lP95zf4Gq72IsB6OKwZ+UYQOndo6uSiqVux
         aTEA==
X-Gm-Message-State: AOUpUlEqLJKy/jD7CbvK5tGTirLGo6lR5yaEo9JDf25+sCEsog1dKgnU
        Q0EF8l7QLMVBDCvY401td0Qz3ROs
X-Google-Smtp-Source: AAOMgpfQpUF4Fo0RdHc7qVHNMUZQD8UD8cqUUIsirP+MaTl4BS4/qiY7VGBRGhWnlAsBktsul7pDTw==
X-Received: by 2002:a37:2aa6:: with SMTP id q38-v6mr13514878qkq.270.1531732439125;
        Mon, 16 Jul 2018 02:13:59 -0700 (PDT)
Received: from [10.178.50.179] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id t11-v6sm26332267qkt.28.2018.07.16.02.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 02:13:58 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
To:     Olof Johansson <olof@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>
References: <20180716075718.4e5ef491@canb.auug.org.au>
 <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6a9fa6f3-7aef-a83b-72a6-dc9492964b5e@gmail.com>
Date:   Mon, 16 Jul 2018 02:13:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/15/2018 03:50 PM, Olof Johansson wrote:
> Thanks Stephen, I keep saying every time you catch these that I need
> to run the same script. :(
> 
> Florian, I wonder if this happened when you rebased to squash in the fix?

Humm, could be, all I did (and it was not the first time) was to do an
interactive rebase with --preserve-merges. AFAICT, all of these commits
came from Eric's pull request, so what I typically do is just sign off
on the merge commit, but do not apply my SoB to all commits coming from
that pull request if that makes sense?

> 
> I'll figure out where to get this into my workflow so we catch it
> before I merge from now on.
> 
> 
> -Olof
> 
> On Sun, Jul 15, 2018 at 2:57 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> Commits
>>
>>   b8ccf02a5014 ("ARM: dts: bcm283x: Add the PMU to the devicetree.")
>>   b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block")
>>   74d1e007915f ("hwmon: Add support for RPi voltage sensor")
>>   70eea1bbb556 ("firmware: raspberrypi: Register hwmon driver")
>>   a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
>>
>> are missing a Signed-off-by from their committer.
>>
>> --
>> Cheers,
>> Stephen Rothwell

-- 
Florian
