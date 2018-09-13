Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F488C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6320881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qRUW0Qw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeIMMM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:12:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeIMMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:12:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so4417964wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=75lCwH85uVeHIPlcKVoaAZ/VCZfT8czEjOHH+ptJzCM=;
        b=qRUW0Qw7kiIC9PNbc35kXPCF6ki1mEZidG3uIBXY5COsJQu3G2um3PCBpXBWOveUGp
         S95ujGJwFKRYMuwtihNccmvHy+UkMIP5qhUYcN/pUv9GN74rEEqbdI68UN00rK7HIe/S
         bDGhqe/ikMSgBin41aCv9kw+m742zHzUVlj0SKEGskg+ALt0bwmN0Z6ZcYabN6VTPnL4
         xPR/T28EDfPsnjp3ghGKE7uLANShuGq2XG4cX5G/SP7yOKu3VBKMrkzcZu3cHE4UOPkZ
         srw5JT4lghVlZCbEYa7d0hsSHog+gazFk2/uJYh19WuLdUHdTYNRA9H9wPxjJdlwKsyq
         a/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=75lCwH85uVeHIPlcKVoaAZ/VCZfT8czEjOHH+ptJzCM=;
        b=YdUETb4qtLEa5maKZQdPIQM5prlwNSDewcabckxPyN/wPLBI4eWli0Rca9GcEMk7Ta
         QAZ58CzcLqWnkjtiaCV+mrzNisKSSu9LuHDFjPEhk2wE4xVGndInhfa4GsAXGXx2fMYr
         QR3UCCHlooZDtPCU8RTIruXdOll2UYiPDjvH492Q5isw9q0bnU3Lb+qr6XopVBpjcLKZ
         2zU/BedY6WV6tx/mPRRISCSJhoBzB+ZcA7nwND35FLanHDntobFUN5Rz4rTO/WSkVeWY
         kPSP9Ua8mBJzuYTo9qpfuh1f+QHT9mm6F+Hdogl+wWOMQ3+F/fSi+BD32ue9mv+sp3M0
         FM7w==
X-Gm-Message-State: APzg51B+QQZ7+sQHEJXzZcyAg3juGSQLqGFuFbCubVb90cDzbBBPMC08
        6NIzONQTIUNhnD7nVZfPaG7B3nC92R8=
X-Google-Smtp-Source: ANB0VdaziT5qeS+m8HqZI8UjYi8BKWxp0BiHT6rr2jOVzpz3j6cpUlLjkb3Vmj+AySka8Yaq/uVz2Q==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr3934914wrj.62.1536822287114;
        Thu, 13 Sep 2018 00:04:47 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k63-v6sm5364730wmd.46.2018.09.13.00.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 00:04:46 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
 <7hh8iuxd1y.fsf@baylibre.com>
 <CAOi56cVESykxXg4zcdLh89Rpyiyg587XCkvFG55FnMSro4vH2w@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
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
Message-ID: <fa3fd18a-88a0-7dbf-c5dd-441cfad5459a@baylibre.com>
Date:   Thu, 13 Sep 2018 09:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOi56cVESykxXg4zcdLh89Rpyiyg587XCkvFG55FnMSro4vH2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 13/09/2018 06:20, Kevin Hilman wrote:
> On Wed, Sep 12, 2018 at 8:59 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> The order between "syscon" and "simple-mfd" is important because in these
>>> particular cases, the node needs to be first a "simple-mfd" to expose
>>> it's sub-nodes, and later on a "syscon" to permit other nodes to access
>>> this register space through the "syscon" mechanism.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Applied to v4.20/dt64,
>>
> 
> I spoke too soon, this doesn't apply cleanly on top of Jeromes
> reorder/cleanup.  Please respin/resend.

I'll respin.

Neil

> 
> Kevin
> 

