Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D392170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k27/kZ/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D392170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHUAZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:25:34 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34197 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:25:34 -0400
Received: by mail-qt0-f180.google.com with SMTP id m13-v6so17892989qth.1;
        Mon, 20 Aug 2018 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7N1g7TR8UJPavSj1xjkA48QEDgxP3/CKOIXHfV19OI=;
        b=k27/kZ/0QSwy+wGwKDM1DF+UnsVjd67q5H2kt4aNXBh659BxomQMwrG+Jr8hj21tdc
         XH701xonqV9gf5qUlbI4xFCkqYub4/nRtpQbhK9Am9up449ruNkJ8EcHFkzGLsmCo1om
         ETrc7QHF1CdHCo7YpQBc99Xel+Vb/UuHzCWkAjTN/3nSlw09yL0J0zZ1RgPm5T94iL0M
         8jtG2DJixlRNPB/UkTeM6L9VvitpV+7dHPC7Y8uTghaqWdJFIpc7pg+kQiLRcGTdb9Xo
         dtwN+ADClo3kLUToUWG2+3WZfpLZOoN3aXtsm4Y/4vVhNipCfKjRpGP9hhUEo5PqUnqt
         8wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d7N1g7TR8UJPavSj1xjkA48QEDgxP3/CKOIXHfV19OI=;
        b=G1M/cJSkKtlIFA6GONQVtVbU/AmxfAqOtvwUPhrA8tr4n6rzQY+NBYCheyGl6M+zpE
         l/PHEhdAwmMRDcHXk2L2IWAXiNZrYnxhwoLYFOVFEKZ8LaYsWByaXsX1Ok4/kqiwnRAm
         woPyImwoSW5Z76GvqvjGdUPKyWw5Bp9yKE4o5hjAIT+78Lg5ybpj8awN4qE9Ch4TKyCk
         BsuPVO3ckujgcprSwAkqIo1OOIIEvykKEihzIiMjX5luMo/Iis3QmCtTfRv7CpSCFZGl
         K/Pt537qkilbZxmUsZfT1WE01rYKhzDnWpedhyuboVVjgkU1s2x6CNZupfk3dUiUyETF
         60zA==
X-Gm-Message-State: AOUpUlHdxO7W2QR0q6V/3q5fbgxHUxcoB0rArZm7YgWk6TGtCV3ghQjM
        xhKCn3IcgU5J4IeP3DziMxM=
X-Google-Smtp-Source: AA+uWPyCt9MFqpN7TDN4FiUKDOZxxTKE3+dSEeBXu7kOM1he6cwZgJRRpUNePH2nfzGGKhxAEKr58w==
X-Received: by 2002:ac8:26fa:: with SMTP id 55-v6mr46643843qtp.57.1534799301784;
        Mon, 20 Aug 2018 14:08:21 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 42-v6sm3638690qtq.39.2018.08.20.14.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 14:08:20 -0700 (PDT)
Subject: Re: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
To:     Andrew Lunn <andrew@lunn.ch>, justinpopo6@gmail.com
Cc:     linux-gpio@vger.kernel.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, gregory.0xf0@gmail.com,
        computersforpeace@gmail.com, linux-arm-kernel@lists.infradead.org
References: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
 <20180818005211.GC26866@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8419b0dc-9998-3147-512f-85d2694c6a2e@gmail.com>
Date:   Mon, 20 Aug 2018 14:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180818005211.GC26866@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 05:52 PM, Andrew Lunn wrote:
> On Fri, Aug 17, 2018 at 04:47:39PM -0700, justinpopo6@gmail.com wrote:
>> From: Justin Chen <justinpopo6@gmail.com>
>>
>> Sometimes we have empty banks within the GPIO block. This commit allows
>> proper handling of 0 width GPIO banks.
> 
> Hi Justin
> 
> This is coming from DT? Why do you put 0 width banks in DT in the
> first place?

The way the binding is defined, the "reg" property must cover the entire
GPIO block. On our chips we typically have two blocks, one called GIO
and one called AON_GIO. One of our chips, BCM7429 unfortunately does not
have contiguous banks (groups of 32 GPIOs) within the GIO register
range, it has a first bank from 0 -> 0x20, then nothing, then another
one from 0x40 -> 0x60, which is why this change was proposed, since it
does not break any existing DT blob.
-- 
Florian
