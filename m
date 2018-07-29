Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43512C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF95D20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG2eBAdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF95D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeG2TN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:13:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53222 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeG2TNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:13:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so10572632wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDFQeWO4sREXeKqirJaBzXGWKWUK5egS8sRdG1+1sUk=;
        b=HG2eBAdwTJO9c5HZu4m3gNT0qYfqW7jTrrnOUNkfJECGsz6PlOJtMnfTXgnD65S8Q8
         mZ3hUOY0WJQBZKIGdrZWjYGHBMERGXJ7UmMYV6/nmo1mxcSVGknsxy8BHDaTKYn52XaF
         LPJuUSpSRzS/8apR0Jp1bj+fGjK6YSGGeA6Pf4dRvuTJSaMEbOc8apHAhQ4+o7vtlz4e
         vE1SiY18I6g98TcJOUn6Di1cywLqh/jkADQz7MaDynbZkf7A/8OZ/V3ndmobPdN6ZCrV
         ZaMpsa+r5SPaGz9vQdUFfzJPybmJcJwhrvGSsXEFJlwrk0oYgpZV4W7KQJJmNx9IzJG8
         hBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDFQeWO4sREXeKqirJaBzXGWKWUK5egS8sRdG1+1sUk=;
        b=lbvyjWnNxpPYGhUQX6lNxby1I9UHwAFNvuDEP7mDOdeFsraVG06HRlC5+vyPty9y5L
         ojq+bmw4kNd1OcrIKTCWGJGx5AYAkJUpgreNDIgC763yJM+/emuNCPYARpuaOt2VJVen
         XLS8kctQQJnx9/Hd5L7m/RYijqOfnKQHoPjAxkI3nxjj3TE4ndN7nNMakw7k8/vby7Va
         fsR/L39Ff37hdSV3Tirl55BH+8dF9VZN1hCiebanh0VdMzNDs3w8iX42KAL+JavTNasY
         P9fIFeTU0M3GuAIbjS1hPXjYJpl0X57ePSkCKLG0zeMnyS8HV3S6Rp1nuL5PuzdFKIM7
         nZQg==
X-Gm-Message-State: AOUpUlHnFE/4jizNsk+Gi4EaJtccFcckEu9rd17AvpSYgzGtedGr21ct
        VHg4CLio9MWQaxKfAgxg3lxXYg44
X-Google-Smtp-Source: AAOMgpfAW7sW/pWgZtgFihCTWDYdAjbEzYL5I2dDJY+d/kJWbD9I3XuawYu7i4CN5eQTCPnI//aI7A==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr11981981wmt.55.1532886163150;
        Sun, 29 Jul 2018 10:42:43 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n17-v6sm9605928wmc.13.2018.07.29.10.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:42:42 -0700 (PDT)
Subject: Re: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180729170851.2581-1-straube.linux@gmail.com>
 <20180729170851.2581-8-straube.linux@gmail.com>
 <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <90fb5087-22df-0480-548a-7658881181c8@gmail.com>
Date:   Sun, 29 Jul 2018 19:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/18 19:21, Joe Perches wrote:
> On Sun, 2018-07-29 at 19:08 +0200, Michael Straube wrote:
>> Use is_broadcast_ether_addr instead of checking each byte of the
>> address array for 0xff. Shortens the code and improves readability.
> 
> You should show in the commit log that sta_addr is __aligned(2)
> as required by is_broadcast_ether_addr, otherwise you could be
> introducing runtime alignment defects.
> 

Ok, sta_addr is used from following structs.

struct ieee_param {
         u32 cmd;
         u8 sta_addr[ETH_ALEN];
         union {
         ...
         ...
         }; u
};

struct ieee_param_ex {
	u32 cmd;
	u8 sta_addr[ETH_ALEN];
	u8 data[0];
};

Well, looking at it now, I'm not sure about the alignment anymore
in the struct that contains the union. Is sta_addr in the first
struct __aligned(2)?

Should I include the snippets in the commit message, or is just
writing that sta_addr is __aligned(2) enough? (if it is in the
first case...)

Regards,
Michael
