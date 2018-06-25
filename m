Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B447C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB56425700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCacVio0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB56425700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755012AbeFYJrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:47:47 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34569 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754632AbeFYJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:47:45 -0400
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so7487520vkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p28S+3O3IU5zBFNjNfvagvG7+EPZifgLSU4gxg5Y9WE=;
        b=kCacVio0KVe3JHK3wLnkFmdCwNSTmVuSUiYbpjUM8kkqe3ET8QqCQrRtxfcj4fJPxW
         cyEMiSepipr82ZJJl5BJ+2gJX0weMJBQPIrkcrw6bBlEj4lyHHIBmFuayOC2HCSxp5tW
         CkPxRePysZITTDCbdO7qlrXABiE5YdsU1myRtib2PWbQyMoTYvAJ0dGG1AGtxXtKBkmm
         8HW2zpaDh7LHOrZ/qo1JllVbVAAPS1C21v+OA7tKpiqVu9rEe5fo3vZ5CS9VFC/XISaA
         5czz6PIJ0Cm+D3ILjadDtp+fqLr9DU+k64utCptIZx8XTvQGE0p8N8kK31jcQv77Dmux
         tW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p28S+3O3IU5zBFNjNfvagvG7+EPZifgLSU4gxg5Y9WE=;
        b=sMcucMeTzZs5WIG6I5oaJ4NKiiCUPVcI4fesajzGBZQuz6E74ZKZ1HPw0l8C//MZa4
         f2rPErf1MqZ8D2eHp+6g56/bq359sYY8adUUzeW1+aWlbeRUQQDkUMjIkijvwBrzEws1
         HG2YKcZD8RGZTZbM/Q+31IS4YAIGD73OtCBLpnQjlzcCL27MtM5hIxAlSJ0mrMa+CDTY
         UOUycmzd/wPDmJ6vqjP0Q6lJq75pH3DTmfZZAAmn/OHwQS3UTozIi1vdW89PDwKm5ZjO
         IA/hVx9bokW5w68+XREF8Am5hAH/bWwMorjbm81pVKPSOQI6WfAMUufgzV497tlFAk9H
         E5Zw==
X-Gm-Message-State: APt69E3X4lrDQbhk3v4d50fpz0PoduLG5vh7QkUQvZLl8SzXw1IJdRkG
        hPSxa9Zx9yCUAs3DFo/vluo6wWGae31Z79kKQiE=
X-Google-Smtp-Source: ADUXVKLpO6dQS0OBxtD2Hy7Ti2A1yuZ2MK/KDOmoT8KKyTcgjCx7Dum8HKiSIu2rqfq/7exsFlGDPjk2lDfgdDetac4=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr6904663vkd.15.1529920064976;
 Mon, 25 Jun 2018 02:47:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:47:44
 -0700 (PDT)
In-Reply-To: <20180622102800.4p6wabmte4yf4rtp@mwanda>
References: <20180621182155.27769-1-michael.straube@posteo.de> <20180622102800.4p6wabmte4yf4rtp@mwanda>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jun 2018 12:47:44 +0300
Message-ID: <CAHp75VeASBAsBrrq65qhkAGXHoSE8Hg-9dSGcgjT2bNND-1MBw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix brace coding style issues
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Michael Straube <michael.straube@posteo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 1:28 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Thu, Jun 21, 2018 at 08:21:55PM +0200, Michael Straube wrote:
>> Remove braces from single line if statements.
>> Also fix a comparsion to NULL in one of the conditions.
>> Issues found by checkpatch.
>>
>> Signed-off-by: Michael Straube <michael.straube@posteo.de>
>> ---
>>  drivers/staging/rtl8723bs/core/rtw_debug.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
>> index f852fde47350..2244ed72ab9c 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
>> @@ -618,9 +618,8 @@ ssize_t proc_set_wait_hiq_empty(struct file *file, const char __user *buffer, si
>>       if (count < 1)
>>               return -EFAULT;
>>
>> -     if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
>> +     if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
>>               sscanf(tmp, "%u", &g_wait_hiq_empty);
>> -     }
>
>
> The original code is kind of bad.  The NULL check isn't required.
> The sscanf call should have error checking.  The error code is wrong if
> the copy from user fails.  The tmp buffer isn't NUL terminated.
>
>         if (copy_from_user(tmp, buffer, sizeof(tmp)))
>                 return -EFAULT;
>         tmp[sizeof(tmp) - 1] = '\0';
>
>         if (sscanf(tmp, "%u", &g_wait_hiq_empty) != 1)
>                 return -EINVAL;
>
>         return count;

Shouldn't this be

kstrtouint_from_user()

instead of all those lines?

-- 
With Best Regards,
Andy Shevchenko
