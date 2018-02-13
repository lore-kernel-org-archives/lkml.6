Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934894AbeBMLcM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:32:12 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34272 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933926AbeBMLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:32:10 -0500
X-Google-Smtp-Source: AH8x226X/0ARtf93TVlrioZdQC162wHX586uOSdS1sx9oumDnXkp3vfKgYhZUX/QSIu0WItPbZG1bq2kx5s8G5KjNSc=
MIME-Version: 1.0
In-Reply-To: <cover.1512741134.git.dongsu@kinvolk.io>
References: <cover.1512741134.git.dongsu@kinvolk.io>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 13 Feb 2018 12:32:09 +0100
Message-ID: <CAOssrKey+oxahrXHO5d6Lu1ZD=r1t-b0i4iZM_Ke9ToqTckjkQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] FUSE mounts from non-init user namespaces
To: Dongsu Park <dongsu@kinvolk.io>
Cc: lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org, Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:

> Patches 1-2 deal with an additional flag of lookup_bdev() to check for
> additional inode permission.

fuse_blk is less suitable for unprivileged mounting than plain fuse.
fusermount doesn't allow mounting fuse_blk unprivileged, so there's
little data about that usecase (IIRC ntfs3g guys did that, or at least
tried to do it, but I don't remember the details).

As such, I think we should leave it out of the initial version.  Which
means you can drop patches 1-2 from this series.  Unless there's a
strong use case for this.  In which case we should look hard at the
differences between fuse_blk and fuse and how that affects
unprivileged operation.   There are a few assumptions about fuse_blk
filesystem being more "well behaved", I think.

Thanks,
Miklos
