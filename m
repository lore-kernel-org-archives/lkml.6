Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE36C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABCE20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU9BvUXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfBYUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:15:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44091 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfBYUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:15:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so4991035pff.11;
        Mon, 25 Feb 2019 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E8lWw2ASNAltZu+69UVfzgghiLoO10/Uv/iw7ORw26Y=;
        b=BU9BvUXf31ufifN7LTHa4MOZ1CsGHTVxHoKsnX5yY70GhSba4nic9Z+Sf+OM6yeC7Z
         z5uGOCY/NyJLP10H4ZA+1c3gl1/95UIkTjBAiBBr240BejrNsD4Wp0Kh/XmkDvHfs57M
         p0sSHozpJB7P+KLpaLQgR/44RNOA1w+ZJGNiUzQ+oEBCF7mbV/ctm9hIapibDCkVIE0P
         Az7hPW09ylhxpXaTgbh+SVFwG4WEaqOnTaPqCohkFTPKWjqwbZJIiwp/PPFUOxb5T46x
         J8qIdjNCAhTCfEY79+HZRMNLkdkxFY9GZ//6SNAEyL2H/ygs/s3GxqsqVHG+28gWqV0K
         UFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8lWw2ASNAltZu+69UVfzgghiLoO10/Uv/iw7ORw26Y=;
        b=OsAgARUspkSoT1OcjIG3QNX3a9SXRLj23zCmn74hSZtGGUG1gpMMaNNaB0vE/bZN9N
         ovZwms6X6d8JAOcTxycW4ERe41nJKXE9lJ9wTWni179TnJvkZvaA102kBSeMObY4/piq
         LYAuRQ3CFF9Fz6VPggj7orVeTnitb5sqKKMfsztoEfZkGOP1qzNsVDrE+8nXZAxoTl+a
         jBGckmTeWWBWudTqYnYrUDPPxCAJE+03J2sNsB9x7PT4BLxejZx5N5hj5BWItzJe3k7D
         GYeXnoUmFRTfzubfjcDzsGR5AeeIGj7bxBOEsIOmrtLeMNuJI8ak9v3J88BxdIUSYItf
         1wWw==
X-Gm-Message-State: AHQUAuZ+fuN6k975YLzDp5m6APf3iTANlcCBI0Dp5yOdygWGnYAG1a38
        S3kmk3tLjUY8wsrSmlYHm0rH0s96
X-Google-Smtp-Source: AHgI3IaTFNeQyFW7nGatod+0p1FY/pomAOTQEY9zw+j5QcUawi4dJoztGwbQ61lcBobcjl5TLa4eBw==
X-Received: by 2002:a62:e0ca:: with SMTP id d71mr21851288pfm.62.1551125747044;
        Mon, 25 Feb 2019 12:15:47 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id g69sm26694823pfd.168.2019.02.25.12.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:15:46 -0800 (PST)
Subject: Re: [PATCH] tun: remove unnecessary memory barrier
To:     Timur Celik <mail@timurcelik.de>,
        David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190223115313.15064-1-mail@timurcelik.de>
 <20190224.221236.905722532971991928.davem@davemloft.net>
 <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
 <20190225.102548.247362521843809607.davem@davemloft.net>
 <20190225201313.GA30005@timur-laptop.fritz.box>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <557edeca-c16a-6be6-2165-e60f3da2dd29@gmail.com>
Date:   Mon, 25 Feb 2019 12:15:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225201313.GA30005@timur-laptop.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/25/2019 12:13 PM, Timur Celik wrote:
> Replace set_current_state with __set_current_state since no memory
> barrier is needed at this point.
> 
> Signed-off-by: Timur Celik <mail@timurcelik.de>
> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

