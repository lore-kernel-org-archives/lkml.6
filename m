Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E688FC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D755207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnIKKs8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D755207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeJXFpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:45:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36410 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXFpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:45:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so3251476wmf.1;
        Tue, 23 Oct 2018 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JIigNVTJFOwfN3Clae2fytl4qYBiZWfJp2YsI5Q7WaA=;
        b=qnIKKs8BUj5HemOqMDtJ8Q3L4Vej7POZXGfdk2eGN3KrdkqbDdTnKEDat6ybxIA8ae
         /CIFg2vD5ZoysG/vOffomk45IdpiT69aGv4+ehJy0vFG9Rt1dtyKCoC3BA8dx5bb5U/c
         UHdyafo8Ql9Rowycxj5P+9y4kWobKDUHrrqGydSZL1pNE0GE7l+/CTT34E6wZNMXFOSm
         1YAp1xA3aeBxygNR/BDI0zZOzgiHGVgmPJj7gdeNUqAlix6nOBYB983fnlvH8ukeEczr
         TR6puseY+8+2cVRzY8F80uFdC1oI5zLH7v/Lk0tvVr9fs3/9NU/fotgCURsG1T2R6/f4
         7KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JIigNVTJFOwfN3Clae2fytl4qYBiZWfJp2YsI5Q7WaA=;
        b=BqSfix7rcPpKpU6RrA35n4TGLIcJl69MY675M2i0FBLE0i8a/F22RGHQbyyG0b4KZC
         8W3lTp62b/Yik+cL+gJCsnwWG+M59SQ0SwUYg6Ryuon72dSmrGYkg1HXB7j6mNm23UND
         mgpcMJNSNQ8tulslydHnW2te2TMISzIS2vDx78D7garHKs6IP4tnurRkBdqy8T1rExli
         naiWbbSdwDRl5TIt0kzAHfeV63zIyeoRPINL0ZImCvMjP/dNZr1jFspiJDvaj3yRl88Y
         r2Wci9a+Ehtr9Pg8BUBlJoxtniSNGGnk44f+9S8GNMaYs/2ufYVqTBITzqR1+nHiVXEo
         DIOQ==
X-Gm-Message-State: ABuFfoiN8ADblyGaQCPpPymwcL0zG52hK5Jrtu7H9J5qnypawdibKJFy
        1Tu9nMMiyXG39SxuVaIzSXI=
X-Google-Smtp-Source: ACcGV63E1DLCU58/8ZoOzoUKRyEl0mn1jSpHGAe1iRUMh1j4LdKWbkOSa3yP+VD0EX61QrTUr/sEGA==
X-Received: by 2002:a7b:c150:: with SMTP id z16-v6mr22314954wmi.25.1540329620312;
        Tue, 23 Oct 2018 14:20:20 -0700 (PDT)
Received: from ziggy.stardust ([81.145.148.99])
        by smtp.gmail.com with ESMTPSA id p1-v6sm2613902wrw.12.2018.10.23.14.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:20:19 -0700 (PDT)
Subject: Re: [PATCH] thermal: bcm2835: enable hwmon explicitly
To:     Stefan Wahren <stefan.wahren@i2se.com>, matthias.bgg@kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        eric@anholt.net
Cc:     geert+renesas@glider.be, pmladek@suse.com,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
 <459136891.184150.1540296101955@email.1und1.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <12ca4f71-8ba9-91dd-f5a0-0c72c91401ef@gmail.com>
Date:   Tue, 23 Oct 2018 23:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <459136891.184150.1540296101955@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 23/10/2018 14:01, Stefan Wahren wrote:
> Hi Matthias,
> 
>> matthias.bgg@kernel.org hat am 21. Oktober 2018 um 23:58 geschrieben:
>>
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> By defaul of-based thermal driver do not enable hwmon.
>> This patch does this explicitly, so that the temperature can be read
>> through the common hwmon sysfs.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> I'm just curious which board and config did you use for your tests?
> 

I use the RPi3 B+. I suppose when asking about the config, you want to know if I
also enable the RASPBERRYPI_HWMON, yes I enable that as well. Actually this
patch is for openSUSE Leap. You can find the whole config (if you are
interested) here:
https://kernel.suse.com/cgit/kernel-source/tree/config/arm64/default?h=SLE15

Regards,
Matthias
