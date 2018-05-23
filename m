Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeEWEbs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:31:48 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41897 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeEWEbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:31:46 -0400
X-Google-Smtp-Source: AB8JxZqNkV50T/mBVNExt4tMQxxrJKqLXN1Uky4BwbE6nJfn/sngBIgQN1AgeD9MGdxyZASoSPrB0uclyUgRbeQuZfE=
MIME-Version: 1.0
In-Reply-To: <20180523033550.z3tqo4lhd3zrmtdu@ast-mbp>
References: <20180513173318.21680-1-alban@kinvolk.io> <20180521162609.lpdrnozowmzdn57m@ast-mbp.dhcp.thefacebook.com>
 <CAH3MdRWgruVq+3r+2pHTah-c2zTO03vPkepjWDZ0_KrYcroy9A@mail.gmail.com>
 <CAH3MdRVdfw52atavT3KL8MpPw7zDM_hR6aUcqDP1PogLn_sH+w@mail.gmail.com> <20180523033550.z3tqo4lhd3zrmtdu@ast-mbp>
From: Y Song <ys114321@gmail.com>
Date: Tue, 22 May 2018 21:31:04 -0700
Message-ID: <CAH3MdRVwmKd84ePvNX+NuAj3TfA_28BObEmzBqGXv=P5_A=8fQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] bpf: tracing: new helper bpf_get_current_cgroup_ino
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alban Crequy <alban.crequy@gmail.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        cgroups@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 8:35 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, May 22, 2018 at 08:33:24PM -0700, Y Song wrote:
>> +       struct cgroup *cgrp = task_dfl_cgroup(current);
>> +       if (!cgrp)
>> +               return -EINVAL;
>
> why this check is needed?

No reason :-) Originally I am concerned whether it is possible cgrp
could be NULL.
By looking at the code, it SEEMS to me that it could not be NULL, but I am not
100% sure (as I am not a cgroup expert). Since you are asking,
probably means it cannot be NULL, so will remove it in formal upstream patch.
