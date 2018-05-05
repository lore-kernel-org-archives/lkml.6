Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEEQhY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 12:37:24 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33526 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeEEQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 12:37:22 -0400
X-Google-Smtp-Source: AB8JxZobY2HT6HWUNm6G6LhkHUCkDd5lFJ9wcekYsdLKTKKuT+zvKFK5MOkz92fNMqGKTFqDgMt/YWWdJ8GZO31yQts=
MIME-Version: 1.0
In-Reply-To: <CAJfpegvnq-+wvmtfX65ts+9eRE-ONGcj6AJyRqhqF1Z=h9bOiA@mail.gmail.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <CAJfpegvnq-+wvmtfX65ts+9eRE-ONGcj6AJyRqhqF1Z=h9bOiA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 May 2018 19:37:20 +0300
Message-ID: <CAOQ4uxhASo_smS3xXcMP=FD=MCr4g1rpJqkWYbgN6b7AbjeXXg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] overlayfs: stack file operations
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 6:23 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Thu, Apr 12, 2018 at 5:07 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
>> Git tree is here:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-rorw
>
> Thanks everyone for your review.
>
> Force pushed new version to the above branch.
>
> Hopefully no comment was missed (I didn't add more reverts yet, those
> can wait).  I'll do a mailbomb as well next week and start processing
> the metacopy patches.
>

Ran -g auto xfstests on overlay over xfs+reflink.
There are no failures and no changes w.r.t skipped tests since v4.17-rc1.

ACK on w.r.t addressing my review comments.

ACK on the freeze protection fix.
Not sure if the fact that we take __mnt_want_write() on overlay and not on
upper_mnt for ovl_real_ioctl() is a problem (i.e. can upper_mnt become
readonly from under overlay? and do we care?).

Thanks,
Amir.
