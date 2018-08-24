Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83732C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2963E2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfrmM8wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2963E2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeHXRDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:03:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHXRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:03:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so7514718wrc.0;
        Fri, 24 Aug 2018 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GC5h/f2aVbYgMn//UjkSMiRXo2c9S9A1Slswqjt5+Fg=;
        b=BfrmM8wk2XoixWjLyDDlzcmi4/74IFH5qMO9WnZUYiiSI/A+LZIr0RzmTRZG8kMhye
         3vjTbCGzRBhTjBoRG4UzmNDtBeU9v0sQfmKm+DX+Byie0nY3lMJzmhrST+hW8I1tV4ds
         n/0umVKI3n2kZKAdo5vntl3kZe+zQx+mSVV0rbEp8E/V8T2uq/5JUNt0bO/q7GUoj/TN
         +6rpTdHpplDUnjf0+E5RmJ7Y8BEShZ6it9kf5OMTS63phqpvg1cjlOm1qZ3Yeoa0oCaU
         bVoFJR/HVYss3I5wa/YneGDzpbEOCoQMo66k3/pMecat+dw39OiXgeO+7bBH+cPd9jto
         MVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=GC5h/f2aVbYgMn//UjkSMiRXo2c9S9A1Slswqjt5+Fg=;
        b=VlkXCARWFJ/l8fZ4SWacVi4jGcvgBrFnCNUv3rz4aN+RU0rCeDvQouIogQ904/8XL4
         2s9dDz6ggQqT6a0xbLVD5d2h9ykw4++zLx1XpCtBHvjb4ceFCx/mdzp9/h3PI4NWVQc1
         aYlR8tg1dfxAykdFNsL0UdUjk0U1yaVRq6FUYe2hUj72QHvkkPNGb7DrLRWZ71F1P0KD
         YOyNw2z4skJSOKXyUeFyWq+tOS4i8M3EkuE9O9eIQa8nAem1PunxWj9xgMUaY/fFJu9o
         IKYSJPgL0DVkYYiKomqym7xFrxAglzu3dBsPRNMlyK1BKWoihWu1ZbjPkfJIRpPvKN20
         kIMw==
X-Gm-Message-State: APzg51De/CuahEHMJdY7Ap1xtcYJf5J4dKbJCYhRkyDacs2Fg1lmM3jW
        dgrpohEFQ/hSWwC9njviKtQ=
X-Google-Smtp-Source: ANB0VdZS0cId1e9y2GNJRtcAOHAkX2421TcYKIxr+I9Vq3TFJdSprxPbEfwZP591Hjnm8/iJnkqkWg==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr1230411wrc.45.1535117315852;
        Fri, 24 Aug 2018 06:28:35 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2447844wmd.32.2018.08.24.06.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:28:35 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>, christian.koenig@amd.com
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
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
References: <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
 <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
 <b11df415-baf8-0a41-3c16-60dfe8d32bd3@amd.com>
 <20180824130132.GP29735@dhcp22.suse.cz>
 <23d071d2-82e4-9b78-1000-be44db5f6523@gmail.com>
 <20180824132442.GQ29735@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <86bd94d5-0ce8-c67f-07a5-ca9ebf399cdd@gmail.com>
Date:   Fri, 24 Aug 2018 15:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824132442.GQ29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 15:24 schrieb Michal Hocko:
> On Fri 24-08-18 15:10:08, Christian König wrote:
>> Am 24.08.2018 um 15:01 schrieb Michal Hocko:
>>> On Fri 24-08-18 14:52:26, Christian König wrote:
>>>> Am 24.08.2018 um 14:33 schrieb Michal Hocko:
>>> [...]
>>>>> Thiking about it some more, I can imagine that a notifier callback which
>>>>> performs an allocation might trigger a memory reclaim and that in turn
>>>>> might trigger a notifier to be invoked and recurse. But notifier
>>>>> shouldn't really allocate memory. They are called from deep MM code
>>>>> paths and this would be extremely deadlock prone. Maybe Jerome can come
>>>>> up some more realistic scenario. If not then I would propose to simplify
>>>>> the locking here. We have lockdep to catch self deadlocks and it is
>>>>> always better to handle a specific issue rather than having a code
>>>>> without a clear indication how it can recurse.
>>>> Well I agree that we should probably fix that, but I have some concerns to
>>>> remove the existing workaround.
>>>>
>>>> See we added that to get rid of a real problem in a customer environment and
>>>> I don't want to that to show up again.
>>> It would really help to know more about that case and fix it properly
>>> rather than workaround it like this. Anyway, let me think how to handle
>>> the non-blocking notifier invocation then. I was not able to come up
>>> with anything remotely sane yet.
>> With avoiding allocating memory in the write lock path I don't see an issue
>> any more with that.
>>
>> All what the write lock path does now is adding items to a linked lists,
>> arrays etc....
> Can we change it to non-sleepable lock then?

No, the write side doesn't sleep any more, but the read side does.

See amdgpu_mn_invalidate_node() and that is where you actually need to 
handle the non-blocking flag correctly.

Christian.
