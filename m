Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367820811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO1FuZfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeLMWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:02:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38379 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:02:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so3164648lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oOUbeilDloeeTJzZDJe3BPrxt2FvEZMxHiEX/QypYs=;
        b=jO1FuZfdUVnSdEG5+Ugve/Z4sVkidPr8go09mWftVP/K009oYH36LZGk/oqJIF9Hde
         IxqfcGHcn7HEYZfPErUhkhGUv+kk9GHFhpB6yT3ceUM9pDdHvtaSUj2dowZHtpX7g8TT
         2NiRpaIuugTScmPo0S3veEZJWJHpnwpG3i+tdW1x6oBI2bRm4/1grMWC/URA3lim++9q
         CNtyySceqsNXS8s4yd/0IS44GF8G0C5HdCeXH3pm2E0UuFWThJziJC1mDko12EsEH4bE
         S/CBU8E/RW7azZcfYcRNxKHinepLqc5Jil/rubTCEFFBALSAJ7nEarfIRujqOhHBhvV1
         IiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oOUbeilDloeeTJzZDJe3BPrxt2FvEZMxHiEX/QypYs=;
        b=Hf4TdfVzyofGy0bJT8rRRV9Ejr9e1bQEICnXR3LmMVCx72ZHS26c8xSs9g8UZ25ozI
         q4/AZzmeDqoKLMsE+4LiU55ttM0IZHi2jTka2DryunG8MT7qM+hCM4MyKGm/nAR7Usv3
         8cFhKudcMkn12ImSN7JXYZW3BzMDDwZZ7dS+xbQ/RHzB6Rp4IdeMdfk/tXL0jJRfqZfD
         0ccVw8ZwvlwQusbAdzaO0MdbdIPgKPiET1PSLtj7dOdkAItb0m2F7Xk4Y8gbc5WAOh8x
         gvDkej0cnzs92SdbSobBe3n4kIo4JbPJzvovjUr1HCRUi6xhO9+OZMtgpMWwDlyqLTAS
         tUAw==
X-Gm-Message-State: AA+aEWYPqSVmQi0ZKNKG15ym9y5825u0dDn5LPqmXd/PEhHe8dQNhLEf
        Uz9uW07wV6L2+8Sz775hHJ2yhlqcAwoh7g7gDEU=
X-Google-Smtp-Source: AFSGD/U0jDFVm5lWRo18wJY+4/PP9KcbwQtNDnF0QxcsTPgZcM15ig6UVgFKeubaze1S5FMidF3aADxb8ELX2v8QNRo=
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr267004ljd.45.1544738544259;
 Thu, 13 Dec 2018 14:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20181209032715.3466040-1-liuxiaozhou@bytedance.com> <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com>
In-Reply-To: <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 13 Dec 2018 23:02:13 +0100
Message-ID: <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     liuxiaozhou@bytedance.com, Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:59 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> What do you think?

[Cc'ing Nick et. al. as well.]

Cheers,
Miguel
