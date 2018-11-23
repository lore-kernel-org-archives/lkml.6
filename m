Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4221C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9195620672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9195620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393257AbeKWQtm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:49:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:49:42 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gQ4c2-0001DF-SP
        for linux-kernel@vger.kernel.org; Fri, 23 Nov 2018 06:06:47 +0000
Received: by mail-pg1-f197.google.com with SMTP id q62so3647414pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2vg7yCW8KTmwsIpE14wCwLuyJZb0VTxxt18tlwTCMgc=;
        b=Sl7zF3pb6CHgdsrXpSTpKt5L4myqtbrznPaFI1tz5pP7iVF+qgiJO0ISSqDC9BZFnm
         GdYqMSmXOycF1FCWyNZKhx1Do0C8FlgdomZSJcwBfrp6d3iHxeILGr8tk6xp5gEExgV7
         XjvgQkeByVraO2zbjRNZGhOFHjjAmOu6FCfAfz9/q6uUH8L2Uy1BmrX3zXcmXdT6V3CI
         WQmfszlIdvai8LMC5Shm5VLLM5SgvIQgTtKD7McylcAP/QNgMGbmad21TMZmQUa0lLFR
         YEH/zAMdtJvEgDzWOWNQRuAKE9Llh/MjZM33958QBthSjAlVb6Nr03gJEFz05yrs9pse
         ipfw==
X-Gm-Message-State: AGRZ1gJ6+nxwRyiaEKMOU3ue650nSk1okSqRoN15LKgscY4b2NY35NDu
        YxUw0u3yDsJ5R9F+dlqanWDBs6hb+fxFtlhaASGCMjP9s8OUPHA92U98Y2u8fHKRCNC4TQKGm5p
        dse+8yggfom0szsFNCpWTSRPQVrX8oK149nGOxtZ2bw==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr14476317pfg.235.1542953205572;
        Thu, 22 Nov 2018 22:06:45 -0800 (PST)
X-Google-Smtp-Source: AJdET5dROJOTbhQktWkPiHakKq76aV9xiP6YKScn0yzjIuDKDiRs8Uh57azgtQTWIb5CGHjxMbxGZQ==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr14476305pfg.235.1542953205357;
        Thu, 22 Nov 2018 22:06:45 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id b7sm6309457pfa.52.2018.11.22.22.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:06:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 0/5 v7] Keep rtsx_usb suspended when there's no card
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <58a96c0933bf4c812fa2dd382e6cb377@natalenko.name>
Date:   Fri, 23 Nov 2018 14:06:42 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Transfer-Encoding: 8BIT
Message-Id: <CD517154-3155-4D89-AAA5-11DA0DE7B9EF@canonical.com>
References: <58a96c0933bf4c812fa2dd382e6cb377@natalenko.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

> On Nov 8, 2018, at 8:17 PM, Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> 
>> This is based on Ulf's work [1] [2].
>> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
>> platforms and ~1.5W on AMD platforms.
>> [1] https://patchwork.kernel.org/patch/10440583/
>> [2] https://patchwork.kernel.org/patch/10445725/
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Do you think this series is ready to be merged to v4.20?

Kai-Heng

> 
> -- 
>  Oleksandr Natalenko (post-factum)

