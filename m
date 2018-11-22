Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE0EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED75C20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMZJmi5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED75C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbeKVOjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:39:01 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:37745 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeKVOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:39:01 -0500
Received: by mail-it1-f174.google.com with SMTP id b5so12047488iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 20:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Eph+6kYERe390bE5HMmNm6xQz/8+gEzh3ip78b+sO8=;
        b=nMZJmi5p/9g35AF6MQCOfLW6lx/nV1qXw3hC9SqxC0kqSZeTTygrPCrMHHHOYHAmrS
         CVIJGhDXqRO8tBVZ2NB7tADhhbzsTRo935qodnF4dgARzb46MOxYirBF1S8b5Egj61Bu
         oqPKexEBEvpRHRnQutYhQHMLnmMebzKQxkAb0BPXSxMYDtEUftScZxRFy1evSXYXAIHN
         cOQbkl/bhuaYrEpJWokzdHRyMqfQJJzXS/m3Nd/Sh1Hb8C48Fd9YAhSjkrvE9BwEVVnY
         PrP41f8WDcUML8IhQdVOanDdDa9FPG0+52LdYCbIS3M1/9GNFbXWj+qidC3FiIO9TcXv
         v5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Eph+6kYERe390bE5HMmNm6xQz/8+gEzh3ip78b+sO8=;
        b=glI88caESzTNTPe+IupGCYxnAthpdtDTIYpeB7JoiinpcfkiYTg5BK3NeXv4W/Nkru
         IvSR8DQyTTBbz047O/gm88y2bJlcgeZal7SkYSctgr/wwBFaZLzkugp3/2iQATpkQcSf
         d1DrjhhKnV1zxhVfChZbHBYHsAjwzC72lP/WHgmXjKuf2BA9tnuhN03Mt7b0TdiIoFR2
         tKUCKEFII2+EAaPvhAKBUIooN/mR/uaqT5xp2bAidgcZeYCwoq34gkhBk4J+WRT/iF6b
         n37Ql1jG7NF6NdHTirVO22YjJN2VG5TG9A4usLikpAofw3l50qYOUDzwJxjbAh9l6ilK
         pU4Q==
X-Gm-Message-State: AGRZ1gJqTgepwENyCjTlppEQSHoSIo1S2bf2QJATmu1IxGZkoPAVi0pp
        5aX0kge6AHbzzwOTs3oC4NwEHQ9U7yn9B8xVobyeEw==
X-Google-Smtp-Source: AJdET5ellUmgj2q6E7QIsvB0IQj6Fc/OErgkV+lW1v3KAiSZWcQig+tMJbU4TdsJAYcCmwzpC0xhLWOVstOTQU8i2C0=
X-Received: by 2002:a24:f00e:: with SMTP id s14-v6mr7955853ith.23.1542859291343;
 Wed, 21 Nov 2018 20:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20181120221659.GA61322@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20181120221659.GA61322@dennisz-mbp.dhcp.thefacebook.com>
From:   Vlad Dumitrescu <vladum@google.com>
Date:   Wed, 21 Nov 2018 20:01:04 -0800
Message-ID: <CABDEL=+Q7eOycRC9zvjdffq3Kyn6Fcau4HVponM-Y6-dHYewNg@mail.gmail.com>
Subject: Re: LPC Traffic Shaping w/ BPF Talk - percpu followup
To:     dennis@kernel.org
Cc:     Eddie Hao <eddieh@google.com>,
        Willem de Bruijn <willemb@google.com>, ast@kernel.org,
        tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:17 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> Hi Eddie, Vlad, and Willem,
>
> A few people mentioned to me that you guys were experiencing issues with
> the percpu memory allocator. I saw the talk slides mention the
> following two bullets:
>
> 1) allocation pattern makes the per cpu allocator reach a highly
>    fragmented state
> 2) sometimes takes a long time (up to 12s) to create the PERCPU_HASH
>    maps at startup
>
> Could you guys elaborate a little more about the above? Some things
> that would help: kernel version, cpu info, and a reproducer if possible?
>
> Also, I did some work last summer to make percpu allocation more
> efficient, which went into the 4.14 kernel. Just to be sure, is that a
> part of the kernel you guys are running?
>
> Thanks,
> Dennis

Hi, Dennis,

Thanks a lot for reaching out and sorry for the delay in answering. I
was trying to build something which shows the problem on a recent
upstream kernel, but I was unable to do so until now.

It seems like I can still reliably reproduce on one of our kernels,
which has a lot of 'percpu: *' patches by you from 4.14, and with an
internal application. Unfortunately, we haven't spent too much time on
this issue, and I will have 'page in' state from a few months back.
Hopefully, I'll be able to reproduce on a vanilla kernel and a simpler
application, that we can publish, in the following days (after TG
weekend).

Thanks,
Vlad
