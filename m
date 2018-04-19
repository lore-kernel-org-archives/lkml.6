Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeDSGFE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:05:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751964AbeDSGFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:05:02 -0400
Subject: Re: [PATCH v2] prctl: fix compat handling for prctl
To: Andy Lutomirski <luto@kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
References: <1524099966-43544-1-git-send-email-huawei.libin@huawei.com>
 <CALCETrUmFfoWE55Nrkiq5cuvPw5oPFJKOg04ky-dJsDVsdSmbg@mail.gmail.com>
From: "Libin (Huawei)" <huawei.libin@huawei.com>
Message-ID: <130bb5d0-e6a8-932b-3f56-ef021f10a8ba@huawei.com>
Date: Thu, 19 Apr 2018 14:03:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUmFfoWE55Nrkiq5cuvPw5oPFJKOg04ky-dJsDVsdSmbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.31.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018/4/19 10:25, Andy Lutomirski 写道:
>> On Apr 18, 2018, at 9:06 PM, Li Bin <huawei.libin@huawei.com> wrote:
>>
>> The member auxv in prctl_mm_map structure which be shared with
>> userspace is pointer type, but the kernel supporting COMPAT didn't
>> handle it. This patch fix the compat handling for prctl syscall.
> 
> I would propose an alternative fix: change the type to u64. As far as

But we also need to modify the sys/prctl.h in Glibc, right?

> I know, this thing is only used by CRIU, and CRIU doesn’t work (AFAIK)
> on native 32-bit anyway.   Do you know of some reason that this
> wouldn't work?
> 
> .
> 
