Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A479A20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf1qJ9Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfANSg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:36:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38371 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:36:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so9755plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4PVGsIaG0j4vALC1QOjFPnyY7phcv6TK6Cm5VP11Suw=;
        b=Nf1qJ9Y8bgxcncC1PhaePAxOf3c9nm9RRtJ8PJEZf+9moHqKcBsE2akhwo5vHHxPKK
         dRS02hvLW9fdM4TxuoXsyPm6uBUCTv3VSCi/af9jyq3UOtsP83EiY9RbVg2fALPJkNeQ
         LSXKBAU6hlw6Lab3fNTedijGP+dsWkHvNdkPhLRAFsKnQ1YHJuygwkZgN3TTuvCFWQ83
         WZGJ/15lNZyofm4eEvvah93pWCTC3IiVUi5H+MdMr1UZ+v7Zn5jPQrwygyKWNmyJG1ZV
         7cRIADcVELQR+iQYV2TNh1RXtppi2IzH3o669ORjW+9mSCzeBhwGLQN9zB11OfLkNexh
         96TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4PVGsIaG0j4vALC1QOjFPnyY7phcv6TK6Cm5VP11Suw=;
        b=gKICXvYWDmsC0GdX5Z6vxdGb4TWSMAplPTQwPQiT29aZ/oVcXt4wBvk7GyHy9/snKy
         d9CulnUFf77bLqM5ckZMeFIKzsa91teuYSBXen+D+l9AhvJYbvcRhhcozDzRO94JesGm
         /DiHgEOeSDDiiUekxlwcNtCC0blgISqSsDXAuwu8eTs/FTGMD/wHy7vB3Ia90tL2LSQY
         wygY6KI878vLicoay+woc2uFakgjJmW3VzBaT1+mYNOtyjiwYMCdLjkVYxMJhhc8FxBP
         lSQ1rzXSjylpIANQpSkwg64osH845ezzaadwi8oXY1oDenxnDCpC/wAE3zbPC3tKcz1R
         5DIA==
X-Gm-Message-State: AJcUuke+VEOcAX9vt7LElLfM7jvW2iZjvEgMuQh8phz3Itdh86HiaFMQ
        g2vdTJci5rSgS0DGTb27KO/2RTVl
X-Google-Smtp-Source: ALg8bN6AP3iO+4TliKc4aoBONgZ9d8K/BV8SK2rSufNhsB8QXo6xIpmbizZNDBNK5hD0z0sYciTP+A==
X-Received: by 2002:a17:902:2f03:: with SMTP id s3mr26187638plb.277.1547490985913;
        Mon, 14 Jan 2019 10:36:25 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v5sm1386261pgn.5.2019.01.14.10.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:36:24 -0800 (PST)
Subject: Re: [GIT PULL 1/4] bcm2835-defconfig-next-2018-11-27
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181127211301.30296-1-eric@anholt.net>
 <da219894-4bba-21a3-94dc-da7ff7e63896@gmail.com>
 <1330816632.286127.1547059111664@email.ionos.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <971c110c-862e-8a14-c7e7-56b8fd7072b9@gmail.com>
Date:   Mon, 14 Jan 2019 10:36:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1330816632.286127.1547059111664@email.ionos.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/19 10:38 AM, Stefan Wahren wrote:
> Hi Florian,
> 
>> Florian Fainelli <f.fainelli@gmail.com> hat am 28. November 2018 um 22:48 geschrieben:
>>
>>
>>
>>
>> On 11/27/18 1:12 PM, Eric Anholt wrote:
>>> Hi Florian,
>>>
>>> Hopefully I'm not too late this time around.  Stefan's been doing a
>>> great job maintaining the bcm2835 branches, and was waiting for me to
>>> send the PRs.
>>>
>>> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>>>
>>>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-11-27
>>>
>>> for you to fetch changes up to 24632d6b78a1929b14f32cab762a0859db7086f2:
>>>
>>>   ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver (2018-11-15 19:07:36 +0100)
>>>
>>> ----------------------------------------------------------------
>>> This pull request enables the V4L2 camera driver on the Pi1 defconfig.
>>>
>>> ----------------------------------------------------------------
>>
>> Merged into defconfig/next, thanks Eric.
> 
> looks like this patch didn't reached Olof for 4.21/5.0.

Indeed, sorry about that, I must have somehow missed pushing the branch
and it was not picked up by my script which I likely ran on a different
machine than where the branch was merged locally.

> 
> Should i resend for the next version?

No need to, this is now applied and pushed out to
broadcom-github/stblinux/defconfig/next.

Thanks!
-- 
Florian
