Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2641146-1524125924-2-3440969787609727826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524125924; b=H+sIbnUEkSa6XC3faxwd5vh/TcUyi59nzx3/fSNK57SoI1l7/0
    cwu7j/EiPNyaRZRfh5t++Sf5Bm6EcZenxZDFUnno0f5VcmGqBOKMrVna6KiyRJ1L
    lKVAS0v/ICAw+otx2QRJOVfCeGAYoRLt2pnvaNDoQaT+hH4h9IXRnHRKkpwNABOp
    KVKoKwE7Lfb9QsMDXqgKuEtlr9N55g/S3Yn7sK2XiBl7MfYHW9EHQjW7THdID77m
    oKnFp/qowMlqeCdIdcYJIK1VF5a7tacO/h7FNgVhzHqOGmoEY4J7yvN47x5xvGAG
    IlEAUjpJuJO1OZyA7VH46//aAuZaDPOXH9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524125924;
    bh=Wj+AXSb+Hy5IOVZLfzCrfnVEEfnee4ezfrbV1wZzoXA=; b=ZQeiN7RRi22t
    przIZStPNGC2PyRK80GUYF7pCBikrR+q6CLQnJ/2cYbG/GcMujdc40nplfsSTEjE
    xIpjScISoMcyWGQoWXxonrKcZlwoRzS4p+CFMreRL2Xemx6Cj/tclYc8B4LibbhQ
    q9vOoWqsssz1yBRVa06JWVDYBFyOmhSpnLB/MGhihDokvnKXCBjObLadqNfEz/mV
    BkkAxE9f25GRrqrQhWnXO8MLxZ5xH2wG5ri+4diIpOObcDj6tz42RKsHvfoZmz+C
    K0+0xPJUHAty/D6gDLhOwNuBZ3HzJ1GEkYMDZqey3B/e67n3Q5hsA5Tt04/pfuaO
    gEWc3cQx+g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b=T0zBJwP6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XlmD/vC2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=baylibre.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b=T0zBJwP6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XlmD/vC2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=baylibre.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3eHs2u5FMlxyexWTjMTki4GPVW6LP8ujwk02LDkuZyBSEsO0WSyEH5KyHavDkN4QGqBsi6D+QSavTuZkOysZwB7Y/m3nCAL1Lg/buHJTdPk+meGN8T
    l5hOVPgcECRrps/FmKZ7FVVWiq+xz0QztVKWjUxYu9+E3rim9gUgs9vSf0FUdteDDx+0QLrFtVVZeEeFbV5zEAQ5cVwExtKdnMOoo+yyn3lbDMJhL3w2GFbl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=IpJZQVW2AAAA:8 a=EvhnAcxuyhhUQ_BxumYA:9 a=QEXdDO2ut3YA:10
    a=IawgGOuG5U0WyFbmm1f5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeDSISl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 04:18:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45231 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeDSISi (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 04:18:38 -0400
X-Google-Smtp-Source: AIpwx4+v6t5Tiy8GT1hBtHvJAp0iUdFLl0Ghsd6rN4AWkTohigHZOmpGFp60ZKNs5qYdkB+yKrytkg==
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic
 Meson GX SoCs
To: stable@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
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
Message-ID: <3b17d17b-cf3d-be54-2462-191e4f2af653@baylibre.com>
Date: Thu, 19 Apr 2018 10:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 23/02/2018 12:44, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
> identified needing this workaround.
> This patch adds the corresponding version to enable a single iteration for
> this specific version.
> 
> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This patch is now present in linux master as commit 9c305eb442f3b371fc722ade827bbf673514123e
Could it be selected for 4.14 ?
The patch has been reworked to apply for 4.17 as indicated in the commit log, but the original patch will apply over 4.14.

Thanks,
Neil

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a38db40..f5018f9 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1637,6 +1637,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
>  	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
>  	 * 4 and 1 iterations respectively.
> +	 * The Amlogic Meson GX SoCs (v2.01a) have been identifies as needing
> +	 * the workaround with a single iteration.
>  	 */
>  
>  	switch (hdmi->version) {
> @@ -1644,6 +1646,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  		count = 4;
>  		break;
>  	case 0x131a:
> +	case 0x201a:
>  		count = 1;
>  		break;
>  	default:
> 
