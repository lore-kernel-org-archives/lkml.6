Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C0FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8919220823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lR063yvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8919220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJ3VJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:09:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40745 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ3VJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:09:47 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so13356246iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=9urQQQn1fUNOI9IvpNudX5kiIpKc0cmznadQSZvSNEY=;
        b=lR063yvLpdrQsBwxoHqSc0QQXtylIJ45LWbMATFVxJgC1Sduzl6z14znluQ6HGoUcu
         8ifR7USC98VdXWdkXci/o24HuN4Rs4GNJsBSSXd6tW6mT/YD7/MeZ21R14YvmttUeDAJ
         VCNs9qi/hpSZLAi7psbg8RTuapCIL36IEEFm+xfQxW4WJige9d68wTf80viT12A5qegj
         D0EzlhW+VEkZDeqo1blt5dKW0v2q+zKKOJSo/+E8qBN+HStmmYBU5VCXGxamwGhNOC4F
         tAUeru2eCJ5YNYC7JivvMpyPdMy2yq3H3ebJaJ2jT1hKCG097hruuXrbVRgyJ6rMgO8+
         JfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=9urQQQn1fUNOI9IvpNudX5kiIpKc0cmznadQSZvSNEY=;
        b=EdJoMlAslGZddFpNh8goXmsUMR9WoHMlVfnxXavjZX6d+1V02WQ6U9fAc3KUyXUd6V
         +e5sGyhohF9FX7MXZVDC8UPGXSaVBlR34z5xa6zOQ9RtiH2l42WtkpVCG9U1pupiA4Mj
         uj/pUw7hpDMhQr2CZVddJY6yxINkEP7OTl/ohe7LjenUQTDwS8dBz/SRmaJHJB/dxBVE
         KlONV755Nfe4uQy7hkdcP8BSBF9W4f7YdCkBbEqPRDHbWeNcbB40RKI31Yy74WrOlIS6
         AqQeh1zALtxa0EvzBah86DWqxpmoJ5UBz7SMREXnr22W9MxD1F5MUoB40oo3ZSUocowz
         QpPQ==
X-Gm-Message-State: AGRZ1gJ5lXr+7NMiB0f2Lr1WS7VrCM/xbz8Fhf/H+jpdnMbyeaDxtoMF
        FeYOyf+oM/19adWro8823/IjPmf+G0+vh9e3zfpXWQ==
X-Google-Smtp-Source: AJdET5e1CELdPrpWyf5kAeEqGZHUEvX+pH0c5qFyq3seCmTNv9mQjBoenNf+JYLWmTYAa6U1xpWpj4Eqjdc2FrgGI0o=
X-Received: by 2002:a02:1548:: with SMTP id j69-v6mr12094938jad.72.1540901792300;
 Tue, 30 Oct 2018 05:16:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 05:16:11
 -0700 (PDT)
In-Reply-To: <20181016155341.GF8983@thunk.org>
References: <0000000000002753c60577b9f707@google.com> <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
 <20181009013425.GB3369@thunk.org> <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
 <20181015180821.GE8983@thunk.org> <CACT4Y+bs72L4GKF7K6zHHqDGfURymzUke7UT6CKtakLWu+f94g@mail.gmail.com>
 <20181016155341.GF8983@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 30 Oct 2018 13:16:11 +0100
Message-ID: <CACT4Y+b3rujNu+kJFaEmZzwOWSHuFYpYVJ4q3vvY62FtQ8+7xA@mail.gmail.com>
Subject: Re: WARNING in ext4_invalidatepage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:53 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> > The patch I referenced in my previous e-mail protects against
>> > additional scenarios where someone might be trying to punch a whole
>> > into a file that is being swapped into the bootloader ioctl.  This
>> > particular ioctl isn't yet being used by anyone, so it had some other
>> > issues as well, such as not interacting well with inline_data-enabled
>> > file systems --- not that any bootloader would be small enough that it
>> > would fit in an inline_data inode, but we're basically proofing the
>> > code against a malicious (or buggy) root-privileged program... such as
>> > syzbot.  :-)
>>
>> ... or paving the way to opening all of this to non-root users. Why
>> not if not bugs? ;)
>
> The intent behind this particular ioctl is used to install a boot
> loader.  It will *never* be opened to non-root users.  It doesn't even
> make sense to make it available to pseudo-containers-root users.  :-)

But it does not have to be executed on the root fs, right? Or is it?
For example, if I need to build a bootable image (which I actually
need to do for syzkaller). In the end it boils down to just creating a
local, private file with some particular contents. Should be nobody's
business, right? But for some reason on Linux creation of a local file
requires root privileges multiple times along the way. As the result I
have run the whole service as root, degrading overall security. And I
can't say that I fully trust all code and data involved, but Linux
simply does not give me any choice.
