Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659BBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E0F24805
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ugBu4LZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E0F24805
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeGCM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:27:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33854 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeGCM1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:27:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so1790263wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ldC5P7njACjAGpU1TBHpK/e8MVvVmPN7LyLSGiGYAcY=;
        b=ugBu4LZNEgd1ME5ETJVrEl+T0toX9MZ6HhIbOjEfmFx8k4RtS4StFF565z8/Lwg59t
         7xEOhXYKAocvgIcwwibqX3nOcr4sJ6ma2fp8Ipr0UDp4qRPwX6/1+ixQus348JrTM9sm
         6nBrBfZKlLbbY6u4JoAuMNUJA54gexTS1IaUIiZMA5otbGDej8rxic3aWNZRkgE3ix22
         b2jciDhwwtHMiD0NYb0wJFxTzqTJBuHab2oQmMpx+tDXxRr2Y6kqQIRbrJHg6nkQQd7x
         p9PwnCRxXd282EEC8gwdnBF1XaWaMxFCeurkRaQ71lSFk60GwdsXNJNu2xdI0c2fL2XO
         rIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ldC5P7njACjAGpU1TBHpK/e8MVvVmPN7LyLSGiGYAcY=;
        b=RgY/ROsCufFoyzKw1jQbuUYpy0pMdR3D30hKX4vgrAD6wt8b7xeOpxoeRuXEV2SGdn
         ZfCJ0NM7uwkpHe6WB2QiukRszCkACtiEPrvZxgjP7FQkZmB7Ul/WuqECmi1bwYVhnp8n
         izIelCwOlMk9ZBz+9YL16DWvEjdVpLtxp0Kulfbe+4o1qBwmY2Mdealqsm07H7XT3DJV
         45LYRtBLfEIUb6d+PhdXnXJfBhpSy/sANfSZDVihBR/EVL34Ws3Tsxr14DbHlHBdg6l1
         IGJtZDoTYQY+wRe0ZHM6OSa5IuO7/RH4RJz505hD23bkCp9viqtiURdfp+vzhHPsQOQ2
         m0Tw==
X-Gm-Message-State: APt69E3RoClh6d6kXQb8K7X4ECiLMqqt+uiqo+DrbaMw5D0shvo0hA+z
        312TucNIax5tp/6Q7F9vRTqNRg==
X-Google-Smtp-Source: AAOMgpf+e431bUaF3D+tRHNaPIVCPQh5I+PJ6zociTRGcgT6ETIJvU5ppG5Nc8b4a9+1oKS9u6xDyA==
X-Received: by 2002:adf:8712:: with SMTP id a18-v6mr1631864wra.178.1530620851724;
        Tue, 03 Jul 2018 05:27:31 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n16-v6sm1785379wrg.58.2018.07.03.05.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 05:27:30 -0700 (PDT)
Subject: Re: [PATCH v7 3/6] mfd: cros-ec: Increase maximum mkbp event size
To:     Lee Jones <lee.jones@linaro.org>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        Stefan Adolfsson <sadolfsson@chromium.org>
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <1527841154-24832-4-git-send-email-narmstrong@baylibre.com>
 <20180618074443.GK31141@dell>
 <017e4688-4036-e606-7220-2e472afa0aac@baylibre.com>
 <20180703094344.GR20176@dell>
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
Message-ID: <b3ff9ca1-6961-9f06-9886-fedcd3431d0a@baylibre.com>
Date:   Tue, 3 Jul 2018 14:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703094344.GR20176@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 03/07/2018 11:43, Lee Jones wrote:
> On Mon, 18 Jun 2018, Neil Armstrong wrote:
> 
>> Hi Lee,
>>
>> On 18/06/2018 09:44, Lee Jones wrote:
>>> On Fri, 01 Jun 2018, Neil Armstrong wrote:
>>>
>>>> Having a 16 byte mkbp event size makes it possible to send CEC
>>>> messages from the EC to the AP directly inside the mkbp event
>>>> instead of first doing a notification and then a read.
>>>>
>>>> Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>  drivers/platform/chrome/cros_ec_proto.c | 40 +++++++++++++++++++++++++--------
>>>>  include/linux/mfd/cros_ec.h             |  2 +-
>>>>  include/linux/mfd/cros_ec_commands.h    | 19 ++++++++++++++++
>>>>  3 files changed, 51 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>>>> index e7bbdf9..c4f6c44 100644
>>>> --- a/drivers/platform/chrome/cros_ec_proto.c
>>>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>>>> @@ -504,10 +504,31 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>>>  }
>>>>  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
>>>>  
>>>> +static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>>>> +			       struct cros_ec_command *msg,
>>>> +			       int version, uint32_t size)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	msg->version = version;
>>>> +	msg->command = EC_CMD_GET_NEXT_EVENT;
>>>> +	msg->insize = size;
>>>> +	msg->outsize = 0;
>>>> +
>>>> +	ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>> +	if (ret > 0) {
>>>> +		ec_dev->event_size = ret - 1;
>>>> +		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static int get_next_event(struct cros_ec_device *ec_dev)
>>>>  {
>>>>  	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
>>>>  	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
>>>> +	static int cmd_version = 1;
>>>>  	int ret;
>>>>  
>>>>  	if (ec_dev->suspended) {
>>>> @@ -515,18 +536,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
>>>>  		return -EHOSTDOWN;
>>>>  	}
>>>>  
>>>> -	msg->version = 0;
>>>> -	msg->command = EC_CMD_GET_NEXT_EVENT;
>>>> -	msg->insize = sizeof(ec_dev->event_data);
>>>> -	msg->outsize = 0;
>>>> +	if (cmd_version == 1) {
>>>> +		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
>>>> +				sizeof(struct ec_response_get_next_event_v1));
>>>> +		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
>>>> +			return ret;
>>>>  
>>>> -	ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>> -	if (ret > 0) {
>>>> -		ec_dev->event_size = ret - 1;
>>>> -		memcpy(&ec_dev->event_data, msg->data,
>>>> -		       sizeof(ec_dev->event_data));
>>>> +		/* Fallback to version 0 for future send attempts */
>>>> +		cmd_version = 0;
>>>>  	}
>>>>  
>>>> +	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
>>>> +				  sizeof(struct ec_response_get_next_event));
>>>> +
>>>>  	return ret;
>>>>  }
>>>>  
>>>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>>>> index f36125e..32caef3 100644
>>>> --- a/include/linux/mfd/cros_ec.h
>>>> +++ b/include/linux/mfd/cros_ec.h
>>>> @@ -147,7 +147,7 @@ struct cros_ec_device {
>>>>  	bool mkbp_event_supported;
>>>>  	struct blocking_notifier_head event_notifier;
>>>>  
>>>> -	struct ec_response_get_next_event event_data;
>>>> +	struct ec_response_get_next_event_v1 event_data;
>>>>  	int event_size;
>>>>  	u32 host_event_wake_mask;
>>>>  };
>>>> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
>>>> index f2edd99..cc0768e 100644
>>>> --- a/include/linux/mfd/cros_ec_commands.h
>>>> +++ b/include/linux/mfd/cros_ec_commands.h
>>>> @@ -2093,12 +2093,31 @@ union ec_response_get_next_data {
>>>>  	uint32_t   sysrq;
>>>>  } __packed;
>>>>  
>>>> +union ec_response_get_next_data_v1 {
>>>> +	uint8_t   key_matrix[16];
>>>> +
>>>> +	/* Unaligned */
>>>
>>> That's funny!
>>>
>>>> +	uint32_t  host_event;
>>>> +
>>>> +	uint32_t   buttons;
>>>> +	uint32_t   switches;
>>>> +	uint32_t   sysrq;
>>>> +	uint32_t   cec_events;
>>>> +	uint8_t    cec_message[16];
>>>
>>> Since there are some whitespace alignment issues in here.
> 
> Fix the white space issues.

Ok

> 
>>>> +} __packed;
>>>
>>> How come these guys have kerneldoc headers?
> 
> Consider using kerneldoc headers (not required for this patch).

I already used kerneldoc for the other patch as requested by Enric.

> 
>> Can you explicit what should be changed here ?
> 
> -^

Ok

Thanks,
Neil

> 
>>>>  struct ec_response_get_next_event {
>>>>  	uint8_t event_type;
>>>>  	/* Followed by event data if any */
>>>>  	union ec_response_get_next_data data;
>>>>  } __packed;
>>>>  
>>>> +struct ec_response_get_next_event_v1 {
>>>> +	uint8_t event_type;
>>>> +	/* Followed by event data if any */
>>>> +	union ec_response_get_next_data_v1 data;
>>>> +} __packed;
>>>> +
>>>>  /* Bit indices for buttons and switches.*/
>>>>  /* Buttons */
>>>>  #define EC_MKBP_POWER_BUTTON	0
>>>
>>
> 

