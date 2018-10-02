Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB1CC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB34720666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vxd2X6no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB34720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJCFTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:19:03 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40004 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:19:03 -0400
Received: by mail-lj1-f170.google.com with SMTP id r83-v6so3261877ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCgUao/VoX6wJZSXuI4jNo34hbMdFPxS1XNXPzsvnvg=;
        b=Vxd2X6nou+R95Ctj+AV+z2G0YPm0Iq8KbHcBQ0yZI5JBROgsxc5SuzTPliO6TChPaH
         SbNEr5U9sGDA2NlFF2TNbqpvrXJ50XqMCRWQt1qwDbBtGMqMEJUad1WYxHhnk3fLJb21
         BaGtx+ZxQVamkyJoRaCOzth975IKy5jo0K6IGNDgKdnNcUmxa4R2KxbXHaZaRRWYAJmt
         WGQ3oo5Wy5D1epmRFpuAMV2P+7QsLb/XkCJP0I+uDEO5neHt6tDE1WidF0wwVPpaLeqb
         Z6wQ1CUIT6ILXV/ka/a4/GuhRW24xFxCoGsa5QXySTG4ann7u14lEpf1JqlCt8fkWgpM
         I/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCgUao/VoX6wJZSXuI4jNo34hbMdFPxS1XNXPzsvnvg=;
        b=gQ5PBukN8/IdNuRpJEc2w4cvHhC7XASKfvLJLKrAD8Qa13IcKY7gfGpC0cnyahwyxb
         ExfIjUBuac+VpXDxz3IRnydExDk6qaKxWcS6jKi6w7QIRG0+hUUqxUYDUOede51clRtj
         JfxT+XbZTK0kKLCmLcG9bZpaCZTMDbJ6MpSSt/SOyJZox0C89bmk/D6+WCc/jZYGGbFS
         nWvljlZKRsyxtVA4eQ8tFCqf688N0/PiwenRvBSiZJxnof16S9CAsrXNcs6zmddKmg7B
         SWYIUv2Bq2zbE1o53yZdHSJKBacpX94SYkACyw4aUFciz2KiLUVJL7LRQv7qRZToV5g8
         UsBA==
X-Gm-Message-State: ABuFfogOZnt3m52KzqjrJL76g9Int7Dtt+0NykgiIaFioVZfE7niu7S4
        kyeCTa3rf+ihR4XGSNIABKvWYjfBIYvfNn+R0SR8apDsh+8=
X-Google-Smtp-Source: ACcGV60lwTmguZ5BPn2yqSRgkHR3LJalnpT0q3/QGNHY93Uuz/NWmutBuHdfBVoz3G8kXx0dUrHWv6Q9eWiD92NGFj0=
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr9332726ljh.154.1538519603236;
 Tue, 02 Oct 2018 15:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com> <20181002223021.GA30567@kroah.com>
In-Reply-To: <20181002223021.GA30567@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 2 Oct 2018 15:33:11 -0700
Message-ID: <CAOGAQer-MSSsUocmjing7FhJb1SEV0T5v9StYr=DDPdTJeU0cw@mail.gmail.com>
Subject: Re: [PATCH 01/15] platform: goldfish: pipe: Remove the
 goldfish_interrupt_tasklet global variable
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see a "global" variable here, what are you referring to.
>
> This one:
>
> > -static DECLARE_TASKLET(goldfish_interrupt_tasklet, goldfish_interrupt_task, 0);
>
> ?

Yes.

> That looks static to this file to me.
> what am I missing here?

It has a global lifetime but it is visible only in this file. How do I
say better, just drop the word "global"?
