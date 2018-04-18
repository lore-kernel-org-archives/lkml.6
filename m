Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeDRLmG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:42:06 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:45809 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbeDRLmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:42:05 -0400
X-Google-Smtp-Source: AIpwx48z86MD++5npx0rAXm0n2NFNota/0Qlbt6nTNoZyJTjcNZJMCE1Fq2aOnd0F7UMDz+XWzWwkyvzWnSi+AcapQ0=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <CAOQ4uxgdWCWvwWgjUu06H=BeMxh-BVAjxVE5Ckj-poKRGgwvMQ@mail.gmail.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-32-mszeredi@redhat.com>
 <CAOQ4uxgdWCWvwWgjUu06H=BeMxh-BVAjxVE5Ckj-poKRGgwvMQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Apr 2018 13:42:03 +0200
Message-ID: <CAJfpegtLdmnxieDx7+FBUoc-fKsTEwA+oHinhAfa4E9SDFfSNw@mail.gmail.com>
Subject: Re: [RFC PATCH 31/35] Revert "vfs: add d_real_inode() helper"
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 10:19 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Apr 12, 2018 at 6:08 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>> This reverts commit a118084432d642eeccb961c7c8cc61525a941fcb.
>>
>> No user of d_real_inode() remains, so it can be removed.
>>
>
> FYI, there is a new user in v4.17-rc1 added by commit
> f0a2aa5a2a40 tracing/uprobe: Add support for overlayfs
>
> Seems like this patch got merged without any CC to overlayfs
> mailing list nor maintainer?
>
> Not sure yet if overlayfs-rorw patches would allow reverting this
> change.

Not trivial, because uprobe is looking at i_mapping to get a list of
current memory maps.   We could set i_mapping at overlay inode
initialization time, but we definitely can't *change* i_mapping at
copy up.  Which is bound to result in some weird inconsistencies.  So
likely we'll need to keep d_real_inode() for the time being.

Thanks,
Miklos
