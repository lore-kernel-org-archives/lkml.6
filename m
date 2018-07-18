Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C54720693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="YrS0VFBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C54720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeGRShW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:37:22 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35280 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbeGRShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:37:21 -0400
Received: by mail-vk0-f45.google.com with SMTP id p12-v6so2985151vkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HRAxKMnP8k5EUTrrJlnJfmL0vY7BdbTPxKk28oPJWVY=;
        b=YrS0VFBH4esOCvA5I6Xr/BfF1kmoGdqfzZuTKDIpf2/DNGMWfkrGtLT6XKIN5KtqS5
         TRGCyIJUMAqmd5vgqfmBSXo8zOw+06ahrU4tM8ujL1pKw/BIejgqREXxU73zlg3QQR4d
         qT7FPEorPz/Hp6ydJJfDKz872JgWv7X7LvBz7es4qvrTiUDjAU7OI5727A8vxUFcVJh7
         DNx7gZzo7hPNTpI1LD476pQzbCDeqFwh1JDXg+87RXGr1KL0RnwGvvIRlsPAFdgyWfG7
         kDZ+k5ea0Puhhjr6o71OWy19y2CIp4RhiXhepAGbCW4Bh5p4cc6CEkE1QMKe7+KkcXh9
         OO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HRAxKMnP8k5EUTrrJlnJfmL0vY7BdbTPxKk28oPJWVY=;
        b=c1EkJsCIx0towEGJ/Za74/dbQg6uLT2KMGn3wI6p+cfsl4BusCXemOjvVAeqEvSkJG
         aVhcbCe3eeEWRg64fUlBkmn2/ROOwaC0IxwUwuVy3BErTXMLJa9uk4zWR38BQuVBVXsh
         Ll1z5iU9NsqGr4RBMJvts9Is5y+vk+seBy9If/BqA7VkYlHuVY0gV07T0DKXvOrQVfPB
         wl8sWgiVGEDHNdgGhUOuF1HVgmGKLPp8Dh60tDNs0JD/ORwvvYSR0pbODKlwahIb5otX
         jdKJ26PwtImXRs+uJDD/7bJyFh1+4CjNvBjg4RQILDMvUxvOs2MGtTuxOUaj+ly/7N2e
         NqQA==
X-Gm-Message-State: AOUpUlEIn1yUcUL4tLG0wv9J1S/N7LffrDw1eOfczZ5v7rCFmKJ9UcvU
        TgkNoj6ems9n1k7HpdaezXUpZ9UhhH3wSlDyBzfA399e
X-Google-Smtp-Source: AAOMgpfEfbiQUof1yBUtE2abfTyyivdOA5xAo/dB4qOVvZjeUKPJmFDLdmv2CHu9pz+rZELwnvNp71b96ssAM4RNQ7M=
X-Received: by 2002:a1f:e7c6:: with SMTP id e189-v6mr4036326vkh.119.1531936699423;
 Wed, 18 Jul 2018 10:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 10:58:18 -0700 (PDT)
In-Reply-To: <CALvZod5UsYzNs_FJqy2U4HiZ+SdKzKZtzdK1OYcV7v_91kqn8A@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com> <CALvZod5UsYzNs_FJqy2U4HiZ+SdKzKZtzdK1OYcV7v_91kqn8A@mail.gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 18 Jul 2018 19:58:18 +0200
Message-ID: <CAOm-9aocfOOFODdGn2Gz236_PKaff++6S0U0bTj9eOPnRwM-_w@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 19:48, Shakeel Butt <shakeelb@google.com> wrote:
> On Wed, Jul 18, 2018 at 10:40 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>> > Yes, very easy to produce zombies, though I don't think kernel
>> > provides any way to tell how many zombies exist on the system.
>> >
>> > To create a zombie, first create a memcg node, enter that memcg,
>> > create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
>> > That memcg will be a zombie until you delete that tmpfs file.
>>
>> Thanks, that makes sense. I'll see if I can reproduce the issue. Do
>> you expect the same thing to happen with normal (non-tmpfs) files that
>> are sitting in the page cache, and/or dentries?
>>
>
> Normal files and their dentries can get reclaimed while tmpfs will
> stick and even if the data of tmpfs goes to swap, the kmem related to
> tmpfs files will remain in memory.

Sure, page cache and dentries are reclaimable given memory pressure.
These machines all have more memory than they need though (64GB+) and
generally don't come under any memory pressure. I'm just wondering if
the behaviour we're seeing can be explained as a result of a lot of
dentries sticking around (because there is no memory pressure) and in
turn causing a lot of zombie cgroups to stay present until something
forces reclamation of dentries.

Cheers
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
