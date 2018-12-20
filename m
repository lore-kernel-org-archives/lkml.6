Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92314C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5890A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UsS/x8NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeLTQOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:14:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37053 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeLTQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:14:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so1154082pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t7iPXpXpK3Mq4fFfTxgTP4i5n9JX2ZwsO2lQqvbKCb4=;
        b=UsS/x8NOkZIhlYVdH7a+5CHP5nfePJi446jYvwjnfgxUg5Rjnd+v1VH6CCaSwuwzGl
         igVvZxI46/GZ8oJ8akHI35M56pNGbQmH3GGbz5It5GUiUkPzms9L13q6YSb5lH3i04o8
         0w6JCbgdU+f0X99YmdWNUmgKRnQPqXIkiGXPXNJ+DSOaKp4XMscVlHuJHEVpcRotXh9p
         98yQvl+kN8FnwxCsVt/I44/4k2BY0Xkm3geDBfs1DgfFCrBambI5MRCM9p4SW6VeY+j6
         +PV07k7kJAORBHaGDIqVt3txsx2gCHP8YGYCs0w5mWTgYAbsX6kRyr870CGPvdTrsYyI
         blDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t7iPXpXpK3Mq4fFfTxgTP4i5n9JX2ZwsO2lQqvbKCb4=;
        b=EX6+KXx52V6fVJ2BS7bPmQtfCxIrbczg3lqS75HF3x45TzFFsjioVrB6Z/zmBvgjg2
         BxT4CHJu2xqnocowTD6llzmaiVelRVV0EWWDw7qBjhwBQJ+SNg52ljTES7vfqdhoOQqp
         0O62DTQjcgpSrcBHPn7da8WcFnwNf/nGJCuPYmSnn0Ps7VMbnHE0kBr/TghKhMYLBYTo
         jKsFMoKxdMEhn0/PGYoQ4WjwM6aihjqHSeGEhIfikrwPpBhiPMWlFWlmwPBtkv/4eRW/
         wSNqBJeUjZLAueTuCSV8CUm95nuLrIUuaCe8xYLYGPtxb2+7nwRrQx3xBVlvOqlgUQ+f
         Rouw==
X-Gm-Message-State: AA+aEWbnjkxFBZXhzYV4QwyY7T6G4fLferbkxpVwNVkDK6d9gyqInbRH
        8nmG/cLr7ZkSMLxvZgsOnYGoAusZ7q7HpA==
X-Google-Smtp-Source: AFSGD/VhyFi2l+hPsIPnnT2Gt1tAHtHPO6WVUXfNnjMw+tRdef4atKAYoQb8fTziz8Pce7nOQYIdJA==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr22175128pgc.336.1545322493187;
        Thu, 20 Dec 2018 08:14:53 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m198sm36202769pga.10.2018.12.20.08.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:14:52 -0800 (PST)
Subject: Re: [ide] ec7d9c9ce8: WARNING:at_fs/proc/generic.c:#remove_proc_entry
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        linux-ide@vger.kernel.org
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
 <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd9cad88-08c6-ee65-abef-eaa8a4540019@kernel.dk>
Date:   Thu, 20 Dec 2018 09:14:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 9:05 AM, Linus Torvalds wrote:
> On Thu, Dec 20, 2018 at 1:19 AM kernel test robot <lkp@intel.com> wrote:
>>
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: ec7d9c9ce897174243af4fcd201dbfc34df0f3a3 ("ide: replace ->proc_fops with ->proc_show")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Funky.  How did the kernel test robot suddenly figure out an 8-month
> old problem?
> 
>> [   44.180514] WARNING: CPU: 1 PID: 165 at fs/proc/generic.c:662 remove_proc_entry+0xb9/0x155
> 
> This is a warning for somebody doing "remove_proc_entry() on a name
> that doesn't actually exist in that /proc directory.
> 
> In this case, it does seem to be due to the named commit adding a
> 
> +               remove_proc_entry("settings", drive->proc);
> 
> to ide_proc_unregister_device(), and looking at the patch I get the
> feeling that it's due to a typo: the code *creates* the file called
> "setting", but removes the file "settings". Note the missing "s" at
> creation time.
> 
> And yes, the name of the /proc file _should_be "settings", judging by
> the rest of the patch.
> 
> So it does seem to be a real bug. Nobody noticed until now? Why did
> the test robot suddenly react to it?

Maybe the the tiny subset of IDE users don't actually have the proc
stuff enabled? A few months ago I did plenty of IDE testing with the
MQ conversion, but I never saw anything like this. I'm guessing that
I, too, did not have IDE_PROC_FS enabled.

Christoph, do you want to post the one-liner fix for this one?

-- 
Jens Axboe

