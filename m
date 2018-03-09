Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeCIAeB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:34:01 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36514 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeCIAeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:34:00 -0500
X-Google-Smtp-Source: AG47ELsz45KiJxUAEH7ROgHkCYzj8wmbUkLY8ryKjKaGL1Jzh62qGEOj/6ZmE9oRDbdIDX27mAwU1dAGoRBgWAVu1i4=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAHC9VhQDLuJ-T9=4YR_vrch-KqAGC+54ZVMsb84yNZpHCrj8bw@mail.gmail.com>
References: <cover.1518603831.git.rgb@redhat.com> <a1450ecfc2dd21c347a8a0037a9545a012bf4349.1518603831.git.rgb@redhat.com>
 <CAHC9VhQDLuJ-T9=4YR_vrch-KqAGC+54ZVMsb84yNZpHCrj8bw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Mar 2018 19:33:58 -0500
Message-ID: <CAHC9VhTdG9imxWx_3eRPtv0Az79GBTtCy2P5EOgiXMDNB2SyMw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 3/4] audit: add refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 7:30 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> Audit link denied events for symlinks had duplicate PATH records rather
>> than just updating the existing PATH record.  Update the symlink's PATH
>> record with the current dentry and inode information.
>>
>> See: https://github.com/linux-audit/audit-kernel/issues/21
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> ---
>>  fs/namei.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Merged.

Scratch that, not merged, although only because I think we need to
refactor patch 4/4 and the refactoring can/should encompass this
patch.

See my comments on 4/4.

>> diff --git a/fs/namei.c b/fs/namei.c
>> index 9cc91fb..0edf133 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
>>         if (nd->flags & LOOKUP_RCU)
>>                 return -ECHILD;
>>
>> +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>>         audit_log_link_denied("follow_link", &nd->stack[0].link);
>>         return -EACCES;
>>  }
>> --
>> 1.8.3.1

-- 
paul moore
www.paul-moore.com
