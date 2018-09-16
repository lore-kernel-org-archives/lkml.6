Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95372ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2C9208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qguBqUqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2C9208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIPGF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 02:05:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32768 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeIPGF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 02:05:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so6043157pgc.0;
        Sat, 15 Sep 2018 17:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fW7LpkI9EwN6Pv70lnbwLFJ5jne6EG9HvwQ/tTqqK78=;
        b=qguBqUqRjp8XeAvHZFEXs0bXsuXEl6/XedDmCtpxDWD6pjDCsnW+ezf1oblwX3Yag7
         qpp/aUm8HwguU3L7s8ROqBClk99pca3FHUpPHYzNpx9l5d0pFeVj/4XtyDKGb263P4gw
         /FSYTeSYr0h4IMfJkndKgCK8Ew1pik7Xkw4NaP29geDqaU/49F+HXVVD0KOfi/DFA2iG
         9xLd8z25Cbrx3jkn7SDxybvdYTlbYKT/T1/Pb55pH9IDM/zXMp5SqrXi3O9RWF+WUe/n
         kupmYNV3P0l35I9mdk4TSA9sVrBmz1CwOdEnds/jt0Gs4m0Cb5PVU/W/tXXAmQlPR4S9
         wMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fW7LpkI9EwN6Pv70lnbwLFJ5jne6EG9HvwQ/tTqqK78=;
        b=cBnV4q4lx2jy35NanNR996/9ur4QZnizFYe5liy7SXHMyEOfELePjH0tZ0SnTJ+jdy
         dK3uGa9+lYJnJM8vSBCCnwTt71f39HaaJq38uAupN3syXmZSn0WS/psOWrPc0TWzGn4P
         8LuFAs/IWRzrbPYcPyHp+J2rObmOIPSBIAiPOfPqrtPgZmZRH+C3TSUn/uRqFGvM3lry
         +EtrTq4fQDqHiK4hGsOp4J2athv2T21Z00Cd2wUbrsu2BQWExnkVJYirBIhQjOAALXNu
         HxAnSnK3QSja982BEeY9ClylEA97K4MNS6P8Tso9Gr5B9uLmEsDqi4q55gzWvdd/IgHk
         c8EA==
X-Gm-Message-State: APzg51CPVp/XVeKT4z/FCghasYcexytijFhBk1Q7KiOuiNgwqeHCY8b5
        exMDLXxnziOaVHcAs9KEQ58=
X-Google-Smtp-Source: ANB0Vdbuts4UMvYWY4TQhTJVFtjFVeFaXnPLOVTxHtKgvzF8IEE0+jP52yMq7U96B5Wh0Z3vFJg8xA==
X-Received: by 2002:aa7:83cd:: with SMTP id j13-v6mr19181720pfn.236.1537058667132;
        Sat, 15 Sep 2018 17:44:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n9-v6sm17248621pfg.21.2018.09.15.17.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 17:44:26 -0700 (PDT)
Subject: Re: [PATCH] hwmon: scmi: Remove redundant pointer check
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180916000506.28905-1-natechancellor@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <568ec241-baf8-7ccd-c0e3-7724a5eb90ae@roeck-us.net>
Date:   Sat, 15 Sep 2018 17:44:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180916000506.28905-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/2018 05:05 PM, Nathan Chancellor wrote:
> Clang warns when the address of a pointer is used in a boolean context
> as it will always return true.
> 
> drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array
> 'sensor->name' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>          if (sensor && sensor->name)
>                     ~~ ~~~~~~~~^~~~
> 1 warning generated.
> 
> Remove the check as it isn't doing anything currently; if validation
> of the contents of the data structure was intended by the original
> author (since this line has been present from the first version of
> this driver), it can be added in a follow-up patch.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
