Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE96C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391782064E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWdr9UwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391782064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHXQot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:44:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41057 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeHXQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:44:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so7439657wrb.8;
        Fri, 24 Aug 2018 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z9fwr1p0j29M5pX+hHePqaRjQrYvU21fMOgn+9Z3uZs=;
        b=YWdr9UwYeAitsOASTrf+/Y87FayyWSBHJuhbFIu0V5tVlKNTS31mBe1+5cBi0QmyNn
         WXCy2gRLSkwl+Q0xNu1VSnMjse3kuMiE51hkhM9tQ3CcISs3AOS92941o5VksIljtbv2
         840xhtB7UgYuSuY09B5O7wF6YmT359lGQNxE7NDTxVLfaNBScaloGL+yHjOqNvRG8cyU
         B97HRHR0oPghyiaxKb6zfjCDUff4gIcpfEoDY2NwZPKvKI2P5jmPa0T8WiWub08ZmrJ8
         8YxHW4ZkTX8sM89dIeIlJui5P+Z19q+w6KpWFdhu+E/QgN004W1oW3PoPzmXOvyX5spD
         3H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=z9fwr1p0j29M5pX+hHePqaRjQrYvU21fMOgn+9Z3uZs=;
        b=EoeP6mezh8DKQTsgR1VBsnYvPJfiALH0v6DnBF8cDp3cewCiEyJnlKncVXDxTTBQX1
         svyO7GFrEe4i50QOxjQnCOZcSRa4kiHgGdtWzrWU7UcK0Asif93YGPBAJ9YtTSPfDswa
         L0wfA/Df11YDMimgR5jcXdV9m59KJG11245JMvcdDfT5W9rOxCmzxpn1Hg1Q8/YYAAPL
         i5lxzR16fSZXPL3DhOqyYof1hduifA2wXiOsogU9xVinE1CPQx6nWyOgVg/YPr6mpEUT
         Y+KJezjFUkvjeAc1/eqT/eBjVBTYflS3W7mbtdTHcsdFZa26GIhaMSVipxcCxTAQLIOb
         Jvlg==
X-Gm-Message-State: APzg51BDnvNnytF1eK96qyKb8uKEzDkYNtPSE4rJ2u1dF2GhQaMWM7Tr
        HwV09wnCt3kzqwLH1ZHNmNQ=
X-Google-Smtp-Source: ANB0VdbpCmYd8F4oTNdpIyAeS1hqWcNDcyiC1uGnCUiVcYpNJV7RdOaiXEj8lIsYhuTDKwBXq9VjoA==
X-Received: by 2002:adf:c754:: with SMTP id b20-v6mr1234077wrh.134.1535116211530;
        Fri, 24 Aug 2018 06:10:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id w3-v6sm5572675wrn.16.2018.08.24.06.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:10:11 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
 <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
 <b11df415-baf8-0a41-3c16-60dfe8d32bd3@amd.com>
 <20180824130132.GP29735@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <23d071d2-82e4-9b78-1000-be44db5f6523@gmail.com>
Date:   Fri, 24 Aug 2018 15:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824130132.GP29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 15:01 schrieb Michal Hocko:
> On Fri 24-08-18 14:52:26, Christian König wrote:
>> Am 24.08.2018 um 14:33 schrieb Michal Hocko:
> [...]
>>> Thiking about it some more, I can imagine that a notifier callback which
>>> performs an allocation might trigger a memory reclaim and that in turn
>>> might trigger a notifier to be invoked and recurse. But notifier
>>> shouldn't really allocate memory. They are called from deep MM code
>>> paths and this would be extremely deadlock prone. Maybe Jerome can come
>>> up some more realistic scenario. If not then I would propose to simplify
>>> the locking here. We have lockdep to catch self deadlocks and it is
>>> always better to handle a specific issue rather than having a code
>>> without a clear indication how it can recurse.
>> Well I agree that we should probably fix that, but I have some concerns to
>> remove the existing workaround.
>>
>> See we added that to get rid of a real problem in a customer environment and
>> I don't want to that to show up again.
> It would really help to know more about that case and fix it properly
> rather than workaround it like this. Anyway, let me think how to handle
> the non-blocking notifier invocation then. I was not able to come up
> with anything remotely sane yet.

With avoiding allocating memory in the write lock path I don't see an 
issue any more with that.

All what the write lock path does now is adding items to a linked lists, 
arrays etc....

So there is no more blocking involved here and the read lock side should 
be able to grab the lock immediately.

Christian.
