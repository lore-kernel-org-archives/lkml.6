Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D5726473
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNG4kuMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D5726473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965291AbeFZDMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:12:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41939 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965257AbeFZDMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:12:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id 21-v6so3914792oip.8;
        Mon, 25 Jun 2018 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zcvt0rULoE1tlIkIfUO3rXkYKGuWBc4NmCfA5JdbXVc=;
        b=PNG4kuMvS/v7N0cesf/l+sWCum++WGWOr3mVRw/yiwWTtEnjLD+Dd4pt3XuefuzvV7
         BUb9ywoUsFMj4pBu2um8Lasj9FlaAO+7/rrAG0gid1wXYwiWzkkO4K8EFaYb3VC5E6Ja
         Ad7Ryt16qDTwIbuw7+U23pnAMJBjqXAlstYcxwT9IoFoGR6qQzpYUA4G+aSAauQPWu7h
         Rl2fxfQUTpUROrbW1tPpZEB3Z53oV3hMHEXzWMpGp0gRiDEWj3cOegaD+bGsw0icq/yM
         kPvvP11jfnfDT+OoUJDTxLtmJFD81axP0VHA+DDSum5FhQl3IfkNz9RquhN9NlC9yJhv
         LQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zcvt0rULoE1tlIkIfUO3rXkYKGuWBc4NmCfA5JdbXVc=;
        b=mgbgqDxqEn0AIt++tAGIB9auQnSmIBnLCqawn+Rd1MUo7yEZUxVM6HmNc6ob/wPN2H
         c1AKTuwT1Svv79oaVcrjDQO3aQU/ZGzycRK3xISqCpreVnKPsbaSCEuArPNb+2CiLazo
         7EX/7GUji7d8kHRyzqtRwVT9DELMZeR/Y1vMlDabltUfAfsoW7i1txN4S3ZSdZWLgS0p
         InruNQYD6X4MHvd43YYCKrZI2EXXxi6m7yhR8ZvRvJtCInnCX5XsNLzoW996bN8uv//I
         8B9rXOnBtYt1PtGH5fBu0LC4Bk/tbKVGrKTs74NaNBhQENgZ3t5eIJceKsfV9jdfp7zr
         v+KQ==
X-Gm-Message-State: APt69E2PwtgbXco/thdwSIXmZUcJl/Lw68ayR6/bLV5bCn6oyKqiEcvt
        fYv5ciZEwRGtRtSJWKP2wc4xJtcr
X-Google-Smtp-Source: ADUXVKJQdb028+Zt7BFem2zbj1SARuoX+dGcwzEo85viD+BLGSsZZdkymXzoDYsFlfFEUgoHL2qsZg==
X-Received: by 2002:aca:698c:: with SMTP id e134-v6mr9052002oic.302.1529982735484;
        Mon, 25 Jun 2018 20:12:15 -0700 (PDT)
Received: from [192.168.0.2] (cpe-24-27-59-32.austin.res.rr.com. [24.27.59.32])
        by smtp.gmail.com with ESMTPSA id f14-v6sm299606oti.45.2018.06.25.20.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 20:12:14 -0700 (PDT)
Subject: Re: [PATCH v4] dcdbas: Add support for WSMT ACPI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mario Limonciello <mario_limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>, Douglas_Warzecha@dell.com,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <3b881313-d96c-0395-05f3-dd612b7e440f@gmail.com>
 <CAHp75VctDOupi9Vk+njzj3U5G8BthwnaNqE=Y8mOhJLviFkYbA@mail.gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <32481fee-df4b-5af2-25f6-4d2dca487fbd@gmail.com>
Date:   Mon, 25 Jun 2018 22:12:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VctDOupi9Vk+njzj3U5G8BthwnaNqE=Y8mOhJLviFkYbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180625-4, 06/25/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2018 12:26 PM, Andy Shevchenko wrote:
> On Thu, Jun 14, 2018 at 6:45 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>
>> If the WSMT ACPI table is present and indicates that a fixed communication
>> buffer should be used, use the firmware-specified buffer instead of
>> allocating a buffer in memory for communications between the dcdbas driver
>> and firmare.
> 
> Thanks for an update.
> 
> I answered to previous thread. The questions / comments are still
> applicable here.
> 

I answered your questions in the previous thread (a while back).

Please let me know if there are any more concerns with this.  Thanks!

 
