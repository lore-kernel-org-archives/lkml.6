Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ABC208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFI4g+y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7ABC208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeHYD2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:28:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36996 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeHYD2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:28:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so5208887pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=duJuPK+dtQzH4YpSOFDKCwqBwjwZNDXnUUdnYEd1Ts8=;
        b=oFI4g+y+rlRFAgG/LDpKsKaO+54eqoSX+utPiidmxeEZvTv6JGNjGqU1Ndxy5yzZJV
         gIeumgLiTaw/yhdRlTZmVFRRaIOq+rCGmzMlwRQXIGXPxjLbLmbAj8EOQFLPJrF/kIuj
         1k77mzGkjepku82MGcB6LSQ600L3Kho3j+bDoIaMFlfA5taukuFUQ15ieFi5AjWrg3Z3
         A1eHbpx1/Ej9hbBSotW7fVnmsFCdIyOesQVVRq7/ZYDL9xoGb3W4nPwghCyYnI4/lO2H
         Llw8OgSbaCTtqxby+jDQAwg9FGnvVieLpZSC++uKcEpr7LrrgTJRPxCsMJ02ip/KZs7r
         TKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=duJuPK+dtQzH4YpSOFDKCwqBwjwZNDXnUUdnYEd1Ts8=;
        b=DmKiDwKBgOayUZ8Svv6EQud3gtVMKB9ZaKz8muaXr1er9DTphDUrZomZj7ef/4ksje
         y4e/v0uMjVyUv7j21ftKVi4IcRt/2ZKxvS5qzMdrZKTZ9D467n8FW93cfWCjq2V+RQqu
         LFjkGmvWFcQ10JUX7GaPCuSMsMT4ex3qewxGKL9NzLdbe09qYSoqydjFWkc88ZOCSaer
         r7B9EGcNOmtIZJByXZpE8Nvf/1A58u+nZB0+bB+ujR9SUAqfMC5hzhx2Erw0c7KXHwJr
         /wz2788WYwLcDC9uEdvchOYU83rH8aTogZakk2QESOy3H8pC7k3G0NgsBCzlEG06xw74
         wJNA==
X-Gm-Message-State: APzg51A86WLeLNZjopqvHuX1JB9lu0bFqDNFz0QxVgrI1eojO5BqmBjp
        gH33dYgFQ0+4N1mmj0yQRaDj2FdjpKdZjl/Cn0JL1g==
X-Google-Smtp-Source: ANB0VdbWFvTsBLKsgHTEwcOACu0jHVliNag8pcBg3KKV8bqdpknS/FNKGJwEDcOSoBgUEIHwiyMxg5xnCEy3+0ZOBpU=
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr4010896pfi.147.1535154669329;
 Fri, 24 Aug 2018 16:51:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 24 Aug 2018 16:50:48
 -0700 (PDT)
In-Reply-To: <20180824233700.GC31961@oracle.com>
References: <20180824230446.GA16891@oracle.com> <000000000000d8879a05743667a2@google.com>
 <CACT4Y+a6P+q8jtRrd=cAf5hWbqQO4CQdWUaCCX-ygRbGsWHnGQ@mail.gmail.com> <20180824233700.GC31961@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Aug 2018 16:50:48 -0700
Message-ID: <CACT4Y+Y=d_AKpPQ494kVv4vmFMizwzgKFo6Lvit+Zw7TFU_+ng@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __rhashtable_lookup (2)
To:     Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc:     syzbot <syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:37 PM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
> On (08/24/18 16:10), Dmitry Vyukov wrote:
>> You need a colon after dup.
>
> I see.
>
>> But this can't possibly be a dup of that bug. That bug was fixed in February:
>
> Apologies, I unknowingly made a mistake in my
> syzbot-tiquette in that case,
>
> I did not intend to *close* the bug as a dup, I was
> merely trying to indicate that this is yet another
> manifestation of the original report with subject
> "KASAN: use-after-free Read in rds_find_bound"
>
> All of these problems are happening because we are missing
> a synchronize_net() in rds_release.
>
> A full description of the race conditon can be found in
> https://www.spinics.net/lists/netdev/msg475074.html
>
> If rds_release is going to nuke the rds_socket
> it needs to sychronize_net() with other threads that may be
> looking up the bind_hash_table. If we dont do that,
> all of these "use-after-free" races can happen.
> As long as we dont have the synchronize_net() we are
> missing a big (and standard) bit of RCU synchronization.


If it's a note for humans, then just a plain English comment will do.
