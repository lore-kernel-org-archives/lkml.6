Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B119720852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABE80zD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B119720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeGZCJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:09:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37950 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeGZCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:09:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so4729pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rynC+1+BbojgOz0vOxYXM2rzEbvJSFTQSc3rxp20pIk=;
        b=ABE80zD5AOk1b1yLewuC5OaxqhjJuHfLkhjWNqrX5NbxxfIZpWg/3tT7uJQP1Qga9H
         ZO34etH2eYxS3BD1DPAUITfulG73eZJFvkNyCoRkBaTFaNN1/2fyDzCmgIwZqzdhSwGV
         17J9DuykOEMYuNTmv1rTvVtCS/60cpsH+In5G7v7pf2Jf0MgOjlRA0FBx9f7ywKMbeTS
         HDJOt5aonYDBLu4oAAPyq1EShglsEAg2aFfc8DA0MbzFJH4wC3ZUvINtjQTD/fpG2k5u
         mYBaufdPrHaS2cglUs0ZgsvGZII3iNwBTcxc1DSifdHSZOy1/yo0izXcQjNzYTIl6Dy5
         JcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rynC+1+BbojgOz0vOxYXM2rzEbvJSFTQSc3rxp20pIk=;
        b=YV+NtnZNz0bV8ugqXWiVkhObw3J+uy56k89rTMp1ttISbEbOVXk47T2abu8FAmMNm9
         238NvPI14JP3H2Ky6lWgh2w3sUWS/P+3ONtgsRQYBBEI/G7oOcuyfJgT+YgdQcVL0xpF
         us7TeqfuqRvuxg8zZKIstDVucUT3Tq5fyW+ZDexXVAHoEuAgm5IL6kMxHN3DyNBNBwwd
         2K1IQ0dZ1e7XiSujVQu+x9UyX3fOAoFoGExisF5ti7WG3QsJSSbAtImYgBHnU9Ejnfk9
         m2YWR5goK7WTpunJyJ1oPGZWTJzXZ25fMpMIIIAMLUb1D7l9TBUrluV0kd3ZmkX8vB3t
         09Kw==
X-Gm-Message-State: AOUpUlGNjSDJ8rf6SifdANvbjZZcBYHMViuq1eq8F68LnLeGBmxGCIKI
        HTgfP3IIjdNxhKEziLW5ffc=
X-Google-Smtp-Source: AAOMgpcDjifLlXgS/mW0VnnaCQoa3mU5PdA8mS4V789k7PSm/vnov3t3KM1yWWzj6BsYYhU+8ZOQsA==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3-v6mr4452919plp.75.1532566516135;
        Wed, 25 Jul 2018 17:55:16 -0700 (PDT)
Received: from 8c8590bceeee.ant.amazon.com ([54.240.193.1])
        by smtp.gmail.com with ESMTPSA id s195-v6sm30930094pgs.76.2018.07.25.17.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 17:55:14 -0700 (PDT)
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some
 machines
To:     Bruce Merry <bmerry@ska.ac.za>, Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz>
 <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <dda7b095-db84-7e69-a03e-d8ce64fc9b8e@gmail.com>
Date:   Thu, 26 Jul 2018 10:55:08 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/18 3:40 AM, Bruce Merry wrote:
> On 18 July 2018 at 17:49, Shakeel Butt <shakeelb@google.com> wrote:
>> On Wed, Jul 18, 2018 at 8:37 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>>> That sounds promising. Is there any way to tell how many zombies there
>>> are, and is there any way to deliberately create zombies? If I can
>>> produce zombies that might give me a reliable way to reproduce the
>>> problem, which could then sensibly be tested against newer kernel
>>> versions.
>>>
>>
>> Yes, very easy to produce zombies, though I don't think kernel
>> provides any way to tell how many zombies exist on the system.
>>
>> To create a zombie, first create a memcg node, enter that memcg,
>> create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
>> That memcg will be a zombie until you delete that tmpfs file.
> 
> Thanks, that makes sense. I'll see if I can reproduce the issue. Do
> you expect the same thing to happen with normal (non-tmpfs) files that
> are sitting in the page cache, and/or dentries?
> 

Do you by any chance have use_hierarch=1? memcg_stat_show should just rely on counters inside the memory cgroup and the the LRU sizes for each node.

Balbir Singh.
