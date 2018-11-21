Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA5CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3B220C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gejMtYd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3B220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeKUU76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:59:58 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33150 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:59:57 -0500
Received: by mail-it1-f196.google.com with SMTP id p11-v6so12406955itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 02:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K49jrwg9lTAITcLS01h/rAlZcCdWzc0eGMEDKwnr7IM=;
        b=gejMtYd9z69oPbqO7eVA0264xorQwULJzZuGeIbzfIW4Q3j2J2GKE1KJqbfF5IOram
         8jUkGTh1SqQWOznlsQ73DNKkG6mKMte16wNIXkaxgIXbJDsTq/QW6n0yrASh03x1mNfG
         qTY1h332Z88ABGtEW/4iyoyIPVuBwTlugn2c0TW2cUuYM2MumizmO+4z5HOg3rUBDemt
         7wdyFf71MHBYG6kL0Nm3Q8emDOxVchJ9aCfeRo3ONQ9MDidoxmlg2hLH1eaPJcCoJW7n
         rj2wo+2Iat20bICk/VH7nm67z4WuZOH/6ZeIWlXWu5zimQLcvi2GxWTMRtyUZZDMa+u1
         R+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K49jrwg9lTAITcLS01h/rAlZcCdWzc0eGMEDKwnr7IM=;
        b=Sp7gi2hmJIokjwbZQ6x8Fwie/ongQbJk2G1yi0LDmkoIK2gPMJUBb8t/JiLC2Yi3n6
         uDNNYwqMPC/YxebPomyukSP6zVb+2z04CDwE5eEmxjMYBS1P6hmnA6dUiMw20zTSEQXV
         S9rDqgiYpwA+6h8ipiuuafYkPcC+nN1bbgtkLZoiAcpAnDo7dMaO1jZIQ1I4UtPeSow7
         kC77Yl5TSt8wEORyPJtwO/fWukpoPfeW1h8kbF5Nl/d87aOAq5e2gUIjjzGO1Y/S8LFC
         6kpP/O1pgz+J/ebA8e2EO2R11txTqRcaMqVwzGkIMNXOkRCwLBRzmKQFYjgUlp+NL/XB
         hPTQ==
X-Gm-Message-State: AA+aEWaNfSgWckektK2GgZMzKwzTYLH0T14GTixwjmrqutEFlbQiUfav
        8KtS+NBlmGxYycQmAhxWBrEh4UgGOgO1eKRZY4IFKQ==
X-Google-Smtp-Source: AJdET5cI+AWVmgvQkZx8sPYr8TJ/Mz/BXw2RwjnUBwl6AmDzlRwMRhxfXXfpces3IE/dAtmgHmAADjs1WvKdHCVBDgE=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr4819187itf.166.1542795542315;
 Wed, 21 Nov 2018 02:19:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Wed, 21 Nov 2018 02:18:41
 -0800 (PST)
In-Reply-To: <CAEAjamsAOJC_EqdX8nTddhN4Xis3d_D1L54Ry3sBdC8L84EdVg@mail.gmail.com>
References: <CAEAjamud-6uX8EmOZy7s6ubWNg=0E1YQZSGK2-SnfsomK8VnGw@mail.gmail.com>
 <CAK8P3a2SnRF9198W4W81WwzEX6yCKFjBLTtTo+97Qcym=99Akg@mail.gmail.com> <CAEAjamsAOJC_EqdX8nTddhN4Xis3d_D1L54Ry3sBdC8L84EdVg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 21 Nov 2018 11:18:41 +0100
Message-ID: <CACT4Y+Yih790PN6UMOLcZdL930TA2Xmnr82DULo0xWbu7SUpww@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in write_port
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:11 AM, Kyungtae Kim <kt0755@gmail.com> wrote:
> Thank you for your reply.
> But I think this kind of crash can occur in real PC as well, and I'm
> just thinking of some way to stop it in the first place (if possible).
> because malicious users can use this, so as to make the whole system
> (kernel) work incorrectly.

If I am not mistaken this program writes to /dev/port. /dev/port is
strictly privileged.

p.s. if you are extending syzkaller to do new things, it can make
sense to send pull requests upstream. Then we can review the changes
and figure out what should be tested, and what does not make sense to
fuzz. E.g. also don't give /dev/mem to syzkaller ;)
