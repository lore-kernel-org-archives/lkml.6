Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BBBC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C14217D2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9A2gOoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C14217D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeHJNOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:14:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38447 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHJNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:14:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so1400168wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j2L3RD0blakF4hmDJl/bni62tZMs+8Wz+wEFfwRplOI=;
        b=j9A2gOoMPcx6gez2LsyfKJF2Fj8vs91baDRSTih0cQwxtPIL86/tDS8UGlNLYaPyyk
         45ROtfPjMQQd5ReyBaL7pZkBdFH8rS7I8oXtgIkoJAJXBiVZkLTQcZRkhEW/ptiLtnpr
         eYQx/rkY+Mf/8jEoIgqzrOuKm2FfzFjYVbewe5gWgChRTyqnYS6u5okjMfszZ6gzz68T
         IzzxCRBZw3yx3nr6ESORQrY4k1evNPL4UVly67NS10QlihPhbS4eGq1cH6HSziGpJBma
         36uw5UbXbs1zUJiyr6rbaKQlH8WqxIsWjExnCKMf57MTSr1hdqJuvi9Rxn3frd+qwAIX
         fwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j2L3RD0blakF4hmDJl/bni62tZMs+8Wz+wEFfwRplOI=;
        b=ZEy6D/42ZwUQIVemqYoWxf7My40Yp/uShwZ43EqGGXYncbVXG92hwa1VXE765KyBco
         /1kqb3qIUWjfxqn+wWn960T7QwJ0qdJEEe4WqKSmOqJRD2LTesMQY0Q+c98ODttfhjoB
         4SG/OUZwQiBIKB2UGCKvbZ/W1qqoXzwlNSxCwpSIIjELDjXfLpb2DDbTadY3UpIIEMzF
         00dvbi78t37sYUwvaUMPphzbB+X7qts0zh3wegizOAjrIfuo3M3I8C8qGY5MwKiG2Ber
         1BWkUfTnrVFoGHhVpOzN/2eBO6esOxfudPohLgeKa/O27UUTfon+5q6hQZuZv86aH6OY
         Bb9A==
X-Gm-Message-State: AOUpUlFiUxPK77v3sp/i6asswrt4RlLvD4rLx/IpIk5+iZvAeCi10dUd
        G2V7Xq61QtlOVVdWTT+sR4vHZxHj
X-Google-Smtp-Source: AA+uWPzXjm51QJo1IXWGWlvwV90zkA4WZP7fuRJwo+tKSZk6Ht83qdAWBhazh0MDbmTsrXi7wZeBqQ==
X-Received: by 2002:a1c:497:: with SMTP id 145-v6mr1164573wme.157.1533897898301;
        Fri, 10 Aug 2018 03:44:58 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g17-v6sm1010647wmh.19.2018.08.10.03.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 03:44:57 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] staging: rtl8188eu: use phydm_reg.h from rtlwifi
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180810071833.1661-1-straube.linux@gmail.com>
 <20180810071833.1661-5-straube.linux@gmail.com>
 <20180810094455.4sji7ex2d7jaq3x4@mwanda>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <7d28a316-cdc6-86c7-d68a-631082f56255@gmail.com>
Date:   Fri, 10 Aug 2018 12:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180810094455.4sji7ex2d7jaq3x4@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.18 11:44, Dan Carpenter wrote:
> Looks good.  Thanks!  I reviewed the series.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks,
Michael
