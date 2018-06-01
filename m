Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeFAATv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:19:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41095 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeFAATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:19:49 -0400
X-Google-Smtp-Source: ADUXVKLz36xglxqT6MAQTvlPX70xZ2cfMsLFr6qjJKHxA3zehYgBMTCWoo1gfqXzd+jKvDgNbDBHx/V8sGenMMMKngk=
MIME-Version: 1.0
In-Reply-To: <20180601100922.56e98097@canb.auug.org.au>
References: <20180601100922.56e98097@canb.auug.org.au>
From: Steve French <smfrench@gmail.com>
Date: Thu, 31 May 2018 19:19:27 -0500
Message-ID: <CAH2r5mt9YaodzbsnnD1rr68xrr7BRQY9MWYpLzeRmk37Z-X68Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the cifs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry about that - missing

#ifdef CONFIG_CIFS_SMB311
#endif

around that.  It is fixed now and repushed to cifs-2.6.git for-next

otherwise requires SMB311 to be enabled in the build

On Thu, May 31, 2018 at 7:09 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the cifs tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> fs/cifs/connect.c: In function 'cifs_mount':
> fs/cifs/connect.c:3967:10: error: 'struct cifs_tcon' has no member named 'posix_extensions'
>   if (tcon->posix_extensions)
>           ^~
>
> Caused by commit
>
>   12a778233fc4 ("smb3: Add posix create context for smb3.11 posix mounts")
>
> # CONFIG_CIFS_SMB311 is not set
>
> I have used the cifs tree from next-20180531 for today.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
