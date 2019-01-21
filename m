Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C249C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDCD2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0nUlnWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfAUR4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:56:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34182 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAUR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:56:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so16246767otk.1;
        Mon, 21 Jan 2019 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N5ORT1moJ+Q4gnZWt32YMbzEaVtAY9l8Tw9HeuDKizw=;
        b=m0nUlnWJ3hATHYnv5CtX98W5N7jmyo5rnNlAUEFz/SYwS6LgKhCIV5AvOPVYrtX7S0
         GUoXVZgmNeVcsLaTARsIdTKe/0m+b/0TM7JbyW4gzT8J62m5uDsZEPlS6v5Qk/Rl1nvd
         JvC6lCKaOVyf7UK5Dt/lbGDJ147VLOe4fkbBcpBWNHQY0bMjx+M4KOPZffcXx2ZJCCrj
         Sg6FiUC0xMccW1pADqD/8NQqHQ6Y95/faiTOnNQGbwjYruYxW6l6nibNXIBo5aZSILnU
         znZYOQjDIVGBHDSgk4Vtb9r0fs7FOObaSqI2LPQFuli+0kgEh/ZYsfWWdS/VLo83WOkq
         CTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N5ORT1moJ+Q4gnZWt32YMbzEaVtAY9l8Tw9HeuDKizw=;
        b=Ij3bPjAF30XkSOwy8Ssq0geeyYNsA3czgSpNWfE2sPfPMPreUOX1rKPjOmdqNg7+rA
         4eD4OqWxZEApWTMQ2VyQ7UigjvNIJHrILpvjaMBxEnavC0Dm9ZCC7c3vnXhmAgOaBJQd
         wDPqIja5l8kPy0YXT8YGWbsKDxEfKDLs3CecZ93wM7FTIc4zQKAI9iBiZbmZxoWYhp6K
         VZuaTj78DCgU6cMvKAy3WLxHm5wWeWOO2RMRcJjf7yklzusVQYJw1S4pcP6goGeBnw9Q
         D8dtTZyQOXH3pVvrBl8KFlrcInXQjSnwmjrsJ1lGrPJThU6c2x3UV6IJ2IKjdhzCiji6
         crDg==
X-Gm-Message-State: AJcUukfBDLdjvmwiYlGxfh60CuHtTr1CS9HYtGcm+VR/ex+7RBZcszGa
        IsbSdWWEirQ03b3J3atYgT1vNSe1
X-Google-Smtp-Source: ALg8bN60Q2ik3M4JSe22iT+wb0Isvj1/73XkBl0nLbKJPEGa9QJQYO7f/2VaIayb52gLmz3KPhT6qg==
X-Received: by 2002:a9d:6d81:: with SMTP id x1mr12599346otp.17.1548093371920;
        Mon, 21 Jan 2019 09:56:11 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i22sm5610467otp.7.2019.01.21.09.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 09:56:11 -0800 (PST)
Subject: Re: [PATCH -next] staging: rtl8712: drop pointless static qualifier
 in r8712_efuse_pg_packet_write()
To:     YueHaibing <yuehaibing@huawei.com>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1548057193-130411-1-git-send-email-yuehaibing@huawei.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <bfb52a90-554c-a144-b928-eb787831ccd0@lwfinger.net>
Date:   Mon, 21 Jan 2019 11:56:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548057193-130411-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 1:53 AM, YueHaibing wrote:
> There is no need to have the 'intrepeat_times' variable static since new
> value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/staging/rtl8712/rtl8712_efuse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
> index 8bc45ff..39eb743 100644
> --- a/drivers/staging/rtl8712/rtl8712_efuse.c
> +++ b/drivers/staging/rtl8712/rtl8712_efuse.c
> @@ -358,7 +358,7 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
>   	u8 pg_header = 0;
>   	u16 efuse_addr = 0, curr_size = 0;
>   	u8 efuse_data, target_word_cnts = 0;
> -	static int repeat_times;
> +	int repeat_times;
>   	int sub_repeat;
>   	u8 bResult = true;

Clearly, the value of this variable is not intended to be carried over between 
calls to this routine. Your fix is correct.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry
