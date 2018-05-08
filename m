Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeEHNh4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:37:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeEHNhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:37:54 -0400
X-Google-Smtp-Source: AB8JxZoeSrLaanxHeE/EnvemO4oo8Lyw6QIuFeXY5tW7kcJU4AvfipmpVGw0ohO1JdiIdlNWjJp9Nw==
Date: Tue, 8 May 2018 08:37:50 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>, Sargun Dhillon <sargun@sargun.me>,
        Dongsu Park <dongsu@kinvolk.io>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] fuse: Ensure posix acls are translated outside of
 init_user_ns
Message-ID: <20180508133750.GA29084@ubuntu-xps13>
References: <87r2mre5b3.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2mre5b3.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 11:47:28AM -0500, Eric W. Biederman wrote:
> 
> Ensure the translation happens by failing to read or write
> posix acls when the filesystem has not indicated it supports
> posix acls.
> 
> This ensures that modern cached posix acl support is available
> and used when dealing with posix acls.  This is important
> because only that path has the code to convernt the uids and
> gids in posix acls into the user namespace of a fuse filesystem.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Miklos after several attempts to handle this better last cycle.  I
> figure we should go with the stupid version for now.  I think I know
> how to do better but I don't want that to gate forward progress on
> fully unprivileged fuse mounts.  Especially as this is the last known
> issue to deal with.

This seems reasonable as a short-term measure.

Acked-by: Seth Forshee <seth.forshee@canonical.com>
