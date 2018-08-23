Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5B92152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wnw0hXaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5B92152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHXCq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:46:56 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:40487 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeHXCq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:46:56 -0400
Received: by mail-it0-f49.google.com with SMTP id h23-v6so9787987ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6FbHeQunNScSG0Uwffqop67W9nwXKbqVsBjxungr8TY=;
        b=wnw0hXaKY3uoVAcbkbP+yOI0PPvwk7rQ2CZPH83YH/e740wI8L7sJAB1AiBZqBcyAX
         czfBkl0c4iNKl7rER/DJRPibK3Qlx1yL1bd+pKzUWZKLuAdarrJaPSTJEd7L2ONtUter
         /WGhDnPEr8pFxKwqg3EzIMpWZuf2zoSSLfF/JpzF/J9H+0MlctqZMysQ3oWrwYhpGjms
         y9gAd3hdHaC/9Kl0HfWB/VoM95iY4iCflajOf1zbYo3LpZ+BYnG7b6ygE8jF/jn4lm45
         83FjwMIblNVLTTDRXiP6OBEd6tLE+MjL2ALluujjfGrgMaUnzfIhF3Aal+PHnPM+E/vW
         LXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FbHeQunNScSG0Uwffqop67W9nwXKbqVsBjxungr8TY=;
        b=HP4Q5whwa8AGQUyoiZn/wKegKbOG33jzWaCz7PXHz+TEEePCzAqrpciolZ1mJprCZE
         Masd10MzqzG3AkprTiW7WVbf7uwFqP1WDe5myuwLxEpaeV+tHYIXQ1r0CRyEY/H7Kopk
         +Yj5hngptzP+d86tWmuyBOoN4GmRCj8zT8pmxdfOT/CJFA1348AIIhNAzA9es6TlRxxT
         VuKSs67m4PLmhtdNIJMnsN8xaaBcLVxkUDP3SjOzG25ix2k+sGyD9puhYtLWokFPO/L5
         nZhZ9WJ87nuX8qfX5mnZdC5Tb9hfo15yOhyzelrBmf4qrirtZc6wVWBd0MjHyoLh9Pb2
         5N7Q==
X-Gm-Message-State: APzg51CkP+xS5vNH23q84Q4mb/ebnNahvqYgUf3CRerFpycpX3uX57pL
        LldwYVEHzBT2j5G3ucup5O3lft0NB6g=
X-Google-Smtp-Source: ANB0VdZC/62fpP61glsiZFRS/nwaDkxOKJ/LG4zG46e23DmD+BlcrdBXglN7o34SAEEY3/VGEl9KIg==
X-Received: by 2002:a02:892a:: with SMTP id o39-v6mr1269857jaj.102.1535066100359;
        Thu, 23 Aug 2018 16:15:00 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id q196-v6sm2216693iod.23.2018.08.23.16.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:14:59 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
From:   Jens Axboe <axboe@kernel.dk>
To:     Anchal Agarwal <anchalag@amzn.com>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        jianchao.w.wang@oracle.com
Cc:     "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
Message-ID: <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
Date:   Thu, 23 Aug 2018 17:14:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 5:03 PM, Jens Axboe wrote:
>> Hi Jens, This patch looks much cleaner for sure as Frank pointed out
>> too. Basically this looks similar to wake_up_nr only making sure that
>> those woken up requests won't get reordered. This does solves the
>> thundering herd issue. However, I tested the patch against my
>> application and lock contention numbers rose to around 10 times from
>> what I had from your last 3 patches.  Again this did add to drop in
>> of total files read by 0.12% and rate at which they were read by
>> 0.02% but this is not a very significant drop. Is lock contention
>> worth the tradeoff?  I also added missing
>> __set_current_state(TASK_RUNNING) to the patch for testing.
> 
> Can you try this variant? I don't think we need a
> __set_current_state() after io_schedule(), should be fine as-is.
> 
> I'm not surprised this will raise contention a bit, since we're now
> waking N tasks potentially, if N can queue. With the initial change,
> we'd always just wake one.  That is arguably incorrect. You say it's
> 10 times higher contention, how does that compare to before your
> patch?
> 
> Is it possible to run something that looks like your workload?

Additionally, is the contention you are seeing the wait queue, or the
atomic counter? When you say lock contention, I'm inclined to think it's
the rqw->wait.lock.

-- 
Jens Axboe

