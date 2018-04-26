Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeDZVNf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:13:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56078 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeDZVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:13:33 -0400
X-Google-Smtp-Source: AB8JxZpk5/rV+MdtUby+jQ8JetKdRLH/s7moBnpRSOQK1OVGGcHVYrd6eU5TxaJTeZm4itjVbK8wj2EuFqfH5LClZWk=
MIME-Version: 1.0
In-Reply-To: <CALCETrUmFfoWE55Nrkiq5cuvPw5oPFJKOg04ky-dJsDVsdSmbg@mail.gmail.com>
References: <1524099966-43544-1-git-send-email-huawei.libin@huawei.com> <CALCETrUmFfoWE55Nrkiq5cuvPw5oPFJKOg04ky-dJsDVsdSmbg@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 26 Apr 2018 22:13:12 +0100
Message-ID: <CAJwJo6bSx3rYZLqPaU6YOed1E6ACwO3ijq8LXA-RUkQWLvdofQ@mail.gmail.com>
Subject: Re: [PATCH v2] prctl: fix compat handling for prctl
To: Andy Lutomirski <luto@kernel.org>
Cc: Li Bin <huawei.libin@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QLDfZ1002890

2018-04-19 3:25 GMT+01:00 Andy Lutomirski <luto@kernel.org>:
>> On Apr 18, 2018, at 9:06 PM, Li Bin <huawei.libin@huawei.com> wrote:
>>
>> The member auxv in prctl_mm_map structure which be shared with
>> userspace is pointer type, but the kernel supporting COMPAT didn't
>> handle it. This patch fix the compat handling for prctl syscall.
>
> I would propose an alternative fix: change the type to u64. As far as
> I know, this thing is only used by CRIU, and CRIU doesn’t work (AFAIK)
> on native 32-bit anyway.

Yeah, it's right - CRIU doesn't work on native 32-bit and no support planned.

Thanks,
             Dmitry
