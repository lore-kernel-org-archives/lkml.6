Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615B7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1939A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dpgolzdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1939A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeIYBLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:11:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41725 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeIYBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:11:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so16717727wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3J4CVQHO9HWtG82mk+W/eGOS3TcgtxFosGmKY1xcdkE=;
        b=dpgolzdR5Y1LamRylYbalf3VQjtt3zb7VQih8WPHNCiDTAy/TEjEHyqbmrG9m1akPz
         1FBAOryHIpflg1Al6LR+jbR+oMsGuS6yNPC2HtbjMrzBTm36msSFVyLxc+U9R8BfUrQd
         VazSQTR4hoL6CXhVxcsy2ngSyWXeVCH1agfyTgXsAQPZgn7Rk0IBr02cRKphQKkVHfcR
         MrPGCGBTk6sCfWdyrFUigT2YtNrCxDKmg+omijmS8KaD2xddeqGiQ3Mf5pmUJZ31kSdU
         2NHRWp2Jv8vffhpcwVk+Mst64woxrQR9qyGvrpudje4TUV/xPiloldmLHUcQ2FsdjzIC
         AcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3J4CVQHO9HWtG82mk+W/eGOS3TcgtxFosGmKY1xcdkE=;
        b=hgM2LUL5UywgVGidIpyXmhnXmrtLpOMrQMQb2HkBAmUd7uX/0xCh89GBCeJ5brt/LJ
         Xdqr19k97q26ASCX2v+0+TotLDKlcbVqNk8c/9UfHCYLIZCKG/ehTFz1hsiZF7lsvl9K
         CP0+WiYcUzzmTAgsTQviA6pHyXNgjJgviVCEiy6edO9EXFDCJpy54thQK4kYN5mW+QWz
         AeyBtvQsC1QG01j5A0DeOoflckKZ/8WM5n1MqcNB0+yhOpPdLzm2uAfn7hSeAxNZTeEr
         6opUAYBronipgbUjSaU2zYnFiHPOY6PTuqEvKDt4WsRRhi88ablpR5kEWMYZqFoKeSOa
         UmpA==
X-Gm-Message-State: ABuFfoiLxzdldYLUx/VUgSll54l8sxuo+0hRao9cI2jahPrqb+nGVh1L
        pnbkrX1rSpVVlB6j0ibsOqUeVQ==
X-Google-Smtp-Source: ACcGV61jy3RZ2Ajd2v8y1CLb8EL4jyPXFn7VX39am4EpP6XbbC7qVzhwfrw2etLB8gdsqZEcm5ljjA==
X-Received: by 2002:adf:df8b:: with SMTP id z11-v6mr130310wrl.113.1537816088050;
        Mon, 24 Sep 2018 12:08:08 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6? ([2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6])
        by smtp.gmail.com with ESMTPSA id z4-v6sm61114wrt.89.2018.09.24.12.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:08:07 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
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
Message-ID: <b87baa02-66e7-b855-478a-6d0bb4d39bad@baylibre.com>
Date:   Mon, 24 Sep 2018 21:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
