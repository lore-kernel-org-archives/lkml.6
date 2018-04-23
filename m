Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbeDWKDv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:03:51 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33980 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeDWKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:03:50 -0400
X-Google-Smtp-Source: AB8JxZpk3PZkmh3xRpdTuoREVdBCoC1g96ibZMwShYcRFcJBqdMQd2BGC8RKU0KX3S9jKh9q8ayyk+Ay7LfvylqElWE=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180420165625.129593-2-songliubraving@fb.com>
References: <20180420165625.129593-1-songliubraving@fb.com> <20180420165625.129593-2-songliubraving@fb.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Apr 2018 12:03:49 +0200
Message-ID: <CAJfpegu7Xogom_vMOYNaYKN4f+2h8Se94VVii2ufxaMeWhcxbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tracing: remove igrab() iput() call from uprobes.c
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 6:56 PM, Song Liu <songliubraving@fb.com> wrote:
> Caller of uprobe_register is required to keep the inode and containing
> mount point referenced.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Howard McLauchlan <hmclauchlan@fb.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  kernel/events/uprobes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ce6848e..20486bb 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -491,7 +491,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>         if (!uprobe)
>                 return NULL;
>
> -       uprobe->inode = igrab(inode);

Where has the assignment gone?

Testing your changes would not hurt...

Thanks,
Miklos
