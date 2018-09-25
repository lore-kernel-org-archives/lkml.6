Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7880C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB90206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETPxjMnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB90206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeIZAIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:08:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40000 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeIZAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:08:00 -0400
Received: by mail-it1-f196.google.com with SMTP id h23-v6so16467109ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e3kzuJw+DaUuPA7/H/kwVFLyLsceEE4NIXFOIJ6ODAA=;
        b=ETPxjMncpjSfAD9W8zCXvy3wpGSyU45jZ4kLGaNAU7Z3OjUnV7bRmu9cMlMPx6KH0T
         oLo1y5FW45/WKhDWjANNiVF2rNj4zH7dPqBP7iuINdr4Q8OWjR1tYKCHp6Yo5wRc/U0+
         s7f82UZCqbChF8bvO3DS9aIgIt7yZgxHiKSyzQdElC+WKyPm6GxOh6g61Vh17Z0py+d+
         VvEI3gcF7dOULN1jlSoattpA6Nnezt/RxfekQuweQprs2Cgov552eHiaV6XgIwcziWvV
         gmIMNpNMQ48OhuD5SNUXcjFn1K0eVNrVce63+fkswwBWPpbfxqNbQiDtSUfYqnLibph8
         ynvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e3kzuJw+DaUuPA7/H/kwVFLyLsceEE4NIXFOIJ6ODAA=;
        b=cMrg91kEiZNIILvJbsxmCkXuiq1IFQb8lprRTzGOtB4FKta/H6GILgilQn2lf39D53
         gXWed+tJsXe7mPds0ccZJs8zocLuzkiOFe+FE+DlXyfsl8yyVMJRyiFfHtEoMvg03cmR
         gmvSe/iTvD+0Y4QlL8ZsBu8RSQEmQAjMIT6MKPbsBBfpp2GwzomC264NeGh9rN7N53A8
         6C6GwI3eVvjm7wpOhioS9YaHh5ikYlTTTw4LGhN+IOQtkVVfGLd1KUARCrCi7KP0hPzk
         75tpZx48/Eu1yTLSZGjTJLZRRDO62PhIPgriml1FXzxMytuMqZqo8ZEAvNodYM/BU2zm
         u+Uw==
X-Gm-Message-State: ABuFfoj9uFxGEM9grVMJdUivLzwRB5uuT9UFVgAg7XdHCrn2KhDSQ2/K
        YDfrZg0mo09HKcN2g8JGRJqafrfDgEJ7ay+oJHmNYg==
X-Google-Smtp-Source: ACcGV624Fp2pnFyQF/8BIdNUeIEs6fJgQe2aIAapqZh1flwGIGMLQZ7h1AKsiYkja7sVK888HeL/BwJtODS0tC8OwdE=
X-Received: by 2002:a24:c0c5:: with SMTP id u188-v6mr1906289itf.57.1537898360673;
 Tue, 25 Sep 2018 10:59:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 10:59:00
 -0700 (PDT)
In-Reply-To: <CACT4Y+bdzDe_LhQQh-eLapOg0ZsfXFRm2tjUbiAsgS-ObMvwBg@mail.gmail.com>
References: <CACT4Y+YS55tk5xoPmscBXcgSbLrgWFSLAz1MUEjby0XT8eanmQ@mail.gmail.com>
 <20180919071847.GE3876@unicorn.suse.cz> <CACT4Y+bdzDe_LhQQh-eLapOg0ZsfXFRm2tjUbiAsgS-ObMvwBg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Sep 2018 19:59:00 +0200
Message-ID: <CACT4Y+aGYtWnGcVPhriLZB8z-hMdZ+2u=na5GN4GvByL6w49Wg@mail.gmail.com>
Subject: Re: bpfilter breaks IPT_SO_GET_INFO
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.com>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:29 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 19, 2018 at 9:18 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
>> On Mon, Sep 17, 2018 at 03:36:21PM +0200, Dmitry Vyukov wrote:
>>> Hi,
>>>
>>> I am having some problem with upstream kernel and bpfilter. The
>>> manifestation is that IPT_SO_GET_INFO on an ipv4 socket works, then
>>> something (that I can't fully localize but can reproduce) happens and
>>> then IPT_SO_GET_INFO starts permanently returning 256.
>> ...
>>> Now the litmus program always fails with:
>>>
>>> getsockopt(3, SOL_IP, 0x40 /* IP_??? */,
>>> "filter\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., [84])
>>> = 256
>>>
>>> I am currently on upstream commit
>>> 28619527b8a712590c93d0a9e24b4425b9376a8c, my .config is attached. I
>>> don't know what is bpfilter, I see it mentions some umh, if it
>>> requires some additional setup I don't it, i.e. I don't install any
>>> userspace modules/helpers.
>>
>> This looks similar to the fallback issue described here:
>>
>>   https://bugzilla.suse.com/show_bug.cgi?id=1106751#c1
>>
>> Unfortunately I didn't have time to look into it more closely yet.
>
> +Takashi
>
> But I already have CONFIG_BPFILTER_UMH=y in my config, so it does not
> help completely.
> Also in my case it is working initially, but breaks after I run the
> second program.


I've disabled CONFIG_BPFILTER for now, it causes too many failures.
https://github.com/google/syzkaller/commit/19a403430d8d5ae2472e16dab2f26ddd899cf552
