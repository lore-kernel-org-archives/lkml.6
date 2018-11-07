Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A661FC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CAE2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5oEvkFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CAE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeKGMit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:38:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42942 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeKGMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:38:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6-v6so7194424plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 19:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FvRQMKGSiR3INq9Vie5/cS4AMtrW1N4ltNzgD2BFd+Y=;
        b=c5oEvkFp4c94BEvwyauk4kKOTJXbkxFmhKr+5jqLZ6t+WlBpTh2y5j7QwVhla8VyyQ
         5WviCLjGGlUOMa3w80z+cBuUwJvGNxwYTd1l7A91ymvhi2jjSgtP+SrJleI7aDrF3o51
         nlSwUeDH7B3xxL6NPlJtbtVgZEXDxAfZjzC29XN+Z185FcKkLHMKm/rEvE51d++2Hfdd
         UbvuJM6kD8Yjka4wOawx8g8iyWck9gqEtuzgnZzxXCdYdgM2c6M35tRuG2AOyX4KSntt
         CRKZoNO/kr3KvOSi0bX6jQrZH2USlMoelEPjdSuNbD9ekwrSNf9reZZtedgowLQb0Mem
         hhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FvRQMKGSiR3INq9Vie5/cS4AMtrW1N4ltNzgD2BFd+Y=;
        b=g5m+WB4KV8rSN86dEne+AKh8m6ul7toK+VxRi07gW4YhzCmUdA1lW1Ql3PRWocSMiA
         NPP7CmPbKAic3j+h617b72co3BZEdo6io/zmn2H9AZhvpIrfgvaNLGaRFW9t0Bas7Wfd
         d6AT2JvsExK220dOvgggACn2OOKas1yRTSp7xk46sjVWRxTO9ZA2bviTCmJKMVuMRi3Q
         EobnuMXoS+ENlGwEr6fwN+Qo0RyJ/cz6orFh+oyM5reOlsMZ++SxmEPcts2Fwko/RAYk
         YjyxWOvxLZJBmT6hAYcODb4zh2YXVkMJ0QcpPctpWYV45mRIysvMU4DKHaefLstt/Hde
         3PHA==
X-Gm-Message-State: AGRZ1gKZgqAUb/oxFmcYr/B2WQhm+IsWpdDpf+/B9xqLy2fZRPl83XFg
        So+No/lYKys1GayHD0/OMCH1+JJV
X-Google-Smtp-Source: AJdET5cUyPnZGQjbc8q21bPx1Io1Y0aKif7KZCav5tZC57OV9fQpYk066/xQMlLGUhMzvpfNP7+U5A==
X-Received: by 2002:a17:902:a9:: with SMTP id a38-v6mr192261pla.7.1541560222352;
        Tue, 06 Nov 2018 19:10:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y88-v6sm44033834pfd.104.2018.11.06.19.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 19:10:21 -0800 (PST)
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Christian Kujau <lists@nerdbynature.de>,
        Brian Norris <briannorris@chromium.org>
Cc:     Genki Sky <sky@genki.is>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <43a04c4e-fa13-c162-5970-fe1aaa1ac557@roeck-us.net>
Date:   Tue, 6 Nov 2018 19:10:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 6:58 PM, Christian Kujau wrote:
> On Tue, 6 Nov 2018, Brian Norris wrote:
>>> Perhaps both scenarios could be satisfied by having
>>> scripts/setlocalversion first check if .git has write permissions, and
>>> acting accordingly. Looking into history, this actually used to be
>>> done, but cdf2bc632ebc ("scripts/setlocalversion on write-protected
>>> source tree", 2013-06-14) removed the updating of the index.
>>
>> A "writeable" check (e.g., [ -w . ]) would be sufficient for our case.
>> But I'm not so sure about that older NFS report, and I'm also not sure
>> that we should be writing to the source tree at all in this case. Maybe
>> we can also check whether there's a build output directory specified?
> 
> FWIW, the issue I reported back in 2013[0] was not an ill-configured NFS
> export, but a read-only NFS export (and then a read-write exported NFS
> export, but the user compiling the kernel did not have write permission)
> and so "test -w .git" did not help in determining if the source tree can
> actually written to. And depending on the user's shell[1], this may or may
> not still be the case.
> 
> So I'm all for the $(touch .git/some-file-here) test to decide if the
> kernel has to be modified during build.
> 
> Christian.
> 
> [0] https://lkml.org/lkml/2013/6/14/574
> [1] https://manpages.debian.org/unstable/dash/dash.1.en.html
> 
>>> However, I admit I don't understand the justification in that commit
>>> from 2013. I'm no NFS expert, but perhaps the real problem there is an
>>> incorrectly configured NFS setup (uid/gid mismatch between NFS
>>> client/server, or permissions mismatch between mount options and NFS
>>> server?). Christian Kujau: can you speak to that?
>>>
>>> Well, we could also make our check $(touch .git/some-file-here
>>> 2>/dev/null && ...) instead of $(test -w .git) to handle misconfigured
>>> NFS setups. But not sure if that has its own problems.
>>
>> Trying to 'touch' the source tree will also break us. No matter whether
>> you redirect stderr, our sandbox will still notice the build is doing
>> something fishy and complain.
> 
For whatever reason, I did not get any of the interim e-mails, only this one.
My apologies to not responding earlier. But then Brian has said it all:
Any write attempt onto the read-only file system will cause our build
system to bail out.

Also, again: I think it is reasonable to expect that the source tree
is not touched if an output directory is specified. Any write attempt
violates this assumption. This most definitely includes any "touch"
commands on the source tree.

Thanks,
Guenter
