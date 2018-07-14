Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75225ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC022083D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9HtKj1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC022083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeGNS5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:57:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43700 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:57:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so24327022pfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WB0Zz/rAsfeWswcfl40p9lY8RZ5IGAEv00EqhT4CZUQ=;
        b=f9HtKj1tk9pDekBM0sT7LiqrNRuli0anAsSbZ4Q/+mJU/5m9SIqpJFDSRM6KoAvWaN
         R1XV1x6eVnfceGqH7mAR5KLl1MyyBdEnVLUShT00Fu6yTU2QqsoW2n0vkfS+3MQZ6QNQ
         0UB+SxXcdXFKBa5EOcx9wKaauULb6pso34S2l5dfSQ740qcPyzHj+tWt/Mp/aDbr5QnP
         h4rlWE8RJZmldu3rZu8Rcig3wGJ3cFzEfcP1mivu0WP1iWCd9h1ZefGyAWQ4A2PLuL1C
         mHCm1SrVZiQ0diZvM3QrSKtSPdE5nvGeMaJCGkoU5RrI53V/k14/V5Ta+7HpKLl7YihM
         T2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WB0Zz/rAsfeWswcfl40p9lY8RZ5IGAEv00EqhT4CZUQ=;
        b=rEMUJVRSkVDWiMv/esLmbQaAW0l7upVBApoIPi3+v9h29geSzRY9Weg33Dii/zMUG5
         WpeVIzo6VdjGN2Go9MlY936IB5k/2c990Hp0u7Cfae0nR2NZI/K0++jrHKG1yGw3sEHn
         KC300Rxqxa0+8IG42lcZY1hQxEa0uM+/Lk+hIokk9Pbr554XcJo5PhmMQs2F+FcoQX30
         9gBQ6ExmAn8CmEMH5uhehLSFR1orTGxOWDqyK1FMFpoUsADKY3I77bEF93oo1zGjcv9s
         40iKO2UuPLrkaXoY70gQanzi8a3LPhMjTSjbt8UyS3/ABxQEY72u5yrCD4dgkz+6jGkq
         5LBg==
X-Gm-Message-State: AOUpUlGw5DVrF2+HcEUb7eNjF4ZPplJZZX7Wdtz5ijY0U9hSUQoOVeEt
        OxPHFzIF2om3dfDU5QvpJ5mTPQ==
X-Google-Smtp-Source: AAOMgpeIMv2LuqgIUBkPJJ+ICXnhKbmdWGgoYLuDzC1Z6/JIOZetHYPH+etNqn1+bnsEr3yZOvHjAA==
X-Received: by 2002:a65:4c41:: with SMTP id l1-v6mr10562905pgr.310.1531593472821;
        Sat, 14 Jul 2018 11:37:52 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s27-v6sm30702564pfk.133.2018.07.14.11.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 11:37:51 -0700 (PDT)
Subject: Re: [Ksummit-discuss] bug-introducing patches
To:     Pavel Machek <pavel@ucw.cz>, Willy Tarreau <w@1wt.eu>
Cc:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org> <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu> <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu> <20180714173812.xhfwtcijlxebmn2k@devuan>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1198cd9-9113-d231-d15a-31ac5224b3b1@roeck-us.net>
Date:   Sat, 14 Jul 2018 11:37:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180714173812.xhfwtcijlxebmn2k@devuan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/2018 10:38 AM, Pavel Machek wrote:
> Hi!
> 
>>> The way I see it, if a commit can get one or two tested-by, it's a good
>>> alternative to a week in -next.
>>
>> Agreed. Even their own actually. And I'm not kidding. Those who run large
>> amounts of tests on certain patches could really mention is in tested-by,
>> as opposed to the most common cases where the code was just regularly
>> tested.
> 
> Actually, it would be cool to get "Tested: no" and "Tested: compile"
> tags in the commit mesages. Sometimes it is clear from the context
> that patch was not tested (treewide update of time to 64bit), but
> sometime it is not.
> 
> This is especially problem for -stable, as it seems that lately
> patches are backported from new version without any testing.


When I started my own testing some five years ago, most architectures
did not even build in stable releases. At that time, the only tests being
done on stable release candidates were a number of build tests, and most
of the results were ignored.

Today, we have 0day, kernelci, kerneltests, Linaro's LKFT, and more, plus
several merge and boot tests done by individuals. Stable release candidates
are build tested on all supported architectures, with hundreds of configurations.
Each stable release candidate is boot tested on qemu with more than 150
configurations on each architecture supported by qemu. A substantial amount of
boot tests run on real hardware. On key architectures, more sophisticated tests
such as kerneltests and LTP ensure that no new regressions are introduced.

What is new is that many more patches are being applied and backported
to stable releases, at least to degree due to Sasha's scripts, but also due
to tools like syzbot running on older kernels and finding problems which
have been fixed upstream, but the fix has not been backported.

At the same time, stable release test coverage has been improved substantially
over the last few years. I am _much_ more confident with stable releases
than I used to be a few of years ago.

Sure, there are regressions. However, the regression rate is very low (last
time I checked it was around 0.1% to 0.3% per stable release for us). Sure,
I would like to further reduce regression rate, to improve stability but also
because each and every regression is used by someone to argue that stable releases
would be unreliable. However, this is more a matter of perception than reality.
Reality is that more than 90% of all CVEs are fixed in stable releases by the time
they are published as affecting a stable release. Reality is that a substantial
percentage of problems reported by syzbot _are_ being fixed in stable releases.
Reality is that, by the time bugs are reported from the field, it is more and
more likely that we find out that the bug has already been fixed in a later
release due to a stable release merge.

Given all that, I think it is quite misleading to claim that the number of
patches applied to stable releases would create additional problems, or that
patches would be applied "without any testing". On the contrary, I would argue
that the additional testing now being performed _enabled_ us to apply more
patches (bug fixes) to stable releases.

Sure, testing is still far from perfect and needs to be improved. However,
requiring that every patch applied to stable releases be tested individually
(where ? on all affected architectures ?) would be the wrong direction.
What we need to do is to further improve test coverage. We should have no
regressions, but we need to get there by improving test coverage, not by
demanding explicit per-patch and per-release testing (which would be all
but impossible anyway - no one has the infrastructure necessary to test
a patch on all affected architectures).

I would encourage everyone interested in kernel testing to attend the
kernel test sessions at Linux Plumbers and ELC later this year to discuss
concerns and possible solutions.

Thanks,
Guenter
