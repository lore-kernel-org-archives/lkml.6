Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B683E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naK+kL/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B683E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbeGWV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:58:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42104 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbeGWV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:58:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so3640052oib.9;
        Mon, 23 Jul 2018 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DFNR+MXEf8GBimdMlEVfTWZarKaQ0YqvZlUwoqZTybQ=;
        b=naK+kL/UllcIP3uk3ik7L/D3SEYhxqv4EXmjp9wAqGHnDkeNmQT7jt+dafldpbDRb7
         hsLo0BbpM6xQYHPfbAfISdjBt92uReoUanHhWVjbtZt3E9SKbF956rbAxrJFI/7gbY1r
         5vbvG2czcnTX8S2tudQLUsiJ7peEDBnT5f8jdX1Ip0XQgiduzs+e2keVLu+7sFE0043E
         vvHZ0KcWKIqGASxZzK0gMeERXkFuvHoyxNXRZEseM8qnCqxdabe8C++N8Xv9dfNrUf1l
         WUJygrTe1K+8OWuM4Op5S6pZsXlb/C5IThU8A9D/jxFi/vlSAQIrKwXP92hHKWXX5l3n
         BFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DFNR+MXEf8GBimdMlEVfTWZarKaQ0YqvZlUwoqZTybQ=;
        b=L0YqCZK3WwLTCJhyeMjowIYMj3p/CBvGV9st0J3MBeaMkDEsejA22Vx/cvJPt2uQUl
         rumf3SlBeVfUJ1B69Qe1Iha1W6/bHquqarX/KlB5qGxCu8DJHita4qXPFsTz+QYBxsX3
         9NZg8snk/X2u+LVhSIEzdUlfDWy6q4bJfxxnY18K3wQxDAYZMpjdI+4D3x1mNdh54a+I
         XCaaL7YH85eZJJchKefep0WEX1bWyrXjLPG1SorUGTO1VpgBXtlVaQ4cTy5dTpZHzIM5
         VlTPhRw5uDiGaVKQhtMc6Fb9A8rSia4acUmJSofdCPdJv5ug64/EmGyjA/ApE1O8fnSj
         +c3g==
X-Gm-Message-State: AOUpUlFUaZzVH0WRnkJLBKMwQ1q0g5BH7GytP8JxNAT25ihjEMDWAHxU
        oHY4+azh6lxCczv5K7phFUaYdVtcYH43/fwKwTtlUegqnrw=
X-Google-Smtp-Source: AAOMgpch5tl2LtekKILxDv++3Lp9JrkLPa9Ttup3SjAvLZLM7O+UXujZxwBlRz53CRdBievXpLFgRfvkgPEd+fIM9uU=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr469263oia.156.1532379343007;
 Mon, 23 Jul 2018 13:55:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:75da:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 13:55:41
 -0700 (PDT)
In-Reply-To: <db8d560e-47d1-c32f-e4a2-407110f2b5b6@oracle.com>
References: <152788068212.768348.15192457501079586650.stgit@buzz> <db8d560e-47d1-c32f-e4a2-407110f2b5b6@oracle.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Mon, 23 Jul 2018 20:55:41 +0000
Message-ID: <CAMkWEXPTb2NJH5rv8WpKWQaZVOJZp91z5Rr-e19UjrwBxB2pNw@mail.gmail.com>
Subject: Re: [PATCH v6] pidns: introduce syscall translate_pid
To:     Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, I'm not seeing much activity on this so here's my $0.02

> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
> into pid namespace, this expose process and could be insecure.


Perhaps it would be a good idea to add a sysctl switch that prevents
credential spoofing over AF_UNIX \by default\ if that is the main
concern, or is there another concern and I have read this wrong?  I'm
having trouble thinking of a legitimate use of SCM_CREDENTIALS
spoofing that isn't in a debugging or troubleshooting context and
would be more comfortable if it were not possible at all... Anyone
know of a program that relies on this spoofing functionality?

If you look at socket(7) under SO_PEERCRED there is a way to get
credentials at time of connect() for an AF_UNIX SOCK_STREAM, or at
time of socketpair() for a SOCK_DGRAM. I would like to think these
credentials are reliable, but will probably require some extra daemon
to proxy a dgram syslog socket.
