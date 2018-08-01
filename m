Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D43C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A514D20851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxFUkBbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A514D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeHAEbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 00:31:18 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45154 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeHAEbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 00:31:18 -0400
Received: by mail-vk0-f66.google.com with SMTP id b78-v6so8567445vka.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hGr5pNaI+H3B+TRP/6ZtKIBJBs4Zd7CCT9YKUOyu7IE=;
        b=fxFUkBbWkwYnecq/Q1Rgbv9fwcDIUFheGnZFDSPSWSWIoPV7I+y5OV82RBnXt4N0Ki
         7FmaZOOT9sr98nm8d6Oa0F2iBzb62/i8yidMsEc26sJgE2CJD959smzTE4jXYfnlgNcJ
         bBqM/i/mQ+4JE16wV55kSlsZpoEEmkivGV1BEAGiE1FxKvnZLXjEZCwtDXJCK9JN6Wk/
         /zXgIhk0HuaFuglaBR3MVl3+dfxINvaH1KMnVc+rtZOfgdoGd1YXThWxC0EE58ecUc7Q
         UBh7f/ZP0IYJl7Wxk0V2LQV7qkjXi9q2u17K/8U5KXmlbNkbbRWpLB110p6kPBs0h4lB
         YlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hGr5pNaI+H3B+TRP/6ZtKIBJBs4Zd7CCT9YKUOyu7IE=;
        b=TraWtvrP5MG+sKNvpwWugQLE50pAMC+ERnrvot44Kj9mFWKhqPeE/y7VP+J6V+KByY
         riMzrtvtQUwqnEmPYQNWeoVGQFM3d06Y2VeUu/x08J8+vG2snTKZsW5qTyYyumsZYKAh
         h2suALM6Sf0/+utuAcJNzPVH9DzHR7qtR3nMYSFGDqKhW1YsULoNhJE7LKtDNVGgwHca
         7WsB2Pa458tu30HkF9SCo2QNUbgO8iTP3CgDtYr6c2PQGznDmS8dc5CEcaoF0Pw2w0tb
         tgiOakbqtYoe5dgBPislN4vnTXsLW6JqfDuwbvKNdKIMdC4R2JKUVil/ZJwnccHjDu4x
         /JhQ==
X-Gm-Message-State: AOUpUlFQMOGvq3cuc3GS6PoNBGyvJXyLW4S3JnzIprDjsPQRsnufp+a4
        nZhiqIdzpnfJzvLYtCWFJVlOKyskgKCWOuWIVGz2ES0q
X-Google-Smtp-Source: AAOMgpc3VZn85Ks9pYfzjGIpumLP+sa7Ocsix9ufDX1Dm2B0KELiLhNv4N1Hcpc7lOQHEYstsCxUTCKE4oF8RHsW4fA=
X-Received: by 2002:a1f:ae96:: with SMTP id x144-v6mr15060414vke.130.1533091680512;
 Tue, 31 Jul 2018 19:48:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:959:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 19:48:00 -0700 (PDT)
In-Reply-To: <20180614073153.GB9371@dhcp22.suse.cz>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com>
 <20180612212007.GA22717@redhat.com> <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
 <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com> <20180614073153.GB9371@dhcp22.suse.cz>
From:   jing xia <jing.xia.mail@gmail.com>
Date:   Wed, 1 Aug 2018 10:48:00 +0800
Message-ID: <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We reproduced this issue again and found out the root cause.
dm_bufio_prefetch() with dm_bufio_lock enters the direct reclaim and
takes a long time to do the soft_limit_reclaim, because of the huge
number of memory excess of the memcg.
Then, all the task who do shrink_slab() wait for  dm_bufio_lock.

Any suggestions for this?Thanks.

On Thu, Jun 14, 2018 at 3:31 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 14-06-18 15:18:58, jing xia wrote:
> [...]
>> PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
>>  #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
>>  #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
>>  #2 [ffffffc0282af450] schedule at ffffff8008850f4c
>>  #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
>>  #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
>>  #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
>
> This trace doesn't provide the full picture unfortunately. Waiting in
> the direct reclaim means that the underlying bdi is congested. The real
> question is why it doesn't flush IO in time.
>
>>  #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
>>  #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
>>  #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
>>  #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040
>> #10 [ffffffc0282af8f0] do_try_to_free_pages at ffffff8008178b6c
>> #11 [ffffffc0282af990] try_to_free_pages at ffffff8008178f3c
>> #12 [ffffffc0282afa30] __perform_reclaim at ffffff8008169130
>> #13 [ffffffc0282afab0] __alloc_pages_nodemask at ffffff800816c9b8
>> #14 [ffffffc0282afbd0] __get_free_pages at ffffff800816cd6c
>> #15 [ffffffc0282afbe0] alloc_buffer at ffffff8008591a94
>> #16 [ffffffc0282afc20] __bufio_new at ffffff8008592e94
>> #17 [ffffffc0282afc70] dm_bufio_prefetch at ffffff8008593198
>> #18 [ffffffc0282afd20] verity_prefetch_io at ffffff8008598384
>> #19 [ffffffc0282afd70] process_one_work at ffffff80080b5b3c
>> #20 [ffffffc0282afdc0] worker_thread at ffffff80080b64fc
>> #21 [ffffffc0282afe20] kthread at ffffff80080bae34
>>
>> > Mikulas
>
> --
> Michal Hocko
> SUSE Labs
