Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDSCZv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeDSCZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:25:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06D82178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4+kRHgOehiSPmYMuuux0xgy8GsvMyv/z0Qa4g4uRIDbO9tVs9LIcLule3Uqf3y9/2V78904bA0s0jLsVbyUWJQ=
MIME-Version: 1.0
In-Reply-To: <1524099966-43544-1-git-send-email-huawei.libin@huawei.com>
References: <1524099966-43544-1-git-send-email-huawei.libin@huawei.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 18 Apr 2018 19:25:27 -0700
X-Gmail-Original-Message-ID: <CALCETrUmFfoWE55Nrkiq5cuvPw5oPFJKOg04ky-dJsDVsdSmbg@mail.gmail.com>
Message-ID: <CALCETrUmFfoWE55Nrkiq5cuvPw5oPFJKOg04ky-dJsDVsdSmbg@mail.gmail.com>
Subject: Re: [PATCH v2] prctl: fix compat handling for prctl
To: Li Bin <huawei.libin@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 18, 2018, at 9:06 PM, Li Bin <huawei.libin@huawei.com> wrote:
>
> The member auxv in prctl_mm_map structure which be shared with
> userspace is pointer type, but the kernel supporting COMPAT didn't
> handle it. This patch fix the compat handling for prctl syscall.

I would propose an alternative fix: change the type to u64. As far as
I know, this thing is only used by CRIU, and CRIU doesn’t work (AFAIK)
on native 32-bit anyway.   Do you know of some reason that this
wouldn't work?
