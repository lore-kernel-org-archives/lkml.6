Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860C5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230962087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xlSuGGOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230962087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbeGMTyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:54:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38563 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbeGMTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:54:16 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so13063922itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2AmQ0VTKxwSuOCR3O0WZpBGUfkMkXCmQeA5iFYEu7fQ=;
        b=xlSuGGOcw0bdzSdRuVmV/NYfMDrfSpw7VrGnM3ki83suOvhg1G6Q/aNYeHSvN8nbuF
         FTxyHkcLyj/T2loqYv6E6q7sk5FpFcf/6V8M5hPGrHGYXgLkcmmBeE51fm33WmA/+SDV
         l9fuyWey7CwKOB7JGDthf3+6OCORo5LVIPX311JtHLra6l3NoQOPmcVdbIEh9L/HSKKB
         mw8rKMk3fAvvvXZVpVrpUHhslrOS6KFFdZtlay5lkyb0ykScsBADQTbtsK1PQEQ5e7Wj
         /KWmBuCXZc5b1MJLKrA2dFQ+v4r1OHxG6VHSno4BNY2UaFPQn7tqg+aAEZeTnCqkPS1Q
         oT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2AmQ0VTKxwSuOCR3O0WZpBGUfkMkXCmQeA5iFYEu7fQ=;
        b=UIYfd28iQBHp+SPurn1KzXGNCOJ1jUHKxpi1JUqP7kiStwxG5v67OWZpBBPccNl+NJ
         MWKvK9FgtX1X9vXk6MWq+47I0eaqqQal23usuh2OLEVUJGkvsEE7m00dT3F+EEtdesaf
         r+qiDuJnfpoS+ayZuNLMjH3rk9O9ayb1lNVC2OI1rWLP+1bMTGl9Ji2VvAYIIiFSEFSo
         FoJ1PEW5KMdWLBOtNI/bqH3U9IXbpgwwPMlDOO4Ova3b6NU+auVoNj4GIodOV2WbpxZg
         08HRWWO8o/eMSbYg8P1VNxKM6BbwNFWZnxlWyK3FPvQXYjm0QKoIXY81JR+9LmlNYbdb
         88fw==
X-Gm-Message-State: AOUpUlGF7oLBH1pr95vM2jSdkYxQYOUW4tv9sp6EYcSGuh/9JiDvkQ+Z
        79gmjjnK7qmJI7bXuwW6Tc4yUrGT0wg=
X-Google-Smtp-Source: AAOMgpdxktQfNCpO0PC6SCaEqovvTCL09vMey8wPAvEpj04NHq89SWMrU0JQtnte7cgHIA1iY+g6PQ==
X-Received: by 2002:a24:a342:: with SMTP id p63-v6mr6056334ite.67.1531510695617;
        Fri, 13 Jul 2018 12:38:15 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id g3-v6sm3384596ioa.57.2018.07.13.12.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 12:38:14 -0700 (PDT)
Subject: Re: [PATCH] [v2] bcache: stop using the deprecated get_seconds()
To:     Arnd Bergmann <arnd@arndb.de>, Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180622134907.227131-1-arnd@arndb.de>
 <b5de0a86-b3cd-9e45-ac39-9c4eb7611016@suse.de>
 <CAK8P3a3FULT7uakRyZ4Nfq3E-ij+Gkn06=XP4Rn2m9u4Wd2OWA@mail.gmail.com>
 <83724892-de0f-40ff-e16a-792a90d77ff1@suse.de>
 <CAK8P3a0GDUpXQ8WnS6ake2AuAu0Q1gZg+hFQVPgXCBqQ1sS+jw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b73a9580-849a-d946-b203-2eacc31509eb@kernel.dk>
Date:   Fri, 13 Jul 2018 13:38:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0GDUpXQ8WnS6ake2AuAu0Q1gZg+hFQVPgXCBqQ1sS+jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/18 12:57 PM, Arnd Bergmann wrote:
> On Fri, Jul 13, 2018 at 5:34 PM, Coly Li <colyli@suse.de> wrote:
>> On 2018/7/13 10:20 PM, Arnd Bergmann wrote:
>>> On Sat, Jun 23, 2018 at 10:12 AM, Coly Li <colyli@suse.de> wrote:
> 
>>>> Added to 4.19 for-next.
>>>
>>> I noticed this isn't part of linux-next (yet). Did it get dropped?
>>>
>>>       Arnd
>>>
>> Hi Arnd,
>>
>> It is here,
>> https://git.kernel.org/pub/scm/linux/kernel/git/colyli/bcache-patches.git/tree/for-next/0004-bcache-stop-using-the-deprecated-get_seconds.patch
> 
> Ok, thanks for the confirmation!
> 
>> It is for Linux v4.19, the merge window is not available yet, and I
>> don't post them to Jens yet.
> 
> That sounds like an odd way to handle your patches. Normally all patches
> should be part of linux-next *before* the merge window so they get tested
> as part of the linux-next kernel before the pull request to Linus is sent.
> 
> It's not important for me for this particular patch, but generally speaking,
> the Documentation/process/2.Process.rst states:
> 
> "all patches merged during a given merge window should really have found
> their way into linux-next some time before the merge window opens."

Coly does generally send before the merge window, I think the phrasing
is just a little bit off. Depending on risk, I usually tell folks to
submit their stuff for the next window at no later than -rc5 time,
so it'll be in for-next for a least two weeks before the merge window
opens.

-- 
Jens Axboe

