Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6O5FODs5HlvcOQAAmS7hNA
	; Mon, 11 Jun 2018 08:56:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D102A60792; Mon, 11 Jun 2018 08:56:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="APDWi051"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3974960385;
	Mon, 11 Jun 2018 08:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3974960385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeFKI41 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:56:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34120 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeFKI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:56:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so19494186wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iS1GVQDZnbQLBGf37XV+6Q9fC8HHxEuh+hI/SFO7Jm0=;
        b=APDWi0514Xz3Z90BlbsuK7RzPE7dHTkRZjlkLhTSN2OenrIhEeVzl/5wRsqfAvAedT
         ttJaMqkuHBbUvqezi3nKucSHqzdFZnG5eJ9AtYiV/g68GSYWpPsGHKl3ZewEtKi0vMFl
         oU1rVZx04CFaFDHAqEOyvBqUL/uPixFWOh486nhEG+D+E2S8NOvrUtWQ708CubQ/U3oZ
         LLbnMhVP3/13PdP6oYzwXhw/K8MmL5B6CZ4Za4QnY3FVQpVi3MzNr5skUdlPA3xf62pH
         2IiOw+C0WX+BwtpSjHSfX/jS38hcfUQWxh1spvXQuyl7SmXCCqU3QYCorwz5hn02oxYc
         tQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iS1GVQDZnbQLBGf37XV+6Q9fC8HHxEuh+hI/SFO7Jm0=;
        b=j5AawrRq090tgec7z4aAAuTNvbYMzsSD0L+4SrHCkSzPylx19GOT/lH88l74euWL0C
         u1Gm4YMgBjiamTpzwLlKRY8TcQzIefI2cts2lRkQydkYXKwtACjWg3b8vtB9tGCPY0QO
         4Ot915xbTuioqcfFtBj6f1M5TZxiu0EYv41cUZ5FLpMpAc2CtUVWOUJCKiTVjEHQkBMS
         vLp+y9r94lBolwmWD+in2lFIJz/+0FQcoJjwrLEzKPi7Av1wylIR8AW67LftM8brn364
         RUBQJ/Ep3g+D7Dcfu1BIZ+8YWTPwMEKuX2csGysEHiGs77rLTIYpaNieCYSDeq7H0AnI
         D+IA==
X-Gm-Message-State: APt69E1I1SwoNmUaSu7pjGlDBGE4B5yETOtSH5kxknJam8P2IpCat79i
        I6KL1P/U83InOWWLISKQcG66Ow==
X-Google-Smtp-Source: ADUXVKIxQT6vem0DdtvA57EzzG39WMR6xlykp55OOCE2QC8OJgbwML9mbbzK5YYIt59kZm7MZ8X8/g==
X-Received: by 2002:adf:f8c2:: with SMTP id f2-v6mr11513941wrq.237.1528707384050;
        Mon, 11 Jun 2018 01:56:24 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a9-v6sm7260412wmh.38.2018.06.11.01.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:56:23 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] Add ChromeOS EC CEC Support
To: Lee Jones <lee.jones@linaro.org>, Hans Verkuil <hansverk@cisco.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, airlied@linux.ie,
        hans.verkuil@cisco.com, olof@lixom.net, seanpaul@google.com,
        sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <04598b47-5099-6695-da43-6e7148145cfa@xs4all.nl>
 <55c2c02d-5675-0821-97ec-6a805659b807@baylibre.com>
 <898f025f-9c59-be61-a2b4-5fbbcbc659c2@cisco.com> <20180611060308.GB5278@dell>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <87562fc8-6c5b-1c9d-4ee4-fd17b652087f@baylibre.com>
Date: Mon, 11 Jun 2018 10:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611060308.GB5278@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 11/06/2018 08:03, Lee Jones wrote:
> On Fri, 08 Jun 2018, Hans Verkuil wrote:
>> On 08/06/18 10:17, Neil Armstrong wrote:
>>> On 08/06/2018 09:53, Hans Verkuil wrote:
>>>> On 06/01/2018 10:19 AM, Neil Armstrong wrote:
>>>>> Hi All,
>>>>>
>>>>> The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
>>>>> through it's Embedded Controller, to enable the Linux CEC Core to communicate
>>>>> with it and get the CEC Physical Address from the correct HDMI Connector, the
>>>>> following must be added/changed:
>>>>> - Add the CEC sub-device registration in the ChromeOS EC MFD Driver
>>>>> - Add the CEC related commands and events definitions into the EC MFD driver
>>>>> - Add a way to get a CEC notifier with it's (optional) connector name
>>>>> - Add the CEC notifier to the i915 HDMI driver
>>>>> - Add the proper ChromeOS EC CEC Driver
>>>>>
>>>>> The CEC notifier with the connector name is the tricky point, since even on
>>>>> Device-Tree platforms, there is no way to distinguish between multiple HDMI
>>>>> connectors from the same DRM driver. The solution I implemented is pretty
>>>>> simple and only adds an optional connector name to eventually distinguish
>>>>> an HDMI connector notifier from another if they share the same device.
>>>>
>>>> This looks good to me, which brings me to the next question: how to merge
>>>> this?
>>>>
>>>> It touches on three subsystems (media, drm, mfd), so that makes this
>>>> tricky.
>>>>
>>>> I think there are two options: either the whole series goes through the
>>>> media tree, or patches 1+2 go through drm and 3-6 through media. If there
>>>> is a high chance of conflicts in the mfd code, then it is also an option to
>>>> have patches 3-6 go through the mfd subsystem.
>>>
>>> I think patches 3-6 should go in the mfd tree, Lee is used to handle this,
>>> then I think the rest could go in the media tree.
>>>
>>> Lee, do you think it would be possible to have an immutable branch with patches 3-6 ?
>>>
>>> Could we have an immutable branch from media tree with patch 1 to be merged in
>>> the i915 tree for patch 2 ?
>>>
>>> Or patch 1+2 could me merged into the i915 tree and generate an immutable branch
>>
>> I think patches 1+2 can just go to the i915 tree. The i915 driver changes often,
>> so going through that tree makes sense. The cec-notifier code is unlikely to change,
>> and I am fine with that patch going through i915.
>>
>>> for media to merge the mfd branch + patch 7 ?
>>
>> Patch 7? I only count 6?
>>
>> If 1+2 go through drm and 3-6 go through mfd, then media isn't affected at all.
>> There is chance of a conflict when this is eventually pushed to mainline for
>> the media Kconfig, but that's all.
> 
> What are the *build* dependencies within the set?

Here are the hard the build dependency :

Patch 2 depends on Patch 1
Patch 5 depends on Patch 4
Patch 6 depends on Patches 1 & 4

> 
> I'd be happy to send out a pull-request for either all of the patches,
> or just the MFD changes once I've had chance to review them.
> 

Great, thanks !

Neil
