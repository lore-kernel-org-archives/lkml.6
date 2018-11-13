Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A67223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YitoNKGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A67223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeKMMZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:25:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34039 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeKMMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:25:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so4684517pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ve4MS2kCazH7ZN/ZfN23igEHV6weSVjjpr/TJBjMl0I=;
        b=YitoNKGJ5zpAej6dJz/BfaOay/F+VZGDl1f4oOXWwq4T1FfMacQ5h3QbcKbdzAdBQc
         VeH686fOQMdUud6S+qBQglGspb7Zw2v+bv5kF8jk6T6UC98vaHu99BIGcbVt0pGCXy2f
         OJEoBGGvUjrZ4TddFO9vjpdwTqJFw8Zb51QXgKcsWRcAOLZQQjMQ5bJ7UKO7FSPwQtF5
         q244ZOGsLNdtCW52N3F2pu1J4t+hybQOcjiM7NrwrjPfUHCNSOshenfKKGzff1TSGu0r
         rlqopFgwUZ3oxmMAytdgDBCeFABEE8SPW/VmnpJ6HWOLlIx+luoev+SFiEyi7YA0S9hD
         dgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ve4MS2kCazH7ZN/ZfN23igEHV6weSVjjpr/TJBjMl0I=;
        b=K9J19mDZWG91gR0hVgduJkCaTPzWEtMQN7Zw7FVz6D8C1N7X2JX4r2+8EuuwM1LuOS
         1lx8gM7V/zVzS1Z83dEaeX9aLJ6p+oJwuoXBTykDIVC5F/eK8b6Zz0EDYexhtyNwPcct
         6AzASxV2b5Sv4TOWoLUk2Ovy8Sv3adaZgzxS5RWBtCiKSh/DHdzjhaZtg6u4Uxxymopm
         bXDo23OI9uDl56BfZ0vKnf5CpEPjq4h+uzPznx4q5K71G+yw+8YUz2eWwnshgxAuTEq7
         dURi/vM6oFkkaTXrCGtfDblFdT3GbGMeb02W5mdJedqedoatx9TTO6fB1afv8jBDsFKW
         qEKA==
X-Gm-Message-State: AGRZ1gJ+CbymeD4T8kGHc7+GWKWDlQLZic4JjrlDI/3bA+aU+PRFJ+1U
        /W8fwEq/EskftrCc//80RHE=
X-Google-Smtp-Source: AJdET5fllbiu6D3uj9Z/xlWFyVKfiYblnWbUUL7iK2+0UrrGA8P0cHSSqgAgLgcbWHaNryDAqFX8+A==
X-Received: by 2002:a62:6181:: with SMTP id v123-v6mr3336399pfb.117.1542076196616;
        Mon, 12 Nov 2018 18:29:56 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id k38sm42620738pgb.33.2018.11.12.18.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:29:55 -0800 (PST)
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
 <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
 <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
Date:   Tue, 13 Nov 2018 15:29:46 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 12.11.2018 um 22:06 schrieb Finn Thain:
> On Mon, 12 Nov 2018, Geert Uytterhoeven wrote:
>
>> Hi Finn,
>>
>> Thanks for your patch!
>>
>> On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>>> The functions that implement arch_gettimeoffset are re-used by
>>> new clocksource drivers in subsequent patches.
>>
>> Disabling this first affects functionality during bisection, right?
>>
>
> It means that all platforms have to use the 'jiffies' clocksource.

So all that happens is timer granularity drops to 10ms, then gets 
restored by the later patches?

I doubt that would be a large enough regression to matter for bisection, 
but the way you reuse the arch_gettimeoffset() code for the new 
read_clock() functions makes reordering of this patch to the end of the 
series impossible.

Best you can don, under the circumstances.

Cheers,

	Michael

