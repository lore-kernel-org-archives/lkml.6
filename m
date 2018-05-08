Return-Path: <dave.hansen@intel.com>
X-Google-Smtp-Source: AB8JxZph+A7dqruj5TG28ssP9E9bbveOn0Z79xBbcOL0LyxWceAITBBRov6iZw67n2ZQcgm2aLrh
ARC-Seal: i=1; a=rsa-sha256; t=1525797007; cv=none;
        d=google.com; s=arc-20160816;
        b=WlwCO/UixTqT9AYMnrL62dBJw+lgfuUHKYDVMyQvDJ3D7if9AYHil0YneJF31wY0Hr
         eU8g4tJcpeifwNOd1QrOJrNPJ+pW/DNwaBclU3DHvXQ7Y8AsUFFX4XUoJeb3QycM1Y9d
         KxDq72qVAN0yPJl7rNb4StFmiBnA7oJSM8en5inaH4A1BSVoWbEARb7xCztIfyPhe4Wd
         qbrtI3FJz5PSi3Ynw60SwXxKC6HV9gQvuAoHY8PlONAXfzMaeA1bD7VaQ7OAqkMbISlq
         QTGwOutpwdSb+PnSX66b0Frl/VPXxR3F9q5n3zDAL00utyvalK57TFPrU3VLkp9kWiKh
         Vs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:openpgp:from:cc:references:to:subject
         :arc-authentication-results;
        bh=wGnwfO3FDAclkoHyuuNKwKho+KvoJOgzwAWnG7yKnrA=;
        b=K3Q38HMTsEc8AxgKw9VWDjRYy48XDJINTqsjS73stJh+iwZqhPTofGVnrlq7EPN01m
         z069OA4TFzSu/j5qPxJ/fo3ScEB33ZwGwUUjHLKNj9iYqOHZmK5Uh4P7bBa3hQJzYM8Z
         Coyvr1j+VjYexwIBdBVELm7EFYlZLveXbxg0arKOgCcaY80YipSsKwxJ0cArQq+ixzTK
         iUnwZVemjnnZb+sl17VYLxxYz9CH7giCP2Mm++rRudXd9PYz2fSI93+ngsRojW54H+i9
         uROm9gy7L4R+lF3fOGg56o0FOe5mMKBU/o9xRM/p8pE8dHU0WOVOMjBiOYSAU5fyRrJH
         bjNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39654549"
Subject: Re: [PATCH 2/2] tools/testing/selftests/x86: fix error: conflicting
 types for 'pkey_get|pkey_set'
To: Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1525770870-19067-2-git-send-email-lizhijian@cn.fujitsu.com>
Cc: mingo@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org,
 pombredanne@nexb.com, ebiederm@xmission.com, luto@kernel.org,
 linux-kernel@vger.kernel.org, philip.li@intel.com,
 leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <125eb810-1d48-394d-9665-40da64326fbb@intel.com>
Date: Tue, 8 May 2018 09:30:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525770870-19067-2-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734480796496?=
X-GMAIL-MSGID: =?utf-8?q?1599914122726463660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 02:14 AM, Li Zhijian wrote:
> -u32 pkey_get(int pkey, unsigned long flags)
> +u32 _pkey_get(int pkey, unsigned long flags)
>  {
>  	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
>  	u32 pkru = __rdpkru();
> @@ -422,7 +426,7 @@ u32 pkey_get(int pkey, unsigned long flags)
>  	return masked_pkru;
>  }

I'm not a huge fan of random underscores for undocumented reasons.  But,
oh well.

Acked-by: Dave Hansen <dave.hansen@intel.com>
