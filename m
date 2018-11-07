Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E34B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhWAiKzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E34B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbeKHBTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:19:17 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40660 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbeKHBTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:19:17 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so6013283uao.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TrlHarah+TLUgkrwLxYsQP6SLsnTl0xdV5j4cE+KW/k=;
        b=NhWAiKzmoKWOSuFAM1ham4fkT1TKE1d4kHiJRT5sdGNeytzeiQSDKcvfvqSmpOiPc7
         Fidu1K6nGb+SwBQ0xqoMIxVRdMG8/knOSN9/faQ8KpgimWcfaCuRjcGzFvJ/nVy/mF2l
         28yBUjo4qeK+bSV5Mt8z9leZLDRKS3fylfm+eTCSDmtJJWpdMKXSy5n7a0P1w6zNaotR
         +XwLcBnkislH72h1p9YOnJ45cojb1kbLD4XniwaZ/gzb9/1cxoXmrmm8VMA/L39Gkunk
         nBGVc/cgovvndyy9hO6RKUzArySi8Pdo4cSHr70KmBRuvWfUyJOCtq/TkWf5F+CDJq7X
         X3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TrlHarah+TLUgkrwLxYsQP6SLsnTl0xdV5j4cE+KW/k=;
        b=qOkDOOY8v3NeDzOJzI8mRWejwcheMn7O/zDvGhOVcoMgzYfPTr4shwwd9PMpzUiGDz
         p3OTLRkvGf6IbNdxQv5pIT89zOwDXq/56R47pMhT9dJeaHBGX6yHvhoKeX7kp/c5mOtN
         dD5WYYQ+83DPkvtXSwk3RpTositwSSmUseOvACoW3SbRChh6LialuBKHcZ5l2EdYLzdu
         ZXuh+ck5tzkAYfU2lUW3R51a0cRFUS2kC6oYp0HeKeBhkGuocLetB801qxfrzK09O73W
         QG5SY2Zb7ws3IJBM/wxPPp63iitJ62dfzci90l6QGYUxbox3+IIX4v0KZpdAeV7itGnl
         crwg==
X-Gm-Message-State: AGRZ1gKH2ePZJyOlLVQY+8aGG1QiZqC/hTpk3MvyzQSQnj/wd1Z9IK0Q
        KUwcUdAi+J0Zxkg3DqU0Ev9V3A6+NVPXosMaqsVaQazdiMd91Q==
X-Google-Smtp-Source: AJdET5cAI9a01SxzPIFrVNsQU75ndS3M2mbuIbr5yY7LrqbNSY2UQ6aPeP2My9HfyKVtrejCKhFmhX23vZtintxHoYE=
X-Received: by 2002:ab0:45e2:: with SMTP id u89mr318243uau.13.1541605701622;
 Wed, 07 Nov 2018 07:48:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 07:48:20 -0800 (PST)
In-Reply-To: <20181106130524.GC2453@dhcp22.suse.cz>
References: <20181031150625.147369-1-dancol@google.com> <20181105132205.138695-1-dancol@google.com>
 <20181106130524.GC2453@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 7 Nov 2018 15:48:20 +0000
Message-ID: <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, rppt@linux.ibm.com,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 1:05 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 05-11-18 13:22:05, Daniel Colascione wrote:
>> State explicitly that holding a /proc/pid file descriptor open does
>> not reserve the PID. Also note that in the event of PID reuse, these
>> open file descriptors refer to the old, now-dead process, and not the
>> new one that happens to be named the same numeric PID.
>
> This sounds quite obvious

Many people *on* *LKML* were wrong about this behavior. If it's not
obvious to experienced kernel developers, it's certainly not obvious
to the public.

> otherwise anybody could simply DoS the system
> by consuming all available pids.

People can do that today using the instrument of terror widely known
as fork(2). The only thing standing between fork(2) and a full process
table is RLIMIT_NPROC. In a world where we really did reserve a
numeric PID through the lifetime of any struct pid to which it refers
(i.e., where "cd /proc/$PID" held $PID), we could charge these struct
pid reservations against RLIMIT_NPROC and achieve behavior as safe as
what we have today. The details would be subtle (you'd have to take
pains to avoid double-counting, for example), but it could be made to
work. Other people, on the various lkml threads about my process API
improvement proposals, have proposed fixing the longstanding PID race
problem by making struct pid behave the way people mistakenly believe
it behaves today. It's a serious idea worth actual consideration.
