Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520419553; cv=none;
        d=google.com; s=arc-20160816;
        b=kDZR9Iv7k8lOrhjZTj9AgJYRzyzpTlP2hqdKPtE5nQJVvtHn+MzHoewiwiLPJWVzRt
         dHR6Wf0janvkAMMOpXmeLBuDboE9hJfKTx/AKJ19jVaLfJFyS4pjcuDIqSqDXMHmfHZ/
         ZQvBnuZirWSK7zK+Ht64/ZzljJhROEMsu4bfUeEiiX5pPnmqaRb4ppNPZryObAHPf96b
         FmTs+X0GvMPQex2DaiednrUd6VbFwbnnZBc0cHj6mx6Ng4C2FeKLlBZJUNDZK9LSwYLc
         lUK238kKYhcZqd1b3VxI1YoT7E/D8jYxpaNj5aAoXq0ShlGLpqeN1qpZU3n2wRpWTOTo
         7d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=2vXjIBHQ/xG3pLZtEBuLJIL2gZonK/zaKnBshAA1k64=;
        b=BCKZhcUKE9P4fXXiJBIaDwLoq1YYZGRU5ANtoh6EezmHgpSET13d8Av5iJ3fZQUKzG
         AcKdugBrOdbVSLHubv/mKYB0zW3ekE4URvx8K1Wi9hwauAvchQ6hjDTsD8Eit/2lQO6z
         C5Bw4/26CG88dkm900UcF9uVKOt5ylylkCwZNorNeY7AdKyO/HsZg1M0swod8UQ6YEkj
         kCJ4mOUNf8siduXL+UTlb2lWbl3ieo9U9uo0sYfMQFLiTWgWSr9xBROrxUmBuKcKEHch
         byjNW9m4dplml61Ia3lCuTAwUK4DL1PMt3/MaiJ/c/6mreu8JIuC+3kNgPx33rbmey9k
         qXjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HcW/y1wC;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HcW/y1wC;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtP9ppccwp853ik1nWeno5bFVAbJjqfGvDV/CwejEPTZNmrR7mRFvpIYfcMgrE5xzBTDuaQNg==
Subject: Re: [PATCH] slimbus: core: use put_device() instead of kfree()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, broonie@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <9d7f5ca30baa3a336b145a96a631a8c093f54d8b.1520418001.git.arvind.yadav.cs@gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <55c2399e-3136-4a90-26ac-0ebcb2918a15@linaro.org>
Date: Wed, 7 Mar 2018 10:45:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <9d7f5ca30baa3a336b145a96a631a8c093f54d8b.1520418001.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594274042806495005?=
X-GMAIL-MSGID: =?utf-8?q?1594275453373741986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/03/18 10:22, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/slimbus/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Looks good for me,

Will queue it up.

> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 4988a8f..7ddfc67 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -141,7 +141,7 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
>   	sbdev->e_addr = *eaddr;
>   	ret = slim_add_device(ctrl, sbdev, node);
>   	if (ret) {
> -		kfree(sbdev);
> +		put_device(&sbdev->dev);
>   		return NULL;
>   	}
>   
> 

thanks,
srini
