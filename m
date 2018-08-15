Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA013C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C25221727
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9P+CyBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25221727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeHODwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:52:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40571 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeHODw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:52:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so9013655plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cSEaXrf+KtMT2F3w1T/DXVBnE0WPJqCKF7lVRY5HeQM=;
        b=L9P+CyBWiwBDVO7idd4I4Mztosa+b0+Id0tOdY0uoi77p4V1T9rwR9LaE8btGH4Ovt
         yPrsbE4QfHC7mn6gXPr/xH1JWvoh9A9c8C97udX3NBPW4Xc72EO6iOMBwoDd1y7E1l7c
         XM4XOOGRlthjcEzpkxuFe3OgtSkOfOrk1ppLcOtiSGfHnNltYmhC+cy9NwtYCww5Aq8T
         /W/svdltiwL9r3jLvvjMWrsUJBYu9Rgzh8DFM3JazOSJy8LKWBHCPshdWfe3LFBknVvl
         EDXN9YmupBqiJToZ9p171CPkY5p+sLUBiOnmGDP6gHG1Y+rEd3kJVUvd8nqU+q9DBq+W
         qlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cSEaXrf+KtMT2F3w1T/DXVBnE0WPJqCKF7lVRY5HeQM=;
        b=faFL7Y4v/hdZzcvuxGVYhdwJ2YS265f+dEhJ9c1KBBAttOoHSpqGyjhupc3ji/WJDx
         RmqxYiRYPQXNGiP/6u5qWI4NQsv0brL6AImvG8mZ0xJiHLhDIojVCPJ9NxRk8gI+RWIn
         hDss5noJ55O1b+cZk/pDKPnFW9S2nWy0vWWKBToqO5TH8ZW+IQVcr0y52+kx8wKWSLz3
         sfA+BGjfhl6mfM9MuKZioQKqIcmjebDuyulCzN4iKWP4UVLNUCtqP36stwd1OXB2H58r
         +VG4tI0r2u+4xwg1QRcQYxUoVJeugIzKocrl1hDfJEcdVZwPj2LnZSRFEebhZrIeqL5+
         8YGQ==
X-Gm-Message-State: AOUpUlHewjrISaEYxdZ1ksxjo3dTS/+znQO0rF3hrkUlVXGCsg+OEjGi
        O5VVq7wE2UOJuhwFq1zNxV0=
X-Google-Smtp-Source: AA+uWPyncWZKBOIFrjPcP1SSmitPRDxba3Sqo5O64RKYGaI5XO1enMtszgnrVhmr3xpI9kHhWS4mLQ==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr22153904plc.221.1534294962598;
        Tue, 14 Aug 2018 18:02:42 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f184-v6sm36897825pfc.88.2018.08.14.18.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 18:02:42 -0700 (PDT)
Subject: Re: Build failures with gcc 4.5 and older
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180814170904.GA12768@roeck-us.net>
 <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
 <20180814221559.GA15888@roeck-us.net>
 <20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org>
 <CA+55aFyU6p-da4j0TWQTEkvYDK_ymFDeTfBa9htYXrdH5gahgQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <87ca655c-e73a-286f-e69d-30fed9d00d77@roeck-us.net>
Date:   Tue, 14 Aug 2018 18:02:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFyU6p-da4j0TWQTEkvYDK_ymFDeTfBa9htYXrdH5gahgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 04:20 PM, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 4:02 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> The m68k build still fails because 0cc3cd21657 ("cpu/hotplug: Boot HT
>> siblings at least once") was evidently never tested on CONFIG_SMP=n.
>> How could that come about - the patch is six weeks old??
> 
> Ehh, meet the joys of embargoes.
> 
> The code was tested (and people even found subtle arm64 problems due
> to that testing), but because it couldn't be made public until today,
> it didn't go through all the usual infrastructure we depend on.
> 
> But:
> 
>> kernel/cpu.c: In function 'boot_cpu_hotplug_init':
>> kernel/cpu.c:2275:2: error: 'struct cpuhp_cpu_state' has no member named 'booted_once'
> 
> it should be fixed now in -git.
> 
>> @@ -490,6 +490,8 @@ struct mm_struct {
>>   #endif
>>          } __randomize_layout;
>>
>> +       int wibble;
>> +
> 
> Can we call this something informative? Like
> 
>          int __gcc_4_4_is_garbage_that_shouldnt_be_used;
> 
> or something?
> 
> That is, if we actually want to really drag out this whole pointless
> pain of allowing ancient compilers?
> 
> Guys, at some point we need to switch to 4.6. The people who feel the
> pain today *will* feel the pain at some point. Just get it over with
> already.
> 

For my part I am all for making gcc 4.6 mandatory.

Guenter

