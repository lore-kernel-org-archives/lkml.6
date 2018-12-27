Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22797C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6930218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYZCz+ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbeL0Xnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:43:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37086 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbeL0Xns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:43:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so19586865wrt.4;
        Thu, 27 Dec 2018 15:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ueXQcrLnuDIN0Go1ih+DHYn457KWlH7rVZ5/vFNinl8=;
        b=GYZCz+ll361gHEWMXKWQmM4emiYmxyo/puNa6FeNcrg56DZuOPkOnttDd5twArtrVk
         DIwsHxIB8wDPGsPebmf4IPbHgPjaXWxYBGvsvOqLflCfsXkI6957u0D7odJk7uFO/Z3w
         LepFMwpmDh33P8NBnO9BrBEwDiUmM8lGgRmVHaggRy2XD12YOsI1oobak43RvbDiER2C
         Y+bMNXwASLqnxpHlg8Vn/1G2ne+gftHOtMKOVpTzvMGADatia9eoNSEC75bkQViylmU+
         nuICF4eXfT3pVVkqLZ7nC9qKuFLuIupOqEqz4jQUxPoV5zMkbOqxGa9i2nnPJx9ySsJ+
         2nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ueXQcrLnuDIN0Go1ih+DHYn457KWlH7rVZ5/vFNinl8=;
        b=TyYL+iPCeWJH6xiHYeJBh3rnTGNoftxxx0YJUsncfEHjUovQd8FIHC2I8ZBevHwYzG
         YSU0ueiJFYYzXDpFJb0a6dx0i5de4A3dHt6W6R2hGotUQNEuT35WMYKE+sNA7TD7Bpy4
         Ko1gL/BbT32G7apKtti+BfNyFag6qT47WpfkcB41HaUe6vO6k6inYslcfTRLueQdCUxS
         S9SjfvLKr2fqxHUBjR6xSIdX9uNPDmHRDQ3O4v60Wzqqn+oWlkNEuozDLFAMxBsYCb6P
         iS58Wu429KdKJ0Eq3kCMCmWy/lUi3wymQuQexN3dY6amUGDDj/Aj9idG+d+ttSoP2j7R
         vgcQ==
X-Gm-Message-State: AJcUukejXnTF6rMgQUls8whWjf0gudJb2ZOzxE3I7KfI+inuigYpW220
        eQjolBM4dHqXjoVIi4RQ/klcjTqL
X-Google-Smtp-Source: ALg8bN4r7DVS2ouEbX3eeFD338Zd/aOxCJm3zBkXyTNIRLJ0Qsfb6+BRn4laLE/YQRxSFN3CqxluaQ==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr24154230wrm.115.1545954226274;
        Thu, 27 Dec 2018 15:43:46 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:25c7:a0bd:faa6:5840? (p200300EA8BCFE30025C7A0BDFAA65840.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:25c7:a0bd:faa6:5840])
        by smtp.googlemail.com with ESMTPSA id m4sm34686535wmi.3.2018.12.27.15.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 15:43:45 -0800 (PST)
Subject: Re: [PATCH] rtc: rv8803: Check return value of rv8803_write_reg
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20181227202856.27408-1-pakki001@umn.edu>
 <ab4c081a-82d7-4a50-5c2a-4dbb4ba79223@gmail.com>
 <CAK8KejrntOUb7Q2MrPR6mYDKyHKc=pzO5hOYv=ZfLaP_xg0Zsw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <cc8304f6-4f48-0e23-daff-f7b3802c7a9a@gmail.com>
Date:   Fri, 28 Dec 2018 00:43:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8KejrntOUb7Q2MrPR6mYDKyHKc=pzO5hOYv=ZfLaP_xg0Zsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.2018 00:28, Kangjie Lu wrote:
> 
> 
> On Thu, Dec 27, 2018 at 4:31 PM Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
> 
>     On 27.12.2018 21:28, Aditya Pakki wrote:
>     > In rv8803_handle_irq, rv8803_write_reg can return a failed return
>     > value when attempting to write to the bus. The fix checks the output
>     > and throws a dev_warn notifying of the failure.
>     >
>     > Signed-off-by: Aditya Pakki <pakki001@umn.edu <mailto:pakki001@umn.edu>>
>     > ---
>     >  drivers/rtc/rtc-rv8803.c | 9 +++++++--
>     >  1 file changed, 7 insertions(+), 2 deletions(-)
>     >
>     You seem to submit the same type of changes throughout very
>     different subsystems. And you do it w/o thinking and testing.
>     If you would have looked at rv8803_write_reg() you would have
>     seen that it prints an error in case of failure. So your
>     patch achieves nothing.
>     You got David Miller upset already and it looks like you
>     want to achieve the same with other maintainers too.
>     I'd strongly suggest that you stop sending patches until
>     you better understand the kernel code.
> 
> 
> Hello Heiner,
> 
> Thanks for your suggestion. Sure, we will try to better understand
> how the kernel works when we are preparing other patches. We recently
> found a lot of potential bugs; due to the significant workload but 
> limited labor force, we may make some mistakes, but yes, we will try 
> to avoid them. 
> 
> One main reason we submit the patches is to seek feedback from Linux
> maintainers who know how the kernel works best.  We hope to get: (1) 
> confirmation: if this is indeed a bug; (2) improvement feedback: if
> it is a bug and our fix is problematic, how can we improve it? 
> 
> Taking the case in this email as an example, rv8803_write_reg could
> fail, so returning IRQ_HANDLED even when it failed doesn't seem to be
> a good practice. Would "returning IRQ_NONE upon failure" be a better
> fix?
> 
> Thanks again for your suggestion.

If you want to understand whether a certain code piece includes a bug
or not, first you need to understand what the code does. In addition
to own analysis you could post a question to the respective mailing
list.
Maintainers usually have a tough workload and can't explain to every
beginner what the code in their respective subsystem does. It's not
the smartest approach to bother and upset them with dumb patches.

Last but not least: You seem to submit all your patches w/o even
compile-testing. Also that's not a smart approach.
Read "SubmittingPatches" carefully, understand it, and follow the
rules.

Heiner
