Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50494C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1459C21477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MBB2AOC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1459C21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJDTWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:22:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34185 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:22:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so1463614wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B5186SVMAOQUdhXc9tjjtbQH53inOiu9dfjeHDeBOl4=;
        b=MBB2AOC1lyQD/xK65c3sPaWZmjRi8wmOhaoPRUm+COOrlX3g7oKOF/kdwtIpm5BoWf
         /V8eMACExBKpUGQWR7UxmGbjzh+OPfHphEa1+MbUaKroxnFYqNatpfckujq91dYj1PAO
         0yMhT1G5kQsWw/1VCTs5y2UdUAFyflHs53WAKsnQCPT5GIUOuUURrR3UlCe+ekvb2M4o
         +Uh/FUXLAcIv1u0Nn6GwXN3Zznq7ZvDSA7gHhJa05pREmHvd6BHtDmf3cimK7MRbY/Ls
         5ABX0JBhHn05T0en+Sj/JPcHoeHFoD79XPSq+4AEScIy1UwMxPhi9bPihH1lm+OBTG2F
         hLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B5186SVMAOQUdhXc9tjjtbQH53inOiu9dfjeHDeBOl4=;
        b=hnNfzL8/JwqvnrC9y7b/mbOGsdjZXOC5xJL6wIEBOQ3lhlacAnfRFRmLcpA+4ucY4N
         jK1Mp6jenfSWsusYauZGq2lhjOQ76AtzK9dPL44GhbuEenjAWIZSOEts+MvS4wW/F1GQ
         qmtB0/wwQCjotDzHc5Oej9N9Gqqp0vHpqc35Y0e2cWiXTo49/sWmtAOSDLmC0u3pRYbG
         H89QCwpVN3/CJABz13T2CWvAiwarMYv1uDeFaFyRq9NG0uxrbkxAhUK/GC3WDCSfDIvm
         yqoKASw/7P+6CNyQukb4S2vuzFqfmq82unap6WlCqkhyVkDaifjeL5xCeGWMzlQkjM0B
         ZlyQ==
X-Gm-Message-State: ABuFfog6UKmzr1Itls+c9BQvQlgJ+Rc3LsC7qVMYP3jju5sW7DNpVwE9
        w4b0YFrvjp2PwXpH2xGrsyb86Q==
X-Google-Smtp-Source: ACcGV62AFmu7GPeIKO64IySoml22rg16sZMG4Y6EDCNzHPorOdToOTDSw0cBhXVcW7tkQZ/6x9+UsQ==
X-Received: by 2002:a1c:a696:: with SMTP id p144-v6mr4643599wme.14.1538656175325;
        Thu, 04 Oct 2018 05:29:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:eeb6:4690:3412:2a4:3cc3:ee11? ([2a01:e34:eeb6:4690:3412:2a4:3cc3:ee11])
        by smtp.gmail.com with ESMTPSA id s10-v6sm6875984wmd.22.2018.10.04.05.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 05:29:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add SECO Boards CEC device driver
To:     ektor5 <ek5.chimenti@gmail.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <cover.1538474121.git.ek5.chimenti@gmail.com>
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
Message-ID: <757ab7a8-4bb2-4573-5870-eae2b9745650@baylibre.com>
Date:   Thu, 4 Oct 2018 14:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1538474121.git.ek5.chimenti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ettore,

On 02/10/2018 18:59, ektor5 wrote:
> This series of patches aims to add CEC functionalities to SECO
> devices, in particular UDOO X86.
> 
> The communication is achieved via Braswell SMBus (i2c-i801) to the
> onboard STM32 microcontroller that handles the CEC signals. The driver
> use direct access to the PCI addresses, due to the limitations of the
> specific driver in presence of ACPI calls.
> 
> The basic functionalities are tested with success with cec-ctl and
> cec-compliance.

Glad to see another user of the i915 cec notifier !

Neil

> 
> Ettore Chimenti (2):
>   media: add SECO cec driver
>   seco-cec: add Consumer-IR support
> 
>  MAINTAINERS                                |   6 +
>  drivers/media/platform/Kconfig             |  21 +
>  drivers/media/platform/Makefile            |   4 +
>  drivers/media/platform/seco-cec/Makefile   |   1 +
>  drivers/media/platform/seco-cec/seco-cec.c | 859 +++++++++++++++++++++
>  drivers/media/platform/seco-cec/seco-cec.h | 143 ++++
>  6 files changed, 1034 insertions(+)
>  create mode 100644 drivers/media/platform/seco-cec/Makefile
>  create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
>  create mode 100644 drivers/media/platform/seco-cec/seco-cec.h
> 

