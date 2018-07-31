Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86674C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F9320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="TWvVYi/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F9320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeGaMRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:17:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53247 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:17:25 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so3706478itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mm9WsthsRfQmUsSoH6kR8pYzF2Hsr2qGl7TlcWHRi6E=;
        b=TWvVYi/f1TvMJiqRvcTh4KgLh9WvFSWKqcV5dG8Xjc8ieWS/uUkxYINYK3T970KivW
         r/nIceLjqYNbFpP+vuXPpmiAuT85r39HCd2O8brPLaoB78V8hyrxRRlINQQeJh7cB55D
         JFcMwJecYjgzk04U36LZdZ0RlZ+BWPcghYoQwQMyE5kmfsPCBANU9VaotUSj+Yj/EsLm
         JdXRxBdWbiYJZwRztV7DL7wUohhMsZXzNjkkpZ7HpZXwXwBwd6gpCI4UuDYhECPOLEg9
         UnWvzEWwrVMnkeFhn52GG5eluBPW1heNEU7dnzZwhFEFIR7jku9Y06O4nVlXL+1tFY5y
         kSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mm9WsthsRfQmUsSoH6kR8pYzF2Hsr2qGl7TlcWHRi6E=;
        b=ozZS7ba6K0Ivi4iOsOS3bOAag0vEdnhbW4DohaXgfMS0MWZ/hQOLdcKUZ5gDE+d8Q9
         zk6reZMO8YwfL0FDAMckDwIEPsb1OOKZYvFplAlLOVFq9fjU2+JKkoUpGiM/PQP/dKtD
         SkX7m0fzihCvhIHQAO4ezTqTbvUXJTQntskqPRWHL2J0c0BwQE2yJjoaRUA/e/01vjW9
         XBlq6B2+xFRa1hRxTJ66MA/xAlkELZVR486MFlqzeln6NGBvjm0y++znjE2TCIFJVmfX
         8U3dseqgpa2WrZPUKxT7bVVi/PZB0fKxjuQxFt+Zmx8Fc5bMYuiDPKAqxITAA4ArkyaF
         q8pQ==
X-Gm-Message-State: AOUpUlGaj+qWANAqigWt9vvx8CwRVuyFgIn2eOW12/D2daXnh1jUXsab
        Kv3ABXDd8TFr8sBgbHt98ZDs//TGVWVNdatpe6d3Jg==
X-Google-Smtp-Source: AAOMgpfPL3F1f8qEqKJQL0dnO0orkcP7Xr4Zy36dbvf05NaQ/bvid/p80/aPzlt9T1OA8H4wkmqZUTtJ5ws2RwyaL38=
X-Received: by 2002:a02:9b9c:: with SMTP id p28-v6mr18744932jak.28.1533033463582;
 Tue, 31 Jul 2018 03:37:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 03:37:42
 -0700 (PDT)
In-Reply-To: <20180731100701.GA18871@mailbox.org>
References: <20180730143710.14413-1-christian@brauner.io> <20180730143710.14413-2-christian@brauner.io>
 <20180730163155.GA27761@infradead.org> <20180730203633.GC12962@bombadil.infradead.org>
 <CAB0TPYG5T_d32iwt8Lgq_nDO_COWfWBfuSzErraASSuTYGm3yQ@mail.gmail.com> <20180731100701.GA18871@mailbox.org>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 31 Jul 2018 12:37:42 +0200
Message-ID: <CAB0TPYF-7jJHoz2=hyaZmCCFsRLg1vV=-0m7Qo1KB6hYdz4FoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] file: export __alloc_fd()
To:     Christian Brauner <christian@brauner.io>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, rlove@google.com,
        ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:07 PM, Christian Brauner
<christian@brauner.io> wrote:
> Ah, this wasn't brought up in the original thread when discussing to
> turn this into a module. If using internal functions like this is going
> away it makes sense to wait for this work to happen first. Is there a
> time-frame for this?

Not yet, it depends on the solution and who has cycles to work on it.

Martijn

>
> Thanks!
> Christian
>
>>
>> >
>> > But I think the binder user-space API relies on this.  The userspace API
>> > seems to rely on passing fd numbers around ... but I'm having trouble
>> > figuring most of this user API out.  Perhaps Martijn can help here.
>>
>> The UAPI does expect a file descriptor, but we may be able to do the
>> mapping from fd to struct file (and vice-versa) in the kernel driver,
>> so userspace wouldn't notice.
>>
>> Thanks,
>> Martijn
