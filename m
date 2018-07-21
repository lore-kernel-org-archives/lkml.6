Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C365CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90B2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxCdnT2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A90B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeGUOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:32:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46289 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeGUOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:32:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so3805735ply.13;
        Sat, 21 Jul 2018 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EuqnFDEt80wnCm2VPGfLg1LWxur11C8HvyiJ3/m21Co=;
        b=DxCdnT2R+cwGesYnx1/IRUmWVv05Z1ScKvcjapj5A+Ox8wVZj5/W8zzcewPKcsgBHz
         xbifxBBccLApGrg4H+R4dswCmeNC3NaGTEq3yZhxi2sry45SmeMbLIHyLg/khtRKkQsO
         pMSH+90RCMG1VKn0GJEjt4hPzZjb678y9RsldlCYGoClJ3JX5OAAn/WlVu45aKfkpvhl
         E/zCbiPLLVp9iZP5eSmI6adZQT0NvmcdnhOk6TolBXQUCAQhXjRisZIOqy1cvF1BfmiB
         vc9aRHyHMNgYG6kWmUqorRnNfvfO8xJHwYbNOtQU7aZxY2f7fYk/KkAeGNuUhWDrsYE5
         aJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EuqnFDEt80wnCm2VPGfLg1LWxur11C8HvyiJ3/m21Co=;
        b=XlCSFmNYNxvmz9h3v2IpjLdCLTSfrTV2EtMnEeiCB2gOtCuAyckH8t+gGsbrBx0bYK
         0bT5eowSek5kKSGO+VZCIMBAlk6mXQRpYncc4MVY8iMbdqaoUEvnDjdeMzSYTrblI0cn
         64+JOBTVIfhe03Bih74Cg7wcO9QzLrvFPI9hFEojWpKTwPKlN7R5S1SRH6DUVDBwgE47
         AY2B2NcGDhVp7UULWyJH2sUmW838CV5bp0z/S4S2EBjPKHv+q71Yr+8HWHdTvvinVcOy
         CfSO5Nmh6pcbhXFBpFZrHekDkdc1KQp1Z1rspSqz0/3lxGdlYt8ExsXHeVxU6/OIUShI
         iDEw==
X-Gm-Message-State: AOUpUlEBvkyWQvvttIKGMG6RfX/ye6EyXaOAYgy9BoIkSHzkIzBFABFG
        BmiQDB6qv+nk4Q/ctQXXtIckT29s
X-Google-Smtp-Source: AAOMgpecoOU5QY6fGugnFdLgI5o3zbWo3CEGWbq2i8r9lGy3klkpciwJXNJda8Ka6J74cndPoi8nDQ==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr5924375plp.143.1532180394813;
        Sat, 21 Jul 2018 06:39:54 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a20-v6sm2046225pfc.14.2018.07.21.06.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:39:54 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/31] 4.4.143-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180720121340.158484922@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6394057b-d551-fd2b-3649-9b8407272f31@roeck-us.net>
Date:   Sat, 21 Jul 2018 06:39:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.143 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 12:13:28 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 149 pass: 149 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
