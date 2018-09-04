Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8DEC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6459D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES/sEfKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6459D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIEDSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:18:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45590 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeIEDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:18:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26-v6so2361544pge.12;
        Tue, 04 Sep 2018 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytlSVuvM9xYi9zrgLK2G22aGCrL7G3YDw3szwTJ2uBs=;
        b=ES/sEfKyzN1tT25fGFzeaDXb794gDfiqp4J96YKFZV2yCjv9bejQ4LNubdH7CNxvyK
         F5iNZ+ocRoXstjjsRbCCNHwGXbnd8hv419jcDBvuyxofEPw9u5iAwURsgZkMgR4q6MBy
         bx4/kPgsBClMTwwdlVfYTV3EfpTmBr+VY6z4b3Qcfo96I4/3eOnB6TTFB5xBmxBvkomT
         hilxexld/k6rCU6T7zpPQbAVxpFdBowx9P9OuXI0/S/OrR+9nyaSmOMiFrp4MVYh9AF+
         GWyFl85aEm4vSGLs0XL8TY+OEMK3rxGGxrRuCpPZy6FMQHYEoYlX668tpgXjP/VBuuiL
         Jw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytlSVuvM9xYi9zrgLK2G22aGCrL7G3YDw3szwTJ2uBs=;
        b=psyNASbscud0K1nRyKUnen/3Rce8KV82ROlYRnTYIzqOdvi4g3h4xpi5OXLPounPC4
         WCD7+b4ipsWj0V1d54ocFoWevKd5TGEgdiLQ2aMGTrq9Kx7j3gA1XTuRmH3NMO4TBZBw
         4JmlDSrcHcH9zR3IvZnnfwAXinUlEX20ZO9nSixR6fmW5yW60kJx+8aS919kTV0KUYEi
         o0fEh7/KttUOZSTY+zSY2iEWTC4At7RElbSUIOaFB35oBiLZ2WmbFpadLI87eHIjLHJ8
         lKbwn6icnmM6oZ5nCNyJ5hXn2YGP3URG2BvnHdJ7jTirN7KzE+B31EMW+U4+GW6jb63W
         iKEw==
X-Gm-Message-State: APzg51DRl3DJvaPgcYG8B0TwAwo3aZS/0gSmp26Fet0x+wKx5My9BJnP
        b+ymq/SuHstR3L4B8xZeNuj4rz5w
X-Google-Smtp-Source: ANB0VdYZgSkxxBZ1QM9OwL0wQyTuDC9H+/8jl8oV2qv4/uwexLmwBx/HUaKgKaecxmfzW1u1you4Qg==
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr37390145pfg.69.1536101480362;
        Tue, 04 Sep 2018 15:51:20 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l3-v6sm84304pff.8.2018.09.04.15.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:51:19 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/80] 4.4.154-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180903164934.171677301@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <754f6af7-1880-6b1a-cf17-a6bdabcf6dc9@roeck-us.net>
Date:   Tue, 4 Sep 2018 15:51:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 09:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.154 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:49:18 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 234 pass: 234 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
