Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520001571; cv=none;
        d=google.com; s=arc-20160816;
        b=wLlT1RK+wuWMaRKsRzBt/M2fNQftri7uFKwsy4YmUdZfzz/vdYzT3BEaMxPMjZWnN4
         nZavvQTsvRmvV+fAmIjq4Z9Wv+WOHzboEv9n8C9WkMSvWoMYdW2WEOF/pQrnL8s3B7F7
         QMFAwJrqSERCMcWVXZ5gCbpW4O+pxxyZxthxMlTsR43JFnGkIJTu9n3FdotN2o6YhOzp
         nkM5zNORAOtFytOeUo+Ggl5OubUpVK4hQgjN7AE1v57Z90BBKvt5gyMdp2Ycu3nXl6fD
         8QiyXNEqq7j13c4MIye6Kdu1IDJICh9eS7t94+GTEshcLm0rV896FhWr6dAfkDQWw6r8
         bxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=/tvyef9u9h4cFj9mJgLmj+vwzsfaRavuUjQuGMMd3Og=;
        b=mJf/jEa8vhG9oXD/rPg8OeRE87gfXR2G22XMUpds9ukVEQDrBwWE1BvFZTC3peCOKU
         9Wp5TgTi6rnKDGvSkvvaS289jWa/g6RKV3mbNx7puTGKR9kJ4LfoIQIO7N3izALhfYxB
         KXNYGOZM5CMwNK2MuAQd2ZpJzNTgp2QkIxO/QlBuvBGdhoFEtXke5ZpstDqniXVNj/DK
         eY9gn1MdThpIlcSdHCyJJqFsX8f/Bqva/wSU2CAVA23a88r5PFhSspjl8HvbKafLNo/m
         WZA9e8OP+wkKQOpKw4EXTe8grUrJkMF/bpssU7Uo+KiRMmdmh+AUN0Mv9INR78L798Co
         0qqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OOUelweo;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OOUelweo;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AG47ELvHoD24HY6MDFhq+ATFAULVDVE9Ru/v1EVUOsAMyEvhxDmM+8ME0aKadcHPRnID4wDF+IHchQ==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: use ARRAY_SIZE for poweroff_functions array sizing
 calculation
To: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 openipmi-developer@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180302141451.656-1-colin.king@canonical.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <73ab71b3-a2dd-1aa9-4c4c-57b761c6cdab@acm.org>
Date: Fri, 2 Mar 2018 08:39:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302141451.656-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593835618533277959?=
X-GMAIL-MSGID: =?utf-8?q?1593837168483726962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 08:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Use the ARRAY_SIZE macro on a array poweroff_functions to determine
> size of the array. Improvement suggested by Coccinelle.

Queued for next release.  Thanks!

-corey

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/char/ipmi/ipmi_poweroff.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
> index 07fa366bc8f0..fccb1e9fd3b7 100644
> --- a/drivers/char/ipmi/ipmi_poweroff.c
> +++ b/drivers/char/ipmi/ipmi_poweroff.c
> @@ -519,8 +519,7 @@ static struct poweroff_function poweroff_functions[] = {
>   	  .detect		= ipmi_chassis_detect,
>   	  .poweroff_func	= ipmi_poweroff_chassis },
>   };
> -#define NUM_PO_FUNCS (sizeof(poweroff_functions) \
> -		      / sizeof(struct poweroff_function))
> +#define NUM_PO_FUNCS ARRAY_SIZE(poweroff_functions)
>   
>   
>   /* Called on a powerdown request. */
