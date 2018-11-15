Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D2A22360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnXI8oCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D2A22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeKOLkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:40:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeKOLkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:40:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so8216702pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 17:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IAn59E27ZMiFVTab4CKws9a00rFyIpke56WwNiCIdtg=;
        b=mnXI8oCdDJhaA5Oti1GhaqBvq0vxoZr1n8cUYdmFDFUXFjD34NPBU/jPBZTvzjIblc
         BAcQ/F7Ih3soNUK1IV6EJ+yRnv6z2Ri6STffri1WCPlo17rsmS0IccjVS6g6nwWObFaj
         b7+a7UcC9nCgSW4ePtsl+ltQjX+/dZY5Ex/Nhtq90OWeiCqm1Dn2EK13/K+QtROl+bPW
         e/iRkCg3xzWOlvKGJfdVCUUzYdh7jBFnxsxZRiTY3itkXmxU8BjA7MxGGyd/DhGl+0m/
         tdDzhrXWu6vEysZ3O6EYigSojsr2mssRm4doZqjGm9yRZXJ768CTlak1HWFRtsBXXDtz
         c0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IAn59E27ZMiFVTab4CKws9a00rFyIpke56WwNiCIdtg=;
        b=ILFFXiBERrXc2iWDmNoR0/x7ly+K6Pis4QwWjolcRHJVQZaTeO7BTc2i4mBfmUbbDE
         n8tVNI36WAZA9QGvppwrYBTAdbYeQs9rvOvFWDyvHfNPqWpTHvA733JQr/OyZltVLBpP
         CXy4Mtap41in6MorK9uDpUED397Zc4xoCkOWevxDvFPLEd88rc8WQ6sa0Nl7I0iO4lns
         to3cM6DO7LWAbQIpgjys5hbm1nwIADs70Vv2XcbMRECn6vxoCYsLjEs9rwI+zmQ7nKaq
         VoTHvOX67wC0FZYhR2CQE57P1AwVL0D6zH4S4WnY6MPXkpanbSfO1QrSMZfsLx7UHTEb
         7qcA==
X-Gm-Message-State: AGRZ1gJnqdiKmNA6Kw8rBq6HY3cM+bKmUfqrBHHQ2B3p0M4MZsxM+oqE
        etTI/ya8FXNHM4DsOsJjapg=
X-Google-Smtp-Source: AJdET5dWUoaBcyvopUuAjswIk5zXQkRRjhZT7WoO5WNAfhy6rwiOL6/VF+FSKjBYgAahfzB3hFzljA==
X-Received: by 2002:a63:f615:: with SMTP id m21mr1986650pgh.428.1542245671979;
        Wed, 14 Nov 2018 17:34:31 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:946e:e563:c52b:3556? ([2001:df0:0:200c:946e:e563:c52b:3556])
        by smtp.gmail.com with ESMTPSA id 85sm21749193pfw.17.2018.11.14.17.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 17:34:31 -0800 (PST)
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
 <20181114075817.GQ30658@n2100.armlinux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b70ae231-19f2-ef7c-f7ca-0a6486d2cb6b@gmail.com>
Date:   Thu, 15 Nov 2018 14:34:22 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114075817.GQ30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/11/18 8:58 PM, Russell King - ARM Linux wrote:
>
>> Are you saying that's not possible on arm, because the current timer rundown
>> counter can't be read while the timer is running?
>>
>> If I were to run a second timer at higher rate for clocksource, but keeping
>> the 10 ms timer as clock event (could easily do that by using timer D on
>> Atari Falcon) - how would that improve my timekeeping? Clock events still
>> only happen 10 ms apart ...
> Ah, I think you're talking about something else.
>
> You seem to be talking about what happens when time keeping interrupts
> happen.
That's what I understood your comment was about.
> I'm talking about the resolution of gettimeofday() and the other
> interfaces that are used (eg) for packet capture timestamping and
> the like - the _user_ visible effects of the timekeeping system.
>
> With the existing implementation, all these have better-than-jiffy
> resolution - in the case of RPC, that's 500ns, rather than 10ms
> which would be the case without gettimeoffset().  Removing
> gettimeoffset() as Finn has proposed without preserving that
> resolution is simply completely unacceptable.

I agree - but Finn had also offered to supply patches to arm that would 
have added a clocksource_read() function very much like for those m68k 
platforms that had used gettimeoffset(). I wondered what reason there 
was for these not to work on arm

I now realize you'd never seen that offer.

The proposal to drop architectures still relying on arch_gettimeoffset() 
had been raising enough of a response on linux-m68k to make me conclude 
that same proposal had been kicked on to other arch MLs affected as 
well. I'm a bit naive that way.

Now your criticism of arch_gettimeoffset() (missing timer rollover 
because the timer interrupt has been cleared by the interrupt handler) 
still stands. I just can't find the offset() functions shown in the 
5cfc8ee0bb51 patch. Any hints?

Cheers,

     Michael


