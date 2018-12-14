Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3114C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9592070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayx5q1qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeLNQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:03:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLNQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:03:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so6295835wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HAYuWYHNhSxPwB8i0BlEZdpwdpE50WfswWl+kgBHlnk=;
        b=ayx5q1qjVp1zmcuO9cPqDt/KIbRqgYH2D7bx6i8o04c7YSeIsy0cdojbwEwrMQQlAI
         e8ZldQ8eGx1t+FPrZYv7fkQ5d7MV9dWgmgbiN7pnHTyOm9TdUsvuilK+252zlqXo3O7G
         mxNJ1jsXTxCjiyk5gXHWqyDhlbAFTK4fva5hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HAYuWYHNhSxPwB8i0BlEZdpwdpE50WfswWl+kgBHlnk=;
        b=WSbDuaF73+NW3NIAgz5g+q0ltqItiT7fdpLt+kpu5M/GxwLtFjVAwhnPS7bd1zETpp
         Yrde3CD/AMu+VCSk1fA9S4V2JckEIiJg5rEk/rQbgs5POBtYpFgKK/WsX97dbpA69RcP
         nWjHbOkojaPlk4f4Q1xsOO7GySKk2cW5yYuVSDXhSsP2NeHGoOc4o13AAOcf1xNYjgZa
         2Y6hMoIodYv4S0Kn76/imaXHgqO+XzDWYnQi1xTAjEMzx9p2DhshgUCGjcgBrmYC7N8o
         Nw8YPG4Eas3SKTna96T88aAq2k8X3qnOQ4hB/N/ErBxC8F29iV0Esa5SBXx6qhIsFa+g
         GVPw==
X-Gm-Message-State: AA+aEWbQaA5uVLnLcALqdmXLYiK2OVD84T7TSiw6Jbx5liVyOs6WWkIx
        fG1Akg5DF7eEjbCnwhDjXbr30g==
X-Google-Smtp-Source: AFSGD/XcTHN6XaGkXFo/YoHob/yYgzGsJu6lXwprcISjuXiQNU+puPA9GL9MR+IYLRBIea3FyzT+DQ==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr3994758wmg.13.1544803435165;
        Fri, 14 Dec 2018 08:03:55 -0800 (PST)
Received: from [192.168.1.2] (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id j202sm9398739wmf.15.2018.12.14.08.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 08:03:54 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <1b4cdda0-9ffb-52b8-6a13-be9eb079bab5@linaro.org>
Date:   Fri, 14 Dec 2018 17:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 16:52, Joe Perches wrote:

>
> A couple variants have been documented and only
> one should actually be used.
>
> $ git grep -i co-developed-by Documentation/process/
> Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
> Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
> Documentation/process/submitting-patches.rst:A Co-Developed-by: states that the patch was also created by another developer
>
> $ git log --grep="co-developed-by:" -i | \
>    grep -ohiP "co-developed-by:" | sort | uniq -c | sort -rn
>       80 Co-developed-by:
>       40 Co-Developed-by:
>
> So which should it be?
>
> btw: I prefer neither as I think Signed-off-by: is sufficient

IMO neither is only an option if you comfortable with the script 
generating false warnings.

If you wont apply the patch anyway I wont pursue it further.
Otherwise please let me know I will also update the documentation to 
match the commit.

TIA


> .
>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -468,6 +468,7 @@ our $logFunctions = qr{(?x:
>>   
>>   our $signature_tags = qr{(?xi:
>>   	Signed-off-by:|
>> +	Co-Developed-by:|
>>   	Acked-by:|
>>   	Tested-by:|
>>   	Reviewed-by:|
>

