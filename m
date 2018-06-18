Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E934AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980EC208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xn9kPbgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980EC208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeFRPhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:37:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35717 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeFRPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:37:05 -0400
Received: by mail-it0-f65.google.com with SMTP id a3-v6so12625430itd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eD0KsrRTJygWTaRVzQ/jkSxHJCZODSpzktrngUa0UZI=;
        b=xn9kPbgZSc+S10XboiYMR59nvZ+OCXna4cghFbp/hnB8URGheSHPLgfKsvc06bnZ+Z
         4SdMYjdIQYSbccXqN9Jt3Gk0aBhDfu/d3fiJ37FR71xcuMZ4J/bfPfMgN224kMLucJe8
         rUd/7FVZh3GJmyuFWbeCeDnfhTGhkAxV7DdzwuZdTgLfPBG/GSvsOC6aZOrRSWgk0nnG
         iMrW2qoM2joV7QAiMaP/tIznZISDzmzWrRNMg2W5GT02VZZ4+C43TcssIdL2cL2WRtt4
         Si3lpgxeNke/g3vYf9rasG0TlNI8mAMIK54H5KFCfnrNaM7wYFtMPmwhnSPaVuzQaZkI
         SFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eD0KsrRTJygWTaRVzQ/jkSxHJCZODSpzktrngUa0UZI=;
        b=H2anaPDbXzHYhyr0Hqg2XJNle39GoAbZgYHBo8gKcNOJle9a/DDBUvShn3BhIR/ET0
         rI7x/RVmv//bX3b4sjhEJEqJrGQJPgBXW5BoW1kp5pCA27izh8fQ5SBkXYGH+ojou6G+
         uXt/zAdDfdvjlETJ+LBMqSrTOxlspP+WffnoZNBweLmCimAxDRWczR2f4RmI2GsOWDs1
         iRxIsNWd9JsICzSLapCmz036bJ+K/SypRb6ExFZNxhoOIEmB+mJlWn3TXTQGHj9ByJVr
         dqY/UElh0cy7NBAFSWt9r3lfexRMxbyRD9jeLtcgfCh2WriNGUpR94Dm31MLy6Iwwgsb
         KoLA==
X-Gm-Message-State: APt69E1wrP6b4dfNYr7XuoqzLePSAflktawwIq7jlyzpNKRdCFrfHflq
        +Nt1yZdW8pVJkoGuqPCNtapzBw==
X-Google-Smtp-Source: ADUXVKKuyaIy+XLqM1i15pD4licYkqFbfjQU7jNn8ujqLo5TJ41kv3xozDWy0WH110CMwJUGyYB3Bw==
X-Received: by 2002:a24:4563:: with SMTP id y96-v6mr10097136ita.112.1529336224691;
        Mon, 18 Jun 2018 08:37:04 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m13-v6sm5785331iob.86.2018.06.18.08.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:37:03 -0700 (PDT)
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
To:     dgilbert@interlog.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Jann Horn <jannh@google.com>
Cc:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        security@kernel.org
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
Date:   Mon, 18 Jun 2018 09:37:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/18 2:47 PM, Douglas Gilbert wrote:
> On 2018-06-15 12:40 PM, Al Viro wrote:
>> On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
>>
>>> I've mostly copypasted ib_safe_file_access() over as
>>> scsi_safe_file_access() because I couldn't find a good common header -
>>> please tell me if you know a better way.
>>> The duplicate pr_err_once() calls are so that each of them fires once;
>>> otherwise, this would probably have to be a macro.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>> ---
>>
>> WTF do you mean, in ->release()?  That makes no sense whatsoever -
>> what kind of copy_{to,from}_user() would be possible in there?
> 
> The folks responsible are no longer active in kernel development ***
> but as far as I know the async write(command), read(response) were
> added to bsg over 10 years ago as proof-of-concept and never properly
> worked in this async mode. The biggest design problem with it that I'm

It was born with that mode, but I don't think anyone ever really used it.
So it might feasible to simply yank it. That said, just doing a prune
mode at ->release() time doesn't seem like such a hard task.

> aware of is that two tasks which issue write(commands) at about the
> same time to the same device can receive one another's read(response).
> The tracking of which response belongs to which task is in part the
> reason why the sg driver's data structures are more complex than the
> bsg driver's are. Hence the code work to fix that problem in the bsg
> driver is not trivial and probably a reason why no-one has attempted it.
> 
> Once real world users (needing an async SCSI (or general storage)
> pass-through) find out about that bsg "feature", they don't use it.
> They use the sg driver or something else. So the fact that bsg has
> other glaring errors in it in async mode is no surprise to me.
> 
> When I took over the maintenance of the sg driver in 1998, it only
> had an async (i.e. write(command), read(response)) interface.
> The SG_IO ioctl was added at the suggestion of Jørg Schilling (of
> cdrecord "fame"). The sg driver implementation was essentially to
> put a write(command) and read(response) back-to-back. The bsg driver
> came along later and started with the synchronous SG_IO ioctl
> interface only. The async write(command)/read(response) functionality
> was added later to bsg. Perhaps that part of the bsg driver should be
> deprecated/withdrawn if a maintainer/rewriter cannot be found.
> [BTW the bsg sync SG_IO ioctl implementation can probably get the
> wrong response, it's just that the window is a lot narrower.]

Feature wise, I don't think it ever changed. The read/write async
mode was included from the get-go.

> 
> That said, the bsg driver has lots of other users. For example it is
> the only generic pass-through in Linux for the SAS Management Protocol
> (SMP) used to control SAS based storage enclosures. I have a user space
> package based on it (in Linux) called smp_utils which works well IMO.
> However disk enclosures won't typically have contention between users
> trying to control them and I'm not aware of any disk enclosures that
> support Persistent Reservations. So the bsg driver's "async" problems
> are not a practical issue in this case. Also I believe some high end
> storage hardware uses bsg to communicate with their hardware from their
> user space tools.
> 
> 
> Just some observations from an interested observer ...
> 
> Doug Gilbert
> 
> 
> *** Well Jens Axbø's Copyright notice is on the bsg driver, together with
>      and Peter M. Jones. Since I have been watching the bsg driver I'm
>      not aware of any substantial patches or reworks for them. As far as
>      I know FUJITA Tomonori did a ground up rewrite of it and he no longer
>      works in this area. Makes you wonder what exactly Copyright banners
>      mean on some code; 10, 15, 20 years on.

It was never re-written. I handed it over to Fujita about 11 years ago,
but there was never any rewrite.

BTW, don't ever write my name like that, the 'oe' is not a spelled out
ascii variant, it's my name. For Jörg, it's o with umlaut, not the
Danish/Norwegian variant (he's German).

-- 
Jens Axboe

