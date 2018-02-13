Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964965AbeBMNhP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:37:15 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39411 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964775AbeBMNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:37:13 -0500
X-Google-Smtp-Source: AH8x227TcKGNxq9GzOydRfACneiy+Hb/roweNckLmEDrTE2K3MIryX9J0JaJT83CpCSGpsmtTD7a0K6URiP/yB+5QfA=
MIME-Version: 1.0
In-Reply-To: <CANxcAMtpE05xpOPt3Ua+4DkiTzkW5hOo4BBpiNZh_5+RTCfThA@mail.gmail.com>
References: <cover.1512741134.git.dongsu@kinvolk.io> <ddf1fb9b5001e633e0022dee7fecb0ef431e851f.1512041070.git.dongsu@kinvolk.io>
 <20171223032606.GD6837@mail.hallyn.com> <CANxcAMtpE05xpOPt3Ua+4DkiTzkW5hOo4BBpiNZh_5+RTCfThA@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 13 Feb 2018 14:37:12 +0100
Message-ID: <CAOssrKdse2_HKO0xweLD7uaBajZQArJ_URcLi9un6aLohqWxLg@mail.gmail.com>
Subject: Re: [PATCH 04/11] fs: Don't remove suid for CAP_FSETID for userns root
To: Dongsu Park <dongsu@kinvolk.io>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2017 at 1:38 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> Hi,
>
> On Sat, Dec 23, 2017 at 4:26 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> On Fri, Dec 22, 2017 at 03:32:28PM +0100, Dongsu Park wrote:
>>> From: Seth Forshee <seth.forshee@canonical.com>
>>>
>>> Expand the check in should_remove_suid() to keep privileges for
>>
>> I realize this description came from Seth, but reading it now,
>> 'Expand' seems wrong.  Expanding a check brings to my mind making
>> it stricter, not looser.  How about 'Relax the check' ?
>
> Makes sense. Will do.
>
>>> CAP_FSETID in s_user_ns rather than init_user_ns.
>>>
>>> Patch v4 is available: https://patchwork.kernel.org/patch/8944621/
>>>
>>> --EWB Changed from ns_capable(sb->s_user_ns, ) to capable_wrt_inode_uidgid
>>
>> Why exactly?
>>
>> This is wrong, because capable_wrt_inode_uidgid() does a check
>> against current_user_ns, not the  inode->i_sb->s_user_ns

I'm thoroughly confused.   s_user_ns is supposed to be about the
usernamespace the filesystem perceives to be in, right?  How does that
come into play when checking permissions to do something?

Thanks,
Miklos
