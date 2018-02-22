Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x224zonPQ1VHsws81Kr3ZEUvbmAiNb1LiZJY/acdG1dkMBmsCqTE0jMXdIWl3ocF0LKuKlbaC
ARC-Seal: i=1; a=rsa-sha256; t=1519320303; cv=none;
        d=google.com; s=arc-20160816;
        b=YlCkuht32SFnMZBPllts9STP2HU6EaTQVwZOZRtGfc5bt47cdvHpfy4EA/EJZCDVrp
         oXeyfpiZ0FxjNLeTgbApSJHB8TaX7dhUlb+kOzca6k7ngY/9adMhHPgcgtixlrNdVIbh
         rZQqTTdWwOvf6zMmBS/XnD7DVfDtc+DX5GCyhnX7yqWPy/+8Lk+ENQcrZQc0aSuR8bPS
         FX4AAQNfx/5rpvniAOxUVYYSs2IQo+hBEShzfKIFhAdfECiwXPikubFSqTqDU0RJxvEd
         duY2VKcWQor37W/mcqCyzjLv6HN2A+Ndk0dJ9yaFxCaO2XkV5E2XhY8nI68B+Ca2KdO3
         gYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=nkjxuQLWdlf3W7gw0nVuem6TjZg9bi5QFBIpSS5yf6k=;
        b=I2nByGmbQHTYtXHinqmXNtqFE2mNxXjmrX1BFcz3KLpSugsOG62A26GBEjpjvXtYn5
         EjUEHG9gohkJgJgieSed3wjif413OVowrFqXYcI95sF4sSwZaj7u7Aqd5FCdo28L3x2r
         w1m7PsUXwzt8GOQRC80ffLRcj5iRLZfrOFxWV6BNZ8/JQxE3RNFWJI9FHJ0bNocuhHN2
         b3LOyHxpUzm/yAJz1FCFY1qSnXlvmpKJCLqWIG/7ONCgiT/KAfRa2HgVHsz8AI12vl3P
         JJxa7fqEVKe2G36onFAEbiP6vi3xKU/MnowlL8+bJewP5ojFU9uogr5rbDGafRhgJ2g3
         mK6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="32800035"
Subject: Re: [RFC PATCH] drivers/peci: peci_match_id() can be static
To: fengguang.wu@intel.com
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
 gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
 benh@kernel.crashing.org, andrew@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180222070111.GA22310@lkp-ne02>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <f5f9afd0-a5ce-346f-772a-e8dec78bd872@linux.intel.com>
Date: Thu, 22 Feb 2018 09:25:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180222070111.GA22310@lkp-ne02>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593083616553853283?=
X-GMAIL-MSGID: =?utf-8?q?1593122806815391768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/21/2018 11:01 PM, kbuild test robot wrote:
> 
> Fixes: 99f5d2b99ecd ("drivers/peci: Add support for PECI bus driver core")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>   peci-core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/peci/peci-core.c b/drivers/peci/peci-core.c
> index d976c73..4709b8c 100644
> --- a/drivers/peci/peci-core.c
> +++ b/drivers/peci/peci-core.c
> @@ -770,8 +770,8 @@ peci_of_match_device(const struct of_device_id *matches,
>   }
>   #endif
>   
> -const struct peci_device_id *peci_match_id(const struct peci_device_id *id,
> -					   struct peci_client *client)
> +static const struct peci_device_id *peci_match_id(const struct peci_device_id *id,
> +						  struct peci_client *client)
>   {
>   	if (!(id && client))
>   		return NULL;
> 

Hi Fengguang,

Thanks a lot for the fix. I'll merge your patch in v3 submission.

BR,
Jae
